using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;

namespace LibrarySystem
{
	public partial class ReportsWindow : Window
	{
		public ReportsWindow()
		{
			InitializeComponent();
			GenerateSummary();
		}

		private void GenerateSummary()
		{
			// Dummy logic for summary (Asal mein ye database queries se ayega)
			lblTotalBooks.Text = "1,240";
			lblIssuedBooks.Text = "85";
			lblTotalFine.Text = "3,450";

			// Overdue books list
			List<OverdueItem> overdueList = new List<OverdueItem>
			{
				new OverdueItem { Name = "Usman Ahmed", Book = "Software Engineering", DueDate = DateTime.Now.AddDays(-5), DaysLate = 5 },
				new OverdueItem { Name = "Ali Raza", Book = "Data Structures", DueDate = DateTime.Now.AddDays(-2), DaysLate = 2 },
				new OverdueItem { Name = "Zaid Khan", Book = "OOP Concepts", DueDate = DateTime.Now.AddDays(-12), DaysLate = 12 }
			};

			dgOverdue.ItemsSource = overdueList;
		}

		private void BtnPrint_Click(object sender, RoutedEventArgs e)
		{
			// Simple Print Command
			PrintDialog printDlg = new PrintDialog();
			if (printDlg.ShowDialog() == true)
			{
				printDlg.PrintVisual(this, "Library Summary Report");
			}
		}
	}

	public class OverdueItem
	{
		public string Name { get; set; }
		public string Book { get; set; }
		public DateTime DueDate { get; set; }
		public int DaysLate { get; set; }
	}
}