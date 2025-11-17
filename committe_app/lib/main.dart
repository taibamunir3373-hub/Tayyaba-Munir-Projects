import 'package:flutter/material.dart';

void main() {
  runApp(CommitteeFinanceApp());
}

// Data Models
class Member {
  String name;
  String phone;
  String email;
  double balance;
  double totalContribution;
  double totalWithdrawal;

  Member({
    required this.name,
    required this.phone,
    required this.email,
    this.balance = 0.0,
    this.totalContribution = 0.0,
    this.totalWithdrawal = 0.0,
  });
}

class Transaction {
  String memberName;
  String type;
  double amount;
  String description;
  DateTime date;

  Transaction({
    required this.memberName,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });
}

// Main App
class CommitteeFinanceApp extends StatelessWidget {
  const CommitteeFinanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Committee Finance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Sample data stored in memory
  List<Member> members = [
    Member(name: "Ali Ahmed", phone: "0300-1234567", email: "ali@email.com", balance: 5000.0),
    Member(name: "Sara Khan", phone: "0312-7654321", email: "sara@email.com", balance: 3000.0),
  ];

  List<Transaction> transactions = [
    Transaction(memberName: "Ali Ahmed", type: "Contribution", amount: 2000.0, description: "Monthly Fee", date: DateTime.now()),
    Transaction(memberName: "Sara Khan", type: "Contribution", amount: 1500.0, description: "Monthly Fee", date: DateTime.now()),
  ];

  void _addMember(Member member) {
    setState(() {
      members.add(member);
    });
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
      // Update member balance
      for (var member in members) {
        if (member.name == transaction.memberName) {
          if (transaction.type == "Contribution") {
            member.balance += transaction.amount;
            member.totalContribution += transaction.amount;
          } else {
            member.balance -= transaction.amount;
            member.totalWithdrawal += transaction.amount;
          }
        }
      }
    });
  }

  void _deleteMember(int index) {
    setState(() {
      members.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(members: members, transactions: transactions),
      MembersScreen(
        members: members,
        onAddMember: _addMember,
        onDeleteMember: _deleteMember,
      ),
      TransactionsScreen(
        members: members,
        transactions: transactions,
        onAddTransaction: _addTransaction,
      ),
      ReportsScreen(members: members, transactions: transactions),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Committee Finance'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}

// Dashboard Screen
class DashboardScreen extends StatelessWidget {
  final List<Member> members;
  final List<Transaction> transactions;

  const DashboardScreen({
    Key? key,
    required this.members,
    required this.transactions,
  }) : super(key: key);

  double getTotalBalance() {
    return members.fold(0.0, (sum, member) => sum + member.balance);
  }

  double getTotalContributions() {
    return members.fold(0.0, (sum, member) => sum + member.totalContribution);
  }

  double getTotalWithdrawals() {
    return members.fold(0.0, (sum, member) => sum + member.totalWithdrawal);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              _buildSummaryCard(
                'Total Balance',
                '\$${getTotalBalance().toStringAsFixed(2)}',
                Colors.green,
                Icons.account_balance_wallet,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                'Total Members',
                members.length.toString(),
                Colors.blue,
                Icons.people,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSummaryCard(
                'Contributions',
                '\$${getTotalContributions().toStringAsFixed(2)}',
                Colors.teal,
                Icons.arrow_upward,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                'Withdrawals',
                '\$${getTotalWithdrawals().toStringAsFixed(2)}',
                Colors.orange,
                Icons.arrow_downward,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Transactions
          const Text(
            'Recent Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildRecentTransactions(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final recentTransactions = transactions.take(5).toList();

    if (recentTransactions.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('No transactions yet'),
          ),
        ),
      );
    }

    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentTransactions.length,
        itemBuilder: (context, index) {
          final transaction = recentTransactions[index];
          return ListTile(
            leading: Icon(
              transaction.type == "Contribution"
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: transaction.type == "Contribution"
                  ? Colors.green
                  : Colors.red,
            ),
            title: Text(transaction.description),
            subtitle: Text('${transaction.memberName} - ${transaction.amount.toStringAsFixed(2)}'),
            trailing: Text(
              transaction.type == "Contribution" ? '+' : '-',
              style: TextStyle(
                color: transaction.type == "Contribution" ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Members Screen
class MembersScreen extends StatefulWidget {
  final List<Member> members;
  final Function(Member) onAddMember;
  final Function(int) onDeleteMember;

  const MembersScreen({
    Key? key,
    required this.members,
    required this.onAddMember,
    required this.onDeleteMember,
  }) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  void _showAddMemberDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {

                final newMember = Member(
                  name: nameController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                );

                widget.onAddMember(newMember);
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${nameController.text} added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add Member'),
          ),
        ],
      ),
    );
  }

  void _showMemberDetails(Member member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Member Details - ${member.name}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone: ${member.phone}'),
              const SizedBox(height: 8),
              Text('Email: ${member.email}'),
              const SizedBox(height: 8),
              Text('Balance: \$${member.balance.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text('Total Contributions: \$${member.totalContribution.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text('Total Withdrawals: \$${member.totalWithdrawal.toStringAsFixed(2)}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    final member = widget.members[index];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Member'),
        content: Text('Are you sure you want to delete ${member.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDeleteMember(index);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${member.name} deleted successfully!'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.members.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No members added yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button to add a member',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: widget.members.length,
        itemBuilder: (context, index) {
          final member = widget.members[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  member.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(member.name),
              subtitle: Text('Balance: \$${member.balance.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteDialog(index),
              ),
              onTap: () => _showMemberDetails(member),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Transactions Screen
class TransactionsScreen extends StatefulWidget {
  final List<Member> members;
  final List<Transaction> transactions;
  final Function(Transaction) onAddTransaction;

  const TransactionsScreen({
    Key? key,
    required this.members,
    required this.transactions,
    required this.onAddTransaction,
  }) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  void _showAddTransactionDialog() {
    if (widget.members.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add members first!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String selectedMember = widget.members.first.name;
    String selectedType = "Contribution";
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Transaction'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedMember,
                  decoration: const InputDecoration(
                    labelText: 'Select Member',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.members.map((member) {
                    return DropdownMenuItem<String>(
                      value: member.name,
                      child: Text('${member.name} (\$${member.balance.toStringAsFixed(2)})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMember = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Transaction Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Contribution",
                      child: Text('Contribution (Add Money)'),
                    ),
                    DropdownMenuItem(
                      value: "Withdrawal",
                      child: Text('Withdrawal (Remove Money)'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {

                  final amount = double.tryParse(amountController.text) ?? 0.0;

                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid amount!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final transaction = Transaction(
                    memberName: selectedMember,
                    type: selectedType,
                    amount: amount,
                    description: descriptionController.text,
                    date: DateTime.now(),
                  );

                  widget.onAddTransaction(transaction);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Transaction added successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.transactions.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.money_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No transactions yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Add members first, then create transactions',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: widget.transactions.length,
        itemBuilder: (context, index) {
          final transaction = widget.transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: transaction.type == "Contribution"
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  transaction.type == "Contribution"
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: transaction.type == "Contribution"
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              title: Text(
                transaction.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.memberName),
                  Text(transaction.date.toString().substring(0, 10)),
                ],
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: transaction.type == "Contribution"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    transaction.type,
                    style: TextStyle(
                      fontSize: 12,
                      color: transaction.type == "Contribution"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Reports Screen
class ReportsScreen extends StatelessWidget {
  final List<Member> members;
  final List<Transaction> transactions;

  const ReportsScreen({
    Key? key,
    required this.members,
    required this.transactions,
  }) : super(key: key);

  double getTotalBalance() {
    return members.fold(0.0, (sum, member) => sum + member.balance);
  }

  double getTotalContributions() {
    return members.fold(0.0, (sum, member) => sum + member.totalContribution);
  }

  double getTotalWithdrawals() {
    return members.fold(0.0, (sum, member) => sum + member.totalWithdrawal);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Financial Reports',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Summary Cards
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Committee Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Total Members', members.length.toString()),
                  _buildSummaryRow('Total Transactions', transactions.length.toString()),
                  _buildSummaryRow('Total Balance', '\$${getTotalBalance().toStringAsFixed(2)}'),
                  _buildSummaryRow('Total Contributions', '\$${getTotalContributions().toStringAsFixed(2)}'),
                  _buildSummaryRow('Total Withdrawals', '\$${getTotalWithdrawals().toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Member Balances
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Member Balances',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...members.map((member) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        member.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(member.name),
                    trailing: Text(
                      '\$${member.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: member.balance >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                        'Phone: ${member.phone}'
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}