import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_dance_payment_page.dart';
import '../../models/recorded_dance_model.dart';

class AddRecordedDancePage extends StatefulWidget {
  AddRecordedDancePage({super.key});

  @override
  State<AddRecordedDancePage> createState() => _AddRecordedDancePageState();
}

class _AddRecordedDancePageState extends State<AddRecordedDancePage> {
  TextEditingController danceController = TextEditingController();
  TextEditingController songController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  bool isEasy = true;

  bool isMedium = false;

  bool isHard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Text('Provide Basic Details',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'This section contains general information of your recorded dance class',
                  textAlign: TextAlign.center,
                ),
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
                TextField(
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
                        // String difficulty;
                        // int id;
                        // if (isEasy == true) {
                        //   difficulty = "Easy";
                        // } else if (isMedium == true) {
                        //   difficulty = "Medium";
                        // } else {
                        //   difficulty = "Hard";
                        // }
                        // if (recordedDance.isEmpty) {
                        //   id = 1;
                        // } else {
                        //   id = recordedDance.last["id"] + 1;
                        // }
                        // recordedDance.add({
                        //   "id": id,
                        //   "classname": danceController.text,
                        //   "song": songController.text,
                        //   "price": priceController.text,
                        //   "link": linkController.text,
                        //   "difficulty": difficulty,
                        //   "details": detailsController.text,
                        // });
                        recordedDance.add({
                          "id": 1,
                          "classname": "Sample Dance Class",
                          "song": "Big Boy - Sza",
                          "price": "200",
                          "link": "Youtube.com/watch?v=9U-opxT87_w",
                          "difficulty": "Easy",
                          "details": "Lorem Ipsum Dolor Iset",
                        });
                        print(recordedDance);
                        Get.to(AddPaymentPage());
                      },
                      child: Text("Next")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
