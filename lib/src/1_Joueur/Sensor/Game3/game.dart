import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(SensorListApp());
}

class SensorListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SensorListPage(),
    );
  }
}

class SensorListPage extends StatefulWidget {
  @override
  _SensorListPageState createState() => _SensorListPageState();
}

class _SensorListPageState extends State<SensorListPage> {
  List<Sensor> _sensors = [];

  @override
  void initState() {
    super.initState();
    _getSensors();
  }

  void _getSensors() async {
    List<Sensor> sensors = await availableSensors;
    setState(() {
      _sensors = sensors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor List'),
      ),
      body: ListView.builder(
        itemCount: _sensors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_sensors[index].toString()),
          );
        },
      ),
    );
  }
}
