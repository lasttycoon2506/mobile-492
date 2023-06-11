import 'package:flutter/material.dart';
import '../models/new_entry_dto.dart';

Widget entryField(BuildContext context, NewEntryDTO newEntry) {
  return Semantics(
    enabled: true,
    hint: 'Enter Number of Wasted Items',
    child: TextFormField(
      autofocus: true,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      onSaved: (value) {
        newEntry.quantity = int.parse(value!);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Number of Wasted Items!';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        hintText: 'Number of Wasted Items!',
      ),
    ),
  );
}
