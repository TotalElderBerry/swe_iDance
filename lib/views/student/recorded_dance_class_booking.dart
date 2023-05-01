import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecordedDanceClassBooking extends StatelessWidget {
  const RecordedDanceClassBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Recorded Dance CLass Booking")
          ],
        ),
      ),
    );
  }
}