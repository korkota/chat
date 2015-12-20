library command_executor;

import 'dart:io';
import 'dart:isolate';

import 'package:chat/src/message.pb.dart';

import 'constants.dart';

runCommandExecutor(config) async {
  SendPort toMaster = config['toMaster'];
  SendPort temp = config['temp'];
  ReceivePort commandsFromWorkers = new ReceivePort();
  temp.send(commandsFromWorkers.sendPort);

  await for (Message message in commandsFromWorkers) {
    print("Command executor has got command: '${message.text}'");

    List<String> command = message.text.substring(COMMAND_PREFIX.length)
        .trim()
        .split(new RegExp(r"\s+"));
    ProcessResult result;

    try {
      result = Process.runSync(command.first, command.sublist(1));
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      continue;
    }

    message.sender = 'Server';
    message.text = result.exitCode == 0 ? result.stdout : result.stderr;

    toMaster.send(message);
  }
}