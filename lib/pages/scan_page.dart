import 'dart:io';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../models/contact_model.dart';

List<String> _mergeLineList = [];

class ScanPage extends StatefulWidget {
  static const String routeName = '/scan_page';
  const ScanPage({super.key});
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  List<String> _lines = [];
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  final _contactModel = ContactModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Scan Visiting Card',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, NewContactPage.routeName,
                    arguments: _contactModel);
              },
              child: const Text(
                'NEXT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: _imagePath == null
                  ? null
                  : Image.file(
                      File(_imagePath!),
                      width: double.maxFinite,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _imageSource = ImageSource.camera;
                    _imagePicker();
                  },
                  child: Text(
                    'CAMERA',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _imageSource = ImageSource.gallery;
                    _imagePicker();
                  },
                  child: Text(
                    'GALLERY',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _lines.length,
                itemBuilder: (context, index) => LineItem(_lines[index]),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _propertyButton(ContactProperties.name),
                  _propertyButton(ContactProperties.company),
                  _propertyButton(ContactProperties.designation),
                  _propertyButton(ContactProperties.mobile),
                  _propertyButton(ContactProperties.email),
                  _propertyButton(ContactProperties.address),
                  _propertyButton(ContactProperties.web),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(source: _imageSource);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      final textDetector = GoogleMlKit.vision.textRecognizer();
      final inputImage = InputImage.fromFilePath(_imagePath!);
      final recognizedText = await textDetector.processImage(inputImage);
      var lines = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          lines.add(line.text);
        }
      }
      setState(() {
        _lines = lines;
      });
    }
  }

  Widget _propertyButton(String property) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ElevatedButton(
        onPressed: () {
          _assignPropertiesToContactModel(property);
        },
        child: Text(
          property,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  void _assignPropertiesToContactModel(String property) {
    final item = _mergeLineList.join(' ');
    switch (property) {
      case ContactProperties.name:
        _contactModel.name = item;
        break;
      case ContactProperties.company:
        _contactModel.companyName = item;
        break;
      case ContactProperties.designation:
        _contactModel.designation = item;
        break;
      case ContactProperties.address:
        _contactModel.address = item;
        break;
      case ContactProperties.mobile:
        _contactModel.mobile = item;
        break;
      case ContactProperties.email:
        _contactModel.email = item;
        break;
      case ContactProperties.web:
        _contactModel.website = item;
        break;
    }
    _mergeLineList.clear();
  }
}

class LineItem extends StatefulWidget {
  final String line;
  LineItem(this.line);

  @override
  State<LineItem> createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.line),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
          value!
              ? _mergeLineList.add(widget.line)
              : _mergeLineList.remove(widget.line);
        },
      ),
    );
  }
}
