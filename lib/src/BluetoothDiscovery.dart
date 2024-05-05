import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDiscovery extends StatefulWidget {
  final ValueChanged<BluetoothDevice> onConnect;

  const BluetoothDiscovery({super.key, required this.onConnect});

  @override
  _BluetoothDiscoveryState createState() => _BluetoothDiscoveryState();
}

class _BluetoothDiscoveryState extends State<BluetoothDiscovery> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> devices = [];

  StreamSubscription? _scanSubscription;

  @override
  void initState() {
    super.initState();
    _requestBluetoothPermissions();
  }

  @override
  void dispose() {
    _stopScan();
    super.dispose();
  }

  Future<void> _requestBluetoothPermissions() async {
    // Requesting all necessary Bluetooth permissions
    Map<Permission, PermissionStatus> permissions = await [
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();
    
    // Check if all permissions are granted
    bool allGranted = permissions.values.every((status) => status.isGranted);
    
    if (allGranted) {
      _startDiscovery();
    } else {
      print('Bluetooth permissions denied');
    }
  }

  Future<void> _startDiscovery() async {
    try {
      await flutterBlue.startScan(timeout: const Duration(seconds: 10));

      _scanSubscription = flutterBlue.scanResults.listen((List<ScanResult> scanResults) {
        setState(() {
          devices = scanResults;
        });
      });
    } catch (e) {
      print('Error starting Bluetooth discovery: $e');
    }
  }

  void _stopScan() {
    flutterBlue.stopScan();
    _scanSubscription?.cancel();
  }

  void _connectToDevice(ScanResult device) async {
    try {
      await device.device.connect();
      widget.onConnect(device.device);
      _stopScan();
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Discovery'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          ScanResult device = devices[index];
          return ListTile(
            title: Text(device.device.name ?? 'Unknown'),
            subtitle: Text(device.device.id.toString()),
            onTap: () {
              _connectToDevice(device);

            },
          );
        },
      ),
    );
  }
}
