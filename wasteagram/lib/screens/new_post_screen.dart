import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../models/new_entry_dto.dart';
import '../widgets/entry_field.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = 'NewPostScreen';

  const NewPostScreen({Key? key}) : super(key: key);

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  File? image;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final newEntry = NewEntryDTO();
  LocationData? locationData;
  var locationService = Location();

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getImage();
      return (const Column(
          children: [Center(child: CircularProgressIndicator())]));
    }
    if (locationData == null) {
      retrieveLocation();
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                  height: 300, child: ListTile(title: Image.file(image!))),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child:
                    Form(key: formKey, child: entryField(context, newEntry))),
          ]),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: uploadButton());
  }

  Widget uploadButton() {
    return SizedBox(
      width: 150,
      height: 150,
      child: Semantics(
        enabled: true,
        button: true,
        label: 'Upload',
        tooltip: 'Upload',
        child: FloatingActionButton.large(
            backgroundColor: Colors.red,
            foregroundColor: Colors.black,
            child: const Icon(Icons.file_upload, size: 80),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();
                newEntry.imageURL = await uploadImage();
                newEntry.date = DateTime.now();
                retrieveLocation();
                getLatiLong();
                FirebaseFirestore.instance.collection('posts').add({
                  'date': newEntry.date,
                  'quantity': newEntry.quantity,
                  'imageURL': newEntry.imageURL,
                  'latitude': newEntry.latitude,
                  'longitude': newEntry.longitude,
                });
                Navigator.of(context).pop();
              }
            }),
      ),
    );
  }

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
  }

  Future uploadImage() async {
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    var url = await storageReference.getDownloadURL();
    return url;
  }

  void retrieveLocation() async {
    try {
      var serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var permissionGranted = await locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  void getLatiLong() {
    newEntry.latitude = locationData!.latitude;
    newEntry.longitude = locationData!.longitude;
  }
}
