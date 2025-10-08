import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceGameApp());
}

class DiceGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "🎲 Multiplayer Dice Game",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DiceGameScreen(),
    );
  }
}

class DiceGameScreen extends StatefulWidget {
  @override
  _DiceGameScreenState createState() => _DiceGameScreenState();
}

class _DiceGameScreenState extends State<DiceGameScreen> {
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _guessController = TextEditingController();

  int diceNumber = 1;
  int totalRounds = 0;
  int currentRound = 1;
  int currentPlayer = 0;
  List<int> playerScores = [0, 0, 0, 0];
  String message = "";
  bool gameStarted = false;
  bool gameOver = false;

  void startGame() {
    if (_roundsController.text.isEmpty) return;
    int? rounds = int.tryParse(_roundsController.text);
    if (rounds == null || rounds <= 0) return;

    setState(() {
      totalRounds = rounds;
      currentRound = 1;
      currentPlayer = 0;
      playerScores = [0, 0, 0, 0];
      message = "Game Started! Player 1's turn 🎯";
      gameStarted = true;
      gameOver = false;
    });
  }

  void rollDice() {
    if (!gameStarted || gameOver) return;

    setState(() {
      diceNumber = Random().nextInt(6) + 1;
      playerScores[currentPlayer] += diceNumber;

      message = "Player ${currentPlayer + 1} rolled a $diceNumber 🎲";

      // Move to next player
      if (currentPlayer < 3) {
        currentPlayer++;
      } else {
        currentPlayer = 0;
        currentRound++;
      }

      // Check if game finished
      if (currentRound > totalRounds) {
        int maxScore = playerScores.reduce(max);
        int winnerIndex = playerScores.indexOf(maxScore);
        message =
        "🏁 Game Over! Player ${winnerIndex + 1} wins with $maxScore points! 🏆";
        gameOver = true;
      } else if (!gameOver) {
        message += "\n➡️ Player ${currentPlayer + 1}'s turn";
      }
    });
  }

  void resetGame() {
    setState(() {
      diceNumber = 1;
      totalRounds = 0;
      currentRound = 1;
      currentPlayer = 0;
      playerScores = [0, 0, 0, 0];
      message = "";
      _roundsController.clear();
      gameStarted = false;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🎲 Dice Game"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _roundsController,
              decoration: InputDecoration(
                labelText: "Enter number of rounds",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sports_esports),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            if (!gameStarted)
              ElevatedButton.icon(
                onPressed: startGame,
                icon: Icon(Icons.play_arrow),
                label: Text("Start Game"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            if (gameStarted) ...[
              SizedBox(height: 20),
              Text(
                "Round $currentRound of $totalRounds",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Current Player: Player ${currentPlayer + 1}",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: rollDice,
                child: Image.asset(
                  "assets/$diceNumber.png",
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: rollDice,
                icon: Icon(Icons.casino),
                label: Text("Roll Dice"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              SizedBox(height: 30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white.withOpacity(0.9),
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Text("${index + 1}"),
                        ),
                        title: Text("Player ${index + 1}"),
                        trailing: Text(
                          "${playerScores[index]} pts",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
