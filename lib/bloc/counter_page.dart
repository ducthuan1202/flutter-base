import 'package:baby/graphql/launches_past.dart';
import 'package:baby/widgets/common/text/h1.dart';
import 'package:baby/widgets/common/text/h4.dart';
import 'package:flutter/material.dart';

// load config .env
import 'package:flutter_dotenv/flutter_dotenv.dart';

// bloc pattern
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baby/bloc/theme_cubit.dart';
import 'package:baby/bloc/counter_bloc.dart';

/// request REST API
import 'package:http/http.dart' as http;
import 'package:baby/datalayer/http/photo_http.dart';
import 'package:baby/datalayer/model/photo_model.dart';
import 'package:baby/widgets/photos_collect.dart';

// multi languages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:baby/l10n/translate.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String secretKey = dotenv.env['SECRET_KEY'].toString();

    return Scaffold(
      appBar: AppBar(title: Text(secretKey)),
      body: BlocBuilder<CounterBloc, int>(
        builder: (_, count) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  H1(text: '$count'),
                  H4(text: AppLocalizations.of(context)!.helloWorld),
                  H4(text: Translate.text(context).instruction),
                  Container( height: 200, child: Ship()),

                  Container(
                    height: 400,
                    child: FutureBuilder<List<Photo>>(
                      future: fetchPhotos(http.Client()),
                      builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Text('Load data error');
                        }
                        if(snapshot.hasData){
                          return PhotoCollect(data: snapshot.data!);
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                context.read<CounterBloc>().add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                context.read<CounterBloc>().add(CounterEvent.decrement);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.brightness_6),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.error),
              onPressed: () {
                context.read<CounterBloc>().add(CounterEvent.error);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(Icons.language),
              onPressed: () {
                context.read<LanguageCubit>().toggleLanguage();
              },
            ),
          )
        ],
      ),
    );
  }
}
