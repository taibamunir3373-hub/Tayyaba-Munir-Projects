using System.Windows;
using System.Windows.Controls;

namespace LibrarySystem
{
	public partial class LoginWindow : Window
	{
		public LoginWindow()
		{
			InitializeComponent();
		}

		private void BtnLogin_Click(object sender, RoutedEventArgs e)
		{
			string username = txtUsername.Text;
			string password = txtPassword.Password;
			ComboBoxItem selectedRole = (ComboBoxItem)cmbRole.SelectedItem;

			// Validation: Khali fields check karna
			if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || selectedRole == null)
			{
				MessageBox.Show("Please fill all fields and select a role.", "Error", MessageBoxButton.OK, MessageBoxImage.Warning);
				return;
			}

			string role = selectedRole.Content.ToString();

			// Login Logic
			// Yahan aap Database check ya Static check laga saktay hain
			if (role == "Librarian" && username == "admin" && password == "admin123")
			{
				MessageBox.Show("Librarian Login Successful!");
				// Open Librarian Dashboard
				// DashboardWindow ds = new DashboardWindow();
				// ds.Show();
				// this.Close();
			}
			else if (role == "Assistant" && username == "staff" && password == "staff123")
			{
				MessageBox.Show("Assistant Login Successful!");
				// Open Assistant Dashboard
			}
			else
			{
				MessageBox.Show("Invalid Username, Password, or Role.", "Login Failed", MessageBoxButton.OK, MessageBoxImage.Error);
			}
		}
	}
}