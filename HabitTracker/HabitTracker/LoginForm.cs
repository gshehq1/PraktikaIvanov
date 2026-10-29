#nullable disable
using System;
using System.Drawing;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>Вход в систему.</summary>
    public class LoginForm : Form
    {
        private readonly TextBox txtLogin = new TextBox { MaxLength = 50 };
        private readonly TextBox txtPassword = new TextBox { UseSystemPasswordChar = true, MaxLength = 100 };

        public LoginForm()
        {
            Text = "Трекер привычек — вход";
            FormBorderStyle = FormBorderStyle.FixedDialog;
            StartPosition = FormStartPosition.CenterScreen;
            MaximizeBox = false;
            ClientSize = new Size(360, 250);

            var title = new Label
            {
                Text = "Трекер привычек",
                Font = new Font(Font.FontFamily, 16, FontStyle.Bold),
                Left = 20, Top = 18, Width = 320, Height = 34
            };
            var lblLogin = new Label { Text = "Логин", Left = 20, Top = 70, Width = 320, Height = 20 };
            txtLogin.SetBounds(20, 92, 320, 26);
            var lblPassword = new Label { Text = "Пароль", Left = 20, Top = 128, Width = 320, Height = 20 };
            txtPassword.SetBounds(20, 150, 320, 26);

            var btnLogin = new Button { Text = "Войти", Left = 20, Top = 195, Width = 150, Height = 34 };
            var btnRegister = new Button { Text = "Регистрация", Left = 190, Top = 195, Width = 150, Height = 34 };
            btnLogin.Click += (s, e) => DoLogin();
            btnRegister.Click += (s, e) => DoRegister();

            Controls.Add(title);
            Controls.Add(lblLogin);
            Controls.Add(txtLogin);
            Controls.Add(lblPassword);
            Controls.Add(txtPassword);
            Controls.Add(btnLogin);
            Controls.Add(btnRegister);
            AcceptButton = btnLogin;
        }

        private void DoLogin()
        {
            string login = txtLogin.Text.Trim();
            string password = txtPassword.Text;

            if (login.Length == 0 || password.Length == 0)
            {
                Ui.Warn("Введите логин и пароль.");
                return;
            }

            try
            {
                // Параметры @l и @h: введённый текст никогда не попадает в SQL как команда
                var result = Db.Query(
                    "SELECT u.user_id, CAST(u.full_name AS text) AS full_name, r.role_name " +
                    "FROM users u JOIN roles r ON r.role_id = u.role_id " +
                    "WHERE u.login = @l AND u.password_hash = @h",
                    Db.P("l", login), Db.P("h", Hashing.Sha256(password)));

                if (result.Rows.Count == 0)
                {
                    Ui.Warn("Неверный логин или пароль.");
                    return;
                }

                Session.UserId = Convert.ToInt32(result.Rows[0]["user_id"]);
                Session.FullName = result.Rows[0]["full_name"].ToString();
                Session.Role = result.Rows[0]["role_name"].ToString();
            }
            catch (Exception ex)
            {
                Errors.Show(ex);
                return;
            }

            var main = new MainForm();
            main.FormClosed += (s, e) =>
            {
                if (main.LoggedOut)
                {
                    Session.Clear();
                    txtPassword.Clear();
                    Show();
                }
                else
                {
                    Close();
                }
            };
            Hide();
            main.Show();
        }

        private void DoRegister()
        {
            using (var dialog = new RegisterForm())
            {
                if (dialog.ShowDialog(this) == DialogResult.OK)
                {
                    txtLogin.Text = dialog.RegisteredLogin;
                    txtPassword.Clear();
                    txtPassword.Focus();
                }
            }
        }
    }
}
