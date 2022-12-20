import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "";
  File? image;
  //bool _load = false;
  // late Future<File> imageFile;
  late ImagePicker imagePicker;

  pickImageFromGallery() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {
      image;
      //_load = false;
      performImageLabelling();
    });
  }

  captureImageWithCamera() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    setState(() {
      image;
      //_load = false;
      performImageLabelling();
    });
  }

  performImageLabelling() async {
    final FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await recognizer.processImage(firebaseVisionImage);

    result = "";
    setState(() {
      for (TextBlock block in visionText.blocks) {
        final String txt = "block.text";
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            result += "${element.text} ";
          }
        }
        result += "\n\n";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(width: 100),
            Container(
              height: 250,
              width: 250,
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.only(left: 25, bottom: 5, right: 15),
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  result,
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
              )),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/note.jpg'), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              //color: Colors.pink,
              height: 250,
              width: 250,
              /*
              margin: EdgeInsets.only(top: 20, right: 140),
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/pin.png',
                        height: 240,
                        width: 240,
                      ),
                    ],
                  ),
                  Center(     */
              child: ElevatedButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  onLongPress: () {
                    captureImageWithCamera();
                  },
                  child: Container(
                    //  color: Colors.yellow,
                    width: 240,
                    height: 200,
                    //margin: EdgeInsets.only(top: 50),
                    child: image != null
                        ? Image.file(
                            image!,
                            width: 140,
                            height: 192,
                            fit: BoxFit.fill,
                          )
                        : Container(
                            height: 250,
                            width: 250,
                            // color: Colors.red,
                            child: Icon(
                              Icons.camera_front,
                              size: 100,
                              color: Colors.grey,
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/pin.png'),
                                    fit: BoxFit.cover)),
                          ),
                    /*  decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/pin.png'),
                            fit: BoxFit.cover)),*/
                  )),
              /* decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/pin.png'), fit: BoxFit.cover)),*/
            ),
          ],
        ),
      ),
    );
  }
}
