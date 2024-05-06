import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:projet_dev_mobile/src/multiJoueurs/Quizz/Game5/game.dart';

class BluetoothSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Bluetooth Device'),
      ),
      body: BondedDevicesList(),
    );
  }
}

class BondedDevicesList extends StatefulWidget {
  @override
  _BondedDevicesListState createState() => _BondedDevicesListState();
}

class _BondedDevicesListState extends State<BondedDevicesList> {
  late List<BluetoothDevice> bondedDevices = [];

  @override
  void initState() {
    super.initState();
    _requestBluetoothPermission();
  }

  Future<void> _requestBluetoothPermission() async {
    // Check if Bluetooth permission is granted
    PermissionStatus bluetooth = await Permission.bluetooth.request();
    PermissionStatus bluetoothconnect = await Permission.bluetoothConnect.request();
    PermissionStatus bluetoothscan = await Permission.bluetoothScan.request();

    if (bluetooth == PermissionStatus.granted &&
        bluetoothconnect == PermissionStatus.granted &&
        bluetoothscan == PermissionStatus.granted) {
      // If permission is granted, fetch bonded devices
      _fetchBondedDevices();
    } else {
      // Handle case where permission is denied
      // You can show a message to the user explaining why the permission is needed
    }
  }

  Future<void> _fetchBondedDevices() async {
    // Fetch bonded Bluetooth devices
    List<BluetoothDevice> devices = await AllBluetooth().getBondedDevices();
    setState(() {
      bondedDevices = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bondedDevices.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(bondedDevices[index].name ?? 'Unknown'),
          onTap: () {
            // Connect to selected device and start the game
            _connectToDeviceAndStartGame(bondedDevices[index].address);
          },
        );
      },
    );
  }

  Future<void> _connectToDeviceAndStartGame(String deviceAddress) async {
    try {
      // Connect to the selected device
      await AllBluetooth().connectToDevice(deviceAddress);
      // Wait for the connection to be established
      await Future.delayed(Duration(seconds: 2)); // Adjust delay as needed
      // Send message to start the game
      AllBluetooth().sendMessage('START_GAME');
      // Navigate to Math2 screen passing the selected device address
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Math2(deviceAddress)),
      );
    } catch (e) {
      // Handle connection errors
      print('Error connecting to device: $e');
      // Show a snackbar or dialog to inform the user about the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to connect to the device. Please try again.'),
        ),
      );
    }
  }
}
