import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/my_appbar.dart';

class AddRecordedDanceClassPage extends StatelessWidget {
  const AddRecordedDanceClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("Create Recorded Dance Class"),
    );
  }
}