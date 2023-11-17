import 'dart:io';
import 'package:wifi_iot/wifi_iot.dart';

import 'package:flutter/material.dart';
import 'package:p2p_transfer/core/server.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String msg = "hello welcome";
  String wifiInfo = "click wifiinfo";
  ServerSocket? socket;

  @override
  void dispose() {
    socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('P2P Transfer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(msg),

            /// buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      socket = await createServer();
                      msg =
                          """Address: ${socket?.address.address}:${socket?.port}\ntype: ${socket?.address.type}                          
                          """;
                      setState(() {});
                    },
                    child: const Text("Recive")),
                ElevatedButton(
                    onPressed: () {
                      createClientAndSendData("0.0.0.0", "Hello iam jasim");
                    },
                    child: const Text("Send")),
                ElevatedButton(
                    onPressed: () async {
                      final ip = await WiFiForIoTPlugin.getIP();
                      final bssid = await WiFiForIoTPlugin.getBSSID();
                      final signelStrength =
                          await WiFiForIoTPlugin.getCurrentSignalStrength();
                      final ssid = await WiFiForIoTPlugin.getSSID();

                      wifiInfo = """IP: $ip
                          ssid: $ssid
                          bssid: $bssid
                          signel Strength: $signelStrength
                          """;
                      setState(() {});
                    },
                    child: const Text("Get WifiInfo")),
              ],
            ),

            Text(wifiInfo),
          ],
        ),
      ),
    );
  }
}
