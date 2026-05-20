using System.Windows;
using System.Windows.Controls;

namespace LibrarySystem
{
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
		}

		// Login Button Click Logic
		private void BtnLoginAction_Click(object sender, RoutedEventArgs e)
		{
			string user = txtUsername.Text;
			string pass = txtPassword.Password;
			var roleItem = cmbRole.SelectedItem as ComboBoxItem;

			if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass) || roleItem == null)
			{
				MessageBox.Show("Please enter all details!", "Validation", MessageBoxButton.OK, MessageBoxImage.Warning);
				return;
			}

			string role = roleItem.Content.ToString();

			// Credentials Check
			if ((role == "Librarian" && user == "admin" && pass == "123") ||
				(role == "Assistant" && user == "staff" && pass == "staff123"))
			{
				// Login Panel ko chupa dein aur Dashboard dikha dein
				LoginPanel.Visibility = Visibility.Collapsed;
				DashboardContent.Visibility = Visibility.Visible;
				lblUserRole.Text = role.ToUpper() + " PANEL";
			}
			else
			{
				MessageBox.Show("Invalid Username or Password!", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
			}
		}

		// Logout Logic
		private void BtnLogout_Click(object sender, RoutedEventArgs e)
		{
			DashboardContent.Visibility = Visibility.Collapsed;
			LoginPanel.Visibility = Visibility.Visible;
			txtUsername.Clear();
			txtPassword.Clear();
		}

		// Search Focus Handler
		

		private void BtnAddBook_Click(object sender, RoutedEventArgs e)
		{
			// Nayi Window ka object banayein
			AddBookWindow addWindow = new AddBookWindow();

			// Isse dashboard ke upar show karein
			addWindow.ShowDialog();
		}

		// Baki functionalities ke liye placeholder (Taki error na aaye)
		private void Search_GotFocus(object sender, RoutedEventArgs e) { txtQuickSearch.Clear(); }
		private void BtnEditDelete_Click(object sender, RoutedEventArgs e)
		{
			// Yeh line EditDeleteBookWindow ko open karegi
			EditDeleteBookWindow editWindow = new EditDeleteBookWindow();
			editWindow.ShowDialog();
		}
		private void BtnIssue_Click(object sender, RoutedEventArgs e)
		{
			// Yeh line IssueBookWindow ko open karegi
			IssueBookWindow issueWin = new IssueBookWindow();
			issueWin.ShowDialog();
		}
		private void BtnReturn_Click(object sender, RoutedEventArgs e)
		{
			ReturnBookWindow returnWin = new ReturnBookWindow();
			returnWin.ShowDialog();
		}
		private void BtnReports_Click(object sender, RoutedEventArgs e)
		{
			ReportsWindow repWin = new ReportsWindow();
			repWin.ShowDialog();
		}
		private void BtnSearch_Click(object sender, RoutedEventArgs e)
		{
			SearchRecordsWindow searchWin = new SearchRecordsWindow();
			searchWin.ShowDialog();
		}
		private void BtnViewRecords_Click(object sender, RoutedEventArgs e)
		{
			// Purana MessageBox wala code hata kar ye likhein
			ViewRecordsWindow recordWin = new ViewRecordsWindow();
			recordWin.ShowDialog();
		}
		private void BtnBackup_Click(object sender, RoutedEventArgs e)
		{
			BackupWindow backWin = new BackupWindow();
			backWin.ShowDialog();
		}
	}
}