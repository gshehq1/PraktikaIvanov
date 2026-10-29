#nullable disable
using System;
using System.Data;
using System.Windows.Forms;
using ClosedXML.Excel;

namespace HabitTracker
{
    /// <summary>Генерация отчёта по данным (Excel).</summary>
    public static class Reports
    {
        public static void ExportToExcel(DataTable data, string title)
        {
            if (data == null || data.Rows.Count == 0)
            {
                Ui.Warn("Нет данных для отчёта.");
                return;
            }

            using (var dialog = new SaveFileDialog())
            {
                dialog.Filter = "Excel (*.xlsx)|*.xlsx";
                dialog.FileName = title + "_" + DateTime.Now.ToString("yyyyMMdd_HHmm") + ".xlsx";
                if (dialog.ShowDialog() != DialogResult.OK) return;

                try
                {
                    DataTable copy = data.Copy();
                    copy.TableName = "Report";

                    using (var workbook = new XLWorkbook())
                    {
                        var sheet = workbook.Worksheets.Add(title);
                        sheet.Cell(1, 1).InsertTable(copy);
                        sheet.Columns().AdjustToContents();
                        workbook.SaveAs(dialog.FileName);
                    }

                    Ui.Info("Отчёт сохранён:\n" + dialog.FileName);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Не удалось сохранить отчёт. Возможно, файл открыт в другой программе.\n\n" + ex.Message,
                        "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}
