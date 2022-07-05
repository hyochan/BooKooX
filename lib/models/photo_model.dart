import 'package:image_picker/image_picker.dart';

class PhotoModel {
  XFile? file;
  String? url;
  bool? isAddBtn;

  PhotoModel({
    this.file,
    this.url,
    this.isAddBtn,
  });
}
