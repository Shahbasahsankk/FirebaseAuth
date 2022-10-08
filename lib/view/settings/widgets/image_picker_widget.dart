import 'package:firebase_authentication/controller/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        width: 200,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<SettingsProvider>(context, listen: false)
                    .getImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt_sharp),
                  Text(
                    'Camera',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Provider.of<SettingsProvider>(context, listen: false)
                    .getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.image_search),
                  Text(
                    'Gallery',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
