import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagepacker = ImagePicker();
  XFile? _file = await _imagepacker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
}
