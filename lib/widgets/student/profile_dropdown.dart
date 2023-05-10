import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../views/student/dance_recorded_page.dart';

class StudentDropdown extends StatefulWidget {
  const StudentDropdown({Key? key}) : super(key: key);

  @override
  State<StudentDropdown> createState() => _StudentDropdownState();
}

class _StudentDropdownState extends State<StudentDropdown> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Transform.translate(
        offset: const Offset(-40, 0),
        child: DropdownButton(
          value: 1,
          items: [
            DropdownMenuItem(
              value: 1,
              child: Text("Live Classes"),
            ),
            DropdownMenuItem(
              child: Text("Recorded Classes"),
              value: 2,
            ),
          ],
          onChanged: (value) {
            if (value ==  2) {
              Get.to(ClassRecordedPage());
            }
          },
        ),
      ),
    );
  }
}
