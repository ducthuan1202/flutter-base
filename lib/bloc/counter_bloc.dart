import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum CounterEvent {
  increment,
  decrement,
  error,
}

final secretNumber = int.parse(dotenv.env['SECRET_NUMBER'].toString());

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(secretNumber);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
      default:
        addError(Exception('event $event unsupported'));
        break;
    }
  }
}
