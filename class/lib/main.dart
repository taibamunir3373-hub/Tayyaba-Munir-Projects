import 'package:flutter/material.dart';

void main() {
  runApp(CardApp());
}

class CardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BusinessCard(),
    );
  }
}

class BusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  "build/images/veilgirl.png",
                ),
              ),
              SizedBox(height: 15),

              // Name
              Text(
                "Tayyaba Munir",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.teal[900],
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Job Title
              Text(
                "Flutter Developer",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal[700],
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20),

              // Divider
              Divider(
                color: Colors.teal,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),

              // Phone Card
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.phone, color: Colors.teal),
                  title: Text("+92 300 1234567",
                      style: TextStyle(fontSize: 16, color: Colors.teal[900])),
                ),
              ),

              // Email Card
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.email, color: Colors.teal),
                  title: Text("tayyaba@example.com",
                      style: TextStyle(fontSize: 16, color: Colors.teal[900])),
                ),
              ),

              // Education Card
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.school, color: Colors.blueAccent),
                  title: Text("BS Software Engineering"),
                  subtitle: Text("COMSATS University, Vehari Campus"),
                ),
              ),

              // Skills Card
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.code, color: Colors.deepPurple),
                  title: Text("Skills"),
                  subtitle: Text("• App Development\n• Web Development"),
                ),
              ),

              // Projects Card
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(Icons.work, color: Colors.orange),
                  title: Text("Projects"),
                  subtitle: Text("• Card App"),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Designed with ❤️ in Flutter",
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
