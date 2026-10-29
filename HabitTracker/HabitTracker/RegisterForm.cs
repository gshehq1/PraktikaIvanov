#nullable disable
using System;
using System.Windows.Forms;

namespace HabitTracker
{
    /// <summary>Регистрация нового пользователя (роль «Пользователь»).</summary>
    public class RegisterForm : BaseDialog
    {
        private readonly TextBox txtLogin;
        private readonly TextBox txtName;
        private readonly TextBox txtEmail;
        private readonly TextBox txtPassword;
        private readonly TextBox txtRepeat;

        public string RegisteredLogin { get; private set; }

        public RegisterForm() : base("Регистрация")
        {
            txtLogin = Add("Логин *", new TextBox { MaxLength = 50 });
            txtName = Add("ФИО *", new TextBox { MaxLength = 100 });
            txtEmail = Add("Email *", new TextBox { MaxLength = 100 });
            txtPassword = Add("Пароль *", new TextBox { UseSystemPasswordChar = true, MaxLength = 100 });
            txtRepeat = Add("Повтор пароля *", new TextBox { UseSystemPasswordChar = true, MaxLength = 100 });
            BtnOk.Text = "Зарегистрироваться";
            Finish();
            BtnOk.SetBounds(ClientSize.Width - 255, BtnOk.Top, 140, 30);
        }

        protected override void OnSave()
        {
            string login = txtLogin.Text.Trim();
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();

            string error = Validators.Login(login)
                           ?? Validators.FullName(name)
                           ?? Validators.Email(email)
                           ?? Validators.Password(txtPassword.Text);
            if (error == null && txtPassword.Text != txtRepeat.Text) error = "Пароли не совпадают.";
            if (error != null)
            {
                Ui.Warn(error);
                return;
            }

            Db.Execute(
                "INSERT INTO users (login, password_hash, full_name, email, registered_at, role_id) " +
                "VALUES (@l, @h, @n, @e, CURRENT_DATE, (SELECT role_id FROM roles WHERE role_name = @role))",
                Db.P("l", login), Db.P("h", Hashing.Sha256(txtPassword.Text)),
                Db.P("n", name), Db.P("e", email), Db.P("role", RoleNames.User));

            RegisteredLogin = login;
            Ui.Info("Регистрация прошла успешно. Теперь можно войти.");
            DialogResult = DialogResult.OK;
        }
    }
}
