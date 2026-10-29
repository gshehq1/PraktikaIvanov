#nullable disable
using System;
using System.Drawing;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>
    /// Главное окно. Набор вкладок зависит от роли:
    /// Администратор — всё, Менеджер — заявки и просмотр, Пользователь — свои привычки.
    /// </summary>
    public class MainForm : Form
    {
        private readonly TabControl tabs = new TabControl { Dock = DockStyle.Fill };

        public bool LoggedOut { get; private set; }

        public MainForm()
        {
            Text = "Трекер привычек";
            Width = 1180;
            Height = 700;
            MinimumSize = new Size(900, 500);
            StartPosition = FormStartPosition.CenterScreen;

            Controls.Add(tabs);

            var top = new Panel { Dock = DockStyle.Top, Height = 40 };
            var lblUser = new Label
            {
                Text = "  " + Session.FullName + "  —  " + Session.Role,
                Dock = DockStyle.Fill,
                TextAlign = ContentAlignment.MiddleLeft,
                Font = new Font(Font, FontStyle.Bold)
            };
            var btnLogout = new Button { Text = "Выйти", Dock = DockStyle.Right, Width = 100 };
            btnLogout.Click += (s, e) =>
            {
                LoggedOut = true;
                Close();
            };
            top.Controls.Add(lblUser);
            top.Controls.Add(btnLogout);
            Controls.Add(top);

            BuildTabs();

            tabs.SelectedIndexChanged += (s, e) => ReloadCurrent();
            Shown += (s, e) => ReloadCurrent();
        }

        private void BuildTabs()
        {
            switch (Session.Role)
            {
                case RoleNames.Admin:
                    AddTab("Пользователи", new UsersPage());
                    AddTab("Привычки", new HabitsPage(false, true));
                    AddTab("Заявки", new RequestsPage(RequestMode.Admin));
                    AddTab("Справочники", new DictionariesPage());
                    AddTab("Отчёт", new StatsPage(true));
                    break;

                case RoleNames.Manager:
                    AddTab("Заявки на привычки", new RequestsPage(RequestMode.Manager));
                    AddTab("Привычки пользователей", new HabitsPage(false, false));
                    AddTab("Отчёт", new StatsPage(true));
                    break;

                default:
                    AddTab("Мои привычки", new HabitsPage(true, true));
                    AddTab("Статистика", new StatsPage(false));
                    AddTab("Мои заявки", new RequestsPage(RequestMode.User));
                    break;
            }
        }

        private void AddTab(string title, Control page)
        {
            var tab = new TabPage(title);
            page.Dock = DockStyle.Fill;
            tab.Controls.Add(page);
            tabs.TabPages.Add(tab);
        }

        private void ReloadCurrent()
        {
            TabPage tab = tabs.SelectedTab;
            if (tab == null || tab.Controls.Count == 0) return;
            var page = tab.Controls[0] as IPage;
            if (page == null) return;
            try { page.Reload(); }
            catch (Exception ex) { Errors.Show(ex); }
        }
    }
}
