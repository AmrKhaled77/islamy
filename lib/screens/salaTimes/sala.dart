import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../MainCubit/AppCubit/AppCubit.dart';
import '../../MainCubit/AppCubit/AppCubitStates.dart';
import 'SalaItem.dart';

class salaTimesScreen extends StatefulWidget {
  // var locationLAT ;
  // var locationLON ;

  @override
  State<salaTimesScreen> createState() => _salaTimesScreenState();
// void initState() {
//   Future<double> getLocationLat() async {
//     var position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     var lastPosition = await Geolocator.getLastKnownPosition();
//     locationLAT = position.latitude;
//   }
//
//   Future<double> getLocationLon() async {
//     var position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     var lastPosition = await Geolocator.getLastKnownPosition();
//     locationLON = position.longitude;
//   }
// }
}

class _salaTimesScreenState extends State<salaTimesScreen> {
  @override
  Widget build(BuildContext context) {


    final myCoordinates = Coordinates(
    appCubit.get(context).rayerTimes.coordinates.latitude
    , appCubit.get(context).rayerTimes.coordinates.longitude);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    String nextSala=prayerTimes.nextPrayer().toString();
    String Asr=DateFormat.jm().format(prayerTimes.asr);
    List NextSala=nextSala.split('.');
    List asr=Asr.split(':');
    int asrTime=int.parse(asr[0]);

    return BlocConsumer<appCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image:
                            AssetImage('assets/images/M-design-rotated.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.015,
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height*0.1,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Center(
                              child: Text(

                                '${ appCubit.get(context).IsArabic?'الصلاه القادمة':
                                "Next pray"} : ${NextSala[1]=='none'?"fajr":NextSala[1]}',


                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(

                                  color: Theme.of(context).canvasColor,
                                  fontFamily: 'Amiri',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 12,
                      width: double.infinity,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Fajr',
                        Tstring: '${DateFormat.jm().format(prayerTimes.fajr)}',
                        Astring: 'الفجر'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Sunrise',
                        Tstring: '${DateFormat.jm().format(prayerTimes.sunrise)}',
                        Astring: 'الشروق'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Zuhr',
                        Tstring: '${DateFormat.jm().format(prayerTimes.dhuhr)}',
                        Astring: 'الظهر'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Asr',
                        Tstring: '${asrTime-1}:${asr[1]}',
                        Astring: 'العصر'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Maghrib',
                        Tstring: '${DateFormat.jm().format(prayerTimes.maghrib)}',
                        Astring: 'المغرب'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Isha',
                        Tstring: '${DateFormat.jm().format(prayerTimes.isha)}',
                        Astring: 'العشاء'),
                  ],
                )
              ],
            ),
          );
        });
  }
}
