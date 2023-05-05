import 'package:flutter/material.dart';
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
                    child: Image.network(
                      'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 125,
                    left: 15,
                    child: Row(
                      children: const [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
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
                        title: const Text('Catto Dela Meow'),
                        subtitle: Row(
                          children: [
                            const Text(
                              '@catto',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Row(
                              children: const [
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
