import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'location_error_widget.dart';

class QiblaCompass extends StatefulWidget {
  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  final _locationStreamController =
  StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator(
              color: Colors.white,
            );
          if (snapshot.data.enabled == true) {
            switch (snapshot.data.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblaWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              default:
                return Container();
            }
          } else {
            return LocationErrorWidget(
              error: "Enable Location Service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _platformBrightness = Theme.of(context).brightness;
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator(
            color: Colors.white,
          );

        final qiblahDirection = snapshot.data;
        var _angle = ((qiblahDirection.qiblah ?? 0) * (pi / 180) * -1);

        // if (_angle < 5 && _angle > -5) print('IN RANGE');

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Transform.rotate(
                      angle: _angle,
                      child: SvgPicture.asset('assets/images/5.svg', // compass
                          color:Theme.of(context).primaryColor),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: SvgPicture.asset('assets/images/3.svg',
                          fit: BoxFit.cover, //needle
                          color:Theme.of(context).primaryColor ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SvgPicture.asset('assets/images/4.svg',
                          fit: BoxFit.cover, //needle
                        )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              '${AppLocalizations.of(context).qiblaBottomText}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: appCubit.get(context).IsArabic ? 17 : 16,
                  fontFamily: 'Amiri'),
            ),
          ],
        );
      },
    );
  }
}
