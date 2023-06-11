import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class PostDetailsScreen extends StatelessWidget {
  static const routeName = 'postDetailsScreen';
  dynamic post;

  PostDetailsScreen({super.key, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wasteagram'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            dateDisplay(post),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post['imageURL'].toString(),
            ),
            itemsDisplay(post),
            locDisplay(post)
          ],
        ),
      )),
    );
  }
}

Widget dateDisplay(dynamic post) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Text(
        style: const TextStyle(
            fontSize: 30, color: Colors.purple, fontWeight: FontWeight.bold),
        DateFormat.yMMMd().format(post['date'].toDate())),
  );
}

Widget itemsDisplay(dynamic post) {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Text(
      '${post['quantity'].toString()} items',
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
    ),
  );
}

Widget locDisplay(dynamic post) {
  return Text(
      'Location:  (${post['latitude'].toString()} , ${post['longitude'].toString()})');
}
