import 'package:flutter/material.dart';
import 'package:baby/datalayer/model/photo_model.dart';

class PhotoListviewItem extends StatelessWidget {
  final Photo data;

  PhotoListviewItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image(image: NetworkImage(data.thumbnailUrl)),
        title: Text(data.title),
        subtitle: Text(data.url),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {},
        ),
      ),
    );
  }
}