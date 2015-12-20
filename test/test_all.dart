import 'package:test/test.dart';

import 'client/args_parser_test.dart' as client_args_parser;
import 'server/args_parser_test.dart' as server_args_parser;
import 'server/command_executor_test.dart' as server_command_executor;
import 'server/worker_test.dart' as server_worker_test;

main() {
  group('client_args_parser', client_args_parser.main);
  group('server_args_parser', server_args_parser.main);
  group('server_command_executor', server_command_executor.main);
  group('server_worker_test', server_worker_test.main);
}