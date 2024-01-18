import 'package:flutter/material.dart';

import 'package:facultyreservation/notification/basics_example.dart';
import 'package:facultyreservation/notification/complex_example.dart';
import 'package:facultyreservation/notification/events_example.dart';
import 'package:facultyreservation/notification/multi_example.dart';
import 'package:facultyreservation/notification/range_example.dart';

class NotificationScreen extends StatefulWidget {
  final ScrollController controller;

  NotificationScreen({required this.controller});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text('Calenders', style: TextStyle(color: Color(0xFF003580), fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      child: Text('Basics Calender', style: TextStyle(color: Color(0xFF003580))),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TableBasicsExample()),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      child: Text('Range Selection Calender', style: TextStyle(color: Color(0xFF003580))),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TableRangeExample()),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      child: Text('Events Calender', style: TextStyle(color: Color(0xFF003580))),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TableEventsExample()),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      child: Text('Multiple Events Calender', style: TextStyle(color: Color(0xFF003580))),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TableMultiExample()),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      child: Text('Complex Calender', style: TextStyle(color: Color(0xFF003580))),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TableComplexExample()),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),             
              // Add more widgets if needed
            ],
          ),
        ),
      ),
    );
  }
}
