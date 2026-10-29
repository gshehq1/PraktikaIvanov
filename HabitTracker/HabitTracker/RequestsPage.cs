#nullable disable
using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using Npgsql;

namespace HabitTracker
{
    public enum RequestMode
    {
        User,
        Manager,
        Admin
    }

    /// <summary>
    /// Связанный процесс:
    /// пользователь подаёт заявку -> менеджер одобряет или отклоняет ->
    /// администратор при необходимости меняет информацию -> пользователь получает привычку.
    /// </summary>
    public class RequestsPage : UserControl, IPage
    {
        private readonly RequestMode mode;
        private readonly DataGridView grid = Ui.NewGrid();
        private readonly TextBox txtSearch = new TextBox { Width = 200, PlaceholderText = "Название, описание, автор" };
        private readonly ComboBox cbStatus = new ComboBox { Width = 160, DropDownStyle = ComboBoxStyle.DropDownList };
        private readonly ComboBox cbSort = new ComboBox { Width = 220, DropDownStyle = ComboBoxStyle.DropDownList };
        private bool loading;
        private bool firstLoad = true;

        public RequestsPage(RequestMode mode)
        {
            this.mode = mode;
            Dock = DockStyle.Fill;

            Controls.Add(grid);

            var top = Ui.Bar(DockStyle.Top);
            top.Controls.Add(Ui.Lbl("Поиск:"));
            top.Controls.Add(txtSearch);
            top.Controls.Add(Ui.Lbl("Статус:"));
            top.Controls.Add(cbStatus);
            top.Controls.Add(Ui.Lbl("Сортировка:"));
            top.Controls.Add(cbSort);
            Controls.Add(top);

            var bottom = Ui.Bar(DockStyle.Bottom);
            switch (mode)
            {
                case RequestMode.User:
                    bottom.Controls.Add(Ui.Btn("Подать заявку", NewRequest));
                    bottom.Controls.Add(Ui.Btn("Получить привычку", Receive, 170));
                    break;
                case RequestMode.Manager:
                    bottom.Controls.Add(Ui.Btn("Одобрить", () => Decide(Statuses.Approved)));
                    bottom.Controls.Add(Ui.Btn("Отклонить", () => Decide(Statuses.Rejected)));
                    break;
                case RequestMode.Admin:
                    bottom.Controls.Add(Ui.Btn("Изменить", EditRequest));
                    bottom.Controls.Add(Ui.Btn("Удалить", DeleteRequest));
                    break;
            }
            bottom.Controls.Add(Ui.Btn("Отчёт в Excel", Export));
            Controls.Add(bottom);

            cbSort.Items.Add("Дата подачи (сначала новые)");
            cbSort.Items.Add("Дата подачи (сначала старые)");
            cbSort.Items.Add("Название (А–Я)");
            cbSort.Items.Add("Статус, затем дата");
            cbSort.SelectedIndex = 0;

            txtSearch.TextChanged += (s, e) => SafeReload();
            cbStatus.SelectedIndexChanged += (s, e) => SafeReload();
            cbSort.SelectedIndexChanged += (s, e) => SafeReload();
        }

        private void SafeReload()
        {
            if (loading) return;
            try { Reload(); }
            catch (Exception ex) { Errors.Show(ex); }
        }

        private void FillStatuses()
        {
            loading = true;
            try
            {
                int status = Ui.ComboValue(cbStatus);
                Ui.FillCombo(cbStatus, Db.Lookup("request_statuses", "status_id", "status_name"), "Все статусы");
                if (status > 0)
                {
                    cbStatus.SelectedValue = status;
                }
                else if (firstLoad && mode == RequestMode.Manager)
                {
                    // менеджеру сразу показываем заявки, которые ждут решения
                    int index = cbStatus.FindStringExact(Statuses.New);
                    if (index >= 0) cbStatus.SelectedIndex = index;
                }
                firstLoad = false;
            }
            finally
            {
                loading = false;
            }
        }

        public void Reload()
        {
            FillStatuses();

            var where = new List<string>();
            var ps = new List<NpgsqlParameter>();

            if (mode == RequestMode.User)
            {
                where.Add("r.author_id = @uid");
                ps.Add(Db.P("uid", Session.UserId));
            }

            string search = txtSearch.Text.Trim();
            if (search.Length > 0)
            {
                where.Add("(CAST(r.name AS text) ILIKE @s OR CAST(r.description AS text) ILIKE @s OR CAST(a.full_name AS text) ILIKE @s)");
                ps.Add(Db.P("s", "%" + Db.EscapeLike(search) + "%"));
            }

            int status = Ui.ComboValue(cbStatus);
            if (status > 0)
            {
                where.Add("r.status_id = @st");
                ps.Add(Db.P("st", status));
            }

            string order;
            switch (cbSort.SelectedIndex)
            {
                case 1: order = "r.submitted_at ASC, r.request_id"; break;
                case 2: order = "r.name ASC"; break;
                case 3: order = "s.status_name, r.submitted_at DESC"; break;
                default: order = "r.submitted_at DESC, r.request_id DESC"; break;
            }

            string sql =
                "SELECT r.request_id AS \"Код\", CAST(a.full_name AS text) AS \"Автор\", CAST(r.name AS text) AS \"Название\", " +
                "CAST(r.description AS text) AS \"Описание\", r.submitted_at AS \"Дата подачи\", " +
                "s.status_name AS \"Статус\", COALESCE(CAST(m.full_name AS text), '') AS \"Менеджер\", " +
                "COALESCE(CAST(r.manager_comment AS text), '') AS \"Комментарий\" " +
                "FROM habit_requests r " +
                "JOIN users a ON a.user_id = r.author_id " +
                "JOIN request_statuses s ON s.status_id = r.status_id " +
                "LEFT JOIN users m ON m.user_id = r.manager_id " +
                (where.Count > 0 ? "WHERE " + string.Join(" AND ", where) + " " : "") +
                "ORDER BY " + order;

            Ui.BindGrid(grid, Db.Query(sql, ps.ToArray()));
        }

        // ----- пользователь -----

        private void NewRequest()
        {
            using (var dialog = new RequestDialog(-1))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK) Reload();
            }
        }

        private void Receive()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите заявку в таблице.");
                return;
            }
            if (Ui.SelectedText(grid, "Статус") != Statuses.Approved)
            {
                Ui.Warn("Получить привычку можно только по заявке со статусом «" + Statuses.Approved + "».");
                return;
            }

            using (var dialog = new HabitDialog(-1, Session.UserId,
                       Ui.SelectedText(grid, "Название"), Ui.SelectedText(grid, "Описание"), id))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK)
                {
                    Ui.Info("Привычка добавлена в ваш список. Заявка получила статус «" + Statuses.Received + "».");
                    Reload();
                }
            }
        }

        // ----- менеджер -----

        private void Decide(string newStatus)
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите заявку в таблице.");
                return;
            }
            if (Ui.SelectedText(grid, "Статус") != Statuses.New)
            {
                Ui.Warn("Можно обработать только заявку со статусом «" + Statuses.New + "».");
                return;
            }

            bool reject = newStatus == Statuses.Rejected;
            string comment = Ui.Prompt(reject ? "Отклонение заявки" : "Одобрение заявки",
                reject ? "Причина отказа (обязательно):" : "Комментарий (необязательно):", "", true, 300);
            if (comment == null) return;
            if (reject && comment.Length == 0)
            {
                Ui.Warn("Укажите причину отказа.");
                return;
            }

            int updated = Db.Execute(
                "UPDATE habit_requests SET status_id = (SELECT status_id FROM request_statuses WHERE status_name = @st), " +
                "manager_id = @m, manager_comment = @c " +
                "WHERE request_id = @id AND status_id = (SELECT status_id FROM request_statuses WHERE status_name = @old)",
                Db.P("st", newStatus), Db.P("m", Session.UserId),
                Db.P("c", comment.Length == 0 ? null : comment),
                Db.P("id", id), Db.P("old", Statuses.New));

            if (updated == 0) Ui.Warn("Эта заявка уже обработана.");
            Reload();
        }

        // ----- администратор -----

        private void EditRequest()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите заявку в таблице.");
                return;
            }
            using (var dialog = new RequestDialog(id))
            {
                if (dialog.ShowDialog(this) == DialogResult.OK) Reload();
            }
        }

        private void DeleteRequest()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите заявку в таблице.");
                return;
            }
            if (!Ui.Confirm("Удалить заявку «" + Ui.SelectedText(grid, "Название") + "»?")) return;

            Db.Execute("DELETE FROM habit_requests WHERE request_id = @id", Db.P("id", id));
            Reload();
        }

        private void Export()
        {
            Reports.ExportToExcel(grid.DataSource as DataTable, "Заявки");
        }
    }
}
