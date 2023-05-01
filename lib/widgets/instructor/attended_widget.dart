import 'package:flutter/material.dart';
import '../../models/attendance_model.dart';

class AttendedWidget extends StatefulWidget {
  const AttendedWidget({super.key});

  @override
  State<AttendedWidget> createState() => _AttendedWidgetState();
}

class _AttendedWidgetState extends State<AttendedWidget> {
  @override
  Widget build(BuildContext context) {
    return attended.isEmpty
        ? Text('No data available.')
        : ListView.builder(
            itemCount: attended.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                  ),
                  title: Text(attended[index]["Name"]),
                  trailing: Text(attended[index]["Date"]),
                ),
              );
            },
          );
  }
}
