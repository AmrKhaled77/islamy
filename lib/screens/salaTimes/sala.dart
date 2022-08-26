import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../MainCubit/AppCubit/AppCubit.dart';
import '../../MainCubit/AppCubit/AppCubitStates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'SalaItem.dart';

class salaTimesScreen extends StatefulWidget {
  @override
  State<salaTimesScreen> createState() => _salaTimesScreenState();
}

class _salaTimesScreenState extends State<salaTimesScreen> {
  @override
  Widget build(BuildContext context) {
    final myCoordinates = Coordinates(appCubit.get(context).locationlaitude,
        appCubit.get(context).locationlongitude);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    String nextSala = prayerTimes.nextPrayer().toString();
    List NextSala = nextSala.split('.');

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
                            image: AssetImage(
                              appCubit.get(context).isDark
                                  ? 'assets/images/M-design-unrotated.png'
                                  : 'assets/images/M-design-light-rotated.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LocationCairo(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Center(
                              child: Text(
                                '${appCubit.get(context).IsArabic ? 'الصلاه القادمة' : "Next pray"} : ${NextSala[1] == 'none' ? "fajr" : NextSala[1]}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: appCubit.get(context).isDark
                                      ? Colors.white
                                      : Color.fromARGB(255, 251, 228, 189),
                                  fontFamily: 'Amiri',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          LocationErrorFunction(),
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
                        Tstring:
                        '${DateFormat.jm().format(prayerTimes.sunrise)}',
                        Astring: 'الشروق'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Dhuhr',
                        Tstring: '${DateFormat.jm().format(prayerTimes.dhuhr)}',
                        Astring: 'الظهر'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Asr',
                        Tstring: '${DateFormat.jm().format(prayerTimes.asr)}',
                        Astring: 'العصر'),
                    SizedBox(
                      height: 19,
                    ),
                    salaItem(
                        context: context,
                        Estring: 'Maghrib',
                        Tstring:
                        '${DateFormat.jm().format(prayerTimes.maghrib)}',
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
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
          );
        });
  }

  LocationCairo() {
    if (appCubit.get(context).locationlongitude == 31.233334 &&
        appCubit.get(context).locationlaitude == 30.033333) {
      return Center(
        child: Container(
          child: Text(
            AppLocalizations.of(context).locationcairo,
            style: TextStyle(
              color: appCubit.get(context).isDark
                  ? Colors.white
                  : Color.fromARGB(255, 251, 228, 189),
              fontFamily: 'Amiri',
              fontSize: appCubit.get(context).IsArabic ? 12 : 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  LocationErrorFunction() {
    return Center(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            AppLocalizations.of(context).locationerror,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appCubit.get(context).isDark
                  ? Colors.white
                  : Color.fromARGB(255, 251, 228, 189),
              fontFamily: 'Amiri',
              fontSize: appCubit.get(context).IsArabic ? 10 : 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
