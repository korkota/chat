library args_parser;

import 'dart:io';

import 'package:args/args.dart';

String parseArgs(List<String> args) {
  ArgParser parser = new ArgParser();

  parser.addOption('server',
      abbr: 's',
      help: 'Path to chat server.',
      defaultsTo: 'ws://127.0.0.1:4040/ws'
  );

  parser.addFlag(
      'help',
      abbr: 'h',
      help: 'Prints this help.',
      negatable: false,
      callback: (printHelp) {
        if (printHelp) {
          print('CLI chat client.\n');
          print(parser.usage);
          exit(0);
        }
      }
  );

  ArgResults results = parser.parse(args);

  return results['server'];
}