
import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import '../MainCubit/bottomNavBarCubit.dart';
import '../MainCubit/bottomNavBarStates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final myCoordinates = Coordinates(30.033333, 31.233334);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    List<String> titles = [
      appCubit.get(context).IsArabic ? 'القرآن  الكريم' : 'Quran',
      AppLocalizations.of(context).sala,
      AppLocalizations.of(context).qbla,
      AppLocalizations.of(context).sebha,
    ];
    return BlocProvider(
      create: (BuildContext context) => bottomNavBarCubit(),
      child: BlocConsumer<bottomNavBarCubit, bottomNavBarStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Image(
                image:appCubit.get(context).isDark?
                AssetImage('assets/images/backgroundupperdraw.png'):
                AssetImage(''),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              Scaffold(

               floatingActionButton:   FloatingActionButton(onPressed:
              appCubit.get(context).changeListPattern,
               child: Icon(Icons.wifi_protected_setup_outlined),),


                backgroundColor: appCubit.get(context).isDark?Colors.transparent:
              Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      showCupertinoDialog(
                          context: context, builder: LanguageDialog);
                    },
                    icon: Icon(
                      Icons.language,
                      color: appCubit.get(context).isDark?Colors.white:
                      Colors.black,
                      size: 24,
                    ),
                  ),
                  actions: [
                    IconButton(
                        icon: ImageIcon(
                          AssetImage('assets/images/paintbrush.png'),
                          color: appCubit.get(context).isDark?Colors.white:
                          Colors.black,
                          size: 21,
                        ),
                        onPressed: () {
                          setState(() {
                            appCubit.get(context).changeTheme(null);
                          });
                          print(appCubit.get(context).isDark);
                        }),
                  ],
                  title: Text(
                    titles[bottomNavBarCubit.get(context).currentIndex],
                    style: TextStyle(
                        color: appCubit.get(context).isDark?Colors.white:
                        Colors.black,
                        fontSize: 25,
                        fontFamily:
                           'Amiri' ,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: bottomNavBarCubit
                    .get(context)
                    .screens[bottomNavBarCubit.get(context).currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: bottomNavBarCubit.get(context).currentIndex,
                  onTap: (index) {
                    bottomNavBarCubit.get(context).ChangeIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: appCubit.get(context).isDark?
                  Color.fromARGB(255, 22, 31, 87):Colors.white,
                  unselectedIconTheme: IconThemeData(color:
                      appCubit.get(context).isDark?
                  Colors.white:Colors.black),
                  selectedIconTheme: IconThemeData(color: Colors.purple),
                  iconSize: 500,
                  items: [
                    BottomNavigationBarItem(
                        icon: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Center(
                            child: ImageIcon(
                              AssetImage('assets/images/koran.png'),
                              size: 26,
                            ),
                          ),
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Center(
                              child: ImageIcon(
                                AssetImage('assets/images/mosque.png'),
                                size: 30,
                              ),
                            )),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height * 0.043,
                            child: Center(
                              child: ImageIcon(
                                AssetImage(
                                  'assets/images/compass.png',
                                ),
                              ),
                            )),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/beads.png')),
                            )),
                        label: ""),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget LanguageDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          appCubit.get(context).IsArabic
              ? 'اللغة ستتغير للإنجليزية !'
              : 'The language will change to Arabic !',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(appCubit.get(context).IsArabic ? 'لا' : 'No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(appCubit.get(context).IsArabic ? 'أجل' : 'Yes'),
            onPressed: () {
              appCubit.get(context).ChangeLocale(null);
              Navigator.pop(context);
            },
          ),
        ],
      );
}

