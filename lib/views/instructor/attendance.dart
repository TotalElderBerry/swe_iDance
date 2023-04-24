import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/instructor/attended_widget.dart';
import '../../widgets/instructor/fulllist_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.custom,
                  widget: Image.network(
                      'https://codehunting.games/assets/images/qrcode-free-code-hunting.jpg'),
                  customAsset: null,
                );
              },
              icon: const Icon(Icons.qr_code),
            ),
          ],
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
                        icon: Text("Attended",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Tab(
                        icon: Text("Full List",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  AttendedWidget(),
                  FullListWidget(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 