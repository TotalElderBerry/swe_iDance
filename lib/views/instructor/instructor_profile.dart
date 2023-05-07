import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:i_dance/controllers/auth/auth_controller.dart';
import 'package:i_dance/models/instructor.dart';
import 'package:quickalert/quickalert.dart';

class InstructorProfilePage extends StatefulWidget {
  InstructorModel instructor = Get.find<AuthController>().currentInstructor.value!;
  InstructorProfilePage({super.key});

  @override
  State<InstructorProfilePage> createState() => _InstructorProfilePageState();
}

class _InstructorProfilePageState extends State<InstructorProfilePage> {
  final tagController = TextEditingController();
  List<String> tagList = ['K-pop', 'Contemporary', 'HipHop', 'Video'];

  void addTag() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      widget: TextField(
        controller: tagController,
      ),
      onConfirmBtnTap: () {
        setState(() {
          tagList.add(tagController.text);
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 230,
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: 
                    (widget.instructor.img == "")?
                          const ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: DecoratedBox(decoration: const BoxDecoration(color: Colors.grey)),
                                ),
                                // child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                                // fit: BoxFit.contain,
                                // height: 150,
                                // ),
                            ):
                             ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                child: Image.network(widget.instructor.img!,
                                fit: BoxFit.cover,
                                height: 150,
                                ),
                            ),
                    // Image.network(
                    //   'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Positioned(
                    top: 125,
                    left: 15,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage((Get.find<AuthController>().authService.getUser()!.photoURL == null)?'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg':Get.find<AuthController>().authService.getUser()!.photoURL!),
                          radius: 50,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 170,
                    child: SizedBox(
                      height: 50,
                      width: 210,
                      child: ListTile(
                        title: Text("${widget.instructor.firstName} ${widget.instructor.lastName}"),
                        subtitle: Row(
                          children: [
                            const Text(
                              '@catto',
                              style: TextStyle(color: Colors.grey),
                            ),
                            RatingBar.builder(
                              ignoreGestures: true,
                              itemSize: 20.0,
                              initialRating: widget.instructor.rating * 1.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (a) => {

                              }
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 100,
                child: GridView.count(
                  padding: const EdgeInsets.all(0),
                  childAspectRatio: 2.5,
                  crossAxisCount: 3,
                  children: [
                    ...List.generate(
                      tagList.length,
                      (index) => Chip(
                        label: Text(
                          tagList.elementAt(index),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    GestureDetector(
                      onTap: addTag,
                      child: Chip(
                        label: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Add tag',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 200,
              //   width: double.infinity,
              //   child: GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       childAspectRatio: 2.5,
              //     ),
              //     itemCount: tagList.length,
              //     itemBuilder: (context, index) {
              //       return Chip(
              //         label: Text(
              //           tagList.elementAt(index),
              //           style: Theme.of(context).textTheme.labelMedium,
              //         ),
              //         backgroundColor: Colors.grey[300],
              //       );
              //     },
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Chip(
              //       label: Text(
              //         'K-pop',
              //         style: Theme.of(context).textTheme.labelMedium,
              //       ),
              //       backgroundColor: Colors.grey[300],
              //     ),
              //     Chip(
              //       label: Text(
              //         'Contemporary',
              //         style: Theme.of(context).textTheme.labelMedium,
              //       ),
              //       backgroundColor: Colors.grey[300],
              //     ),
              //     Chip(
              //       label: Text(
              //         'HipHop',
              //         style: Theme.of(context).textTheme.labelMedium,
              //       ),
              //       backgroundColor: Colors.grey[300],
              //     ),
              //     Chip(
              //       label: Text(
              //         'Video',
              //         style: Theme.of(context).textTheme.labelMedium,
              //       ),
              //       backgroundColor: Colors.grey[300],
              //     ),
              //   ],
              // ),

              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Icon(
                    Icons.edit,
                    size: 15,
                  ),
                ],
              ),
              Text(
                '${widget.instructor.description}',
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Icon(
                    Icons.pie_chart,
                    size: 15,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.people,
                          color: Colors.purple,
                          size: 50,
                        ),
                        Text(
                          'Booked Students',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      thickness: 3,
                      color: Colors.purple,
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 55,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        child: Text(
                          '20',
                          style: TextStyle(fontSize: 60, color: Colors.purple),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
