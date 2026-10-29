#nullable disable
using System;
using System.Data;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>
    /// Добавление и изменение привычки.
    /// habitId &lt; 0 — новая привычка. fixedUserId &gt; 0 — владелец задан (обычный пользователь).
    /// requestId &gt; 0 — привычка создаётся из одобренной заявки (статус заявки станет «Получена»).
    /// </summary>
    public class HabitDialog : BaseDialog
    {
        private readonly int habitId;
        private readonly int fixedUserId;
        private readonly int requestId;

        private readonly ComboBox cbUser;
        private readonly TextBox txtName;
        private readonly TextBox txtDesc;
        private readonly ComboBox cbCategory;
        private readonly ComboBox cbFrequency;
        private readonly DateTimePicker dtpStart;

        public HabitDialog(int habitId, int fixedUserId, string presetName = null, string presetDesc = null, int requestId = -1)
            : base(habitId < 0 ? "Новая привычка" : "Изменение привычки")
        {
            this.habitId = habitId;
            this.fixedUserId = fixedUserId;
            this.requestId = requestId;

            if (fixedUserId <= 0)
            {
                cbUser = Add("Владелец *", new ComboBox());
                Ui.FillCombo(cbUser, Db.Query(
                    "SELECT user_id AS id, CAST(full_name AS text) || ' (' || CAST(login AS text) || ')' AS name " +
                    "FROM users ORDER BY full_name"));
            }

            txtName = Add("Название *", new TextBox { MaxLength = 100 });
            txtDesc = Add("Описание", new TextBox { Multiline = true, AcceptsReturn = true, Height = 70, MaxLength = 500, ScrollBars = ScrollBars.Vertical });

            cbCategory = Add("Категория *", new ComboBox());
            Ui.FillCombo(cbCategory, Db.Lookup("categories", "category_id", "category_name"));

            cbFrequency = Add("Периодичность *", new ComboBox());
            Ui.FillCombo(cbFrequency, Db.Lookup("frequencies", "frequency_id", "frequency_name"));

            dtpStart = Add("Дата начала *", new DateTimePicker
            {
                Format = DateTimePickerFormat.Short,
                MinDate = new DateTime(2020, 1, 1),
                Value = DateTime.Today
            });

            Finish();

            if (habitId > 0)
            {
                LoadExisting();
            }
            else
            {
                txtName.Text = presetName ?? "";
                txtDesc.Text = presetDesc ?? "";
            }
        }

        private void LoadExisting()
        {
            DataTable table = Db.Query(
                "SELECT user_id, category_id, frequency_id, name, description, start_date FROM habits WHERE habit_id = @id",
                Db.P("id", habitId));
            if (table.Rows.Count == 0)
            {
                Ui.Warn("Привычка не найдена: возможно, её уже удалили.");
                Shown += (s, e) => Close();
                return;
            }

            DataRow row = table.Rows[0];
            txtName.Text = row["name"].ToString();
            txtDesc.Text = row["description"] == DBNull.Value ? "" : row["description"].ToString();
            cbCategory.SelectedValue = Convert.ToInt32(row["category_id"]);
            cbFrequency.SelectedValue = Convert.ToInt32(row["frequency_id"]);
            if (cbUser != null) cbUser.SelectedValue = Convert.ToInt32(row["user_id"]);

            DateTime start = (DateTime)row["start_date"];
            dtpStart.Value = start < dtpStart.MinDate ? dtpStart.MinDate : start;
        }

        protected override void OnSave()
        {
            string name = txtName.Text.Trim();
            if (name.Length == 0)
            {
                Ui.Warn("Введите название привычки.");
                return;
            }

            int category = Ui.ComboValue(cbCategory);
            int frequency = Ui.ComboValue(cbFrequency);
            int userId = fixedUserId > 0 ? fixedUserId : Ui.ComboValue(cbUser);
            if (category < 0 || frequency < 0 || userId < 0)
            {
                Ui.Warn("Выберите значения во всех выпадающих списках.");
                return;
            }

            string description = string.IsNullOrWhiteSpace(txtDesc.Text) ? null : txtDesc.Text.Trim();
            DateOnly start = DateOnly.FromDateTime(dtpStart.Value.Date);

            if (habitId < 0)
            {
                Db.Execute(
                    "INSERT INTO habits (user_id, category_id, frequency_id, name, description, start_date) " +
                    "VALUES (@u, @c, @f, @n, @d, @s)",
                    Db.P("u", userId), Db.P("c", category), Db.P("f", frequency),
                    Db.P("n", name), Db.P("d", description), Db.P("s", start));

                if (requestId > 0)
                {
                    // последний шаг связанного процесса: пользователь получил привычку по заявке
                    Db.Execute(
                        "UPDATE habit_requests SET status_id = " +
                        "(SELECT status_id FROM request_statuses WHERE status_name = @st) WHERE request_id = @r",
                        Db.P("st", Statuses.Received), Db.P("r", requestId));
                }
            }
            else
            {
                // Id (habit_id) в запросе не меняется
                Db.Execute(
                    "UPDATE habits SET user_id = @u, category_id = @c, frequency_id = @f, " +
                    "name = @n, description = @d, start_date = @s WHERE habit_id = @id",
                    Db.P("u", userId), Db.P("c", category), Db.P("f", frequency),
                    Db.P("n", name), Db.P("d", description), Db.P("s", start), Db.P("id", habitId));
            }

            DialogResult = DialogResult.OK;
        }
    }
}
