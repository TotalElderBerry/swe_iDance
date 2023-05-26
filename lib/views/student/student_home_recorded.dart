import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/models/recorded_dance_model.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/student/recorded_class_card.dart';

enum SortOption {
  priceAscending,
  priceDescending,
  difficultyAscending,
  difficultyDescending,
  dateAscending,
  dateDescending, difficultyAdvanced,
  emptyHaha
}

class StudentHomeRecordedPage extends StatefulWidget {
  const StudentHomeRecordedPage({Key? key}) : super(key: key);

  @override
  State<StudentHomeRecordedPage> createState() => _StudentHomeRecordedPageState();
}

class _StudentHomeRecordedPageState extends State<StudentHomeRecordedPage> {
  TextEditingController searchController = TextEditingController();
  String difficultyValue = "";
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: MyAppBar(parentContext: context, title: "", scaffoldKey: _scaffoldKey),
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
                                onPressed: () {
                                  _showFilterOptions(context);
                                },
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

void _showFilterOptions(BuildContext context) {
  SortOption priceSortOption = SortOption.priceAscending;
  SortOption difficultySortOption = SortOption.difficultyAscending;
  SortOption dateSortOption = SortOption.dateAscending;

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Options',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: SortOption.priceAscending,
                      groupValue: priceSortOption,
                      onChanged: (value) {
                        setState(() {
                          priceSortOption = value as SortOption;
                        });
                      },
                    ),
                    Text('Ascending'),
                    SizedBox(width: 10.0),
                    Radio(
                      value: SortOption.priceDescending,
                      groupValue: priceSortOption,
                      onChanged: (value) {
                        setState(() {
                          priceSortOption = value as SortOption;
                        });
                      },
                    ),
                    Text('Descending'),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  'Difficulty',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ChoiceChip(
                      label: Text('Beginner'),
                      selected: difficultySortOption == SortOption.difficultyAscending,
                      onSelected: (selected) {
                        print(selected);
                        setState(() {
                          difficultySortOption = selected? SortOption.difficultyAscending:SortOption.emptyHaha;
                          difficultyValue = selected? "Beginner":"";
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    ChoiceChip(
                      label: Text('Intermediate'),
                      selected: difficultySortOption == SortOption.difficultyDescending,
                      onSelected: (selected) {
                        setState(() {
                          difficultySortOption = selected? SortOption.difficultyDescending:SortOption.emptyHaha;
                          difficultyValue = selected? "Intermediate":"";
                        });
                      },
                    ),
                    SizedBox(width: 10.0),
                    ChoiceChip(
                      label: Text('Advanced'),
                      selected: difficultySortOption == SortOption.difficultyAdvanced,
                      onSelected: (selected) {
                        setState(() {
                          difficultySortOption = selected? SortOption.difficultyAdvanced:SortOption.emptyHaha;
                          difficultyValue = selected? "Advanced":"";
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Apply the filters and close the modal
                          // Get.find<DanceClassController>().searchedLiveDanceClasses.clear();
                          // Get.find<DanceClassController>().searchedRecordedDanceClasses.sort((a,b){
                          //   int aDaysBetween = a.price;
                          //   int bDaysBetween = b.price;
                          //   return (priceSortOption == SortOption.priceAscending)? aDaysBetween.compareTo(bDaysBetween):aDaysBetween.compareTo(bDaysBetween);
                          // });
                          switch(difficultyValue){
                            case 'Beginner':
                              difficultyValue = 'Easy';
                              break;
                            case 'Intermidiate':
                              difficultyValue = 'Medium';
                              break;
                            case 'Advanced':
                              difficultyValue = 'Hard';
                            
                          }


                          Get.find<DanceClassController>().searchedRecordedDanceClasses.value = Get.find<DanceClassController>().getRecordedClassesByDifficulty(difficultyValue);
                          Navigator.pop(context);
                        },
                        child: Text('Apply Filters'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(onPressed: (){
                        Get.find<DanceClassController>().searchedRecordedDanceClasses.clear();
                        Get.find<DanceClassController>().searchedRecordedDanceClasses.addAll(Get.find<DanceClassController>().recordedClasses);
                        Navigator.pop(context);

                      }, child: Text('Clear'))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
}
