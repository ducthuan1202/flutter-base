import 'package:flutter/material.dart';
import 'package:baby/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabMenuHome extends StatefulWidget {
  final String title;

  const TabMenuHome({Key? key, required this.title}) : super(key: key);

  @override
  _TabMenuHomeState createState() => _TabMenuHomeState();
}

class _TabMenuHomeState extends State<TabMenuHome> {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CounterBloc, int>(
      builder: (_, count){
        return Center(
          child: Text(
            '$count', style: Theme.of(context).textTheme.headline1,
          ),
        );
      },
    );
  }

}

