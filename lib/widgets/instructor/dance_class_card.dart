import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/models/live_dance_class.dart';
import 'package:i_dance/views/instructor/dance_class_details.dart';

class DanceClassCard extends StatelessWidget {
  LiveDanceClassModel liveDance;
  DanceClassCard({super.key,required this.liveDance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(DanceClassDetails(liveDance: liveDance,));
        print("object");
      },
      child: SizedBox(
        width: ((MediaQuery.of(context).size.width / 2)-25),
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          elevation: 2,
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
                            Text(liveDance.danceName, style: Theme.of(context).textTheme.labelMedium,),
                            const Divider(),
      
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(size: 10, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                    Text(" ${liveDance.date}", style: Theme.of(context).textTheme.labelSmall,),
                                  ],
                                ),
                                const SizedBox(width:10,),
                      
                              ],
                            ),
                            const SizedBox(height:5,),
    
                            Row(
                              children: [
                                Icon(size: 10, Icons.access_time,color: Theme.of(context).primaryColor,),
                                Text(" 12:00 PM", style: Theme.of(context).textTheme.labelSmall,),
                              ],
                            ),
                            const SizedBox(height:5,),
                      
                            Row(
                                children: [
                                  Icon(size: 10, Icons.location_on,color: Theme.of(context).primaryColor,),
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
                          
                          ],
                          
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}