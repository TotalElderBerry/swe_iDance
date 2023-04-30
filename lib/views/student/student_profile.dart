import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/student/student.dart';

import '../../widgets/student/dance_class_card.dart';

class StudentProfilePage extends StatelessWidget{
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Brian Keith Lisondra",style: Theme.of(context).textTheme.labelLarge),
                        Chip(label: Text("Beginner"),materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,visualDensity: VisualDensity(horizontal: 0.0, vertical: -4))
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20,),
    
              DefaultTabController(length: 4, child: Container(
                  child: TabBar(
                    isScrollable: true,
                    onTap: (int indx){
                       if(indx == 0){
                          Get.find<StudentController>().getBookedClasses();
                        }
                        if(indx == 1){
                          Get.find<StudentController>().getPendingClasses();
                        }
                    },
                    tabs: [
                    Tab(
                      icon: Text("Upcoming", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Tab(
                      icon: Text("Pending", style: Theme.of(context).textTheme.bodyMedium),
          
                    ),
                    Tab(
                      icon: Text("Done", style: Theme.of(context).textTheme.bodyMedium),
          
                    ),
                    Tab(
                      icon: Text("Likes", style: Theme.of(context).textTheme.bodyMedium),
          
                    ),
                  ])
          
          
                )),
                SizedBox(height: 30,),
              
                const SizedBox(height: 10,),
              // Row(
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(
              //         hintText: "Search"
              //       ),
              //     ),
              //     IconButton(onPressed: null, icon: Icon(Icons.filter))
              //   ],
              // ),
    
    
    
    
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FutureBuilder(
                    future: Get.find<StudentController>().getStudentDanceClass(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if (Get.find<StudentController>().studentBookingClasses.isEmpty) {
                            return Text("No data");
                        }
                       
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx((){
                                return Expanded(
                                  child: ListView.builder(itemCount: Get.find<StudentController>().filteredBookingClass.length ,itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DanceClassCard(
                                            liveClass:
                                            Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!
                                          ),
                                          // DanceClassCard(),
                                        ],
                                      );
                                  }),
                                );
                              }),
                            ],
                          );
                      }
                      return Text("Number");
                    }
                  ),
                ),
            ],
          ),
        );
      }
    );
  }

}