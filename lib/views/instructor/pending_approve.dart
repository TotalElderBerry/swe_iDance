import 'package:flutter/material.dart';

class Pending_Approve extends StatelessWidget {
  const Pending_Approve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: 10),
            TabBar(
              tabs: [
                Tab(
                  icon: Text("Pending",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Tab(
                  icon: Text("Approved",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Tab(
                  icon: Text("Cancel",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
