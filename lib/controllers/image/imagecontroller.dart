import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  RxString imgPath = ''.obs;

  XFile? imageDanceClass;
  RxString imgPathDanceClass = ''.obs;

  XFile? instructorImage;
  RxString instructorImagePath = ''.obs;

  void pickImage ()async{
    image = await _picker.pickImage(source: ImageSource.gallery);
    imgPath.value = (image == null) ? "":image!.path;
    print(imgPath);
  }

  void pickImageForClass () async {
    imageDanceClass = await _picker.pickImage(source: ImageSource.gallery);
    imgPathDanceClass.value = (imageDanceClass == null) ? "":imageDanceClass!.path;
    print(imgPathDanceClass);
  }

  void pickImageForInstructor () async {
    instructorImage = await _picker.pickImage(source: ImageSource.gallery);
    instructorImagePath.value = (instructorImage == null) ? "":instructorImage!.path;
    print(instructorImagePath);
  }
}