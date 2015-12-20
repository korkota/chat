library server_worker_test;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:chat/src/message.pb.dart';
import 'package:chat/src/server/constants.dart';
import 'package:chat/src/server/worker.dart';
import 'package:test/test.dart';

main() {
  Isolate worker;
  ReceivePort fromWorkers;
  ReceivePort fromWorkerToCommandExecutor;
  SendPort toCommandExecutor;
  Stream messagesFromWorkers;
  WebSocket socket;
  String host = '127.0.0.1';
  int port = 4000;

  setUp(() async {
    fromWorkers = new ReceivePort();
    fromWorkerToCommandExecutor = new ReceivePort();
    toCommandExecutor = fromWorkerToCommandExecutor.sendPort;

    worker = await Isolate.spawn(runWorker, {
      'id': '1',
      'host': host,
      'port': port,
      'toMaster': fromWorkers.sendPort,
      'toCommandExecutor': toCommandExecutor
    });
    messagesFromWorkers = fromWorkers.asBroadcastStream();
    await messagesFromWorkers.first;
    socket = await WebSocket.connect('ws://$host:$port/ws');
  });

  tearDown(() async {
    fromWorkers.close();
    fromWorkerToCommandExecutor.close();
    await socket.close();
    worker.kill(priority: Isolate.IMMEDIATE);
  });

  test('Worker should send message from client to broker.', () async {
    String text = 'lorem ipsum';
    Message message = new Message()
      ..text = text;
    socket.add(message.writeToBuffer());

    Message messageToMaster = await messagesFromWorkers.first;
    expect(text, equals(messageToMaster.text));
  });

  test('Worker should send command from client to command executor.', () async {
    String text = "$COMMAND_PREFIX echo '123'";
    Message message = new Message()
      ..text = text;
    socket.add(message.writeToBuffer());

    Message messageToCommandExecutor = await fromWorkerToCommandExecutor.first;
    expect(text, equals(messageToCommandExecutor.text));
  });
}