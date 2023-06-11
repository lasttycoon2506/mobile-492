import 'package:flutter/material.dart';
import '../screens/new_post_screen.dart';

class NewPostButton extends StatelessWidget {
  const NewPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Select a Photo',
      button: true,
      enabled: true,
      tooltip: 'Select a Photo',
      child: FloatingActionButton(
          child: const Icon(Icons.photo_camera),
          onPressed: () {
            Navigator.pushNamed(context, NewPostScreen.routeName);
          }),
    );
  }
}
