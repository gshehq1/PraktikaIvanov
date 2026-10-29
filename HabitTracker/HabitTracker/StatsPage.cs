#nullable disable
using System;
using System.Data;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>
    /// Статистика выполнения привычек.
    /// all = false — статистика текущего пользователя по его привычкам;
    /// all = true — сводный отчёт по всем пользователям (менеджер и администратор).
    /// </summary>
    public class StatsPage : UserControl, IPage
    {
        private readonly bool all;
        private readonly DataGridView grid = Ui.NewGrid();

        public StatsPage(bool all)
        {
            this.all = all;
            Dock = DockStyle.Fill;
            Controls.Add(grid);

            var bottom = Ui.Bar(DockStyle.Bottom);
            bottom.Controls.Add(Ui.Btn("Обновить", Reload));
            bottom.Controls.Add(Ui.Btn("Отчёт в Excel", Export));
            Controls.Add(bottom);
        }

        public void Reload()
        {
            DataTable data;
            if (all)
            {
                data = Db.Query(
                    "SELECT u.user_id AS \"Код\", CAST(u.full_name AS text) AS \"Пользователь\", " +
                    "COUNT(DISTINCT h.habit_id) AS \"Привычек\", COUNT(l.log_id) AS \"Отметок\", " +
                    "COUNT(l.log_id) FILTER (WHERE l.is_done) AS \"Выполнено\", " +
                    "COALESCE(ROUND(100.0 * COUNT(l.log_id) FILTER (WHERE l.is_done) / NULLIF(COUNT(l.log_id), 0), 1), 0) AS \"Процент выполнения\" " +
                    "FROM users u " +
                    "JOIN roles r ON r.role_id = u.role_id " +
                    "LEFT JOIN habits h ON h.user_id = u.user_id " +
                    "LEFT JOIN habit_logs l ON l.habit_id = h.habit_id " +
                    "WHERE r.role_name = @role " +
                    "GROUP BY u.user_id, u.full_name " +
                    "ORDER BY \"Процент выполнения\" DESC, u.full_name",
                    Db.P("role", RoleNames.User));
            }
            else
            {
                data = Db.Query(
                    "SELECT h.habit_id AS \"Код\", CAST(h.name AS text) AS \"Привычка\", " +
                    "COUNT(l.log_id) AS \"Отметок\", " +
                    "COUNT(l.log_id) FILTER (WHERE l.is_done) AS \"Выполнено\", " +
                    "COALESCE(ROUND(100.0 * COUNT(l.log_id) FILTER (WHERE l.is_done) / NULLIF(COUNT(l.log_id), 0), 1), 0) AS \"Процент выполнения\" " +
                    "FROM habits h " +
                    "LEFT JOIN habit_logs l ON l.habit_id = h.habit_id " +
                    "WHERE h.user_id = @uid " +
                    "GROUP BY h.habit_id, h.name " +
                    "ORDER BY \"Процент выполнения\" DESC, h.name",
                    Db.P("uid", Session.UserId));
            }
            Ui.BindGrid(grid, data);
        }

        private void Export()
        {
            Reports.ExportToExcel(grid.DataSource as DataTable, all ? "Сводный отчёт" : "Моя статистика");
        }
    }
}
