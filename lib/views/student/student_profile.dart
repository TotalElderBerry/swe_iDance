import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/views/student/dance_recorded_page.dart';
import 'package:i_dance/widgets/student/dance_class_card.dart';
import 'package:i_dance/widgets/student/pending_class_card.dart';
import '../../widgets/student/profile_dropdown.dart';
import '../../widgets/student/student_class_card.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Brian Keith Lisondra",
                          style: Theme.of(context).textTheme.labelLarge),
                      const Chip(
                          label: Text("Beginner"),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              VisualDensity(horizontal: 0.0, vertical: -4))
                    ],
                  ),
                ],
              ),
            ),
            StudentDropdown(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Text("Upcoming",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    Tab(
                      icon: Text("Pending",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    Tab(
                      icon: Text("Done",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    Tab(
                      icon: Text("Likes",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StudentClassCard(
                    fromPage: 'CardUpcoming',
                  ),
                  StudentClassCard(
                    fromPage: 'CardPending',
                  ),
                  Column(
                    children: const [
                      Text('This is Done.'),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('This is Likes.'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
