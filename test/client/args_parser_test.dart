library client_args_parser_test;

import 'package:chat/src/client/args_parser.dart';
import 'package:test/test.dart';

main() {
  test('Parser should return default value if run without parameters.', () {
    expect(parseArgs([]), 'ws://127.0.0.1:4040/ws');
  });

  group('Parser should return server address if pass', () {
    final String address = "ws://test.test/test";

    test('short flag name.', () {
      expect(parseArgs(['-s', address]), address);
    });

    test('full flag name.', () {
      expect(parseArgs(['--server', address]), address);
    });
  });
}