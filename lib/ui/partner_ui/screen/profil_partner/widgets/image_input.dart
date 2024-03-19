import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture(ImageSource imageSource) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: imageSource,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Photo de profil",
              style: TextStyle(
                fontFamily: "Manrope",
                color: myGrisFonce,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        _takePicture(ImageSource.camera);
                      },
                      child: const CircleAvatar(
                        backgroundColor: myPink,
                        radius: 25,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Caméra",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myGrisFonce,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        _takePicture(ImageSource.gallery);
                      },
                      child: const CircleAvatar(
                        backgroundColor: myPink,
                        radius: 25,
                        child: Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Galerie",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myGrisFonce,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
