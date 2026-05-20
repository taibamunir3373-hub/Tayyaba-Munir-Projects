using Microsoft.Win32;
using System;
using System.IO;
using System.Windows;

namespace LibrarySystem
{
	public partial class BackupWindow : Window
	{
		public BackupWindow()
		{
			InitializeComponent();
		}

		private void BtnBackup_Click(object sender, RoutedEventArgs e)
		{
			// F10 Requirement: Manual Backup Logic
			SaveFileDialog saveFile = new SaveFileDialog();
			saveFile.Filter = "Backup Files (*.bak)|*.bak|JSON Files (*.json)|*.json|All Files (*.*)|*.*";
			saveFile.FileName = $"Library_Backup_{DateTime.Now:yyyyMMdd_HHmm}";

			if (saveFile.ShowDialog() == true)
			{
				try
				{
					// Simulation: Asal mein yahan aap apne SQL Database ya 
					// List ko Serialize karke file mein write karenge.
					string dummyData = "Library System Backup Data - Date: " + DateTime.Now.ToString();
					File.WriteAllText(saveFile.FileName, dummyData);

					MessageBox.Show($"Backup Created Successfully!\nLocation: {saveFile.FileName}",
									"Backup Complete", MessageBoxButton.OK, MessageBoxImage.Information);

					lblLastBackup.Text = "Last Backup: " + DateTime.Now.ToString("f");
				}
				catch (Exception ex)
				{
					MessageBox.Show("Backup Failed: " + ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
				}
			}
		}
	}
}