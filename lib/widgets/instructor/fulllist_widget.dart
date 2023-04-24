import 'package:flutter/material.dart';

import '../../models/attendance_model.dart';

class FullListWidget extends StatefulWidget {
  const FullListWidget({super.key});

  @override
  State<FullListWidget> createState() => _FullListWidgetState();
}

class _FullListWidgetState extends State<FullListWidget> {
  @override
  Widget build(BuildContext context) {
    return attended.isEmpty
        ? Text('No data available.')
        : ListView.builder(
            itemCount: fullList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                    ),
                    title: Text(fullList.elementAt(index)),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Attend'),
                    )),
              );
            },
          );
  }
}
