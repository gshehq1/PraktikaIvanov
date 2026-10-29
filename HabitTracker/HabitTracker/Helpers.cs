#nullable disable
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using Npgsql;

namespace HabitTracker
{
    /// <summary>Хэширование пароля: SHA-256, строка в верхнем регистре (как в SQL-скрипте с тестовыми данными).</summary>
    public static class Hashing
    {
        public static string Sha256(string text)
        {
            using (var sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(text));
                return Convert.ToHexString(bytes);
            }
        }
    }

    /// <summary>Проверка вводимых данных (те же правила, что и у доменов в базе данных).</summary>
    public static class Validators
    {
        private static readonly Regex LoginRx = new Regex("^[A-Za-z0-9_]{3,50}$");
        private static readonly Regex EmailRx = new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$");

        public static string Login(string v)
        {
            return LoginRx.IsMatch(v ?? "") ? null
                : "Логин: от 3 до 50 символов, только латинские буквы, цифры и знак подчёркивания.";
        }

        public static string FullName(string v)
        {
            return (v ?? "").Trim().Length >= 2 ? null : "Введите ФИО (минимум 2 символа).";
        }

        public static string Email(string v)
        {
            return EmailRx.IsMatch(v ?? "") ? null : "Введите корректный email, например name@mail.ru.";
        }

        public static string Password(string v)
        {
            return (v ?? "").Length >= 6 ? null : "Пароль должен быть не короче 6 символов.";
        }
    }

    /// <summary>Понятные сообщения об ошибках вместо технических текстов базы данных.</summary>
    public static class Errors
    {
        // имена ограничений доменов из скрипта 04_domains.sql
        private static readonly Dictionary<string, string> Rules = new Dictionary<string, string>
        {
            { "ck_login_format", "Логин: от 3 до 50 символов, только латинские буквы, цифры и знак подчёркивания." },
            { "ck_email_format", "Введите корректный email, например name@mail.ru." },
            { "ck_hash_format", "Некорректный формат пароля." },
            { "ck_person_name_len", "ФИО должно содержать не меньше 2 символов." },
            { "ck_title_not_empty", "Название не может быть пустым." },
            { "ck_text_not_empty", "Описание не может быть пустым." },
            { "ck_comment_not_empty", "Комментарий не может быть пустым." },
            { "ck_date_min", "Дата не может быть раньше 01.01.2020." }
        };

        public static string Describe(Exception ex)
        {
            var pg = ex as PostgresException;
            if (pg != null)
            {
                string msg = pg.MessageText ?? "";
                foreach (var rule in Rules)
                {
                    if (msg.Contains(rule.Key)) return rule.Value;
                }

                switch (pg.SqlState)
                {
                    case PostgresErrorCodes.UniqueViolation:
                        string info = (pg.Detail ?? "") + " " + (pg.ConstraintName ?? "");
                        if (info.Contains("login")) return "Пользователь с таким логином уже существует.";
                        if (info.Contains("email")) return "Этот email уже зарегистрирован.";
                        return "Такая запись уже существует.";

                    case PostgresErrorCodes.ForeignKeyViolation:
                        if (msg.StartsWith("update or delete"))
                            return "Нельзя удалить запись: она используется в других таблицах (привычки, заявки и т. п.).";
                        return "Указано несуществующее значение связанной записи.";

                    case PostgresErrorCodes.NotNullViolation:
                        return "Заполните обязательное поле"
                               + (string.IsNullOrEmpty(pg.ColumnName) ? "." : " (" + pg.ColumnName + ").");

                    case PostgresErrorCodes.StringDataRightTruncation:
                        return "Введённое значение слишком длинное.";

                    case PostgresErrorCodes.CheckViolation:
                        return "Значение не допускается правилами базы данных.";
                }
                return "Ошибка базы данных: " + msg;
            }

            if (ex is NpgsqlException || ex is System.Net.Sockets.SocketException)
            {
                return "Нет связи с базой данных. Проверьте, что PostgreSQL запущен, "
                       + "а строка подключения в файле Db.cs указана верно.";
            }

            return "Произошла ошибка: " + ex.Message;
        }

        public static void Show(Exception ex)
        {
            MessageBox.Show(Describe(ex), "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
