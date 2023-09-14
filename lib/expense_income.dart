import 'package:expense_tracker/savings_page.dart';
import 'package:expense_tracker/settings_page.dart';
import 'package:expense_tracker/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';// Import image_picker package
import 'package:permission_handler/permission_handler.dart';
class IncomeExpenseAddPage extends StatefulWidget {
  @override
  _IncomeExpenseAddPageState createState() => _IncomeExpenseAddPageState();
}
class _IncomeExpenseAddPageState extends State<IncomeExpenseAddPage> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int _bottomNavigationBarIndex = 1; // Index for the selected tab
  double _expenseIncomeSliderValue = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Heading
          SizedBox(height:30.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Financial Transaction Entry",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff3AA6B9),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // Slider with Expense and Income Page
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                  child: Text(
                    "Expense Entry",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: _currentPage == 0
                          ? FontWeight.bold
                          : FontWeight.bold,
                      color: _currentPage == 0 ? Color(0xff3AA6B9) : Color(0xff727272),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                  child: Text(
                    "Income Entry",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: _currentPage == 1
                          ? FontWeight.bold
                          : FontWeight.bold,
                      color: _currentPage == 1 ? Color(0xff3AA6B9) : Color(0xff727272),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // PageView for Expense and Income Forms
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                // Expense Form with Slider
                ExpenseTransactionForm(),
                // Income Form
                IncomeTransactionForm(),
              ],
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
    );
  }
}

class ExpenseTransactionForm extends StatefulWidget {
  @override
  _ExpenseTransactionFormState createState() => _ExpenseTransactionFormState();
}

class _ExpenseTransactionFormState extends State<ExpenseTransactionForm> {
  PageController _transactionPageController = PageController(initialPage: 0);
  int _currentTransactionPage = 0;

  @override
  void dispose() {
    _transactionPageController.dispose();
    super.dispose();
  }

  void _onTransactionPageChanged(int page) {
    setState(() {
      _currentTransactionPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Slider between Online Expense and Cash Expense
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _transactionPageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Text(
                    "Online Expense",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: _currentTransactionPage == 0
                          ? FontWeight.bold
                          : FontWeight.bold,
                      color: _currentTransactionPage == 0
                          ? Color(0xff3AA6B9) : Color(0xff727272),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _transactionPageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Text(
                    "Cash Expense",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: _currentTransactionPage == 1
                          ? FontWeight.bold
                          : FontWeight.bold,
                      color: _currentTransactionPage == 1
                          ? Color(0xff3AA6B9) : Color(0xff727272),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PageView for Online Expense and Cash Expense Forms
          Expanded(
            child: PageView(
              controller: _transactionPageController,
              onPageChanged: _onTransactionPageChanged,
              children: [
                // Online Expense Form (Same as Expense Form)
                TransactionForm(),
                // Cash Expense Form with Photo Options
                CashTransactionForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap the entire body in SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Fill the Online Expense details below",
                  style: TextStyle(
                    color: Color(0xff3AA6B9),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Container for Amount input field
              Container(
                //width: 350,
                decoration: BoxDecoration(
                  color: Color(0xffb2f3f3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Icon(Icons.attach_money, color: Color(0xff3AA6B9)),
                    labelStyle: TextStyle(
                      color: Color(0xff3AA6B9),
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 30),
              // Container for Date input field with date picker
              Container(
                width: 350,
                decoration: BoxDecoration(
                  color: Color(0xffb2f3f3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      prefixIcon: Icon(Icons.calendar_today, color: Color(0xff3AA6B9)),
                      labelStyle: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    child: Text(
                      _selectedDate != null
                          ? "${_selectedDate!.toLocal()}".split(' ')[0]
                          : 'Select Date',
                      style: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Container for Category dropdown
              Container(
                // Remove the fixed width for responsiveness
                // width: 350,
                decoration: BoxDecoration(
                  color: Color(0xffb2f3f3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButtonFormField<String>(
                  items: [
                    "Housing",
                    "Transportation",
                    "Food and Dining",
                    "Utilities",
                    "Personal Expense",
                    "Miscellaneous",
                    // Add more category names as needed
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // Handle category selection
                  },
                  decoration: InputDecoration(
                    labelText: "Category",
                    prefixIcon: Icon(Icons.category, color: Color(0xff3AA6B9)),
                    labelStyle: TextStyle(
                      color: Color(0xff3AA6B9),
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),


              SizedBox(height: 30),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Handle form submission here
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3AA6B9)),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CashTransactionForm extends StatefulWidget {
  @override
  _CashTransactionFormState createState() => _CashTransactionFormState();
}

class _CashTransactionFormState extends State<CashTransactionForm> {
  bool _photoUploaded = false;
  String? scannedData; // Store scanned data here
  DateTime? _selectedDate;
  String? selectedCategory;

  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> requestPermissions() async {
    // Request camera permission
    var cameraStatus = await Permission.camera.request();
    // Request photo library permission
    var photoStatus = await Permission.photos.request();

    // Check if permissions were granted
    if (cameraStatus.isGranted && photoStatus.isGranted) {
      // Permissions granted, you can proceed.
    } else {
      // Permissions not granted, handle accordingly (e.g., show an explanation).
    }
  }

  // Function to handle clicking a photo
  Future<void> _handleClickPhoto() async {
    requestPermissions();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Handle scanned data here, you can use image processing libraries
      // For now, simulate data
      setState(() {
        scannedData =
        "Scanned Amount: 100.00\nScanned Date: 2023-08-29\nScanned Category: Category 1";
        _photoUploaded = true;
      });
    }
  }

  // Function to handle uploading a photo
  Future<void> _handleUploadPhoto() async {
    requestPermissions();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle scanned data here, you can use image processing libraries
      // For now, simulate data
      setState(() {
        scannedData =
        "Scanned Amount: 100.00\nScanned Date: 2023-08-29\nScanned Category: Category 1";
        _photoUploaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // Center the form fields
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Fill the Cash Expense Details below",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xff3AA6B9),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xffb2f3f3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  prefixIcon: Icon(
                      Icons.attach_money, color: Color(0xff3AA6B9)),
                  labelStyle: TextStyle(
                    color: Color(0xff3AA6B9),
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                keyboardType: TextInputType.number,
                initialValue: scannedData != null &&
                    scannedData!.contains("Scanned Amount:")
                    ? scannedData?.split("Scanned Amount:")[1].split("\n")[0]
                    .trim()
                    : null,
              ),
            ),
            SizedBox(height: 30),
            // Container for Date input field with date picker
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xffb2f3f3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today, color: Color(0xff3AA6B9)),
                    labelStyle: TextStyle(
                      color: Color(0xff3AA6B9),
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    _selectedDate != null
                        ? "${_selectedDate!.toLocal()}".split(' ')[0]
                        : 'Select Date',
                    style: TextStyle(
                      color: Color(0xff3AA6B9),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xffb2f3f3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCategory, // Set the initial value here
                items: [
                  "Housing",
                  "Transportation",
                  "Food and Dining",
                  "Utilities",
                  "Personal Expense",
                  "Miscellaneous",
                  // Add more category names as needed
                ].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value; // Update the selected category
                  });
                },
                decoration: InputDecoration(
                  labelText: "Category",
                  prefixIcon: Icon(Icons.category, color: Color(0xff3AA6B9)),
                  labelStyle: TextStyle(
                    color: Color(0xff3AA6B9),
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _handleClickPhoto,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff3AA6B9)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Click a Photo",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _handleUploadPhoto,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff3AA6B9)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Upload a Photo",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],

            ),
            SizedBox(height: 30),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Handle form submission here
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3AA6B9)),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeTransactionForm extends StatefulWidget {
  @override
  _IncomeTransactionFormState createState() => _IncomeTransactionFormState();
}

class _IncomeTransactionFormState extends State<IncomeTransactionForm> {
  DateTime? _selectedDate;
  String? _selectedSource;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                "Fill in the Income details below",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3AA6B9),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xffb2f3f3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  prefixIcon: Icon(Icons.attach_money, color: Color(0xff3AA6B9)),
                  labelStyle: TextStyle(
                    color: Color(0xff3AA6B9),
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xffb2f3f3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today, color: Color(0xff3AA6B9)),
                    labelStyle: TextStyle(
                      color: Color(0xff3AA6B9),
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    _selectedDate != null
                        ? "${_selectedDate!.toLocal()}".split(' ')[0]
                        : 'Select Date',
                    style: TextStyle(
                      color: Color(0xff3AA6B9),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 350, // Adjust the width as needed
              decoration: BoxDecoration(
                color: Color(0xffb2f3f3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonFormField<String>(
                items: [
                  "Employment Income (Salary or Wages)",
                  "Business Profits",
                  "Investment Income",
                  "Rental Income",
                  // Add more category names as needed
                ].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(
                        color: Color(0xff3AA6B9),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // Handle category selection
                },
                decoration: InputDecoration(
                  labelText: "Category",
                  prefixIcon: Icon(Icons.category, color: Color(0xff3AA6B9)),
                  labelStyle: TextStyle(
                    color: Color(0xff3AA6B9),
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                // Add this property to ensure the dropdown menu is displayed above
                // when there's limited space below
                isExpanded: true,
                // Add this property to control the position of the dropdown menu
                // (adjust it as needed)
                dropdownColor: Color(0xffffffff),
              ),
            ),

            SizedBox(height: 30),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Handle form submission here
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3AA6B9)),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
