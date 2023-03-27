import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  NoImageWidget({super.key, required this.noimage});
  String noimage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.image, size: 100),
        SizedBox(height: 16.0),
        Text(
          'No image selected.',
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}
