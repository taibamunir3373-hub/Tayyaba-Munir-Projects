using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace LibrarySystem
{
	public partial class ViewRecordsWindow : Window
	{
		// Data Store karne ke liye list
		List<RecordData> masterList = new List<RecordData>();

		public ViewRecordsWindow()
		{
			InitializeComponent();
			LoadInitialData();
		}

		private void LoadInitialData()
		{
			// Dummy Data (Testing ke liye)
			masterList.Add(new RecordData { Name = "Usman Ahmed", Book = "C# Programming", IDate = DateTime.Now.AddDays(-5), RDate = DateTime.Now.AddDays(2), Status = "Issued" });
			masterList.Add(new RecordData { Name = "Dr. Zahid", Book = "Data Science", IDate = DateTime.Now.AddDays(-10), RDate = DateTime.Now.AddDays(-2), Status = "Returned" });
			masterList.Add(new RecordData { Name = "Zaid Ali", Book = "Networking", IDate = DateTime.Now.AddDays(-1), RDate = DateTime.Now.AddDays(6), Status = "Issued" });

			dgLogs.ItemsSource = masterList;
		}

		// Search karne ki logic
		private void txtSearch_TextChanged(object sender, TextChangedEventArgs e)
		{
			string search = txtSearch.Text.ToLower();
			var filtered = masterList.Where(x => x.Name.ToLower().Contains(search) || x.Book.ToLower().Contains(search)).ToList();
			dgLogs.ItemsSource = filtered;
		}
	}

	// Data Structure
	public class RecordData
	{
		public string Name { get; set; }
		public string Book { get; set; }
		public DateTime IDate { get; set; }
		public DateTime RDate { get; set; }
		public string Status { get; set; }
	}
}