import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DanceClassDetails extends StatelessWidget {
  const DanceClassDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
           ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                              fit: BoxFit.contain,
                              height: 150,
                              ),
                          ),
        ],
      ),
    );
  }
}