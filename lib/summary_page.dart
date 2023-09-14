import 'package:expense_tracker/savings_page.dart';
import 'package:expense_tracker/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'expense_income.dart';
FirebaseAuth auth = FirebaseAuth.instance;

final firebase_auth.User? user = FirebaseAuth.instance.currentUser;

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int _bottomNavigationBarIndex = 0; // Index for the selected tab
  int _pageViewIndex = 0;


  void _onSliderIndexChanged(int index) {
    setState(() {
      _pageViewIndex = index;
    });
  }

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


  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  final List<Widget> _pages = [
    SummaryPage(), // Dashboard page
    IncomeExpenseAddPage(), // Expenses/Income page
   // SavingsPage(), // Savings page
    SettingsPage(), // Settings page
  ];
  // Pie Chart Data
  Map<String, double> categoryData = {
    'Food \$300': 300.0,
    'Shopping \$150': 150.0,
    'Entertainment \$100': 100.0,
    'Transportation \$200': 200.0,
  };

  Map<String, double> incomeExpenseSavingsData = {
      'Expenses \$650': 650.0,
      'Savings \$300': 350.0,
  };

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Pie Charts Page
      Column(
        children: <Widget>[
          SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Category Distribution',
                      style: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 280, // Adjust the height as needed
                      child: PieChart(
                        dataMap: categoryData,
                        animationDuration: Duration(seconds: 1),
                        chartLegendSpacing: 10.0,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.bottom,
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Income Distribution',
                      style: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 280, // Adjust the height as needed
                      child: PieChart(
                        dataMap: incomeExpenseSavingsData,
                        animationDuration: Duration(seconds: 1),
                        chartLegendSpacing: 10.0,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.bottom,
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 0,
                        ),
                        totalValue: 1000,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      // Transactions Page
      ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(transactions[index]),
          );
        },
      ),
    ];
    return Scaffold(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Date selectors
          SizedBox(height:30),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Financial Dashboard',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff3AA6B9),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Start Date',
                              style: TextStyle(
                                color: Color(0xff3AA6B9),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: startDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (selectedDate != null && selectedDate != startDate) {
                                  setState(() {
                                    startDate = selectedDate;
                                  });
                                }
                              },
                              controller: TextEditingController(
                                text: "${startDate.toLocal()}".split(' ')[0],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'End Date',
                              style: TextStyle(
                                color: Color(0xff3AA6B9),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: endDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (selectedDate != null && selectedDate != endDate) {
                                  setState(() {
                                    endDate = selectedDate;
                                  });
                                }
                              },
                              controller: TextEditingController(
                                text: "${endDate.toLocal()}".split(' ')[0],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement action when the submit button is pressed
                            // You can use the selected startDate and endDate
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3AA6B9)),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to Pie Charts
                    _onSliderIndexChanged(0);
                  },
                  child: Text(
                    'Pie Charts',
                    style: TextStyle(
                      fontWeight: _pageViewIndex == 0 ? FontWeight.bold : FontWeight.w600,
                      color: _pageViewIndex == 0 ? Color(0xff3AA6B9) : Color(0xff727272),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to Transactions
                    _onSliderIndexChanged(1);
                  },
                  child: Text(
                    'Transactions View',
                    style: TextStyle(
                      fontWeight: _pageViewIndex == 1 ? FontWeight.bold : FontWeight.w600,
                      color: _pageViewIndex == 1 ? Color(0xff3AA6B9) : Color(0xff727272),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Add PageView for sliding between Pie Charts and Transactions
          Expanded(
            child: PageView(
              controller: PageController(initialPage: _pageViewIndex),
              onPageChanged: _onSliderIndexChanged,
              children: pages,
            ),
          ),

          // Heading for Slider View
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
    );
  }
}

// Define your transaction data
final List<String> transactions = [
  'Transaction 1',
  'Transaction 2',
  'Transaction 3',
  // Add your transactions here
];