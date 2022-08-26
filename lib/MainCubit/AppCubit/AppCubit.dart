import 'package:adhan/adhan.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import '../../screens/quran/SurahAndJuz2Item.dart';
import 'AppCubitStates.dart';
import '../../MainCubit/AppCubit/AppCubitStates.dart';

class appCubit extends Cubit<AppCubitStates> {
  appCubit() : super(ThemeInitialState());

  static appCubit get(context) => BlocProvider.of(context);
  DateTime currentTime = DateTime.now();
  double suraOffset;
  final Scrollcontroller = ScrollController();

  GoToLastAyaIndex(int suranum) {
    if(cacheHelper.getdata(key: 'lastsuraCheck')==suranum){
    double offset = cacheHelper.getdata(key: 'lastverss');
    Scrollcontroller.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }}

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

  bool isDark = false;

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

  var locationlaitude = 30.033333;
  var locationlongitude = 31.233334;

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, We cannot request permissions');
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var LastPosition = await Geolocator.getLastKnownPosition();
    print(LastPosition);
    print(position.latitude);
    locationlaitude = position.latitude;
    locationlongitude = position.longitude;
    emit(locationState());
  }

  void ShowToast(context, message) => Fluttertoast.showToast(
    msg: message,
    fontSize: 15,
    backgroundColor:
    appCubit.get(context).isDark ? Colors.white : Colors.white,
    textColor: appCubit.get(context).isDark ? Colors.black : Colors.black,
  );
  List <String> LIST=[];
  List Quran=[];

// bool isReading=false;
// void change(){
//   isReading=!isReading;
//   emit(ChangeState());
//
// }
  List<verssModel> AudioList = [];

}

