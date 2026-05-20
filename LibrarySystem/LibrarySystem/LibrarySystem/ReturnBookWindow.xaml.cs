using System;
using System.Collections.Generic;
using System.Windows;

namespace LibrarySystem
{
	public partial class ReturnBookWindow : Window
	{
		public ReturnBookWindow()
		{
			InitializeComponent();
			dtpActualReturnDate.SelectedDate = DateTime.Now; // Aaj ki date default
			LoadReturnData();
		}

		private void LoadReturnData()
		{
			// Dummy data: Asal mein ye data "Issued Books" ki table se ayega
			if (rbRetStudent.IsChecked == true)
			{
				cmbReturnNames.ItemsSource = new List<IssuedRecord> {
					new IssuedRecord { Name = "Usman Ahmed", BookTitle = "C# Mastery", DueDate = DateTime.Now.AddDays(-3), IssueDate = DateTime.Now.AddDays(-10) },
					new IssuedRecord { Name = "Zaid Ali", BookTitle = "Digital Logic", DueDate = DateTime.Now.AddDays(2), IssueDate = DateTime.Now.AddDays(-5) }
				};
			}
			else
			{
				cmbReturnNames.ItemsSource = new List<IssuedRecord> {
					new IssuedRecord { Name = "Dr. Zahid", BookTitle = "Advanced Algorithms", DueDate = DateTime.Now.AddDays(-1), IssueDate = DateTime.Now.AddDays(-15) }
				};
			}
		}

		private void RetType_Checked(object sender, RoutedEventArgs e)
		{
			if (cmbReturnNames != null) LoadReturnData();
		}

		private void cmbReturnNames_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (cmbReturnNames.SelectedItem is IssuedRecord record)
			{
				lblIssuedBook.Text = "Book Name: " + record.BookTitle;
				lblIssueDate.Text = "Issued On: " + record.IssueDate.ToShortDateString();
				lblDueDate.Text = "Due Date: " + record.DueDate.ToShortDateString();
				CalculateFine(record.DueDate);
			}
		}

		private void CalculateFine(DateTime dueDate)
		{
			DateTime actualDate = dtpActualReturnDate.SelectedDate ?? DateTime.Now;
			if (actualDate > dueDate)
			{
				int delayDays = (actualDate - dueDate).Days;
				int fine = delayDays * 10; // 10 Rupees per day
				lblFineAmount.Text = "Rs. " + fine.ToString();
			}
			else
			{
				lblFineAmount.Text = "Rs. 0";
			}
		}

		private void dtpActualReturnDate_SelectedDateChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (cmbReturnNames.SelectedItem is IssuedRecord record)
			{
				CalculateFine(record.DueDate);
			}
		}

		private void BtnConfirmReturn_Click(object sender, RoutedEventArgs e)
		{
			if (cmbReturnNames.SelectedItem == null)
			{
				MessageBox.Show("Please select a record first!");
				return;
			}

			MessageBox.Show("Book Returned Successfully!\nStock updated to 'Available'.", "Success");
			this.Close();
		}
	}

	public class IssuedRecord
	{
		public string Name { get; set; }
		public string BookTitle { get; set; }
		public DateTime IssueDate { get; set; }
		public DateTime DueDate { get; set; }
	}
}