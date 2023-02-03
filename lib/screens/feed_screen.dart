import 'package:flutter/material.dart';

// constants
const baseImageUrl = 'https://picsum.photos/';
const imageWidth = 250;
const imageHeight = 200;
const imageCount = 10;

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: imageCount,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Image.network(
                    '$baseImageUrl$imageWidth/$imageHeight?random=$index'),
              ],
            ),
          );
        });
  }
}
