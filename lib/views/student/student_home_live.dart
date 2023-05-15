import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/controllers/student/student.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:i_dance/views/instructor/instructor_home.dart';
import 'package:i_dance/views/student/dance_class_details.dart';
import 'package:i_dance/widgets/student/dance_class_card.dart';
import 'package:i_dance/widgets/my_appbar.dart';
import 'package:i_dance/widgets/student/student_class_card.dart';

class StudentHomeLivePage extends StatefulWidget {
  const StudentHomeLivePage({Key? key}) : super(key: key);

  @override
  _StudentHomeLivePageState createState() => _StudentHomeLivePageState();
}

class _StudentHomeLivePageState extends State<StudentHomeLivePage> {
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
      List<String> tempList = [];
      items.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      });
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(tempList);
      });
      return;
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
        child:  Column(
                children: [
                  
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
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
                  Obx((){
                        if(Get.find<DanceClassController>().upcomingDanceClasses.isEmpty){
                          return Text("Empty");
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: Get.find<DanceClassController>().upcomingDanceClasses.length,
                            itemBuilder: (context, idx){
                              print(Get.find<StudentController>().isBookedClasses(Get.find<DanceClassController>().upcomingDanceClasses[idx].danceClassId));
                                return DanceClassCard(liveClass: Get.find<DanceClassController>().upcomingDanceClasses.elementAt(idx));
                            }
                          ),
                        );
                  })
                  // FutureBuilder(
                  //   future: Get.find<DanceClassController>().populateUpcomingClasses(),
                  //   builder: (context, snapshot) {
                  //     if(snapshot.hasData){
                  //       print(Get.find<DanceClassController>().upcomingDanceClasses);
                        
                  //     }
                  //   return Text("loading");
                  //   }
                  // ),
                ],
              )
      ),
    );
  }
}
