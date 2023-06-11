import 'package:flutter/material.dart';

Widget listHeader(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10),
    color: Colors.amber,
    child: const ListTile(
      title: Text(
        'Date',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      trailing: Text('Items',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
    ),
  );
}
