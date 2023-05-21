import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../controllers/image/imagecontroller.dart';
import '../../widgets/my_appbar.dart';


class EditInstructorProfile extends StatefulWidget {
  const EditInstructorProfile({Key? key}) : super(key: key);

  @override
  State<EditInstructorProfile> createState() => _EditInstructorProfileState();
}

class _EditInstructorProfileState extends State<EditInstructorProfile> {
  TextEditingController tagController = TextEditingController();  
  List<String> tagList = ['K-pop', 'Contemporary', 'HipHop', 'Video'];
  String url = "https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80";



  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Update',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          content: const Text(
            'Are you sure you want to update',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          backgroundColor: const Color(0xFFede9f7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF5f527e),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Color(0xFF5f527e),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
      appBar: AppBar(),
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
                  InkWell(
                    onTap: (){
                      Get.find<ImagePickerController>().pickImage();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Icon(
                                Icons.image_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
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
                          label:  Row(
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
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write something about yourself',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
             /* const Text(
                'Lorem Ipsum Dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
              ),*/
              const SizedBox(
                height: 145,
              ),
              ElevatedButton(
                onPressed: () {
                 _showDialog(context);
                },
                child: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
