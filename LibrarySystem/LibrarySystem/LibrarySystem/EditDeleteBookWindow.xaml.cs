using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;

namespace LibrarySystem
{
	// Book ka simple structure (Model)
	public class Book
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public string Author { get; set; }
		public string Publisher { get; set; }
		public int Quantity { get; set; }
	}

	public partial class EditDeleteBookWindow : Window
	{
		// Fake data testing ke liye (Aap isay database se replace karenge baad mein)
		ObservableCollection<Book> bookList = new ObservableCollection<Book>();

		public EditDeleteBookWindow()
		{
			InitializeComponent();
			LoadSampleData();
			dgBooks.ItemsSource = bookList;
		}

		private void LoadSampleData()
		{
			bookList.Add(new Book { Id = 1, Title = "C# Programming", Author = "Microsoft", Publisher = "MS Press", Quantity = 5 });
			bookList.Add(new Book { Id = 2, Title = "Data Structures", Author = "Robert Lafore", Publisher = "Pearson", Quantity = 3 });
		}

		// Jab Table mein koi row select ho
		private void dgBooks_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (dgBooks.SelectedItem is Book selectedBook)
			{
				txtEditTitle.Text = selectedBook.Title;
				txtEditAuthor.Text = selectedBook.Author;
				txtEditQty.Text = selectedBook.Quantity.ToString();
			}
		}

		// F2: Update Book Logic
		private void BtnUpdate_Click(object sender, RoutedEventArgs e)
		{
			if (dgBooks.SelectedItem is Book selectedBook)
			{
				selectedBook.Title = txtEditTitle.Text;
				selectedBook.Author = txtEditAuthor.Text;
				selectedBook.Quantity = int.Parse(txtEditQty.Text);

				dgBooks.Items.Refresh(); // Table update karein
				MessageBox.Show("Book details updated successfully!");
			}
		}

		// F2: Delete Book Logic
		private void BtnDelete_Click(object sender, RoutedEventArgs e)
		{
			if (dgBooks.SelectedItem is Book selectedBook)
			{
				var result = MessageBox.Show("Are you sure you want to delete this book?", "Confirm Delete", MessageBoxButton.YesNo);
				if (result == MessageBoxResult.Yes)
				{
					bookList.Remove(selectedBook);
					MessageBox.Show("Book record deleted.");
				}
			}
		}
	}
}