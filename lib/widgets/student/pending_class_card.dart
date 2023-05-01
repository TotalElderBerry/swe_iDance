import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/student/dance_class_details.dart';

class PendingClassCard extends StatelessWidget {
  const PendingClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   DanceClassDetails(
        //     isPending: true,
        //   ),
        // );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width) - 32,
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Chip(
                          label: Row(
                            children: [
                              const Icon(
                                Icons.video_camera_front_rounded,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Recorded Class',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          backgroundColor: Colors.purple,
                        ),
                        Text(
                          "Run - BTS",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(
                                  'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Roger Intong",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(size: 10, Icons.calendar_month),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "March 12,2023",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(size: 10, Icons.location_on),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "UC Main Campus",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
