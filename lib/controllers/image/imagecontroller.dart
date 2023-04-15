import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  RxString imgPath = ''.obs;
  void pickImage ()async{
    image = await _picker.pickImage(source: ImageSource.gallery);
    imgPath.value = (image == null) ? "":image!.path;
    print(imgPath);
  }
}