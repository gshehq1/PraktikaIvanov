#nullable disable
using System;
using System.Data;
using System.Windows.Forms;

namespace HabitTracker
{

    public class DictionariesPage : UserControl, IPage
    {

        private static readonly string[,] Dicts =
        {
            { "Роли", "roles", "role_id", "role_name" },
            { "Категории", "categories", "category_id", "category_name" },
            { "Периодичности", "frequencies", "frequency_id", "frequency_name" },
            { "Статусы заявок", "request_statuses", "status_id", "status_name" }
        };

        private readonly DataGridView grid = Ui.NewGrid();
        private readonly ComboBox cbDict = new ComboBox { Width = 220, DropDownStyle = ComboBoxStyle.DropDownList };
        private bool loading;

        public DictionariesPage()
        {
            Dock = DockStyle.Fill;
            Controls.Add(grid);

            var top = Ui.Bar(DockStyle.Top);
            top.Controls.Add(Ui.Lbl("Справочник:"));
            top.Controls.Add(cbDict);
            Controls.Add(top);

            var bottom = Ui.Bar(DockStyle.Bottom);
            bottom.Controls.Add(Ui.Btn("Добавить", AddValue));
            bottom.Controls.Add(Ui.Btn("Изменить", EditValue));
            bottom.Controls.Add(Ui.Btn("Удалить", DeleteValue));
            Controls.Add(bottom);

            for (int i = 0; i < Dicts.GetLength(0); i++) cbDict.Items.Add(Dicts[i, 0]);
            cbDict.SelectedIndex = 0;
            cbDict.SelectedIndexChanged += (s, e) =>
            {
                if (loading) return;
                try { Reload(); }
                catch (Exception ex) { Errors.Show(ex); }
            };
        }

        private int Current
        {
            get { return cbDict.SelectedIndex < 0 ? 0 : cbDict.SelectedIndex; }
        }

        public void Reload()
        {
            string table = Dicts[Current, 1];
            string id = Dicts[Current, 2];
            string name = Dicts[Current, 3];

            DataTable data = Db.Query(
                "SELECT " + id + " AS \"Код\", " + name + " AS \"Название\" FROM " + table + " ORDER BY " + id);
            Ui.BindGrid(grid, data);
        }

        private void AddValue()
        {
            string value = Ui.Prompt("Новое значение", "Название (" + Dicts[Current, 0] + "):", "", false, 30);
            if (value == null) return;
            if (value.Length == 0)
            {
                Ui.Warn("Название не может быть пустым.");
                return;
            }

            Db.Execute("INSERT INTO " + Dicts[Current, 1] + " (" + Dicts[Current, 3] + ") VALUES (@n)", Db.P("n", value));
            Reload();
        }

        private void EditValue()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите значение в таблице.");
                return;
            }

            string value = Ui.Prompt("Изменение значения", "Новое название:", Ui.SelectedText(grid, "Название"), false, 30);
            if (value == null) return;
            if (value.Length == 0)
            {
                Ui.Warn("Название не может быть пустым.");
                return;
            }


            Db.Execute("UPDATE " + Dicts[Current, 1] + " SET " + Dicts[Current, 3] + " = @n WHERE " + Dicts[Current, 2] + " = @id",
                Db.P("n", value), Db.P("id", id));
            Reload();
        }

        private void DeleteValue()
        {
            int id = Ui.SelectedId(grid);
            if (id < 0)
            {
                Ui.Warn("Выберите значение в таблице.");
                return;
            }
            if (!Ui.Confirm("Удалить значение «" + Ui.SelectedText(grid, "Название") + "»?")) return;

 
            Db.Execute("DELETE FROM " + Dicts[Current, 1] + " WHERE " + Dicts[Current, 2] + " = @id", Db.P("id", id));
            Reload();
        }
    }
}
