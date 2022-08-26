import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qurann/pdf.dart';
import 'package:qurann/screens/audio.dart';
import 'package:qurann/screens/quran/readingScreen.dart';
import 'package:qurann/screens/quran/readingScreenNoBasmala.dart';
import 'package:quran/quran.dart' as quran;

import 'PagePreview.dart';

class verssModel {
  String verss;
  int versCount;

  verssModel(this.verss, this.versCount);
}

Widget surahItem(context, index) {
  List choice = [
    AppLocalizations.of(context).pages,
    AppLocalizations.of(context).freescroll,
  ];
  List kora2 = [
    AppLocalizations.of(context).saudalshuraim,
    AppLocalizations.of(context).saadalghamdi,
    AppLocalizations.of(context).abdulbasit,
    AppLocalizations.of(context).abdulrahmanalsudais,
    AppLocalizations.of(context).alminshawi,
    AppLocalizations.of(context).alrifai,
    AppLocalizations.of(context).altablawi,
    AppLocalizations.of(context).maher,
    AppLocalizations.of(context).jibril,
    AppLocalizations.of(context).alhosari,
    AppLocalizations.of(context).alafasy,
    AppLocalizations.of(context).aldossary,
  ];
  List<verssModel> list = [];
  int surahnum = index + 1;
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.125,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/images/star.png'),
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
              Text(
                '${index + 1}',
                style: TextStyle(
                    fontFamily: 'Amiri',
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).canvasColor,
                    fontSize: 12),
              ),
            ],
          ),
        ), // surah number border
        InkWell(
          onTap: () {
            choosePageOrScroll(context, choice, list, surahnum, index);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Text(
                    appCubit.get(context).IsArabic
                        ? '${quran.getSurahNameArabic(surahnum) == 'اللهب' ? 'المسد' : quran.getSurahNameArabic(surahnum)}'
                        : '${quran.getSurahName(surahnum).toUpperCase()}',
                    style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: appCubit.get(context).IsArabic ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).canvasColor),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${quran.getPlaceOfRevelation(surahnum).toUpperCase()} ● ${quran.getVerseCount(surahnum)} VERSES',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: appCubit.get(context).isDark
                          ? Colors.white30
                          : Color.fromARGB(255, 45, 37, 20)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        InkWell(
          onTap: () async {
            showKora2(context, index, kora2);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.125,
            child: Icon(
              Icons.play_circle_outline_sharp,
              size: 40,
              color: appCubit.get(context).isDark
                  ? Color.fromARGB(255, 134, 48, 177)
                  : Color.fromARGB(255, 150, 121, 89),
            ),
          ),
        ),
      ],
    ),
  );
}

void openPDF(BuildContext context, file, int index) =>
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(
          file: file,
          index: index,
        ),
      ),
    );

choosePageOrScroll(context, choice, list, surahnum, indexSura) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            color: appCubit.get(context).isDark
                ? Color.fromARGB(255, 22, 31, 87)
                : Color.fromARGB(255, 251, 228, 189),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(29),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    if (index == 0) {
                      appCubit.get(context).currentSurahNumber = indexSura + 1;
                      appCubit.get(context).currentSurahName =
                          quran.getSurahNameArabic(indexSura + 1);

                      appCubit.get(context).saveDataCache(context,
                          appCubit.get(context).currentSurahName, 'suraName');
                      appCubit.get(context).saveInt(context,
                          appCubit.get(context).currentSurahNumber, 'suraID');
                      final path = 'assets/images/moshaf.pdf';
                      final file = await PDFApi.loadAsset(path);
                      openPDF(context, file, indexSura);
                    } else {
                      for (int i = 1;
                          i < quran.getVerseCount(surahnum) + 1;
                          i++) {
                        verssModel v =
                            verssModel(quran.getVerse(surahnum, i), i);
                        list.add(v);
                      }
                      appCubit.get(context).currentSurahNumber = surahnum;
                      appCubit.get(context).currentSurahName =
                          quran.getSurahNameArabic(surahnum);

                      appCubit.get(context).saveDataCache(context,
                          appCubit.get(context).currentSurahName, 'suraName');
                      appCubit.get(context).saveInt(context,
                          appCubit.get(context).currentSurahNumber, 'suraID');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => surahnum == 9 || surahnum == 1
                              ? readingScreenNoBasmala(
                                  list: list,
                                  lastSura: false,
                              suraNum: surahnum,
                                )
                              : ReadingScreen(

                                  list: list,
                                  lastSura: false,
                            suraNum: surahnum,
                                ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.125,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/star.png'),
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Text(
                            choice[index],
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize:
                                    appCubit.get(context).IsArabic ? 18 : 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 1,
                    color: Theme.of(context).canvasColor,
                  ),
                );
              },
              itemCount: 2),
        );
      });
}

Widget JuzaItem(context, index) {
  return InkWell(
    onTap: () {
      showJuz(context, index);
    },
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('assets/images/star.png'),
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    Text(
                      '${index + 1}',
                      style: TextStyle(
                          fontFamily: 'Amiri',
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).canvasColor,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Text(
                  appCubit.get(context).IsArabic
                      ? '${juz2A[index]}'
                      : '${juz2E[index]}',
                  style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: appCubit.get(context).IsArabic ? 18 : 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).canvasColor),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Icon(
                  Icons.list_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

showKora2(context, index1, kora2) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            color: appCubit.get(context).isDark
                ? Color.fromARGB(255, 22, 31, 87)
                : Color.fromARGB(255, 251, 228, 189),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(29),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.45,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                audioPlayerScreen(index1, index)));
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.125,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/star.png'),
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 171,
                          child: Text(
                            kora2[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textDirection: appCubit.get(context).IsArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize:
                                    appCubit.get(context).IsArabic ? 18 : 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 1,
                    color: Theme.of(context).canvasColor,
                  ),
                );
              },
              itemCount: 12),
        );
      });
}

List juz2E = [
  "First Juz'",
  "Second Juz'",
  "Third Juz'",
  "Fourth Juz'",
  "Fifth Juz'",
  "Sixth Juz'",
  "Seventh Juz'",
  "Eighth Juz'",
  "Ninth Juz'",
  "Tenth Juz'",
  "Eleventh Juz'",
  "Twelfth Juz'",
  "Thirteenth Juz'",
  "Fourteenth Juz'",
  "Fifteenth Juz'",
  "Sixteenth Juz'",
  "Seventeenth Juz'",
  "Eighteenth Juz'",
  "Nineteenth Juz'",
  "Twentieth Juz'",
  "Twenty-First Juz'",
  "Twenty-Second Juz'",
  "Twenty-Third Juz'",
  "Twenty-Fourth Juz'",
  "Twenty-Fifth Juz'",
  "Twenty-Sixth Juz'",
  "Twenty-Seventh Juz'",
  "Twenty-Eighth Juz'",
  "Twenty-Ninth Juz'",
  "Thirtieth Juz'",
];

List juz2A = [
  'الجزء الأول',
  'الجزء الثاني',
  'الجزء الثالث',
  'الجزء الرابع',
  'الجزء الخامس',
  'الجزء السادس',
  'الجزء السابع',
  'الجزء الثامن',
  'الجزء التاسع',
  'الجزء العاشر',
  'الجزء الحادي عشر',
  'الجزء الثانى عشر',
  'الجزء الثالث عشر',
  'الجزء الرابع عشر',
  'الجزء الخامس عشر',
  'الجزء السادس عشر',
  'الجزء السابع عشر',
  'الجزء الثامن عشر',
  'الجزء التاسع عشر',
  'الجزء العشرون',
  'الجزء الحادي و العشرون',
  'الجزء الثاني و العشرون',
  'الجزء الثالث و العشرون',
  'الجزء الرابع و العشرون',
  'الجزء الخامس و العشرون',
  'الجزء السادس و العشرون',
  'الجزء السابع و العشرون',
  'الجزء الثامن و العشرون',
  'الجزء التاسع و العشرون',
  'الجزء الثلاثون'
];
List<String> LIST = [];

showJuz(context, index1) {
  LIST.clear();
  for (int i = 0; i < lll[index1].length; i++) {
    String suraName = appCubit.get(context).IsArabic
        ? quran.getSurahNameArabic(lll[index1][i][0])
        : quran.getSurahName(lll[index1][i][0]);
    LIST.add(suraName);
  }
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (builder) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: appCubit.get(context).isDark
                ? Color.fromARGB(255, 22, 31, 87)
                : Color.fromARGB(255, 251, 228, 189),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(29),
            ),
          ),
          height: index1<20? MediaQuery.of(context).size.height * 0.35
              :MediaQuery.of(context).size.height * 0.5,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                List<verssModel> list = [];
                return InkWell(
                  onTap: () {
                    for (int i = lll[index1][index][1];
                        i <= lll[index1][index][2];
                        i++) {
                      String vers = quran.getVerse(lll[index1][index][0], i);
                      verssModel v = verssModel(
                          quran.getVerse(lll[index1][index][0], i), i);
                      list.add(v);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => lll[index1][index][0] == 9 ||
                                    lll[index1][index][0] == 1
                                ? readingScreenNoBasmala(
                                    list: list,
                                    lastSura: false,
                                  )
                                : ReadingScreen(
                                    list: list,
                                    lastSura: false,
                                  )));
                    appCubit.get(context).currentSurahNumber =
                        lll[index1][index][0];
                    appCubit.get(context).currentSurahName =
                        quran.getSurahNameArabic(lll[index1][index][0]);

                    appCubit.get(context).saveDataCache(context,
                        appCubit.get(context).currentSurahName, 'suraName');
                    appCubit.get(context).saveInt(context,
                        appCubit.get(context).currentSurahNumber, 'suraID');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.125,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/star.png'),
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Text(
                            LIST[index],
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize:
                                    appCubit.get(context).IsArabic ? 18 : 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          width: 130,
                          child: Text(
                            '${AppLocalizations.of(context).ff} ${lll[index1][index][1]}'
                            ' ${AppLocalizations.of(context).tt} '
                            '${lll[index1][index][2]}',
                            style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize:
                                    appCubit.get(context).IsArabic ? 18 : 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 1,
                    color: Theme.of(context).canvasColor,
                  ),
                );
              },
              itemCount: lll[index1].length),
        );
      });
}

List<List> lll = [
  [
    [1, 1, 7],
    [2, 1, 141]
  ],
  [
    [2, 142, 252]
  ],
  [
    [2, 253, 286],
    [3, 1, 92]
  ],
  [
    [3, 93, 200],
    [4, 1, 23]
  ],
  [
    [4, 24, 147]
  ],
  [
    [4, 148, 176],
    [5, 1, 81]
  ],
  [
    [5, 82, 120],
    [6, 1, 110]
  ],
  [
    [6, 111, 165],
    [7, 1, 87]
  ],
  [
    [7, 88, 206],
    [8, 1, 40]
  ],
  [
    [8, 41, 75],
    [9, 1, 92]
  ],
  [
    [9, 92, 129],
    [10, 1, 109],
    [111, 1, 5]
  ],
  [
    [11, 6, 123],
    [12, 1, 52]
  ],
  [
    [12, 53, 111],
    [13, 1, 43],
    [14, 1, 52]
  ],
  [
    [15, 1, 99],
    [16, 1, 128]
  ],
  [
    [17, 1, 111],
    [18, 1, 74]
  ],
  [
    [18, 75, 110],
    [19, 98],
    [20, 1, 135]
  ],
  [
    [21, 1, 112],
    [22, 1, 78]
  ],
  [
    [23, 1, 118],
    [24, 1, 68],
    [25, 1, 20]
  ],
  [
    [25, 21, 77],
    [26, 1, 227],
    [27, 1, 55]
  ],
  [
    [27, 56, 93],
    [28, 1, 88],
    [29, 1, 45]
  ],
  [
    [29, 46, 69],
    [30, 1, 60],
    [31, 1, 34],
    [32, 1, 30],
    [33, 1, 30]
  ],
  [
    [33, 31, 73],
    [34, 1, 54],
    [35, 1, 45],
    [36, 1, 27]
  ],
  [
    [36, 28, 83],
    [37, 1, 182],
    [38, 1, 88],
    [39, 1, 31]
  ],
  [
    [39, 32, 75],
    [40, 1, 85],
    [41, 1, 46]
  ],
  [
    [41, 47, 54],
    [42, 1, 53],
    [43, 1, 89],
    [44, 1, 59],
    [45, 1, 37]
  ],
  [
    [46, 1, 35],
    [47, 1, 38],
    [48, 1, 29],
    [49, 1, 18],
    [50, 1, 45],
    [51, 1, 30]
  ],
  [
    [51, 31, 60],
    [52, 1, 49],
    [53, 1, 62],
    [54, 1, 55],
    [55, 1, 78],
    [56, 1, 96],
    [57, 1, 29]
  ],
  [
    [58, 1, 22],
    [59, 1, 24],
    [60, 1, 13],
    [61, 1, 14],
    [62, 1, 11],
    [63, 1, 11],
    [64, 1, 18],
    [65, 1, 12],
    [66, 1, 12]
  ],
  [
    [67, 1, 30],
    [68, 1, 52],
    [69, 1, 52],
    [70, 1, 44],
    [71, 1, 28],
    [72, 1, 28],
    [73, 1, 20],
    [74, 1, 56],
    [75, 1, 40],
    [76, 1, 31],
    [77, 1, 50]
  ],
  [
    [78, 1, 40],
    [79, 1, 46],
    [80, 1, 42],
    [81, 1, 29],
    [82, 1, 19],
    [83, 1, 36],
    [84, 1, 25],
    [85, 1, 22],
    [86, 1, 17],
    [87, 1, 19],
    [88, 1, 26],
    [89, 1, 30],
    [90, 1, 20],
    [91, 1, 15],
    [92, 1, 21],
    [93, 1, 11],
    [94, 1, 8],
    [95, 1, 8],
    [96, 1, 19],
    [97, 1, 5],
    [98, 1, 8],
    [99, 1, 8],
    [100, 1, 11],
    [101, 11, 11],
    [102, 1, 8],
    [103, 1, 3],
    [104, 1, 9],
    [105, 1, 5],
    [106, 1, 4],
    [107, 1, 7],
    [108, 1, 3],
    [109, 1, 6],
    [110, 1, 3],
    [111, 1, 5],
    [112, 1, 4],
    [113, 1, 5],
    [114, 1, 6]
  ],
];
