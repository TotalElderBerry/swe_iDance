import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/add_livedance_class_page.dart';

import '../../widgets/my_appbar.dart';
import 'add_recordedclass_page.dart';

class AddClassLandingPage extends StatefulWidget {
  AddClassLandingPage({super.key});

  @override
  State<AddClassLandingPage> createState() => _AddClassLandingPageState();
}


class _AddClassLandingPageState extends State<AddClassLandingPage> {
  int? _value = 0;
  VoidCallback callBackFun = (){

  };
  List<String> optionsText = ["Recorded Dance Class", "Live Dance Class"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('Choose an item', style: Theme.of(context).textTheme.headlineMedium),
              const Divider(color: Colors.transparent,),
              Column(
                children: List<Widget>.generate(
                  2,
                  (int index) {
                    return ChoiceChip(
                      label: Container(width: 150, child: Text(optionsText[index])),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : null;

                        });
                      },
                    );
                  },
                ).toList(),
              ),
              const Spacer(),
              Container(
                width: (MediaQuery.of(context).size.width),
                child: ElevatedButton(onPressed: (_value == null)?null:(){
                Get.to((_value == 0)?AddRecordedDanceClassPage():AddLiveDanceClassPage());
                },child: Text("Next")),
              )
          ],
        ),
      ),
    );
  }
}