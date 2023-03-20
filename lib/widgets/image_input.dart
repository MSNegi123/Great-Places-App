import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ImageInputScreen extends StatefulWidget {
  final Function selectImage;

  const ImageInputScreen(this.selectImage);

  @override
  State<ImageInputScreen> createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 150,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text("Take Picture"),
            textColor: Theme.of(context).primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Future<void> _takePicture() async {
    final _imagePicker = ImagePicker();
    final _pickedImage = await _imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if(_pickedImage == null) return;
    setState(() {
      _storedImage = File(_pickedImage.path);
    });
    var fileName = path.basename(_pickedImage.path);
    var _dirPath = await sysPath.getApplicationDocumentsDirectory();
    var _savedImage = await File(_pickedImage.path).copy("${_dirPath.path}/$fileName");
    widget.selectImage(_savedImage);
  }
}
