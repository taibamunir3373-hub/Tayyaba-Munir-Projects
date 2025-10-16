import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

// Entry point
void main() {
  runApp(const CgpaApp());
}

class CgpaApp extends StatelessWidget {
  const CgpaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGPA Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

//
// 🌟 Splash Screen
//
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CgpaHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeInDown(
            duration: const Duration(seconds: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: Colors.white, size: 90),
                const SizedBox(height: 20),
                Text(
                  'CGPA Calculator',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                FadeInUp(
                  child: Text(
                    'Calculate your success ✨',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// 🎓 Home Page
//
class CgpaHomePage extends StatefulWidget {
  const CgpaHomePage({super.key});

  @override
  State<CgpaHomePage> createState() => _CgpaHomePageState();
}

class _CgpaHomePageState extends State<CgpaHomePage> {
  final List<Semester> _semesters = [Semester()];
  double _cgpa = 0.0;

  void _addSemester() {
    setState(() => _semesters.add(Semester()));
  }

  void _calculateCgpa() {
    double totalPoints = 0, totalCredits = 0;
    for (var sem in _semesters) {
      for (var sub in sem.subjects) {
        double? g = double.tryParse(sub.gradeController.text);
        double? c = double.tryParse(sub.creditController.text);
        if (g != null && c != null && c > 0 && g >= 0 && g <= 4) {
          totalPoints += g * c;
          totalCredits += c;
        }
      }
      sem.calculateSemesterGpa();
    }

    _cgpa = totalCredits > 0 ? totalPoints / totalCredits : 0;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultPage(cgpa: _cgpa)),
    );
  }

  void _reset() {
    setState(() {
      _semesters.clear();
      _semesters.add(Semester());
      _cgpa = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FadeInDown(
                    child: Text(
                      '🎓 CGPA Calculator',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeIn(
                    child: Text(
                      'Add subjects, enter grade points & credits — we’ll handle the rest!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ..._semesters.map((sem) {
                    int index = _semesters.indexOf(sem);
                    return FadeInUp(
                      child: Card(
                        color: Colors.white,
                        elevation: 6,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                'Semester ${index + 1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const Divider(),
                              ...sem.subjects.map((sub) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 6),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.deepPurple.shade50,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: sub.nameController,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.book),
                                            hintText: 'Subject Name',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                sub.gradeController,
                                                keyboardType:
                                                TextInputType.number,
                                                decoration:
                                                const InputDecoration(
                                                  labelText:
                                                  'Grade (0.0 - 4.0)',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                sub.creditController,
                                                keyboardType:
                                                TextInputType.number,
                                                decoration:
                                                const InputDecoration(
                                                  labelText: 'Credit Hours',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              const SizedBox(height: 8),
                              OutlinedButton.icon(
                                onPressed: () {
                                  setState(() => sem.addSubject());
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Add Subject"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.deepPurple,
                                  side: const BorderSide(
                                      color: Colors.deepPurple, width: 1.5),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Semester GPA: ${sem.semesterGpa.toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _addSemester,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Semester'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade600,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _calculateCgpa,
                          icon: const Icon(Icons.calculate),
                          label: const Text('Calculate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _reset,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// 🌟 Result Summary Page
//
class ResultPage extends StatelessWidget {
  final double cgpa;
  const ResultPage({super.key, required this.cgpa});

  String getMessage() {
    if (cgpa >= 3.7) return "Outstanding! 🌟";
    if (cgpa >= 3.3) return "Excellent Work 💪";
    if (cgpa >= 2.7) return "Good Job 👍";
    if (cgpa >= 2.0) return "Keep Improving 💡";
    return "Needs Effort 📚";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: BounceInDown(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events,
                    color: Colors.amber, size: 100),
                const SizedBox(height: 20),
                Text(
                  "Your CGPA is:",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Text(
                  cgpa.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  child: Text(
                    getMessage(),
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Back"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// 🧮 Models
//
class Semester {
  final List<Subject> subjects = [Subject()];
  double semesterGpa = 0.0;

  void addSubject() => subjects.add(Subject());

  void calculateSemesterGpa() {
    double totalPoints = 0, totalCredits = 0;
    for (var s in subjects) {
      double? g = double.tryParse(s.gradeController.text);
      double? c = double.tryParse(s.creditController.text);
      if (g != null && c != null && c > 0 && g >= 0 && g <= 4) {
        totalPoints += g * c;
        totalCredits += c;
      }
    }
    semesterGpa = totalCredits > 0 ? totalPoints / totalCredits : 0;
  }
}

class Subject {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController creditController = TextEditingController();
}
