import 'package:flutter/material.dart';

class H2 extends StatelessWidget {
  final String text;

  const H2({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
