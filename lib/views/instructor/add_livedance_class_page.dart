import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_dance/views/instructor/add_dance_payment_page.dart';

import '../../controllers/image/imagecontroller.dart';
import '../../widgets/map.dart';
import '../../widgets/my_appbar.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
//10.3156992 , 123.88543660000005

class AddLiveDanceClassPage extends StatefulWidget {

  AddLiveDanceClassPage({super.key});

  @override
  State<AddLiveDanceClassPage> createState() => _AddLiveDanceClassPageState();
}

class _AddLiveDanceClassPageState extends State<AddLiveDanceClassPage> {
  GoogleMapController? mapController; 
 //contrller for Google map
  Set<Marker> markers = Set(); 
 //markers for google map
  LatLng showLocation = LatLng(10.3156992, 123.88543660000005);  
  String location = "Search Location"; 
  CameraPosition? cameraPosition;
  TextEditingController dateController = TextEditingController();

  TextEditingController danceNameController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController maxStudentsController = TextEditingController();

  @override
  void initState() {
      markers.add(Marker( //add marker on google map
          markerId: MarkerId(showLocation.toString()),
          position: showLocation, //position of marker
          infoWindow: InfoWindow( //popup info 
            title: 'My Custom Title ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //you can add more markers here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 32.0, left: 32, ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
            children: [
               Text('Provide Basic Details',style: Theme.of(context).textTheme.headlineMedium),
               const SizedBox(height: 5,),
              const Text('This section contains general information of your dance class',textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: Colors.grey[100],
                  child: 
                  Obx((){
                    if(Get.find<ImagePickerController>().imgPathDanceClass.value == ''){
                      return SizedBox(
                          child: IconButton(
                          onPressed: (){
                            Get.find<ImagePickerController>().pickImageForClass();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(Icons.camera_alt)),
                          width: (MediaQuery.of(context).size.width),
                          height: 150,
                        );
                    }else{
                      return GestureDetector(
                        onTap: () => Get.find<ImagePickerController>().pickImageForClass(),
                        onLongPress: () => Get.find<ImagePickerController>().imgPathDanceClass.value = '',
                        child: SizedBox(
                            child: Image.file(File(Get.find<ImagePickerController>().imgPathDanceClass.value),fit: BoxFit.cover,),
                            width: (MediaQuery.of(context).size.width),
                            height: 150,
                          ),
                      );
                    }
                  }
                )
                  
                ),
              ),
              TextField(
                controller: danceNameController,
                decoration: InputDecoration(
                  labelText: "Dance Class Name"
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "Date",
                            border: OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), 
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                );
        
                                if(picked != null){
                                  dateController.text = picked.toString().split(" ")[0];
                                }
                              },
                              icon: Icon(Icons.calendar_month),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter date";
                            }
                            return null;
                          },
                          
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: timeController,
                          decoration: InputDecoration(
                            labelText: "Time",
                            border: OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
        
                                print(picked!.format(context));
                                if(picked != null){
                                  timeController.text = picked.format(context).toString();
                                }
                              },
                              icon: Icon(Icons.access_time),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your time";
                            }
                            return null;
                          },
                          
                        ),
                      ),
                ],
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      showDialog(context: context, builder: (BuildContext context){
                        return Dialog(
                            child: Container(
                              constraints: BoxConstraints(maxHeight: 350),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        child: Card(
                                          child: Container(
                                              padding: EdgeInsets.all(0),
                                              width: MediaQuery.of(context).size.width - 40,
                                              child: ListTile(
                                                  title:Text(location, style: TextStyle(fontSize: 18),),
                                                  trailing: Icon(Icons.search),
                                                  dense: true,
                                              )
                                          ),
                                        ),
                                        onTap: () async {
                                        },
                                    ),
                                      const SizedBox(height: 10,),
                                      Expanded(
                                        child: GoogleMap( //Map widget from google_maps_flutter package
                                          zoomGesturesEnabled: true, //enable Zoom in, out on map
                                          initialCameraPosition: CameraPosition( //innital position in map
                                            target: showLocation, //initial position
                                            zoom: 14.0, //initial zoom level
                                          ),
                                          markers: markers, //markers to show on map
                                          mapType: MapType.normal, //map type
                                          onMapCreated: (controller) { //method called when map is created
                                            setState(() {
                                              mapController = controller; 
                                            });
                                          },
                                          onCameraMove: (CameraPosition cameraPositiontemp){
                                            cameraPosition = cameraPositiontemp;
                                          },
                                          onCameraIdle: () async{
                                            List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude,cameraPosition!.target.latitude);
                                            setState(() => {
                                              location = placemarks.first.administrativeArea.toString() + ", "+ placemarks.first.street.toString(),

                                              showLocation = LatLng(cameraPosition!.target.latitude,cameraPosition!.target.latitude)
                                            });
                                          }
                                        ),                                    
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        );
                      });
                    },
                    icon: Icon(Icons.location_city),
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your time";
                  }
                  return null;
                },
                
              ),
              const SizedBox(height: 10,),
               Row(
                children: [
                  Expanded(
                        child: TextFormField(
                          controller: priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
                            border: OutlineInputBorder(),
                            isDense: true,
                            icon:  Icon(Icons.money),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: maxStudentsController,
                          decoration: InputDecoration(
                            labelText: "Max Students",
                            border: OutlineInputBorder(),
                            isDense: true,
                            icon: Icon(Icons.people_alt),
                            
                          ),
                        ),
                      ),
                ],
              ),
              const Spacer(),
              Container(
                width: (MediaQuery.of(context).size.width),
                child: ElevatedButton(onPressed: (){
                  Get.to(AddPaymentPage(date: dateController.text, danceName: danceNameController.text, time: timeController.text,price: priceController.text,maxStudents: maxStudentsController.text, location: locationController.text,));
                },child: Text("Next")),
              )
            ],
          ),
            )
          ],
          
        ),
      ),
    );
  }
}