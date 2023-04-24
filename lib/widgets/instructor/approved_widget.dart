import 'package:flutter/material.dart';

import '../../models/studentlist_model.dart';

class ApprovedWidget extends StatefulWidget {
  const ApprovedWidget({super.key});

  @override
  State<ApprovedWidget> createState() => _ApprovedWidgetState();
}

class _ApprovedWidgetState extends State<ApprovedWidget> {
  @override
  Widget build(BuildContext context) {
    return approvedAttend.isEmpty
        ? Text('No data available.')
        : ListView.builder(
            itemCount: approvedAttend.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                  ),
                  title: Text(approvedAttend[index]["Name"]),
                  trailing: Text(approvedAttend[index]["Date"]),
                ),
              );
            },
          );
  }
}
