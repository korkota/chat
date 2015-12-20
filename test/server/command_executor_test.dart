library server_command_executor_test;

import 'dart:isolate';

import 'package:chat/src/message.pb.dart';
import 'package:chat/src/server/command_executor.dart';
import 'package:chat/src/server/constants.dart';
import 'package:test/test.dart';

main() {
  test('Command executor should execute command', () async {
    ReceivePort result = new ReceivePort();
    ReceivePort temp = new ReceivePort();
    await Isolate.spawn(runCommandExecutor, {
      'toMaster': result.sendPort,
      'temp': temp.sendPort
    });
    SendPort toCommandExecutor = await temp.first;
    String command = "echo 123";
    toCommandExecutor.send(new Message()
      ..text = "$COMMAND_PREFIX $command");
    Message message = await result.first;
    print(message);
    expect('123\n', equals(message.text));
  });
}