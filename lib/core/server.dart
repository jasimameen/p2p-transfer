import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future createServer() async {
  await ServerSocket.bind(InternetAddress.anyIPv4, 3000)
      .then((ServerSocket serverSocket) {
    serverSocket.listen(
      (Socket data) {
        data.listen((event) {
          var decoded = utf8.decode(event);
          print('Received from client: $decoded');
        });
      },
      onError: (error) {
        print('Error: $error');
      },
      onDone: () {
        print('Client has closed the connection');
      },
    );
    return serverSocket;
  });

  // (socket.asBroadcastStream()).listen((event) {
  //   print(event.toString());
  // });
  // socket.asBroadcastStream(
  //   onListen: (subscription) {
  //     subscription.onData((data) {
  //       print('data from broadcast from clint');
  //     });
  //   },
  // );

  // socket.listen((Socket socket) {
  //   socket.listen((List<int> data) {
  //     print('hey data has recieved from the clint');
  //     String msg = utf8.decode(data);
  //     socket.write("Hello client");
  //     print(msg);
  //   });
  // });

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

  // return socket;
}

void createClientAndSendData(ip, dynamic data) {
  Socket.connect('0.0.0.0', 3000).then((Socket socket) {
    print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
    socket.listen(
      (data) {
        print('Received from server: ${utf8.decode(data)}');
      },
      onError: (error) {
        print('Error: $error');
      },
      onDone: () {
        print('Server has closed the connection');
      },
    );
    socket.write('Hello, Server!');
  });

  // IO.Socket socket = IO.io(
  //     'http://0.0.0.0:3000',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .enableAutoConnect()
  //         .enableReconnection()
  //         .build());

  // // socket.onConnecting((data) {
  // //   dPrint("connecting");
  // // });

  // // socket.onConnect((handler) {
  // //   dPrint("onConnect: ${handler.toString()}");
  // //   socket.emit('data', data);
  // // });

  // // print("conneted: ${socket.connected}");
  // // socket.onAny((event, data) {
  // //   dPrint("event: $event");
  // //   dPrint("onAny: ${data.toString()}");
  // // });
  // socket.on('s', (data) {
  //   print("yay s event data is here: $data");
  // });
  // socket.onConnect((data) {
  //   socket.emit('i', 'heyyy i am clint'.codeUnits);
  //   print('connection establihed');
  // });
  // socket.onError((data) => dPrint("socker onError: $data"));
  // socket.on("data", (data) => debugPrint("socket dat on event: data: $data"));

  // socket.connect();
}
