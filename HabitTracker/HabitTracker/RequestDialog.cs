#nullable disable
using System;
using System.Data;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>
    /// requestId &lt; 0 — пользователь подаёт новую заявку на привычку.
    /// requestId &gt; 0 — администратор изменяет информацию в существующей заявке.
    /// </summary>
    public class RequestDialog : BaseDialog
    {
        private readonly int requestId;
        private readonly TextBox txtName;
        private readonly TextBox txtDesc;
        private readonly ComboBox cbStatus;
        private readonly TextBox txtComment;

        public RequestDialog(int requestId)
            : base(requestId < 0 ? "Новая заявка на привычку" : "Изменение заявки")
        {
            this.requestId = requestId;

            txtName = Add("Название *", new TextBox { MaxLength = 100 });
            txtDesc = Add("Описание *", new TextBox { Multiline = true, AcceptsReturn = true, Height = 80, MaxLength = 500, ScrollBars = ScrollBars.Vertical });

            if (requestId > 0)
            {
                cbStatus = Add("Статус *", new ComboBox());
                Ui.FillCombo(cbStatus, Db.Lookup("request_statuses", "status_id", "status_name"));
                txtComment = Add("Комментарий", new TextBox { Multiline = true, AcceptsReturn = true, Height = 60, MaxLength = 300, ScrollBars = ScrollBars.Vertical });
            }

            Finish();

            if (requestId > 0) LoadExisting();
        }

        private void LoadExisting()
        {
            DataTable table = Db.Query(
                "SELECT name, description, status_id, manager_comment FROM habit_requests WHERE request_id = @id",
                Db.P("id", requestId));
            if (table.Rows.Count == 0)
            {
                Ui.Warn("Заявка не найдена: возможно, её уже удалили.");
                Shown += (s, e) => Close();
                return;
            }

            DataRow row = table.Rows[0];
            txtName.Text = row["name"].ToString();
            txtDesc.Text = row["description"].ToString();
            cbStatus.SelectedValue = Convert.ToInt32(row["status_id"]);
            txtComment.Text = row["manager_comment"] == DBNull.Value ? "" : row["manager_comment"].ToString();
        }

        protected override void OnSave()
        {
            string name = txtName.Text.Trim();
            string description = txtDesc.Text.Trim();
            if (name.Length == 0 || description.Length == 0)
            {
                Ui.Warn("Заполните название и описание заявки.");
                return;
            }

            if (requestId < 0)
            {
                // Оформление заказа пользователем: заявка получает статус «Новая»
                Db.Execute(
                    "INSERT INTO habit_requests (author_id, status_id, name, description, submitted_at) " +
                    "VALUES (@a, (SELECT status_id FROM request_statuses WHERE status_name = @st), @n, @d, CURRENT_DATE)",
                    Db.P("a", Session.UserId), Db.P("st", Statuses.New), Db.P("n", name), Db.P("d", description));
            }
            else
            {
                int status = Ui.ComboValue(cbStatus);
                if (status < 0)
                {
                    Ui.Warn("Выберите статус заявки.");
                    return;
                }
                string comment = string.IsNullOrWhiteSpace(txtComment.Text) ? null : txtComment.Text.Trim();

                Db.Execute(
                    "UPDATE habit_requests SET name = @n, description = @d, status_id = @s, manager_comment = @c " +
                    "WHERE request_id = @id",
                    Db.P("n", name), Db.P("d", description), Db.P("s", status), Db.P("c", comment), Db.P("id", requestId));
            }

            DialogResult = DialogResult.OK;
        }
    }
}
