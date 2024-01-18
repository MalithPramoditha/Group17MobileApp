// import 'package:flutter/material.dart';
// import 'package:facultyreservation/search/date_picker_widget.dart';

// class SearchScreen extends StatelessWidget {
//   final ScrollController controller;

//   SearchScreen({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Search',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF003580),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         color: const Color(0xFFFFFFFF),
//         child: ListView(
//           controller: controller,
//           children: [
//             Expanded(
//               child: Center(
//                 child: DatePicker(
//                   startDate: DateTime.now(),
//                   width: 60,
//                   height: 80,
//                   controller: DatePickerController(), 
//                   onDateChange: (selectedDate) {
//                     print(selectedDate);
//                   },
//                   monthTextStyle: TextStyle(color: Colors.black), 
//                   dayTextStyle: TextStyle(color: Colors.black), 
//                   dateTextStyle: TextStyle(color: Colors.black),
//                   selectedTextColor: Colors.white, 
//                   selectionColor: Colors.blue, 
//                   deactivatedColor: Colors.grey, 
//                   daysCount: 500, 
//                   locale: "en_US",
//                   initialSelectedDate: DateTime.now(),
//                   activeDates: [/* Add your list of active dates here */],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   final ScrollController controller;

//   SearchScreen({required this.controller});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final ScrollController _resultController = ScrollController();
//   String hallName = "";
//   List<String> searchResults = [];

//   void updateHallName(String value) {
//     setState(() {
//       hallName = value;
//     });
//   }

//   void clearHallName() {
//     setState(() {
//       hallName = "";
//       searchResults.clear(); // Clear the search results when clearing the hall name
//     });
//   }

//   // Function to fetch reservations from the database based on hall name
//   Future<void> fetchReservations(String hallName) async {
//     // Replace with actual database fetching logic
//     // Simulate fetching data from the database based on the hall name
//     await Future.delayed(Duration(seconds: 2));

//     // Simulated search results
//     setState(() {
//       searchResults = List.generate(5, (index) => '$hallName Reservation ${index + 1}');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Search',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF003580),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         color: const Color(0xFFFFFFFF),
//         child: ListView(
//           controller: widget.controller,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SearchBar(
//                 onSearch: (value) async {
//                   // Handle the search button click here
//                   print("Search button clicked with hall name: $value");
//                   await fetchReservations(value);
//                 },
//                 onClear: clearHallName,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Hall Name: $hallName',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//             ),
//             // Display search results
//             ...searchResults.map((result) => ListTile(title: Text(result))),
//             // Add other widgets/components below the SearchBar
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchBar extends StatefulWidget {
//   final void Function(String) onSearch;
//   final VoidCallback onClear;

//   SearchBar({required this.onSearch, required this.onClear});

//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color borderColor = const Color(0xFF003580);
//     final Color iconColor = const Color(0xFF003580);

//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: borderColor, width: 2),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Enter Hall Name',
//                 hintStyle: TextStyle(color: iconColor),
//                 contentPadding: const EdgeInsets.all(10.0),
//                 prefixIcon: Icon(Icons.search, color: iconColor),
//               ),
//               onChanged: (value) {
//                 // Handle the hall name changes here
//                 widget.onSearch(value);
//               },
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.check, color: iconColor),
//             onPressed: () {
//               // Trigger the callback when the arrow button is pressed
//               widget.onSearch(_searchController.text);
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.clear, color: iconColor),
//             onPressed: () {
//               // Clear the hall name and trigger the callback
//               _searchController.clear();
//               widget.onClear();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/database.dart';

class SearchScreen extends StatefulWidget {
  final ScrollController controller;

  SearchScreen({required this.controller});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String hallName = "";
  List<Map<String, dynamic>> searchResults = [];

  void updateHallName(String value) {
    setState(() {
      hallName = value;
    });
  }

  void clearHallName() {
    setState(() {
      hallName = "";
      searchResults.clear(); // Clear the search results when clearing the hall name
    });
  }

  Future<void> fetchReservations(String hallName) async {
    try {
      // Replace this with actual logic to fetch reservations from the database
      List<Map<String, dynamic>> results = await DatbaseMethods().getReservationsByHallName(hallName);

      setState(() {
        searchResults = results;
      });
    } catch (e) {
      print("Error fetching reservations: $e");
      Fluttertoast.showToast(
        msg: "Error fetching reservations",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: ListView(
          controller: widget.controller,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(
                onSearch: (value) async {
                  // Handle the search button click here
                  print("Search button clicked with hall name: $value");
                  await fetchReservations(value);
                },
                onClear: clearHallName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Filtered Reservations',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF003580),),
                    ),
                  ),
                ],
              ),
            ),
            // Display search results
            ...searchResults.map((result) => ReservationItem(result)),
            // Add other widgets/components below the SearchBar
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final void Function(String) onSearch;
  final VoidCallback onClear;

  SearchBar({required this.onSearch, required this.onClear});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = const Color(0xFF003580);
    final Color iconColor = const Color(0xFF003580);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter Lecture Hall',
                hintStyle: TextStyle(color: iconColor),
                contentPadding: const EdgeInsets.all(10.0),
                prefixIcon: Icon(Icons.search, color: iconColor),
              ),
              onChanged: (value) {
                // Handle the hall name changes here
                widget.onSearch(value);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.check, color: iconColor),
            onPressed: () {
              // Trigger the callback when the arrow button is pressed
              widget.onSearch(_searchController.text);
            },
          ),
          IconButton(
            icon: Icon(Icons.clear, color: iconColor),
            onPressed: () {
              // Clear the hall name and trigger the callback
              _searchController.clear();
              widget.onClear();
            },
          ),
        ],
      ),
    );
  }
}

class ReservationItem extends StatelessWidget {
  final Map<String, dynamic> reservation;

  ReservationItem(this.reservation);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0,right: 20, left: 20),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            image: DecorationImage(
              image: AssetImage("assets/reservations.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              _buildDataRow("Lecturer Name", reservation["Full Name"]),
              _buildDataRow("Lecture Hall", reservation["Hall"]),
              _buildDataRow("Lecture Date", reservation["Date"]),
              _buildDataRow("Lecture Time", reservation["Time"]),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            child: Text(
              "$label",
              style: TextStyle(
                color: const Color(0xFF003580),
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

