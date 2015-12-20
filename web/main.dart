import 'dart:html';
import 'dart:typed_data';

import 'package:chat/src/message.pb.dart' show Message;
import 'package:intl/intl.dart';

class CustomUriPolicy implements UriPolicy {
  bool allowsUri(String uri) => true;
}

main() async {
  WebSocket socket = new WebSocket('ws://127.0.0.1:4040/ws');
  socket.binaryType = 'arraybuffer';
  await socket.onOpen.first;

  Function sendMessage = (e) {
    TextAreaElement input = document.querySelector('textarea');
    Message message = new Message()
      ..text = input.value;
    socket.send(message.writeToBuffer());
    input.value = '';
  };

  document
      .querySelector('#sendBtn')
      .onClick
      .listen(sendMessage);

  document
      .querySelector('#messageText')
      .onKeyUp
      .where((e) => e.keyCode == KeyCode.ENTER && e.ctrlKey)
      .listen(sendMessage);

  Element chat = document.querySelector('.chat-widget');

  await for (MessageEvent event in socket.onMessage) {
    ByteBuffer data = event.data;
    Message message = new Message.fromBuffer(data.asUint8List());
    String time = new DateFormat.Hms().format(new DateTime.now());
    NodeValidator validator = new NodeValidatorBuilder()
      ..allowHtml5()
      ..allowImages(new CustomUriPolicy());
    chat.appendHtml('''
    <div class="message">
      <hr>
      <div class="row">
        <div class="col-lg-12">
          <div class="media">
            <a class="pull-left" href="#">
              <img class="media-object img-circle" src="http://api.adorable.io/avatars/40/${message
        .sender}.png" alt="">
            </a>

            <div class="media-body">
              <h5 class="media-heading">${message.sender}
                <span class="small pull-right">${time}</span>
              </h5>

              <div>${message.text}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    ''', validator: validator);
    chat.children.last.scrollIntoView(ScrollAlignment.BOTTOM);
  }
}