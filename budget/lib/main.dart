import 'package:budget/pages/login_register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? '/home' // Redirect to HomeScreen if the user is already logged in
          : '/', // Show LoginPage if the user is not logged in
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/addExpense': (context) => AddExpenseScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  List<Map<String, dynamic>> expenses = [];
  List<Goal> goals = [];
  String topic = '';
  double amount = 0.0;
  bool showGoals = false; // Track whether to show the goals section or not

  double getTotalExpense() {
    return expenses.fold(
        0, (previousValue, element) => previousValue + element['amount']);
  }

  void addExpense(String topic, double amount) {
    if (topic.isNotEmpty && amount > 0) {
      setState(() {
        expenses.add({'topic': topic, 'amount': amount});
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid topic and amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Budget Tracker')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Hi, Welcome Back ✌️ ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Total Expenses 💰 till now',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('₹${getTotalExpense().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) => Dismissible(
                key: Key(expenses[index]['topic']),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) => deleteExpense(index),
                child: ListTile(
                  title: Text(expenses[index]['topic']),
                  subtitle:
                      Text('₹${expenses[index]['amount'].toStringAsFixed(2)}'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            topic = value;
                          },
                          decoration: InputDecoration(labelText: 'Topic'),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          onChanged: (value) {
                            amount = double.tryParse(value) ?? 0.0;
                          },
                          decoration:
                              InputDecoration(labelText: 'Enter Amount'),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            addExpense(topic, amount);
                            Navigator.pop(context);
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text('Add Expense'),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showGoals = !showGoals;
              });
            },
            child: Text(showGoals ? 'Hide Goals' : 'See Goals'),
          ),
          if (showGoals)
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(goals[index].topic),
                  subtitle: Text(
                      'Target Amount: ₹${goals[index].targetAmount.toStringAsFixed(2)}'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// AddExpenseScreen and other classes remain the same

class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          title: Text('Expense $index'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addExpense'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Expense Value'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add expense logic
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}

class Goal {
  final String topic;
  final double targetAmount;

  Goal(this.topic, this.targetAmount);
}
