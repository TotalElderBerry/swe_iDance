import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/student/student.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/student/dance_class_card.dart';
import '../../widgets/student/student_class_card.dart';


class StudentProfilePage extends StatelessWidget{
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<StudentController>().filteredBookingClass.value =  Get.find<StudentController>().getBookedClasses();
    Get.find<StudentController>().isPending.value = false;
    return DefaultTabController(
      length: 4,
      child: Builder(
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
                        backgroundImage: NetworkImage((Get.find<AuthController>().authService.getUser()!.photoURL == null)?'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg':Get.find<AuthController>().authService.getUser()!.photoURL!),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${Get.find<AuthController>().currentUser.value!.firstName} ${Get.find<AuthController>().currentUser.value!.lastName}",style: Theme.of(context).textTheme.labelLarge),
                          Chip(label: Text("Beginner"),materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,visualDensity: VisualDensity(horizontal: 0.0, vertical: -4))
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20,),
      
                TabBar(
                  isScrollable: true,
                  onTap: (int indx){
                     if(indx == 0){
                         Get.find<StudentController>().filteredBookingClass.value =  Get.find<StudentController>().getBookedClasses();
                         Get.find<StudentController>().isPending.value = false;
                        Get.find<StudentController>().isDone.value = false;

                      }else if(indx == 1){
                        Get.find<StudentController>().filteredBookingClass.value = Get.find<StudentController>().getPendingClasses();
                        Get.find<StudentController>().isPending.value = true;
                        Get.find<StudentController>().isDone.value = false;
                        print("length is ${Get.find<StudentController>().filteredBookingClass.length}");
                      }else if(indx == 2){
                        Get.find<StudentController>().filteredBookingClass.value = Get.find<StudentController>().getDoneClasses();
                        Get.find<StudentController>().isDone.value = true;
                      }else{
                        Get.find<StudentController>().filteredBookingClass.clear();
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
                ]),
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
                      // Expanded(
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(24.0),
                      //       child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   Obx((){
                      //                     if(Get.find<StudentController>().filteredBookingClass.isEmpty){
                      //                       return Text("Empty");
                      //                     }
                      //                     print("inside obx");
                      //                     return Expanded(
                      //                       child: ListView.builder(itemCount: Get.find<StudentController>().filteredBookingClass.length ,itemBuilder: (context, index) {
                      //                           return Row(
                      //                             mainAxisAlignment: MainAxisAlignment.center,
                      //                             children: [
                      //                               StudentClassCard(isPending: Get.find<StudentController>().isPending.value, liveDance: Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!)
                      //                               // DanceClassCard(
                      //                               //   liveClass:
                      //                               //   Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!
                      //                               // ),
                      //                               // Text(Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!.danceName)
                      //                               // DanceClassCard(),
                      //                             ],
                      //                           );
                      //                       }),
                      //                     );
                      //                   }),
                      //                 ],
                      //               )
                      //     ),
                      //   ),
    
                      Expanded(
                        child: TabBarView(children: [
                              Expanded(
                                child:  Obx((){
                                  if(Get.find<StudentController>().filteredBookingClass.isEmpty){
                                    return Text("Empty");
                                  }
                                  print("inside obx");
                                  return Expanded(
                                    child: ListView.builder(itemCount: Get.find<StudentController>().filteredBookingClass.length ,itemBuilder: (context, index) {
                                        print("dance class ${Get.find<StudentController>().filteredBookingClass[index].payment!.referenceNumber}");
                                        print(Get.find<StudentController>().filteredBookingClass[index].dateApproved);
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            StudentClassCard(isPending: Get.find<StudentController>().isPending.value, liveDance: Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!)
                                           
                                          ],
                                        );
                                    }),
                                  );
                                }),
                              ),
                              // Text("A"),
                              // Text("b"),
                              // Text("c"),
                              // Text("d"),
                             
                              // StudentClassCard(isPending: Get.find<StudentController>().isPending.value, liveDance: Get.find<StudentController>().filteredBookingClass[0].liveDanceClass!),
                              // StudentClassCard(isPending: Get.find<StudentController>().isPending.value, liveDance: Get.find<StudentController>().filteredBookingClass[0].liveDanceClass!),
                              // StudentClassCard(isPending: Get.find<StudentController>().isPending.value, liveDance: Get.find<StudentController>().filteredBookingClass[0].liveDanceClass!),
                        ]),
                      ),
      
                  // TabBarView(children: [
                  //       Expanded(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(24.0),
                  //           child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //                       Obx((){
                  //                         if(Get.find<StudentController>().filteredBookingClass.isEmpty){
                  //                           return Text("Empty");
                  //                         }
                  //                         print("inside obx");
                  //                         return Expanded(
                  //                           child: ListView.builder(itemCount: Get.find<StudentController>().filteredBookingClass.length ,itemBuilder: (context, index) {
                  //                               return Row(
                  //                                 mainAxisAlignment: MainAxisAlignment.center,
                  //                                 children: [
                  //                                   DanceClassCard(
                  //                                     liveClass:
                  //                                     Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!
                  //                                   ),
                  //                                   // Text(Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!.danceName)
                  //                                   // DanceClassCard(),
                  //                                 ],
                  //                               );
                  //                           }),
                  //                         );
                  //                       }),
                  //                     ],
                  //                   )
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(24.0),
                  //           child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //                       Obx((){
                  //                         if(Get.find<StudentController>().filteredBookingClass.isEmpty){
                  //                           return Text("Empty");
                  //                         }
                  //                         print("inside obx");
                  //                         return Expanded(
                  //                           child: ListView.builder(itemCount: Get.find<StudentController>().filteredBookingClass.length ,itemBuilder: (context, index) {
                  //                               return Row(
                  //                                 mainAxisAlignment: MainAxisAlignment.center,
                  //                                 children: [
                  //                                   DanceClassCard(
                  //                                     liveClass:
                  //                                     Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!
                  //                                   ),
                  //                                   // Text(Get.find<StudentController>().filteredBookingClass[index].liveDanceClass!.danceName)
                  //                                   // DanceClassCard(),
                  //                                 ],
                  //                               );
                  //                           }),
                  //                         );
                  //                       }),
                  //                     ],
                  //                   )
                  //         ),
                  //       ),
                  //       Text("Done"),
                  //       Text("Likes"),
                  // ])
                  ],
      
            ),
          );
        }
      ),
    );
  }

}
