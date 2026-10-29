#nullable disable
using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using Npgsql;

namespace HabitTracker
{
    /// <summary>
    /// Список привычек: поиск по нескольким полям, фильтры по двум полям, сортировка.
    /// ownOnly — показывать только привычки текущего пользователя.
    /// canEdit — разрешены добавление, изменение и удаление.
    /// </summary>
    public class HabitsPage : UserControl, IPage
    {
        private readonly bool ownOnly;
        private readonly bool canEdit;

        private readonly DataGridView grid = Ui.NewGrid();
        private readonly TextBox txtSearch = new TextBox { Width = 200, PlaceholderText = "Название или описание" };
        private readonly ComboBox cbCategory = new ComboBox { Width = 150, DropDownStyle = ComboBoxStyle.DropDownList };
        private readonly ComboBox cbFrequency = new ComboBox { Width = 150, DropDownStyle = ComboBoxStyle.DropDownList };
        private readonly ComboBox cbSort = new ComboBox { Width = 230, DropDownStyle = ComboBoxStyle.DropDownList };
        private bool loading;

        public HabitsPage(bool ownOnly, bool canEdit)
        {
            this.ownOnly = ownOnly;
            this.canEdit = canEdit;
            Dock = DockStyle.Fill;

            // сначала таблица (Fill), потом панели сверху и снизу
            Controls.Add(grid);

            var top = Ui.Bar(DockStyle.Top);
            top.Controls.Add(Ui.Lbl("Поиск:"));
            top.Controls.Add(txtSearch);
            top.Controls.Add(Ui.Lbl("Категория:"));
            top.Controls.Add(cbCategory);
            top.Controls.Add(Ui.Lbl("Периодичность:"));
            top.Controls.Add(cbFrequency);
            top.Controls.Add(Ui.Lbl("Сортировка:"));
            top.Controls.Add(cbSort);
            Controls.Add(top);

            var bottom = Ui.Bar(DockStyle.Bottom);
            if (canEdit)
            {
                bottom.Controls.Add(Ui.Btn("Добавить", AddHabit));
                bottom.Controls.Add(Ui.Btn("Изменить", EditHabit));
                bottom.Controls.Add(Ui.Btn("Удалить", DeleteHabit));
            }
            if (ownOnly)
            {
                bottom.Controls.Add(Ui.Btn("Отметить сегодня", MarkToday, 170));
            }
            bottom.Controls.Add(Ui.Btn("Отчёт в Excel", Export));
            Controls.Add(bottom);

            cbSort.Items.Add("Название (А–Я)");
            cbSort.Items.Add("Название (Я–А)");
            cbSort.Items.Add("Дата начала (сначала новые)");
            cbSort.Items.Add("Дата начала (сначала старые)");
            cbSort.Items.Add("Категория, затем название");
            if (!ownOnly) cbSort.Items.Add("Владелец, затем название");
            cbSort.SelectedIndex = 0;

            txtSearch.TextChanged += (s, e) => SafeReload();
            cbCategory.SelectedIndexChanged += (s, e) => SafeReload();
            cbFrequency.SelectedIndexChanged += (s, e) => SafeReload();
            cbSort.SelectedIndexChanged += (s, e) => SafeReload();
        }

        private void SafeReload()
        {
            if (loading) return;
            try { Reload(); }
            catch (Exception ex) { Errors.Show(ex); }
        }

        private void FillFilters()
        {
            loading = true;
            try
            {
                int category = Ui.ComboValue(cbCategory);
                int frequency = Ui.ComboValue(cbFrequency);
                Ui.FillCombo(cbCategory, Db.Lookup("categories", "category_id", "category_name"), "Все категории");
                Ui.FillCombo(cbFrequency, Db.Lookup("frequencies", "frequency_id", "frequency_name"), "Любая периодичность");
                if (category > 0) cbCategory.SelectedValue = category;
                if (frequency > 0) cbFrequency.SelectedValue = frequency;
            }
            finally
            {
                loading = false;
            }
        }

        public void Reload()
        {
            FillFilters();

            var where = new List<string>();
            var ps = new List<NpgsqlParameter>();

            if (ownOnly)
            {
                where.Add("h.user_id = @uid");
                ps.Add(Db.P("uid", Session.UserId));
            }

            string search = txtSearch.Text.Trim();
            if (search.Length > 0)
            {
                where.Add("(CAST(h.name AS text) ILIKE @s OR COALESCE(CAST(h.description AS text), '') ILIKE @s)");
                ps.Add(Db.P("s", "%" + Db.EscapeLike(search) + "%"));
            }

            int category = Ui.ComboValue(cbCategory);
            if (category > 0)
            {
                where.Add("h.category_id = @c");
                ps.Add(Db.P("c", category));
            }

            int frequency = Ui.ComboValue(cbFrequency);
            if (frequency > 0)
            {
                where.Add("h.frequency_id = @f");
                ps.Add(Db.P("f", frequency));
            }

            // порядок сортировки выбирается только из заранее заданных вариантов
            string order;
            switch (cbSort.SelectedIndex)
            {
                case 1: order = "h.name DESC"; break;
                case 2: order = "h.start_date DESC, h.name"; break;
                case 3: order = "h.start_date ASC, h.name"; break;
                case 4: order = "c.category_name, h.name"; break;
                case 5: order = "u.full_name, h.name"; break;
                default: order = "h.name ASC"; break;
            }

            string sql =
                "SELECT h.habit_id AS \"Код\", CAST(u.full_name AS text) AS \"Владелец\", CAST(h.name AS text) AS \"Название\", " +
                "c.category_name AS \"Категория\", f.frequency_name AS \"Периодичность\", " +
                "h.start_date AS \"Дата начала\", COALESCE(CAST(h.description AS text), '') AS \"Описание\" " +
                "FROM habits h " +
                "JOIN users u ON u.user_id = h.user_id " +
                "JOIN categories c ON c.category_id = h.category_id " +
                "JOIN frequencies f ON f.frequency_id = h.frequency_id " +
                (where.Count > 0 ? "WHERE " + string.Join(" AND ", where) + " " : "") +
                "ORDER BY " + order;

            Ui.BindGrid(grid, Db.Query(sql, ps.ToArray()));
        }

        private void AddHabit()
        {
            using (var dialog = new HabitDialog(-1, ownOnly ? Session.UserId : -1))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK) Reload();
            }
        }

        private void EditHabit()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите привычку в таблице.");
                return;
            }
            using (var dialog = new HabitDialog(id, ownOnly ? Session.UserId : -1))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK) Reload();
            }
        }

        private void DeleteHabit()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите привычку в таблице.");
                return;
            }
            if (!Ui.Confirm("Удалить привычку «" + Ui.SelectedText(grid, "Название") + "» вместе с отметками выполнения?"))
                return;

            Db.Execute("DELETE FROM habit_logs WHERE habit_id = @id", Db.P("id", id));
            Db.Execute("DELETE FROM habits WHERE habit_id = @id", Db.P("id", id));
            Reload();
        }

        /// <summary>Отметить привычку выполненной сегодня (повторное нажатие снимает отметку).</summary>
        private void MarkToday()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите привычку в таблице.");
                return;
            }

            int updated = Db.Execute(
                "UPDATE habit_logs SET is_done = NOT is_done WHERE habit_id = @h AND log_date = CURRENT_DATE",
                Db.P("h", id));
            if (updated == 0)
            {
                Db.Execute(
                    "INSERT INTO habit_logs (habit_id, log_date, is_done) VALUES (@h, CURRENT_DATE, true)",
                    Db.P("h", id));
            }

            bool done = Convert.ToBoolean(Db.Scalar(
                "SELECT is_done FROM habit_logs WHERE habit_id = @h AND log_date = CURRENT_DATE", Db.P("h", id)));
            Ui.Info(done ? "Отмечено: привычка выполнена сегодня." : "Отметка за сегодня снята.");
        }

        private void Export()
        {
            Reports.ExportToExcel(grid.DataSource as DataTable, "Привычки");
        }
    }
}
