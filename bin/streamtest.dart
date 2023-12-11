import 'dart:async';

//import 'package:streamtest/streamtest.dart' as streamtest;

Future<void> main(List<String> arguments) async {
  //print('Hello world: ${streamtest.calculate()}!');
  //final stream = Stream.value(0);
  //final stream = Stream.fromIterable([0, 1, 3, 5, 7]);
  final controller = StreamController<int>.broadcast();
  //final stream = controller.stream.map((event) => 'Dado $event');
  //final stream = controller.stream.map<String>(_convertIntegerToString);
  final stream = controller.stream
      .distinct()
      .where((event) => event != 1)
      .asyncMap<String>(
        _FutureConvertIntegerToString,
      );

  stream.listen(
    //stream.listen(
    (success) {
      print(success);
    },
    onDone: () {
      print('Done');
    },
  );

/*   controller.stream.listen((success) {print(success);
    },onDone: () {print('Done');},); */

  controller.sink.add(0);
  controller.sink.add(1);
  controller.sink.add(3);
  await Future<dynamic>.delayed(
    const Duration(
      seconds: 15,
    ),
  );
  controller.close();
}

String _convertIntegerToString(int value) {
  return 'Dado $value';
}

Future<String> _FutureConvertIntegerToString(int value) async {
  await Future<dynamic>.delayed(
    const Duration(
      seconds: 2,
    ),
  );
  return 'Dado $value';
}
