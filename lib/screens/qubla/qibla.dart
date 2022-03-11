
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:qurann/screens/qubla/qblaComponants/qibla.dart';



class QiblaScreen extends StatelessWidget {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );

        if (snapshot.hasError)
          return Center(
            child: Text('Error: ${snapshot.error.toString()}'),
          );
        if (snapshot.hasData)
          return QiblaCompass();
        else
          return Container(
            child: Text('Error'),
          );
      },
    );
  }
}