


import 'package:adhan/adhan.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import 'AppCubitStates.dart';
import '../../MainCubit/AppCubit/AppCubitStates.dart';
class appCubit extends Cubit<AppCubitStates> {
  appCubit() : super(ThemeInitialState());

  static appCubit get(context) => BlocProvider.of(context);
  DateTime currentTime = DateTime.now();
  double suraOffset;
  final Scrollcontroller =ScrollController();
  GoToLastAyaIndex(){
    double offset=cacheHelper.getdata(key: 'lastverss');
    Scrollcontroller.animateTo(offset, duration:
    Duration(seconds: 1)
        , curve: Curves.ease );

  }

  String todayDateClock() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('h:mm').format(now);
    return formattedTime;
  }

  String DateNow() {
    String unformateddate = DateTime.now().toString();
    List date = unformateddate.split(' ');
    return date[0];
  }

  int currentSurahNumber = 1;
  String currentSurahName = '';

  void saveDataCache(context, String value, String key) {
    cacheHelper.saveData(key: key, value: value);
    emit(saveDataState());
  }

  void saveInt(context, int value, String key) {
    cacheHelper.saveData(key: key, value: value);
    emit(saveDataState());
  }

  bool IsArabic = false;

  void ChangeLocale(bool fromCache) {
    if (fromCache != null) {
      emit(ChangeL10n());
      IsArabic = fromCache;
    } else
      IsArabic = !IsArabic;
    emit(ChangeL10n());
    cacheHelper
        .saveData(key: 'ISARBICK', value: IsArabic)
        .then((value) => {emit(ChangeL10n())});
  }

  int totalPages;
  double taspeh = 0.0;
  String tspehWord = 'سبحان الله';
  int duration = 0;
  var currentAngle = 0.0;


  bool isDark=false;
  void changeTheme(bool fromCache) {
    if (fromCache != null) {
      emit(AppChangeThemeSTete());
      isDark = fromCache;
    } else
      isDark = !isDark;
    cacheHelper
        .saveData(key: 'isDark', value: isDark)
        .then((value) => {emit(AppChangeThemeSTete())});
  }
  var locationLAT=30.21035;
  var locationLON=31.36812;

  // void getLocationLat() async {
  //   var x = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best,);
  //   var lastPosition = await Geolocator.getLastKnownPosition();
  //   locationLAT =x.altitude;
  //   locationLON = x.longitude;
  // }
  PrayerTimes rayerTimes;
void c(){
  final myCoordinates = Coordinates(30.033333, 31.233334);
  final params = CalculationMethod.egyptian.getParameters();
  params.madhab = Madhab.hanafi;
  final prayerTimes = PrayerTimes.today(myCoordinates, params);
  rayerTimes =PrayerTimes.today(myCoordinates, params);
}
  bool juzaPattern=false;
void changeListPattern(){
  juzaPattern=!juzaPattern;
  emit(AppChangeListPattern());
}

  }

//



