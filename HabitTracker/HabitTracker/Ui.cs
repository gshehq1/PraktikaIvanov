#nullable disable
using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>Страница (вкладка), которую можно обновить из базы данных.</summary>
    public interface IPage
    {
        void Reload();
    }

    public static class Ui
    {
        public static void Info(string text)
        {
            MessageBox.Show(text, "Трекер привычек", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public static void Warn(string text)
        {
            MessageBox.Show(text, "Проверьте данные", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        public static bool Confirm(string text)
        {
            return MessageBox.Show(text, "Подтверждение", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                   == DialogResult.Yes;
        }

        // ---------- таблицы ----------

        public static DataGridView NewGrid()
        {
            return new DataGridView
            {
                Dock = DockStyle.Fill,
                ReadOnly = true,                       // Id и данные нельзя править прямо в таблице
                AllowUserToAddRows = false,
                AllowUserToDeleteRows = false,
                AllowUserToResizeRows = false,
                MultiSelect = false,
                SelectionMode = DataGridViewSelectionMode.FullRowSelect,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells,
                RowHeadersVisible = false,
                BackgroundColor = SystemColors.Window
            };
        }

        public static void BindGrid(DataGridView grid, DataTable table)
        {
            grid.DataSource = table;
            foreach (DataGridViewColumn column in grid.Columns)
            {
                if (column.ValueType == typeof(DateTime))
                    column.DefaultCellStyle.Format = "dd.MM.yyyy";
            }
            // последний столбец занимает всё свободное место
            if (grid.Columns.Count > 0)
                grid.Columns[grid.Columns.Count - 1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }

        /// <summary>Код (Id) выбранной строки: первый столбец таблицы.</summary>
        public static int SelectedId(DataGridView grid)
        {
            if (grid.CurrentRow == null || grid.CurrentRow.Cells.Count == 0) return -1;
            object value = grid.CurrentRow.Cells[0].Value;
            if (value == null || value == DBNull.Value) return -1;
            return Convert.ToInt32(value);
        }

        public static string SelectedText(DataGridView grid, string column)
        {
            if (grid.CurrentRow == null) return null;
            object value = grid.CurrentRow.Cells[column].Value;
            return value == null || value == DBNull.Value ? "" : value.ToString();
        }

        // ---------- выпадающие списки ----------

        /// <summary>Заполнить список значениями из справочника (таблица со столбцами id и name).</summary>
        public static void FillCombo(ComboBox box, DataTable source, string allText = null)
        {
            DataTable table = source.Copy();
            if (allText != null)
            {
                DataRow row = table.NewRow();
                row["id"] = -1;
                row["name"] = allText;
                table.Rows.InsertAt(row, 0);
            }
            box.DropDownStyle = ComboBoxStyle.DropDownList;   // можно выбрать только готовое значение
            box.DisplayMember = "name";
            box.ValueMember = "id";
            box.DataSource = table;
            if (table.Rows.Count > 0) box.SelectedIndex = 0;
        }

        /// <summary>Выбранный код в списке (-1: ничего не выбрано или выбрано «Все»).</summary>
        public static int ComboValue(ComboBox box)
        {
            if (box == null || box.SelectedValue == null || box.SelectedValue is DataRowView) return -1;
            return Convert.ToInt32(box.SelectedValue);
        }

        // ---------- элементы панелей ----------

        public static FlowLayoutPanel Bar(DockStyle dock)
        {
            return new FlowLayoutPanel
            {
                Dock = dock,
                AutoSize = true,
                AutoSizeMode = AutoSizeMode.GrowAndShrink,
                WrapContents = true,
                Padding = new Padding(6, 4, 6, 4)
            };
        }

        public static Label Lbl(string text)
        {
            return new Label { Text = text, AutoSize = true, Margin = new Padding(8, 8, 2, 0) };
        }

        public static Button Btn(string text, Action onClick, int width = 140)
        {
            var button = new Button { Text = text, Width = width, Height = 32, Margin = new Padding(4) };
            button.Click += (s, e) =>
            {
                try { onClick(); }
                catch (Exception ex) { Errors.Show(ex); }
            };
            return button;
        }

        // ---------- небольшое окно ввода текста ----------

        /// <summary>Спросить у пользователя текст. Возвращает null, если нажата «Отмена».</summary>
        public static string Prompt(string title, string label, string initial = "", bool multiline = false, int maxLength = 100)
        {
            using (var form = new Form())
            {
                form.Text = title;
                form.FormBorderStyle = FormBorderStyle.FixedDialog;
                form.StartPosition = FormStartPosition.CenterParent;
                form.MaximizeBox = false;
                form.MinimizeBox = false;
                form.ShowInTaskbar = false;

                int boxHeight = multiline ? 90 : 26;
                var lbl = new Label { Text = label, Left = 12, Top = 12, Width = 376, Height = 20 };
                var box = new TextBox
                {
                    Left = 12, Top = 36, Width = 376, Height = boxHeight,
                    Text = initial ?? "", MaxLength = maxLength, Multiline = multiline
                };
                if (multiline) box.ScrollBars = ScrollBars.Vertical;

                int buttonsTop = 36 + boxHeight + 12;
                var ok = new Button { Text = "OK", Left = 208, Top = buttonsTop, Width = 85, Height = 28, DialogResult = DialogResult.OK };
                var cancel = new Button { Text = "Отмена", Left = 303, Top = buttonsTop, Width = 85, Height = 28, DialogResult = DialogResult.Cancel };

                form.ClientSize = new Size(400, buttonsTop + 28 + 12);
                form.Controls.Add(lbl);
                form.Controls.Add(box);
                form.Controls.Add(ok);
                form.Controls.Add(cancel);
                if (!multiline) form.AcceptButton = ok;
                form.CancelButton = cancel;

                return form.ShowDialog() == DialogResult.OK ? box.Text.Trim() : null;
            }
        }
    }

    /// <summary>Основа для окон ввода данных: поля располагаются друг под другом.</summary>
    public class BaseDialog : Form
    {
        private int y = 15;
        private readonly int width;

        protected Button BtnOk = new Button { Text = "Сохранить" };
        protected Button BtnCancel = new Button { Text = "Отмена", DialogResult = DialogResult.Cancel };

        public BaseDialog(string title, int width = 460)
        {
            this.width = width;
            Text = title;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            StartPosition = FormStartPosition.CenterParent;
            MaximizeBox = false;
            MinimizeBox = false;
            ShowInTaskbar = false;
            ClientSize = new Size(width, 100);
        }

        protected T Add<T>(string label, T control) where T : Control
        {
            Controls.Add(new Label { Text = label, AutoSize = false, Left = 12, Top = y + 4, Width = 118, Height = 20 });
            control.Left = 135;
            control.Top = y;
            control.Width = width - 150;
            Controls.Add(control);
            y += control.Height + 10;
            return control;
        }

        /// <summary>Вызвать после добавления всех полей.</summary>
        protected void Finish()
        {
            BtnOk.SetBounds(width - 215, y + 5, 100, 30);
            BtnCancel.SetBounds(width - 110, y + 5, 95, 30);
            BtnOk.Click += (s, e) =>
            {
                try { OnSave(); }
                catch (Exception ex) { Errors.Show(ex); }
            };
            Controls.Add(BtnOk);
            Controls.Add(BtnCancel);
            AcceptButton = BtnOk;
            CancelButton = BtnCancel;
            ClientSize = new Size(width, y + 50);
        }

        protected virtual void OnSave() { }
    }
}
