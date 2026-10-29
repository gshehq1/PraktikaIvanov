#nullable disable
using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using Npgsql;

namespace HabitTracker
{
    /// <summary>Пользователи (только для администратора): поиск, фильтр по роли, сортировка, CRUD.</summary>
    public class UsersPage : UserControl, IPage
    {
        private readonly DataGridView grid = Ui.NewGrid();
        private readonly TextBox txtSearch = new TextBox { Width = 220, PlaceholderText = "Логин, ФИО или email" };
        private readonly ComboBox cbRole = new ComboBox { Width = 160, DropDownStyle = ComboBoxStyle.DropDownList };
        private readonly ComboBox cbSort = new ComboBox { Width = 230, DropDownStyle = ComboBoxStyle.DropDownList };
        private bool loading;

        public UsersPage()
        {
            Dock = DockStyle.Fill;
            Controls.Add(grid);

            var top = Ui.Bar(DockStyle.Top);
            top.Controls.Add(Ui.Lbl("Поиск:"));
            top.Controls.Add(txtSearch);
            top.Controls.Add(Ui.Lbl("Роль:"));
            top.Controls.Add(cbRole);
            top.Controls.Add(Ui.Lbl("Сортировка:"));
            top.Controls.Add(cbSort);
            Controls.Add(top);

            var bottom = Ui.Bar(DockStyle.Bottom);
            bottom.Controls.Add(Ui.Btn("Добавить", AddUser));
            bottom.Controls.Add(Ui.Btn("Изменить", EditUser));
            bottom.Controls.Add(Ui.Btn("Удалить", DeleteUser));
            bottom.Controls.Add(Ui.Btn("Отчёт в Excel", Export));
            Controls.Add(bottom);

            cbSort.Items.Add("ФИО (А–Я)");
            cbSort.Items.Add("Логин (А–Я)");
            cbSort.Items.Add("Дата регистрации (сначала новые)");
            cbSort.Items.Add("Роль, затем ФИО");
            cbSort.SelectedIndex = 0;

            txtSearch.TextChanged += (s, e) => SafeReload();
            cbRole.SelectedIndexChanged += (s, e) => SafeReload();
            cbSort.SelectedIndexChanged += (s, e) => SafeReload();
        }

        private void SafeReload()
        {
            if (loading) return;
            try { Reload(); }
            catch (Exception ex) { Errors.Show(ex); }
        }

        private void FillRoles()
        {
            loading = true;
            try
            {
                int role = Ui.ComboValue(cbRole);
                Ui.FillCombo(cbRole, Db.Lookup("roles", "role_id", "role_name"), "Все роли");
                if (role > 0) cbRole.SelectedValue = role;
            }
            finally
            {
                loading = false;
            }
        }

        public void Reload()
        {
            FillRoles();

            var where = new List<string>();
            var ps = new List<NpgsqlParameter>();

            string search = txtSearch.Text.Trim();
            if (search.Length > 0)
            {
                where.Add("(CAST(u.login AS text) ILIKE @s OR CAST(u.full_name AS text) ILIKE @s OR CAST(u.email AS text) ILIKE @s)");
                ps.Add(Db.P("s", "%" + Db.EscapeLike(search) + "%"));
            }

            int role = Ui.ComboValue(cbRole);
            if (role > 0)
            {
                where.Add("u.role_id = @r");
                ps.Add(Db.P("r", role));
            }

            string order;
            switch (cbSort.SelectedIndex)
            {
                case 1: order = "u.login"; break;
                case 2: order = "u.registered_at DESC, u.user_id DESC"; break;
                case 3: order = "r.role_name, u.full_name"; break;
                default: order = "u.full_name"; break;
            }

            string sql =
                "SELECT u.user_id AS \"Код\", CAST(u.login AS text) AS \"Логин\", CAST(u.full_name AS text) AS \"ФИО\", " +
                "CAST(u.email AS text) AS \"Email\", r.role_name AS \"Роль\", u.registered_at AS \"Дата регистрации\" " +
                "FROM users u JOIN roles r ON r.role_id = u.role_id " +
                (where.Count > 0 ? "WHERE " + string.Join(" AND ", where) + " " : "") +
                "ORDER BY " + order;

            Ui.BindGrid(grid, Db.Query(sql, ps.ToArray()));
        }

        private void AddUser()
        {
            using (var dialog = new UserDialog(-1))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK) Reload();
            }
        }

        private void EditUser()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите пользователя в таблице.");
                return;
            }
            using (var dialog = new UserDialog(id))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK) Reload();
            }
        }

        private void DeleteUser()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите пользователя в таблице.");
                return;
            }
            if (id == Session.UserId)
            {
                Ui.Warn("Нельзя удалить пользователя, под которым вы вошли.");
                return;
            }
            if (!Ui.Confirm("Удалить пользователя «" + Ui.SelectedText(grid, "ФИО") + "»?")) return;

            // если у пользователя есть привычки или заявки, база не даст удалить его — покажем понятное сообщение
            Db.Execute("DELETE FROM users WHERE user_id = @id", Db.P("id", id));
            Reload();
        }

        private void Export()
        {
            Reports.ExportToExcel(grid.DataSource as DataTable, "Пользователи");
        }
    }
}
