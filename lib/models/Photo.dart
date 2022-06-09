import 'package:image_picker/image_picker.dart';

class Photo {
  XFile file;
  String url;
  bool isAddBtn;

  Photo({
    this.file,
    this.url,
    this.isAddBtn,
  });
}
