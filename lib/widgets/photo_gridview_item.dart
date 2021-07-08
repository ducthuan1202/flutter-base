import 'package:flutter/material.dart';
import 'package:baby/datalayer/model/photo_model.dart';

class PhotoGridviewItem extends StatelessWidget {
  final Photo data;

  PhotoGridviewItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: NetworkImage(data.thumbnailUrl),),
    );
  }
}