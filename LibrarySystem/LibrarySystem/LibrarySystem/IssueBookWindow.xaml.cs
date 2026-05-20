using System;
using System.Collections.Generic;
using System.Windows;

namespace LibrarySystem
{
	public partial class IssueBookWindow : Window
	{
		public IssueBookWindow()
		{
			InitializeComponent();
			LoadData();
		}

		private void LoadData()
		{
			cmbBooks.ItemsSource = new List<BookInfo> {
				new BookInfo { BookID = 101, Title = "Software Engineering" },
				new BookInfo { BookID = 102, Title = "Digital Logic Design" }
			};

			cmbEmployees.ItemsSource = new List<EmployeeInfo> {
				new EmployeeInfo { EmpID = "T-101", EmpName = "Dr. Ahmed (HOD)", Designation = "Professor" },
				new EmployeeInfo { EmpID = "T-202", EmpName = "Ms. Sara", Designation = "Lecturer" }
			};

			cmbStudents.ItemsSource = new List<StudentInfo> {
				new StudentInfo { StuID = "FA23-01", StuName = "Zaid Ali", Session = "2023-27" },
				new StudentInfo { StuID = "FA23-05", StuName = "Hafsa", Session = "2023-27" }
			};
		}

		// Yeh function control karega ke Student active hai ya Employee
		private void Type_Checked(object sender, RoutedEventArgs e)
		{
			if (gbStudent == null || gbEmployee == null) return;

			if (rbStudent.IsChecked == true)
			{
				gbStudent.IsEnabled = true; gbStudent.Opacity = 1;
				gbEmployee.IsEnabled = false; gbEmployee.Opacity = 0.5;
				cmbEmployees.SelectedItem = null; // Dusra clear kar do
			}
			else
			{
				gbEmployee.IsEnabled = true; gbEmployee.Opacity = 1;
				gbStudent.IsEnabled = false; gbStudent.Opacity = 0.5;
				cmbStudents.SelectedItem = null; // Dusra clear kar do
			}
		}

		private void cmbBooks_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (cmbBooks.SelectedItem is BookInfo b) lblBookInfo.Text = $"Book ID: {b.BookID} | Status: Available";
		}

		private void cmbStudents_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (cmbStudents.SelectedItem is StudentInfo s) lblStuDetails.Text = $"Roll No: {s.StuID} | Session: {s.Session}";
		}

		private void cmbEmployees_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (cmbEmployees.SelectedItem is EmployeeInfo emp) lblEmpDetails.Text = $"ID: {emp.EmpID} | Designation: {emp.Designation}";
		}

		private void BtnConfirmIssue_Click(object sender, RoutedEventArgs e)
		{
			if (cmbBooks.SelectedItem == null || dtpReturnDate.SelectedDate == null)
			{
				MessageBox.Show("Please select Book and Return Date!");
				return;
			}

			string target = "";
			if (rbStudent.IsChecked == true && cmbStudents.SelectedItem != null)
				target = ((StudentInfo)cmbStudents.SelectedItem).StuName;
			else if (rbEmployee.IsChecked == true && cmbEmployees.SelectedItem != null)
				target = ((EmployeeInfo)cmbEmployees.SelectedItem).EmpName;
			else
			{
				MessageBox.Show("Please select a valid Student or Employee!");
				return;
			}

			MessageBox.Show($"Book successfully issued to {target}!", "F3 Success");
			this.Close();
		}
	}

	public class BookInfo { public int BookID { get; set; } public string Title { get; set; } }
	public class EmployeeInfo { public string EmpID { get; set; } public string EmpName { get; set; } public string Designation { get; set; } }
	public class StudentInfo { public string StuID { get; set; } public string StuName { get; set; } public string Session { get; set; } }
}