import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/dance_class_details.dart';
import '../../models/recorded_dance_model.dart';
 
class HomeDanceCard extends StatelessWidget {
  const HomeDanceCard({
    super.key,
  });
 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: recordedDance.length,
      itemBuilder: (context, index) {
        String link = recordedDance[index]['link'];
        RegExp regExp = RegExp(r"(?:(?<=v=)|(?<=be/))[\w-]+");
        RegExpMatch? match = regExp.firstMatch(link);
        String? id = match?.group(0);
        return GestureDetector(
          onTap: () => Get.to(
            DanceClassDetails(
              fromPage: "StudentHomeRecorded",
              danceId: index,
            ),
          ),
          child: Card(
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
                      child: Image.network(
                        'https://i.ytimg.com/vi/$id/maxresdefault.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                              ),
                              radius: 15,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Enter Name',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          recordedDance[index]['classname'],
                          style: const TextStyle(
                            color: Colors.blue,
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
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'May 05, 2023',
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
                              Icons.access_time_filled_outlined,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              '6:00',
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.purple,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'UCC Campus',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}