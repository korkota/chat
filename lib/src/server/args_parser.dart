library args_parser;

import 'dart:io';

import 'package:args/args.dart';

Map parseArgs(List<String> args) {
  ArgParser parser = new ArgParser();

  parser.addOption('threads',
      abbr: 't',
      help: 'Number of threads.',
      defaultsTo: Platform.numberOfProcessors.toString()
  );

  parser.addOption('host',
      abbr: 'h',
      help: 'Host name.',
      defaultsTo: '127.0.0.1'
  );

  parser.addOption('port',
      abbr: 'p',
      help: 'Port number.',
      defaultsTo: '4040'
  );

  parser.addFlag(
      'help',
      help: 'Prints this help.',
      negatable: false,
      callback: (printHelp) {
        if (printHelp) {
          print('Multithreaded chat server.\n');
          print(parser.usage);
          exit(0);
        }
      }
  );

  ArgResults results = parser.parse(args);

  return {
    'threads': int.parse(results['threads'],
        onError: (_) => Platform.numberOfProcessors),
    'host': results['host'],
    'port': int.parse(results['port'], onError: (_) => 4040)
  };
}