import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/student_home.dart';
import 'package:i_dance/views/student/student_home_live.dart';
import 'package:i_dance/views/student/student_home_recorded.dart';
import 'package:i_dance/widgets/my_appbar.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../widgets/student/home_dance_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: FutureBuilder<Object>(
          future: Get.find<AuthController>().getLoggedStudent(),
          builder: (context, snapshot) {
            if(snapshot.hasData){

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Featured',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 180,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Popular Instructors',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                            ),
                            radius: 25,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                            ),
                            radius: 25,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                            ),
                            radius: 25,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                            ),
                            radius: 25,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Live Dance Class',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () => Get.to(const StudentHomeLivePage()),
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            HomeDanceCard(),
                            HomeDanceCard(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recorded Dance Class',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () => Get.to(const StudentRecordedHomePage()),
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            HomeDanceCard(),
                            HomeDanceCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            return Text("Loading pa");

            }
        ),
      ),
    );
  }
}
