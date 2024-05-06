import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/main.dart';
import 'package:projet_dev_mobile/src/1_Joueur/Quizz/Game5/game.dart';
import 'package:projet_dev_mobile/src/multiJoueurs/Bluetooth/chat_screen.dart';

void main() {
  runApp(const BluetoothDiscovery());
}

final allBluetooth = AllBluetooth();

class BluetoothDiscovery extends StatelessWidget {
  const BluetoothDiscovery({super.key});

  /*Future<String?> getDeviceName() async {
    List<BluetoothDevice> devices = await allBluetooth.getBondedDevices();
    if (devices.isNotEmpty) {
      return devices.first.name;
    } else {
      return null;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
          stream: allBluetooth.listenForConnection,
          builder: (context, snapshot) {
            final result = snapshot.data;
            if (result?.state == true) {
              return const ChatScreen();
            }
            print(result);
            return const HomeScreen();
          }),
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
