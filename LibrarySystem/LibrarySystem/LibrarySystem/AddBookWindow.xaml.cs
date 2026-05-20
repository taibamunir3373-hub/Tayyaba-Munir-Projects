using System;
using System.Windows;
using System.Text.RegularExpressions;
using System.Windows.Input;

namespace LibrarySystem
{
	public partial class AddBookWindow : Window
	{
		public AddBookWindow()
		{
			InitializeComponent();
		}

		// Save Button Click Event
		private void BtnSave_Click(object sender, RoutedEventArgs e)
		{
			string title = txtTitle.Text;
			string author = txtAuthor.Text;
			string publisher = txtPublisher.Text;
			string quantity = txtQuantity.Text;

			// Validation: Check if any field is empty
			if (string.IsNullOrWhiteSpace(title) ||
				string.IsNullOrWhiteSpace(author) ||
				string.IsNullOrWhiteSpace(publisher) ||
				string.IsNullOrWhiteSpace(quantity))
			{
				MessageBox.Show("Please fill all the book details.", "Empty Fields", MessageBoxButton.OK, MessageBoxImage.Warning);
				return;
			}

			// Filhal hum sirf message show karwa rahay hain
			// Yahan aap Database Insert ki query likh saktay hain
			string bookInfo = $"Book Saved Successfully!\n\nTitle: {title}\nAuthor: {author}\nPublisher: {publisher}\nQuantity: {quantity}";

			MessageBox.Show(bookInfo, "Success", MessageBoxButton.OK, MessageBoxImage.Information);

			ClearFields();
		}

		// Sirf Numbers allow karne ke liye logic
		private void NumberValidationTextBox(object sender, TextCompositionEventArgs e)
		{
			Regex regex = new Regex("[^0-9]+");
			e.Handled = regex.IsMatch(e.Text);
		}

		// Fields ko clear karne ke liye function
		private void BtnClear_Click(object sender, RoutedEventArgs e)
		{
			ClearFields();
		}

		private void ClearFields()
		{
			txtTitle.Text = "";
			txtAuthor.Text = "";
			txtPublisher.Text = "";
			txtQuantity.Text = "";
		}
	}
}