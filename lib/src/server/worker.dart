library worker;

import 'dart:io';
import 'dart:isolate';

import 'package:chat/src/message.pb.dart';

import 'constants.dart';

runWorker(config) async {
  SendPort toMaster = config['toMaster'];
  SendPort toCommandExecutor = config['toCommandExecutor'];
  String workerId = config['id'];

  List<WebSocket> sockets = new List<WebSocket>();
  ReceivePort fromMaster = new ReceivePort();
  toMaster.send(fromMaster.sendPort);

  fromMaster.listen((message) {
    for (WebSocket socket in sockets) {
      print("Worker #$workerId sends message '${message
          .text}' to all his sockets.");
      socket.add(message.writeToBuffer());
    }
  });

  HttpServer server = await HttpServer.bind(
      config['host'], config['port'], shared: true);

  await for (HttpRequest req in server) {
    if (req.uri.path == '/ws') {
      // Upgrade an HttpRequest to a WebSocket connection.
      WebSocket socket = await WebSocketTransformer.upgrade(req);
      sockets.add(socket);

      await for (List<int> data in socket.where((data) => data is List<int>)) {
        Message message;

        try {
          message = new Message.fromBuffer(data);
        } catch (e, stackTrace) {
          print(e);
          print(stackTrace);
          continue;
        }

        print("Worker #$workerId has recived message '${message
            .text}' from client.");

        if (message.text.startsWith(COMMAND_PREFIX)) {
          toCommandExecutor.send(message);
        } else {
          message.sender = "User_${socket.hashCode.toString()}_$workerId";
          toMaster.send(message);
        }
      }

      await socket.done;

      sockets.remove(socket);
      print("Worker #$workerId has removed socket ${socket.hashCode}.");
    }
  }
}