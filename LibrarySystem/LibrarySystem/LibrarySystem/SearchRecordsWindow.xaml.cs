using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace LibrarySystem
{
	public partial class SearchRecordsWindow : Window
	{
		// Sample Library Data
		List<SearchBookModel> libraryData = new List<SearchBookModel>();

		public SearchRecordsWindow()
		{
			InitializeComponent();
			LoadData();
		}

		private void LoadData()
		{
			// Dummy Data (Asal mein ye database se ayega)
			libraryData.Add(new SearchBookModel { BookID = "B-001", Title = "C# Programming Guide", Author = "Herbert Schildt", Publisher = "McGraw Hill", Quantity = 12 });
			libraryData.Add(new SearchBookModel { BookID = "B-002", Title = "Database Management", Author = "Abraham Silberschatz", Publisher = "Pearson", Quantity = 5 });
			libraryData.Add(new SearchBookModel { BookID = "B-003", Title = "Data Structures in C++", Author = "Robert Lafore", Publisher = "Sams Publishing", Quantity = 8 });
			libraryData.Add(new SearchBookModel { BookID = "B-004", Title = "Operating Systems", Author = "William Stallings", Publisher = "Pearson", Quantity = 3 });
			libraryData.Add(new SearchBookModel { BookID = "B-005", Title = "Visual Basic .NET", Author = "Deitel & Deitel", Publisher = "Prentice Hall", Quantity = 15 });

			dgSearchResults.ItemsSource = libraryData;
			lblStatus.Text = $"Found {libraryData.Count} items in catalog";
		}

		// F6: Real-time Search Logic
		private void txtSearchGlobal_TextChanged(object sender, TextChangedEventArgs e)
		{
			string query = txtSearchGlobal.Text.ToLower();

			if (libraryData == null) return;

			var filteredResults = libraryData.Where(b =>
				b.Title.ToLower().Contains(query) ||
				b.Author.ToLower().Contains(query) ||
				b.BookID.ToLower().Contains(query)
			).ToList();

			dgSearchResults.ItemsSource = filteredResults;
			lblStatus.Text = $"Found {filteredResults.Count} matching items";
		}

		private void BtnClearSearch_Click(object sender, RoutedEventArgs e)
		{
			txtSearchGlobal.Clear();
			dgSearchResults.ItemsSource = libraryData;
		}
	}

	public class SearchBookModel
	{
		public string BookID { get; set; }
		public string Title { get; set; }
		public string Author { get; set; }
		public string Publisher { get; set; }
		public int Quantity { get; set; }
	}
}