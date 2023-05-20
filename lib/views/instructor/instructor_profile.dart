import 'package:flutter/material.dart';
import 'package:i_dance/widgets/my_appbar.dart';
import 'package:quickalert/quickalert.dart';

class InstructorProfilePage extends StatefulWidget {
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
      appBar: MyAppBar(
        context,
        isStudent: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
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
                    child: Image.network(
                      'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                      fit: BoxFit.cover,
                    ),
                  ),
                   Positioned(
                    top: 125,
                    left: 15,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg',
                          ),
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
                        title: Text('Catto Dela Meow'),
                        subtitle: Row(
                          children: [
                            Text(
                              '@catto',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_half_rounded,
                                  color: Colors.yellow,
                                ),
                              ],
                            )
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
                  child: Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,

                    children: [
                      ...List.generate(
                        tagList.length,
                            (index) => Chip(
                          label: Text(
                            tagList.elementAt(index),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.purple[300],
                        ),
                      ),
                      GestureDetector(
                        onTap: addTag,
                        child: SizedBox(
                          width: 100,
                          child: Chip(
                            label: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Add tag',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.purple[300],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
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
              const Text(
                'Lorem Ipsum Dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
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
                height: 155,
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
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Booked Students'),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('L'),
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('R'),
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('L'),
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('R'),
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                  Container(
                                    width: 175,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(''),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 3,
                      color: Colors.purple[300],
                    ),
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.purple[300],
                        radius: 55,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          child: Text(
                            '20',
                            style: TextStyle(
                                fontSize: 60, color: Colors.purple[300]),
                          ),
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
