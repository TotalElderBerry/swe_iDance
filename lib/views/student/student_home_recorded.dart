import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/student/recorded_class_card.dart';

class StudentHomeRecordedPage extends StatefulWidget {
  const StudentHomeRecordedPage({Key? key}) : super(key: key);

  @override
  State<StudentHomeRecordedPage> createState() => _StudentHomeRecordedPageState();
}

class _StudentHomeRecordedPageState extends State<StudentHomeRecordedPage> {
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
      appBar: MyAppBar(context,isStudent: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: Get.find<AuthController>().getLoggedStudent(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
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
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.filter_2_rounded))
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        StudentClassRecordedCard(fromPage: "StudentRecordedLive",image: "https://i.ytimg.com/vi/MhaH4XkHK5A/maxresdefault.jpg", id: 0,),
                        StudentClassRecordedCard(fromPage: "StudentRecordedLive",image: "https://i.ytimg.com/vi/7eLdG8tRgO4/maxresdefault.jpg", id: 1,)
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Text("Loading pa");
            }),
      ),
    );
  }
}
