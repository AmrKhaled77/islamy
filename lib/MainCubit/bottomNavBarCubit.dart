
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurann/screens/Sebha/Sebha.dart';
import 'package:qurann/screens/quran/quran.dart';
import 'package:qurann/screens/salaTimes/sala.dart';
import '../screens/qubla/qibla.dart';
import 'bottomNavBarStates.dart';

class bottomNavBarCubit extends Cubit<bottomNavBarStates> {
  bottomNavBarCubit() : super(bottomNavBarInitial());

  static bottomNavBarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    quranScreen(),
    salaTimesScreen(),
    QiblaScreen(),
    SebhaScreen(),
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarSTete());
  }
}
