import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:p2p_transfer/core/stdout.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Future<ServerSocket> createServer() async {
  final socket = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);

  print("socker url${socket.address}");

  // (socket.asBroadcastStream()).listen((event) {
  //   print(event.toString());
  // });
  socket.asBroadcastStream(
    onListen: (subscription) {
      subscription.onData((data) {
        print('data from broadcast from clint');
      });
    },
  );

  socket.listen((Socket socket) {
    socket.listen((List<int> data) {
      print(data);
    });
  });

  // socket.listen((client) {
  //   dPrint("listening remote ${client.remoteAddress.toString()}");
  //   dPrint("listening port: ${client.remotePort.toString()}");

  //   // client.write("hei ima sjsj");
  //   client.writeln("hei iam server");

  //   dPrint(client.address.toString());
  //   client.asBroadcastStream(
  //     onListen: (subscription) {
  //       print(subscription.toString());
  //     },
  //   );
  // });

  return socket;
}

void createClientAndSendData(ip, dynamic data) {
  IO.Socket socket = IO.io(
      'http://0.0.0.0:3000',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect()
          .enableReconnection()
          .build());

  // socket.onConnecting((data) {
  //   dPrint("connecting");
  // });

  // socket.onConnect((handler) {
  //   dPrint("onConnect: ${handler.toString()}");
  //   socket.emit('data', data);
  // });

  // print("conneted: ${socket.connected}");
  // socket.onAny((event, data) {
  //   dPrint("event: $event");
  //   dPrint("onAny: ${data.toString()}");
  // });
  socket.on('s', (data) {
    print("yay s event data is here: $data");
  });
  socket.onConnect((data) {
    socket.emit('i', 'heyyy i am client');
    print('connection establihed');
  });
  socket.onError((data) => dPrint("socker onError: $data"));
  socket.on("data", (data) => debugPrint("socket dat on event: data: $data"));

  socket.connect();
}
