import 'package:flutter/material.dart';

import '../../models/live_dance_class.dart';

class HomeDanceCard extends StatelessWidget {
  LiveDanceClassModel liveDance;
  HomeDanceCard({
    super.key,
    required this.liveDance
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 252, 254),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 210,
          child: Column(
            children: [
              Container(
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: 
                ClipRRect(
                          borderRadius:const  BorderRadius.all(Radius.circular(8)),
                            child:
                            (liveDance.img == "")?
                            const SizedBox(
                              
                                  width: double.infinity,
                                  child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
                                ): 
                            Image.network(
                                liveDance.img!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                            ),
                        ),
                
                // Image.network(
                //   'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          liveDance.instructor.profilePicture!,
                        ),
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${liveDance.instructor.firstName} ${liveDance.instructor.lastName}",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  // const Icon(
                  //   Icons.favorite,
                  //   color: Colors.red,
                  // ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    liveDance.danceName,
                    style: TextStyle(
                      color: Color.fromARGB(255, 233, 116, 202),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_rounded,
                        color: Color.fromARGB(255, 193, 72, 160),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        liveDance.date,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Color.fromARGB(255, 193, 72, 160),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        liveDance.location,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}