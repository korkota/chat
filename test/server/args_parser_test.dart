library server_args_parser_test;

import 'dart:io';

import 'package:chat/src/server/args_parser.dart';
import 'package:test/test.dart';

main() {
  test('Parser should return default value if run without parameters.', () {
    expect(parseArgs([]), {
      'host': '127.0.0.1',
      'port': 4040,
      'threads': Platform.numberOfProcessors
    });
  });

  String host = '42.42.42.42';
  String port = '42';
  String threads = '42';

  Map result = {
    'host': host,
    'port': int.parse(port),
    'threads': int.parse(threads)
  };

  test('Short flag name.', () {
    expect(parseArgs(['-h', host, '-p', port, '-t', threads]), result);
  });

  test('Full flag name.', () {
    expect(
        parseArgs(['--host', host, '--port', port, '--threads', threads]),
        result);
  });
}
