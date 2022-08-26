import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:qurann/screens/quran/Sora.dart';
import 'package:qurann/screens/quran/SurahAndJuz2Item.dart';
import 'package:qurann/screens/quran/readingScreen.dart';
import 'package:qurann/screens/quran/readingScreenNoBasmala.dart';
import 'package:qurann/screens/quran/Juz2.dart';
import '../../MainCubit/AppCubit/AppCubitStates.dart';
import 'package:quran/quran.dart' as quran;

class quranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, AppCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  List<verssModel> list = [];
                  for (int i = 1;
                  i <
                      quran.getVerseCount(
                          appCubit.get(context).currentSurahNumber) +
                          1;
                  i++) {
                    verssModel v = verssModel(
                        quran.getVerse(
                            appCubit.get(context).currentSurahNumber, i),
                        i);
                    list.add(v);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => appCubit
                              .get(context)
                              .currentSurahNumber ==
                              9 ||
                              appCubit.get(context).currentSurahNumber == 1
                              ? readingScreenNoBasmala(
                            list: list,
                            lastSura: true,
                          )
                              : ReadingScreen(list: list, lastSura: true)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent, //color of border
                          //width of border
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: AssetImage(appCubit.get(context).isDark
                                  ? appCubit.get(context).IsArabic
                                  ? 'assets/images/lastread_flipped.png'
                                  : 'assets/images/lastread.png'
                                  : 'assets/images/M-design-light-rotated.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          lastReadWidget(context),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: appCubit.get(context).isDark
                          ? Color.fromARGB(255, 134, 48, 177).withOpacity(0.9)
                          : Color.fromARGB(255, 45, 37, 20).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                        labelColor: appCubit.get(context).isDark
                            ? Color.fromARGB(255, 134, 48, 177).withOpacity(0.9)
                            : Color.fromARGB(255, 45, 37, 20),
                        physics: BouncingScrollPhysics(),
                        unselectedLabelColor: appCubit.get(context).isDark
                            ? Color.fromARGB(255, 23, 21, 81)
                            : Color.fromARGB(255, 251, 228, 189),
                        indicator: BoxDecoration(
                            color: appCubit.get(context).isDark
                                ? Color.fromARGB(255, 23, 21, 81)
                                : Color.fromARGB(255, 251, 228, 189),
                            borderRadius: BorderRadius.circular(8)),
                        labelStyle: TextStyle(
                          fontSize: appCubit.get(context).IsArabic ? 23 : 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                        ),
                        tabs: [
                          Tab(
                            text: appCubit.get(context).IsArabic
                                ? 'سورة'
                                : 'Sora',
                          ),
                          Tab(
                            text:
                            appCubit.get(context).IsArabic ? 'جزء' : "Juz'",
                          ),
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SoraList(),
                    Juz2List(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

lastReadWidget(context) {
  if (appCubit.get(context).isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage(
                    'assets/images/bookmark.png',
                  ),
                  color: appCubit.get(context).isDark
                      ? Colors.white
                      : Color.fromARGB(255, 251, 228, 189),
                ),
                Text(
                  '${AppLocalizations.of(context).lastRead}',
                  style: TextStyle(
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 251, 228, 189),
                      fontFamily: 'Amiri',
                      fontWeight: appCubit.get(context).IsArabic
                          ? FontWeight.w800
                          : FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${GetlastRead(context)}'.toUpperCase(),
                    style: TextStyle(
                        color: appCubit.get(context).isDark
                            ? Colors.white
                            : Color.fromARGB(255, 251, 228, 189),
                        fontWeight: FontWeight.w800,
                        fontSize: 18)),
                Text(
                    '${AppLocalizations.of(context).surahno} : ${appCubit.get(context).currentSurahNumber == null ? '1' : appCubit.get(context).currentSurahNumber}',
                    style: TextStyle(
                        color: appCubit.get(context).isDark
                            ? Colors.white
                            : Color.fromARGB(255, 251, 228, 189),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Amiri',
                        fontSize: appCubit.get(context).IsArabic ? 16 : 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
  if (!appCubit.get(context).isDark) {
    return Center(
      child: Column(
        crossAxisAlignment: appCubit.get(context).isDark
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: appCubit.get(context).isDark
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: appCubit.get(context).isDark
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            crossAxisAlignment: appCubit.get(context).isDark
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage(
                  'assets/images/bookmark.png',
                ),
                color: appCubit.get(context).isDark
                    ? Colors.white
                    : Color.fromARGB(255, 251, 228, 189),
              ),
              Text(
                '${AppLocalizations.of(context).lastRead}',
                style: TextStyle(
                    color: appCubit.get(context).isDark
                        ? Colors.white
                        : Color.fromARGB(255, 251, 228, 189),
                    fontFamily: 'Amiri',
                    fontWeight: appCubit.get(context).IsArabic
                        ? FontWeight.w800
                        : FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${GetlastRead(context)}'.toUpperCase(),
                  style: TextStyle(
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 251, 228, 189),
                      fontWeight: FontWeight.w800,
                      fontSize: 18)),
              Text(
                '${AppLocalizations.of(context).surahno} : ${appCubit.get(context).currentSurahNumber == null ? '1' : appCubit.get(context).currentSurahNumber}',
                style: TextStyle(
                    color: appCubit.get(context).isDark
                        ? Colors.white
                        : Color.fromARGB(255, 251, 228, 189),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Amiri',
                    fontSize: appCubit.get(context).IsArabic ? 16 : 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String GetlastRead(context) {
  if (appCubit.get(context).currentSurahName == null) {
    return 'الفاتحة';
  } else {
    return appCubit.get(context).currentSurahName == 'اللهب'
        ? 'المسد'
        : appCubit.get(context).currentSurahName;
  }
}
