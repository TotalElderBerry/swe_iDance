import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../controllers/danceclass/danceclasscontroller.dart';
import '../../models/live_dance_class.dart';

class ReviewDanceClassPage extends StatelessWidget {
  LiveDanceClassModel danceClass;
  ReviewDanceClassPage({super.key, required this.danceClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Get.find<DanceClassController>().addLiveDanceClass(danceClass);
          },
          child: const Center(
            child: Text('Create Dance Class'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            children: [
               ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                  fit: BoxFit.contain,
                  height: 200,
                  ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Run - BTS", style: Theme.of(context).textTheme.headlineLarge,),
                    
                      ],
                    ),
              
                      Row(
                          children: [
                            Icon(size: 24, Icons.location_on,color: Theme.of(context).primaryColor,),
                            Text(" UC Main Campus", style: Theme.of(context).textTheme.labelSmall,),
                          ],
                      ),
              
                      const SizedBox(height: 10,),
              
                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
                              children: [
                                Row(
                                  children: [
                                    Icon(size: 24, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                    Text("March 12,2023", style: Theme.of(context).textTheme.labelSmall,),
                                  ],
                                ),
                                const SizedBox(width:15,),
              
                                Row(
                                    children: [
                                      Icon(size: 24, Icons.access_time,color: Theme.of(context).primaryColor,),
                                      Text("12:00 PM", style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                                const SizedBox(width:15,),
              
                                  Row(
                                    children: [
                                      Icon(size: 24, Icons.money,color: Theme.of(context).primaryColor,),
                                      Text("400 Pesos", style: Theme.of(context).textTheme.labelSmall,),
                                    ],
                                  ),
                        
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(),
                      SizedBox(height: 5,),
        
                     
                      SizedBox(height: 20,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment Details", style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 5,),

                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
                            ),
                            title: Text("PayMaya"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dance Description",style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 5,),

                           Text("Get ready to dance the night away with us! We're excited to announce that our upcoming dance class will be taught by the one and only Dennis Kaldag. Dennis is a talented and experienced dance instructor, and we're thrilled to have him leading our class.",style: Theme.of(context).textTheme.bodyMedium,),
                        ],
                      )

        

                     
        
                      
                      
                 
                  ],
                ),
              ),
        
        
            ],
          ),
      ),
    );
  }
}