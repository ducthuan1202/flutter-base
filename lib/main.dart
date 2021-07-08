import 'package:baby/bloc/counter_bloc.dart';
import 'package:baby/bloc/counter_page.dart';
import 'package:baby/bloc/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future main() async{
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppGraphQLProvider();
  }
}

class AppGraphQLProvider extends StatelessWidget {
  const AppGraphQLProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    WidgetsFlutterBinding.ensureInitialized();

    final HttpLink httpLink = HttpLink('https://api.spacex.land/graphql');

    ValueNotifier<GraphQLClient> client = ValueNotifier(
        GraphQLClient(
          cache: GraphQLCache(store: InMemoryStore()),
          link: httpLink,
        )
    );



    return GraphQLProvider(
      client: client,
      child: LanguageProvider(),
    );
  }
}


class AppProvider extends StatelessWidget {
  final Locale locale;
  final ThemeData theme;
  const AppProvider({Key? key, required this.locale, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool debug = dotenv.env['APP_DEBUG'].toString().toLowerCase() == 'true';
    return MaterialApp(
      debugShowCheckedModeBanner: debug,
      theme: theme,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class ThemeProvider extends StatelessWidget {
  final Locale locale;
  const ThemeProvider({Key? key, required this.locale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) =>AppProvider(locale: locale, theme: theme),
      ),
    );
  }
}

class LanguageProvider extends StatelessWidget {
  const LanguageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (_, locale) =>ThemeProvider(locale: locale),
        )
    );
  }
}


