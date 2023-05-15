import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/models/recorded_dance_model.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/student/recorded_class_card.dart';

class StudentHomeRecordedPage extends StatefulWidget {
  const StudentHomeRecordedPage({Key? key}) : super(key: key);

  @override
  State<StudentHomeRecordedPage> createState() => _StudentHomeRecordedPageState();
}

class _StudentHomeRecordedPageState extends State<StudentHomeRecordedPage> {
  TextEditingController searchController = TextEditingController();
  List<String> items = [
    'Hello World',
    'Flutter',
    'Dart',
    'Android',
    'iOS',
    'React Native',
    'Xamarin',
    'Ionic',
    'PhoneGap',
    'Apache Cordova',
    'Unity',
    'GameMaker',
    'Godot',
    'Unreal Engine'
  ];
  List<String> filteredItems = [];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text('Edit Profile'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.school),
                label: Text('Switch to Instructor'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  void filterItems(String query) {
    if (query.isNotEmpty) {
      List<RecordedDanceClassModel> recordedClasses = [];
      final arr = Get.find<DanceClassController>().recordedClasses;
      List<String> tempList = [];
      arr.forEach((item) {
        if (item.danceName.toLowerCase().contains(query.toLowerCase())) {
          // tempList.add(item);
          recordedClasses.add(item);
        }
      });
      Get.find<DanceClassController>().searchedRecordedDanceClasses.clear();
      Get.find<DanceClassController>().searchedRecordedDanceClasses.addAll(recordedClasses);
      return;
    }else{
       Get.find<DanceClassController>().searchedRecordedDanceClasses.clear();
       Get.find<DanceClassController>().searchedRecordedDanceClasses.addAll(Get.find<DanceClassController>().recordedClasses);
    }
    setState(() {
      filteredItems.clear();
      filteredItems.addAll(items);
    });
  }

  @override
  void initState() {
    super.initState();
    filteredItems.addAll(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  filterItems(value);
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.filter_2_rounded))
                          ],
                        ),
                      ),
                    ),
                    
                      Expanded(
                        child: 
                        Obx((){
                          return ListView.builder(
                            itemCount: Get.find<DanceClassController>().searchedRecordedDanceClasses.length,
                            itemBuilder: (context,index){
                              return StudentClassRecordedCard(recordedDanceClassModel: Get.find<DanceClassController>().searchedRecordedDanceClasses[index]);
                          });

                        })
                      ),

                    // Column(
                    //   children: [
                    //     
                    //     StudentClassRecordedCard(fromPage: "StudentRecordedLive",image: "https://i.ytimg.com/vi/7eLdG8tRgO4/maxresdefault.jpg")
                    //   ],
                    // ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Column(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
      ),
    );
  }
}
