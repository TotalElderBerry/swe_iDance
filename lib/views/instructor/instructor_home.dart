import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/instructor/add_class_landing.dart';
import 'package:i_dance/views/instructor/add_livedance_class_page.dart';

import '../../widgets/instructor/dance_class_card.dart';
import '../../widgets/my_appbar.dart';

class InstructorHome extends StatelessWidget {
  final isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: (isEmpty)? 
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
              Text("Welcome, Sarah!", style: Theme.of(context).textTheme.titleLarge),
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                          fit: BoxFit.contain,
                          ),
                      ),
                    const SizedBox(height:5,),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Run - BTS", style: Theme.of(context).textTheme.headlineSmall,),
                          const SizedBox(height:5,),
        
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(size: 14, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                  Text(" March 12,2023", style: Theme.of(context).textTheme.labelSmall,),
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
                                Text(" UC Main Campus", style: Theme.of(context).textTheme.labelSmall,),
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
                              Text(" 88", style: Theme.of(context).textTheme.labelSmall,),
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
                child: TabBar(tabs: [
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DanceClassCard(),
                      DanceClassCard(),
                    ],
                  ),
                  Column(
                    children: [
                      DanceClassCard(),
                      DanceClassCard(),
                    ],
                  ),
                ],
              ),
               
            ],
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
