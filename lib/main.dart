import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  // Get battery level.
  String _batteryLevel = '';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  String _model = 'Tap button to get info';

  Future<void> _getDeviceInfo() async {
    String model;
    try {
      final String result = await platform.invokeMethod('model');
      model = '$result ';
    } on PlatformException catch (e) {
      model = "Failed to get : '${e.message}'.";
    }

    setState(() {
      _model = model;
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_model),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _getDeviceInfo();
          _getBatteryLevel();
        },
        child: const Text('Get Device Info'),
      ),
    );
  }
}
