import 'package:baby/widgets/photo_listview_item.dart';
import 'package:flutter/material.dart';
import 'photo_gridview_item.dart';
import 'package:baby/datalayer/model/photo_model.dart';

@immutable
class PhotoCollect extends StatelessWidget {
  final List<Photo> data;
  bool isListview = false;

  PhotoCollect({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isListview ? renderListview() : renderGridview();
  }

  Widget renderGridview() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => PhotoGridviewItem(data: data[index]),
    );
  }

  Widget renderListview() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            PhotoListviewItem(data: data[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: data.length);
  }
}
