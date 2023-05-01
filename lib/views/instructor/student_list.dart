import 'package:flutter/material.dart';
import '../../widgets/instructor/approved_widget.dart';
import '../../widgets/instructor/pending_widget.dart';

class StudentListScreen extends StatefulWidget {
  StudentListScreen({super.key, required this.initIndex});
  final int initIndex;

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.pending_outlined),
                            Text("Pending",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.approval),
                            Text("Approved",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    PendingWidget(),
                    ApprovedWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
