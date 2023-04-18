import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DanceClassCard extends StatelessWidget {
  const DanceClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ((MediaQuery.of(context).size.width / 2)-30),
      child: Card(
        color: Theme.of(context).colorScheme.onSecondary,
        elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                           Row(
                                children: [
                                  CircleAvatar(
                                      radius: 10,
                                      backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                                    ),
                                    SizedBox(width: 5,),
                                  Text("Roger Intong", style: Theme.of(context).textTheme.labelSmall,),
                              
                                ],
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Run - BTS", style: Theme.of(context).textTheme.titleMedium,),
                              Row(
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline,size: 12,),padding: EdgeInsets.all(8),color: Colors.red,constraints: BoxConstraints(),),
                                  // Text("88", style: Theme.of(context).textTheme.labelSmall,),
                              
                                ],
                              )
                          
                            ],
                          ),
                          const Divider(),
    
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(size: 10, Icons.calendar_month,color: Theme.of(context).primaryColor,),
                                  Text(" March 12,2023", style: Theme.of(context).textTheme.labelSmall,),
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
    
                     
                    ],
                  ),
                ),
              ),
    );
  }
}