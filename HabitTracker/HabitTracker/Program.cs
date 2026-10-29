#nullable disable
using System;
using System.Windows.Forms;

namespace HabitTracker
{
    internal static class Program
    {
        [STAThread]
        private static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            try
            {
                // Проверка подключения + служебный статус заявки «Получена»
                Db.EnsureStatuses();
            }
            catch (Exception ex)
            {
                Errors.Show(ex);
                return;
            }

            Application.Run(new LoginForm());
        }
    }
}
