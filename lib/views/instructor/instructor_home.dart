import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/add_class_landing.dart';
import 'package:i_dance/widgets/student/recorded_class_card.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/instructor/instructor.dart';
import '../../models/live_dance_class.dart';
import '../../widgets/instructor/dance_class_card.dart';
import '../../widgets/instructor/recordedclass_card.dart';
import '../../widgets/instructor_appbar.dart';

import '../../utils/getDaysBetween.dart';
class LiveDanceClassDaysBetween {
  LiveDanceClassModel danceClass;
  int daysBetween;

  LiveDanceClassDaysBetween({required this.danceClass, required this.daysBetween});
}

class InstructorHome extends StatelessWidget {
  final isEmpty = false;

  InstructorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InstructorAppBar(context),
      body: Container(
        child: (isEmpty)? 
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wala pa may data. Click here para makahimo ka ug dance class"),
                TextButton(onPressed: (){
          
                }, child: Text("Click dere"))
              ],
            ),
          ),
        )
        :Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Welcome, Teacher ${Get.find<AuthController>().currentInstructor.value!.firstName}!", style: Theme.of(context).textTheme.titleLarge),
                const Divider(color: Colors.transparent,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Next Event", style: Theme.of(context).textTheme.bodyMedium,),
                    TextButton(onPressed: (){
                    
                    }, child: 
                      Text("View All", style: Theme.of(context).textTheme.bodySmall),
                    )
                  ],
                ),
            
                FutureBuilder(
                  future: Get.find<InstructorController>().getLiveClassesOfInstructorbyId(Get.find<AuthController>().currentInstructor.value!),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      // wa papud koy sure nga algo
                      List<LiveDanceClassDaysBetween> liveDances = [];
                      int i = 0;
                      for(;i< Get.find<InstructorController>().instructorDanceClass.length;i++){
                        LiveDanceClassModel temp = Get.find<InstructorController>().instructorDanceClass[i];
                        
                        LiveDanceClassDaysBetween tempDance = LiveDanceClassDaysBetween(danceClass: temp, daysBetween: getDaysBetweenFromToday(temp.date));
                        print('loop ${Get.find<InstructorController>().instructorDanceClass[i].danceName}');
                        liveDances.add(tempDance);
                      }
                      // wa pa na test nga algo
                      Get.find<InstructorController>().instructorDanceClass.sort((a,b){
                        int aDaysBetween = getDaysBetweenFromToday(a.date);
                        int bDaysBetween = getDaysBetweenFromToday(b.date);
                        return bDaysBetween.compareTo(aDaysBetween);
                      });
            
                      if(Get.find<InstructorController>().instructorDanceClass.isEmpty){
                          return Text("Empty Data");
                      }
                      return Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.all(Radius.circular(8)),
                                  //     child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                                  //     fit: BoxFit.contain,
                                  //     ),
                                  // ),
                                  (Get.find<InstructorController>().instructorDanceClass[0].img == "")?
                                  const ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                        child: SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
                                        ),
                                        // child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                                        // fit: BoxFit.contain,
                                        // height: 150,
                                        // ),
                                    ):
                        
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                            Get.find<InstructorController>().instructorDanceClass[0].img!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                                const SizedBox(height:5,),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Get.find<InstructorController>().instructorDanceClass[0].danceName, style: Theme.of(context).textTheme.headlineSmall,),
                                      const SizedBox(height:5,),
                                    
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(size: 14, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                              Text(Get.find<InstructorController>().instructorDanceClass[0].date, style: Theme.of(context).textTheme.labelSmall,),
                                            ],
                                          ),
                                          const SizedBox(width:10,),
                                
                                          Row(
                                            children: [
                                              Icon(size: 14, Icons.access_time,color: Theme.of(context).primaryColor,),
                                              Text(" 12:00 PM", style: Theme.of(context).textTheme.labelSmall,),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height:5,),
                                
                                      Row(
                                          children: [
                                            Icon(size: 14, Icons.location_on,color: Theme.of(context).primaryColor,),
                                            Text(Get.find<InstructorController>().instructorDanceClass[0].location, style: Theme.of(context).textTheme.labelSmall,),
                                          ],
                                      ),
                                    ],
                                  ),
                                ),
                                      const SizedBox(height:5,),
                                    
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(size: 12, Icons.favorite,color: Colors.red,),
                                          Text("${Get.find<InstructorController>().instructorDanceClass[0].likes}", style: Theme.of(context).textTheme.labelSmall,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 65,
                                            child: Stack(
                                              children: const [
                                                CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: NetworkImage(
                                                        'https://www.w3schools.com/w3images/avatar2.png'),
                                                  ),
                                                Positioned(
                                                  left: 20,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: NetworkImage(
                                                        'https://www.w3schools.com/w3images/avatar2.png'),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 40,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: NetworkImage(
                                                        'https://www.w3schools.com/w3images/avatar2.png',),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                      Text(" 120 are going", style: Theme.of(context).textTheme.labelSmall,),
                                    
                                        ],
                                        
                                      )
                                    ],
                                    
                                  ),
                                    
                      
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height:10,),
                                          
                          DefaultTabController(length: 3, child: Container(
                            child: TabBar(
                              onTap: (idx){
                                print(idx);
                                switch(idx){
                                  case 0:
                                      Get.find<InstructorController>().toShowList.value = Get.find<InstructorController>().getUpcomingClasses();
                                      Get.find<InstructorController>().toShowLive.value = 0;
                                    break;
                                  case 1:
                                      Get.find<InstructorController>().toShowList.value = Get.find<InstructorController>().getDoneClasses();
                                      Get.find<InstructorController>().toShowLive.value = 1;
                                    break;
                                  case 2:
                                    Get.find<InstructorController>().toShowList.clear();
                                    Get.find<InstructorController>().toShowLive.value = 2;

                                    break;
                                }
                              },
                              tabs: [
                              Tab(
                                icon: Text("Upcoming", style: Theme.of(context).textTheme.bodyMedium),
                              ),
                              Tab(
                                icon: Text("Done", style: Theme.of(context).textTheme.bodyMedium),
                                        
                              ),
                              Tab(
                                icon: Text("Recorded", style: Theme.of(context).textTheme.bodyMedium),
                                        
                              )
                            ])
                                        
                                        
                          )),
                          const SizedBox(height:10,),
                      
                          //OBX here
                      
                          // Column(
                          //   children: [
                          //     Wrap(
                          //       children: [
                          //         ListView.builder(
                          //           shrinkWrap: true,
                          //           itemCount: Get.find<InstructorController>().instructorDanceClass.length,
                          //           itemBuilder: (context,index){
                          //              return DanceClassCard(liveDance: Get.find<InstructorController>().instructorDanceClass[index]);
                          //         }),
                          //       ],
                          //     ),
                          //   ],
                          // )
                          Obx((){
                            if(Get.find<InstructorController>().toShowLive.value <= 1){
                              return Wrap(
                                children: [
                                  
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: Get.find<InstructorController>().toShowList.length,
                                    itemBuilder: (context,index){
                                        print(Get.find<InstructorController>().toShowList[index].liveClassId);
                                        return SizedBox( width: ((MediaQuery.of(context).size.width / 2)-25), child: DanceClassCard(liveDance: Get.find<InstructorController>().toShowList[index]));
                                    }
                                  ),
                                  // DanceClassCard(),
                                ],
                              );
                            }else{
                              final arr = Get.find<InstructorController>().instructorRecordedDanceClass;
                               return Wrap(
                                 children: [
                                   ListView.builder(
                                     physics: NeverScrollableScrollPhysics(),
                                     shrinkWrap: true,
                                     itemCount: arr.length,
                                     itemBuilder: (context,index){
                                         print(arr[index].recordedClassId);
                                        //  Text(arr[index].youtubeLink);
                                         return SizedBox( width: ((MediaQuery.of(context).size.width / 2)-25), child: InstructorRecordedClassCard(recordedDanceClassModel: Get.find<InstructorController>().instructorRecordedDanceClass[index]));
                                     }
                                   ),
                                 ],
                               );
                            }
                          }),
                         
                        ],
                      );
            
                    }
                    return Text("Wait");
                  }
                ),
            
                
                 
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddClassLandingPage());
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 116, 116, 185),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
