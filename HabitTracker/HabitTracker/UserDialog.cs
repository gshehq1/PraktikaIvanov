#nullable disable
using System;
using System.Data;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>Добавление и изменение пользователя администратором.</summary>
    public class UserDialog : BaseDialog
    {
        private readonly int userId;
        private readonly TextBox txtLogin;
        private readonly TextBox txtName;
        private readonly TextBox txtEmail;
        private readonly TextBox txtPassword;
        private readonly ComboBox cbRole;

        public UserDialog(int userId) : base(userId < 0 ? "Новый пользователь" : "Изменение пользователя")
        {
            this.userId = userId;

            txtLogin = Add("Логин *", new TextBox { MaxLength = 50 });
            txtName = Add("ФИО *", new TextBox { MaxLength = 100 });
            txtEmail = Add("Email *", new TextBox { MaxLength = 100 });
            txtPassword = Add(userId < 0 ? "Пароль *" : "Новый пароль", new TextBox { UseSystemPasswordChar = true, MaxLength = 100 });
            cbRole = Add("Роль *", new ComboBox());
            Ui.FillCombo(cbRole, Db.Lookup("roles", "role_id", "role_name"));

            Finish();

            if (userId > 0) LoadExisting();
        }

        private void LoadExisting()
        {
            DataTable table = Db.Query(
                "SELECT CAST(login AS text) AS login, CAST(full_name AS text) AS full_name, " +
                "CAST(email AS text) AS email, role_id FROM users WHERE user_id = @id",
                Db.P("id", userId));
            if (table.Rows.Count == 0)
            {
                Ui.Warn("Пользователь не найден: возможно, его уже удалили.");
                Shown += (s, e) => Close();
                return;
            }

            DataRow row = table.Rows[0];
            txtLogin.Text = row["login"].ToString();
            txtName.Text = row["full_name"].ToString();
            txtEmail.Text = row["email"].ToString();
            cbRole.SelectedValue = Convert.ToInt32(row["role_id"]);
        }

        protected override void OnSave()
        {
            string login = txtLogin.Text.Trim();
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            int role = Ui.ComboValue(cbRole);

            string error = Validators.Login(login) ?? Validators.FullName(name) ?? Validators.Email(email);
            if (error == null && (userId < 0 || password.Length > 0)) error = Validators.Password(password);
            if (error == null && role < 0) error = "Выберите роль.";
            if (error != null)
            {
                Ui.Warn(error);
                return;
            }

            if (userId < 0)
            {
                Db.Execute(
                    "INSERT INTO users (login, password_hash, full_name, email, registered_at, role_id) " +
                    "VALUES (@l, @h, @n, @e, CURRENT_DATE, @r)",
                    Db.P("l", login), Db.P("h", Hashing.Sha256(password)),
                    Db.P("n", name), Db.P("e", email), Db.P("r", role));
            }
            else if (password.Length > 0)
            {
                Db.Execute(
                    "UPDATE users SET login = @l, password_hash = @h, full_name = @n, email = @e, role_id = @r " +
                    "WHERE user_id = @id",
                    Db.P("l", login), Db.P("h", Hashing.Sha256(password)),
                    Db.P("n", name), Db.P("e", email), Db.P("r", role), Db.P("id", userId));
            }
            else
            {
                Db.Execute(
                    "UPDATE users SET login = @l, full_name = @n, email = @e, role_id = @r WHERE user_id = @id",
                    Db.P("l", login), Db.P("n", name), Db.P("e", email), Db.P("r", role), Db.P("id", userId));
            }

            DialogResult = DialogResult.OK;
        }
    }
}
