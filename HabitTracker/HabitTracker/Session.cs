#nullable disable

namespace HabitTracker
{
    /// <summary>Названия ролей (должны совпадать с таблицей roles).</summary>
    public static class RoleNames
    {
        public const string Admin = "Администратор";
        public const string Manager = "Менеджер";
        public const string User = "Пользователь";
    }

    /// <summary>Названия статусов заявок (таблица request_statuses).</summary>
    public static class Statuses
    {
        public const string New = "Новая";
        public const string Approved = "Одобрена";
        public const string Rejected = "Отклонена";
        public const string Received = "Получена";
    }

    /// <summary>Текущий вошедший пользователь.</summary>
    public static class Session
    {
        public static int UserId;
        public static string FullName;
        public static string Role;

        public static void Clear()
        {
            UserId = 0;
            FullName = null;
            Role = null;
        }
    }
}
