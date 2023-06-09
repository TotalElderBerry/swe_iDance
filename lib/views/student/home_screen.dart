import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/danceclass/danceclasscontroller.dart';
import 'package:i_dance/controllers/instructor/instructor.dart';
import 'package:i_dance/views/student/instructor_details_page.dart';
import 'package:i_dance/views/student/student_home.dart';
import 'package:i_dance/views/student/student_home_live.dart';
import 'package:i_dance/views/student/student_home_recorded.dart';
import 'package:i_dance/widgets/my_appbar.dart';
import 'package:skeletons/skeletons.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../widgets/drawer.dart';
import '../../widgets/student/home_dance_card.dart';
import '../../widgets/student/home_recorded_dance_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: MyAppBar(
        parentContext: context,
        title: "",
        scaffoldKey: _scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: RefreshIndicator(
          onRefresh: () async {
            Get.find<AuthController>().getLoggedStudent();
            // Get.find<DanceClassController>().populateUpcomingClasses();
            Get.offAll(HomeScreen());
          },
          child: FutureBuilder<Object>(
              future: Get.find<AuthController>().getLoggedStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder(
                      future: Get.find<DanceClassController>()
                          .populateUpcomingClasses(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          print("success");
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Featured',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                                  child: Image.asset(
                                    'assets/images/1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Popular Instructors',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),

                                // Expanded(
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: Get.find<InstructorController>().instructors.length,
                                //     itemBuilder: (context,index){
                                //       return CircleAvatar(
                                //         backgroundImage: NetworkImage(
                                //           'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                                //         ),
                                //         radius: 25,
                                //       );
                                //     }),
                                // ),

                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount:
                                          Get.find<InstructorController>()
                                              .instructors
                                              .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              print(Get.find<
                                                      InstructorController>()
                                                  .instructors[index]
                                                  .profilePicture);

                                              Get.to(InstructorDetailsPage(
                                                instructor: Get.find<
                                                        InstructorController>()
                                                    .instructors[index],
                                              ));
                                            },
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      Get.find<
                                                              InstructorController>()
                                                          .instructors[index]
                                                          .profilePicture!,
                                                    ),
                                                    radius: 25,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 30,
                                                  top: 30,
                                                  child: Container(
                                                    width: 30,
                                                    height: 35,
                                                    decoration: ShapeDecoration(
                                                      shape: StarBorder(),
                                                      color: Color.fromARGB(
                                                          255, 247, 164, 211),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Get.find<
                                                                InstructorController>()
                                                            .instructors[index]
                                                            .rating
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),

                                // CircleAvatar(
                                //           backgroundImage: NetworkImage(
                                //             'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                                //           ),
                                //           radius: 25,
                                //         ),
                                const SizedBox(
                                  height: 12,
                                ),

                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Live Dance Class',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                          onPressed: () => Get.to(
                                              const StudentHomeLivePage()),
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
                                    SizedBox(
                                      height: 280,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              Get.find<DanceClassController>()
                                                  .upcomingDanceClasses
                                                  .length,
                                          itemBuilder: (context, index) {
                                            return HomeDanceCard(
                                              liveDance: Get.find<
                                                      DanceClassController>()
                                                  .upcomingDanceClasses[index],
                                            );
                                          }),
                                    ),

                                    // SingleChildScrollView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   child: Row(
                                    //     children: const [
                                    //       HomeDanceCard(),
                                    //       HomeDanceCard(),
                                    //     ],
                                    //   ),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Recorded Dance Class',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                          onPressed: () => Get.to(
                                              const StudentHomeRecordedPage()),
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

                                    SizedBox(
                                      height: 270,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              Get.find<DanceClassController>()
                                                  .recordedClasses
                                                  .length,
                                          itemBuilder: (context, index) {
                                            return HomeRecordedDanceCard(
                                              recordedClass: Get.find<
                                                      DanceClassController>()
                                                  .recordedClasses[index],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        // return Text("Loading pa wait");
                        return OverflowBox(
                          maxHeight: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              const SizedBox(height: 100),

                              const SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    width: double.infinity,
                                    height: 200),
                              ),
                              const SizedBox(height: 36),
                              //
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.circle,
                                          width: 50,
                                          height: 50),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.circle,
                                          width: 50,
                                          height: 50),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.circle,
                                          width: 50,
                                          height: 50),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 36),

                              FittedBox(
                                child: ClipRect(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 150),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 150),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              FittedBox(
                                child: ClipRect(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 150),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 150),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }));
                }
                return OverflowBox(
                  maxHeight: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(height: 100),

                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            width: double.infinity,
                            height: 200),
                      ),
                      const SizedBox(height: 36),
                      //
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  shape: BoxShape.circle,
                                  width: 50,
                                  height: 50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  shape: BoxShape.circle,
                                  width: 50,
                                  height: 50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  shape: BoxShape.circle,
                                  width: 50,
                                  height: 50),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),

                      FittedBox(
                        child: ClipRect(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 150),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 150),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FittedBox(
                        child: ClipRect(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 150),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 150),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
