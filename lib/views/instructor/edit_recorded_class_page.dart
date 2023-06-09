import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/recorded_dance_model.dart';
import 'add_dance_payment_page.dart';


class EditRecordedClassPage extends StatefulWidget {
  const EditRecordedClassPage({Key? key}) : super(key: key);

  @override
  State<EditRecordedClassPage> createState() => _EditRecordedClassPageState();
}

class _EditRecordedClassPageState extends State<EditRecordedClassPage> {
  TextEditingController danceController = TextEditingController();
  TextEditingController songController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  bool isEasy = true;

  bool isMedium = false;

  bool isHard = false;


  @override
  void initState() {
    danceController.text = "test";
    songController.text = "test";
    priceController.text = "test";
    linkController.text = "test";
    detailsController.text = "test";
    super.initState();
  }

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 135,

            child: Column(
              children: [
                Text('Update Recorded Class',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 50,
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                //   child: Container(
                //       color: Colors.grey[100],
                //       child: Obx(() {
                //         if (Get.find<ImagePickerController>().imgPath.value ==
                //             '') {
                //           return SizedBox(
                //             child: IconButton(
                //                 onPressed: () {
                //                   Get.find<ImagePickerController>().pickImage();
                //                 },
                //                 splashColor: Colors.transparent,
                //                 highlightColor: Colors.transparent,
                //                 icon: Icon(Icons.camera_alt)),
                //             width: (MediaQuery.of(context).size.width),
                //             height: 150,
                //           );
                //         } else {
                //           return GestureDetector(
                //             onTap: () =>
                //                 Get.find<ImagePickerController>().pickImage(),
                //             onLongPress: () => Get.find<ImagePickerController>()
                //                 .imgPath
                //                 .value = '',
                //             child: SizedBox(
                //               child: Image.file(
                //                 File(Get.find<ImagePickerController>()
                //                     .imgPath
                //                     .value),
                //                 fit: BoxFit.cover,
                //               ),
                //               width: (MediaQuery.of(context).size.width),
                //               height: 150,
                //             ),
                //           );
                //         }
                //       })),
                // ),
                TextFormField(
                  validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter dance class name";
                      }
                    },
                  textCapitalization: TextCapitalization.words,
                  controller: danceController,
                  decoration:
                  const InputDecoration(labelText: "Dance Class Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter song name";
                            }
                          },
                        textCapitalization: TextCapitalization.words,
                        controller: songController,
                        decoration: const InputDecoration(
                          labelText: "Song",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.music_note),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter price";
                            }
                          },
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.money),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter link";
                            }
                          },
                        textCapitalization: TextCapitalization.words,
                        controller: linkController,
                        decoration: const InputDecoration(
                          labelText: "Link",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.link),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Difficulty',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isEasy = true;
                            isMedium = false;
                            isHard = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color:
                            isEasy == true ? Colors.purple : Colors.white,
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: Center(
                              child: Text(
                                'Easy',
                                style: TextStyle(
                                    color: isEasy == true
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isEasy = false;
                            isMedium = true;
                            isHard = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color:
                            isMedium == true ? Colors.purple : Colors.white,
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: Center(
                              child: Text(
                                'Medium',
                                style: TextStyle(
                                    color: isMedium == true
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isEasy = false;
                            isMedium = false;
                            isHard = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color:
                            isHard == true ? Colors.purple : Colors.white,
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: Center(
                              child: Text(
                                'Hard',
                                style: TextStyle(
                                    color: isHard == true
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter details";
                            }
                          },
                        textCapitalization: TextCapitalization.words,
                        maxLines: null,
                        controller: detailsController,
                        decoration: const InputDecoration(
                          labelText: "Details",
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.info),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  child: ElevatedButton(
                      onPressed: () {
                        String difficulty;
                        int id;
                        if (isEasy == true) {
                          difficulty = "Easy";
                        } else if (isMedium == true) {
                          difficulty = "Medium";
                        } else {
                          difficulty = "Hard";
                        }
                        if (recordedDance.isEmpty) {
                          id = 1;
                        } else {
                          id = recordedDance.last["id"] + 1;
                        }
                        recordedDance.add({
                          "id": id,
                          "classname": danceController.text,
                          "song": songController.text,
                          "price": priceController.text,
                          "link": linkController.text,
                          "difficulty": difficulty,
                          "details": detailsController.text,
                        });
                        // recordedDance.add({
                        //   "id": 1,
                        //   "classname": "Sample Dance Class",
                        //   "song": "Big Boy - Sza",
                        //   "price": "200",
                        //   "link": "youtube.com/watch?v=MhaH4XkHK5A",
                        //   "difficulty": "Easy",
                        //   "details": "Lorem Ipsum Dolor Iset",
                        // });
                        // print(recordedDance);
                        // Get.to(AddPaymentPage());
                        _showDialog(context);
                      },
                     
                  child: const Text("Update"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 244, 209, 235),
                  ),
                  ),
                  ),
                ),
              ],
                )
            ),
          ),
        ),
      );
  }
}
