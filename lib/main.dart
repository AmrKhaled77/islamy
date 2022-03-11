import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import 'package:qurann/screens/HomeScreen.dart';
import 'package:qurann/screens/OnBoarding/OnBoarding.dart';
import 'package:qurann/screens/splach/splach.dart';

import 'MainCubit/AppCubit/AppCubit.dart';
import 'MainCubit/AppCubit/AppCubitStates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await cacheHelper.init();
  String suraName = cacheHelper.getdata(key: 'suraName');
  int suraID = cacheHelper.getdata(key: 'suraID');
  bool onBoarding = cacheHelper.getdata(key: 'OnBoarding');
  bool isDark = cacheHelper.getdata(key: 'isDark');
  bool isarbic = cacheHelper.getdata(key: 'ISARBICK');
  runApp(MyApp(suraName, suraID, isDark, isarbic, onBoarding));
}

class MyApp extends StatelessWidget {
  final String suraName;
  final int suraID;
  final bool isDark;
  final bool isarabic;
  final bool onBoarding;

  MyApp(
      this.suraName, this.suraID, this.isDark, this.isarabic, this.onBoarding);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

        create: (BuildContext context) => appCubit()..c()
          // ..getChaptersData()
          // ..getTaspehWord()
          ..ChangeLocale(isarabic)
        ..changeTheme(isDark),
        child: BlocConsumer<appCubit, AppCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            appCubit.get(context).currentSurahName = suraName;
            appCubit.get(context).currentSurahNumber = suraID;
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);

            return MaterialApp(

              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: appCubit.get(context).IsArabic
                  ? Locale('ar', '')
                  : Locale('en', ''),
              theme: ThemeData(
                primaryColor: Colors.black,
                accentColor: Colors.white,
                canvasColor: Colors.black,
                scaffoldBackgroundColor: Colors.white
              ),
              darkTheme: ThemeData(
                  primaryColor: Color.fromARGB(255, 134, 48, 177),
                  accentColor: Color.fromARGB(255, 22, 31, 87),
                  canvasColor: Colors.white),
              themeMode: appCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
              home: AnimatedSplashScreen(
                duration: 5000,
                splashTransition: SplashTransition.fadeTransition,
                nextScreen: onBoarding!=true? OnBording():HomeScreen(),
                splash: splach(),
                splashIconSize: 2000,
                backgroundColor:appCubit.get(context).isDark?
                Color.fromARGB(255, 23, 21, 81):Colors.white,
              ),
            );
          },
        ));
  }
}
