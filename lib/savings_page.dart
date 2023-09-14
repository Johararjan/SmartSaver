import 'package:expense_tracker/settings_page.dart';
import 'package:expense_tracker/summary_page.dart';
import 'package:flutter/material.dart';

import 'expense_income.dart';

class Goal {
  String name;
  double targetAmount;
  DateTime finishDate;
  String priorityLabel; // Priority label (Low, Medium, High)

  Goal(this.name, this.targetAmount, this.finishDate, this.priorityLabel);
}


class FinancialGoalsPage extends StatefulWidget {
  @override
  _FinancialGoalsPageState createState() => _FinancialGoalsPageState();
}

class _FinancialGoalsPageState extends State<FinancialGoalsPage> {
  List<Goal> goals = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController targetDateController = TextEditingController(text: 'Select Date');
  TextEditingController priorityController = TextEditingController(text: 'Priority Low');
  int _bottomNavigationBarIndex = 2; // Index for the selected tab
  DateTime? selectedDate;
  // Define priority labels
  static const String lowPriorityLabel = 'Low';
  static const String mediumPriorityLabel = 'Medium';
  static const String highPriorityLabel = 'High';

  // Function to convert priority labels to integer values for sorting
  int priorityLabelToInt(String priorityLabel) {
    switch (priorityLabel) {
      case lowPriorityLabel:
        return 0;
      case mediumPriorityLabel:
        return 1;
      case highPriorityLabel:
        return 2;
      default:
        return 0; // Default to Low priority
    }
  }

  // Sort goals by priority label (High > Medium > Low)
  void sortGoalsByPriority() {
    goals.sort((a, b) =>
    priorityLabelToInt(b.priorityLabel) -
        priorityLabelToInt(a.priorityLabel));
  }
  Goal? selectedGoal;
  void _onBottomNavBarIndexChanged(int index) {
    setState(() {
      _bottomNavigationBarIndex = index;
      if (index == 3) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
          ),
        );
      }
      if (index == 2) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FinancialGoalsPage(),
          ),
        );
      }
      if (index == 1) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IncomeExpenseAddPage(),
          ),
        );
      }
      if (index == 0) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SummaryPage(),
          ),
        );
      }
    });
  }
  double calculateProgress(Goal goal) {
    final currentSavings = calculateCurrentSavings(goal);
    return currentSavings / goal.targetAmount;
  }

  double calculateCurrentSavings(Goal goal) {
    // You can calculate current savings based on user's transactions and expenses.
    // Implement your logic here.
    return 0.00;
  }

  String getSavingsSuggestions() {
    // Analyze user's expenses and offer tailored suggestions.
    // Implement your logic here.
    return "Consider cutting down on dining out to save more.";
  }

  void _editGoal(Goal goal) {
    // Fill the form with the selected goal's data for editing
    nameController.text = goal.name;
    targetAmountController.text = goal.targetAmount.toString();
    selectedDate = goal.finishDate;
    priorityController.text = goal.priorityLabel; // Set the priority label

    setState(() {
      selectedGoal = goal;
    });

    // Show the dialog for editing
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Goal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff3AA6B9),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Goal Name',
                    labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                  ),
                ),
                TextField(
                  controller: targetAmountController,
                  decoration: InputDecoration(
                    labelText: 'Target Amount (\$)',
                    labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: targetDateController,
                  decoration: InputDecoration(
                    labelText: 'Finish Date',
                    labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                  ),
                  onTap: () => _selectDate(context), // Make the TextField tappable to open the date picker
                ),
                TextFormField(
                  controller: priorityController,
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                  ),
                  readOnly: true, // Make it read-only to prevent manual editing
                  onTap: () {
                    // Show a dialog with the priority options when tapped
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Select Priority',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3AA6B9),
                            ),
                          ),
                          content: Container(
                            width: double.maxFinite,
                            child: DropdownButtonFormField<String>(
                              value: priorityController.text,
                              items: [
                                lowPriorityLabel,
                                mediumPriorityLabel,
                                highPriorityLabel,
                              ].map((priorityLabel) {
                                return DropdownMenuItem<String>(
                                  value: priorityLabel,
                                  child: Text('Priority $priorityLabel'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  priorityController.text = value ?? lowPriorityLabel;
                                });
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              decoration: InputDecoration(
                                labelText: 'Priority',
                                labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the form dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff3AA6B9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _addGoal(); // Update the goal
                Navigator.of(context).pop(); // Close the form dialog
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Color(0xff3AA6B9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addGoal() {
    if (nameController.text.isNotEmpty &&
        targetAmountController.text.isNotEmpty &&
        selectedDate != null) {
      if (selectedGoal == null) {
        final newGoal = Goal(
          nameController.text,
          double.parse(targetAmountController.text),
          selectedDate!,
          priorityController.text, // Store the priority label
        );

        setState(() {
          goals.add(newGoal);
        });
      } else {
        // Editing an existing goal
        setState(() {
          selectedGoal!.name = nameController.text;
          selectedGoal!.targetAmount = double.parse(targetAmountController.text);
          selectedGoal!.finishDate = selectedDate!;
          selectedGoal!.priorityLabel = priorityController.text; // Update priority label
          selectedGoal = null; // Clear the selected goal after editing
        });
      }
    }

    // Sort goals by priority after adding/editing
    sortGoalsByPriority();

    // Clear the form fields and reset selected values
    nameController.clear();
    targetAmountController.clear();
    selectedDate = null;
    priorityController.text = lowPriorityLabel; // Reset priority label to Low
  }



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      targetDateController.text = "${picked.toLocal()}".split(' ')[0];

    }
  }




  void _deleteGoal(Goal goal) {
    setState(() {
      goals.remove(goal);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Financial Goals',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3AA6B9),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  final remainingDays = goal.finishDate
                      .difference(DateTime.now())
                      .inDays;
                  final progress = calculateProgress(goal);
                  return Dismissible(
                      key: Key(goal.name), // Use a unique key for each goal
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          // User swiped to delete
                          _deleteGoal(goal);
                        }
                      },
                      background: Container(
                        color: Colors.red, // Background color when swiping to delete
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    child: Card(
                      color: Color(0xff3AA6B9),
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          goal.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Target Amount: \$${goal.targetAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                            Text(
                              'Finish Date: ${goal.finishDate.toLocal().toString().split(' ')[0]}',
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff3AA6B9),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Priority: ${goal.priorityLabel}',
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Remaining Days: $remainingDays',
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Suggestions:',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getSavingsSuggestions(),
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _editGoal(goal); // Edit the goal when tapped
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

          ],

        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavigationBarIndex,
          onTap: _onBottomNavBarIndexChanged,
          selectedItemColor: Color(0xff3AA6B9), // Change this color to your desired color
          unselectedItemColor: Color(0xff727272),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Expenses/Income',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), // Icon for Savings
              label: 'Savings', // Label for Savings
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedLabelStyle: TextStyle(color: Color(0xff3AA6B9)),
          unselectedLabelStyle: TextStyle(color: Color(0xff727272)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Clear the form fields when adding a new goal
            nameController.clear();
            targetAmountController.clear();
            selectedDate = null;
            priorityController.text = lowPriorityLabel; // Set default priority label to Low
            selectedGoal = null; // Clear the selected goal

            // Show the dialog for adding a new goal
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Add Goal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3AA6B9),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Goal Name',
                            labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                          ),
                        ),
                        TextField(
                          controller: targetAmountController,
                          decoration: InputDecoration(
                            labelText: 'Target Amount (\$)',
                            labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: targetDateController,
                          decoration: InputDecoration(
                            labelText: 'Finish Date',
                            labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                          ),
                          onTap: () => _selectDate(context), // Make the TextField tappable to open the date picker
                        ),
                        TextFormField(
                          controller: priorityController,
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                          ),
                          readOnly: true,
                          onTap: () {
                            // Show a dialog with the priority options when tapped
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Select Priority',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3AA6B9),
                                    ),
                                  ),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: DropdownButtonFormField<String>(
                                      value: priorityController.text,
                                      items: [
                                        lowPriorityLabel,
                                        mediumPriorityLabel,
                                        highPriorityLabel,
                                      ].map((priorityLabel) {
                                        return DropdownMenuItem<String>(
                                          value: priorityLabel,
                                          child: Text('Priority $priorityLabel'),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          priorityController.text = value ?? lowPriorityLabel;
                                        });
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Priority',
                                        labelStyle: TextStyle(color: Color(0xff3AA6B9)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the form dialog
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _addGoal(); // Update the goal
                        Navigator.of(context).pop(); // Close the form dialog
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),

      ),
      );
    }

}
