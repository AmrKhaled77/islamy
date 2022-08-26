import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import '../MainCubit/bottomNavBarCubit.dart';
import '../MainCubit/bottomNavBarStates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List x=[];
    List<String> titles = [
      appCubit.get(context).IsArabic ? 'القرآن  الكريم' : 'Quran',
      AppLocalizations.of(context).sala,
      AppLocalizations.of(context).qbla,
      AppLocalizations.of(context).sanda,
    ];
    return BlocProvider(
      create: (BuildContext context) => bottomNavBarCubit(),
      child: BlocConsumer<bottomNavBarCubit, bottomNavBarStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

            backgroundColor: appCubit.get(context).isDark
                ? Color.fromARGB(255, 22, 31, 87)
                : Color.fromARGB(255, 251, 228, 189),
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
                  color: appCubit.get(context).isDark
                      ? Colors.white
                      : Color.fromARGB(255, 45, 37, 20),
                  size: 24,
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 45, 37, 20),
                      size: 25,
                    ),
                    onPressed: () {
                      appCubit.get(context).getCurrentLocation();
                      showCupertinoDialog(
                          context: context, builder: HelpDialog);
                    }),
                IconButton(
                    icon: ImageIcon(
                      AssetImage('assets/images/paintbrush.png'),
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 45, 37, 20),
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
                    color: appCubit.get(context).isDark
                        ? Colors.white
                        : Color.fromARGB(255, 45, 37, 20),
                    fontSize: 25,
                    fontFamily: 'Amiri',
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
              backgroundColor: appCubit.get(context).isDark
                  ? Color.fromARGB(255, 22, 31, 87)
                  : Color.fromARGB(255, 251, 228, 189),
              elevation: 20,
              unselectedIconTheme: IconThemeData(
                  color: appCubit.get(context).isDark
                      ? Colors.white
                      : Color.fromARGB(255, 150, 121, 89)),
              selectedIconTheme: IconThemeData(
                  color: appCubit.get(context).isDark
                      ? Colors.purple
                      : Color.fromARGB(255, 38, 32, 17)),
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
                            AssetImage('assets/images/duahands.png'),
                            size: 35,
                          ),
                        )),
                    label: ""),
              ],
            ),
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
        child: Text(appCubit.get(context).IsArabic ? 'أجل' : 'Yes'),
        onPressed: () {
          appCubit.get(context).ChangeLocale(null);
          Navigator.pop(context);
        },
      ),
      CupertinoDialogAction(
        child: Text(appCubit.get(context).IsArabic ? 'لا' : 'No'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  Widget HelpDialog(BuildContext context) => CupertinoAlertDialog(
    title: Text(
      appCubit.get(context).IsArabic
          ? ' في حالة عدم ظهور رسالة الوصول إلى الموقع ، يرجى إعطاء إذن للتطبيق للوصول إلى الموقع من الإعدادات'
          : "In case location access message didn't appear, please give to the app permission to have location access from settings",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    actions: [
      CupertinoDialogAction(
        child: Text(appCubit.get(context).IsArabic ? 'حسنا' : 'Okay'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
 class formate  {
int sura;
List<int> verss;
formate(this.sura,this.verss);




 }

