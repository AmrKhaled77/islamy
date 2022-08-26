// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
// import 'package:qurann/cache_helper/cache_helper.dart';
// import 'package:qurann/screens/audio.dart';
// import 'package:qurann/screens/quran/readingScreen.dart';
// import 'package:qurann/screens/quran/readingScreenNoBasmala.dart';
// import 'package:quran/quran.dart' as quran;
// class verssModel{
//   String verss;
//   int versCount;
//   verssModel(this.verss,this.versCount
//       );
// }
//
// Widget surahItem(context,index) {
//   List<verssModel> list=[];
//   int surahnum=index+1;
//   return InkWell(
//     onTap: () {
//
//       for(int i=1;i<quran.getVerseCount(surahnum)+1;i++){
//         String  verss=quran.getVerse(surahnum, i);
//    verssModel v=    verssModel(quran.getVerse(surahnum, i),i );
//    list.add(v);
//       }
//
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) =>
//       surahnum==9||surahnum==1?readingScreenNoBasmala(list: list,lastSura: false,):
//       ReadingScreen(list: list,lastSura: false,)));
//       appCubit.get(context).currentSurahNumber = surahnum;
//       appCubit.get(context).currentSurahName =
//           quran.getSurahNameArabic(surahnum);
//
//       appCubit.get(context).saveDataCache(
//           context, appCubit.get(context).currentSurahName, 'suraName');
//       appCubit
//           .get(context)
//           .saveInt(context, appCubit.get(context).currentSurahNumber, 'suraID');
//
//     },
//
//     child: Container(
//
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.125,
//       child: Row(
//
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//
//                 ImageIcon(
//                   AssetImage('assets/images/star.png'),
//                   color: Theme.of(context).primaryColor,
//                   size: 40,
//                 ),
//
//                 Text(
//                   '${index+1}',
//                   style: TextStyle(
//                       fontFamily: 'Amiri',
//                       fontWeight: FontWeight.w900,
//                       color:Theme.of(context).canvasColor,
//                       fontSize: 12),
//                 ),
//               ],
//             ),
//           ), // surah number border
//           Container(
//
//             width: MediaQuery.of(context).size.width * 0.47,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.04,
//                   child: Text(
//                     appCubit.get(context).IsArabic
//                         ? '${quran.getSurahNameArabic(surahnum)=='اللهب'?'المسد':quran.getSurahNameArabic(surahnum)}'
//                         : '${quran.getSurahName(surahnum).toUpperCase()}',
//                     style: TextStyle(
//                         fontFamily: 'Amiri',
//                         fontSize: appCubit.get(context).IsArabic ? 16 : 18,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).canvasColor),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   '${quran.getPlaceOfRevelation(surahnum).toUpperCase()} ● ${quran.getVerseCount(surahnum)} VERSES',
//                   style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: appCubit.get(context).isDark?Colors.white30:Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child:  InkWell(
//                 onTap: (){
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>MusicApp(index))
//                   );
//                 },
//                 child: Icon(
//                   Icons.play_arrow_sharp
//                   ,color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     ),
//
//   );
// }
// Widget JuzaItem(context,index) {
//   List<verssModel> list=[];
//   int surahnum=index+1;
//   return InkWell(
//     onTap: () {
//
//       for(int i=1;i<quran.getVerseCount(surahnum)+1;i++){
//         String  verss=quran.getVerse(surahnum, i);
//         verssModel v=    verssModel(quran.getVerse(surahnum, i),i );
//         list.add(v);
//       }
//
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) =>
//       surahnum==9||surahnum==1?readingScreenNoBasmala(list: list,lastSura: false,):
//       ReadingScreen(list: list,lastSura: false,)));
//       appCubit.get(context).currentSurahNumber = surahnum;
//       appCubit.get(context).currentSurahName =
//           quran.getSurahNameArabic(surahnum);
//
//       appCubit.get(context).saveDataCache(
//           context, appCubit.get(context).currentSurahName, 'suraName');
//       appCubit
//           .get(context)
//           .saveInt(context, appCubit.get(context).currentSurahNumber, 'suraID');
//
//     },
//
//     child: Container(
//
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.125,
//       child: Row(
//
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 ImageIcon(
//                   AssetImage('assets/images/star.png'),
//                   color: Theme.of(context).primaryColor,
//                   size: 40,
//                 ),
//                 Text(
//                   '${index+1}',
//                   style: TextStyle(
//                       fontFamily: 'Amiri',
//                       fontWeight: FontWeight.w900,
//                       color:Theme.of(context).canvasColor,
//                       fontSize: 12),
//                 ),
//               ],
//             ),
//           ), // surah number border
//           Container(
//
//             width: MediaQuery.of(context).size.width * 0.47,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.04,
//                   child: Text(
//                   'الجزء ${juza[index]}',
//
//                     style: TextStyle(
//                         fontFamily: 'Amiri',
//                         fontSize: appCubit.get(context).IsArabic ? 16 : 18,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).canvasColor),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 3,
//                 ),
//
//
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: Text(
//                 'الجزء ${juza[index]}',
//                 style: TextStyle(
//                     fontFamily: 'Amiri',
//                     fontSize: appCubit.get(context).IsArabic ? 13 : 20,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor),
//                 textAlign: appCubit.get(context).IsArabic
//                     ? TextAlign.left
//                     : TextAlign.right,
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     ),
//
//   );
// }
//
// List juza=[' الاول',
//   ' الثاني ',
//   'الثالث ',
//   'الرابع  ',
//    'الخامس ',
//    'السادس',
//   'السابع ',
//   'الثامن ',
//    'التاسع ',
//   'العاشر ',
//   'الحادي عشر ',
//    'الاثن عشر ',
//    'الثالث عشر',
//   'الرابع عشر ',
//    'الخامس عشر ',
//   'السادس عشر ',
//    'السابع عشر ',
//    'الثامن عشر ',
//    'التاسع عشر ',
//   'العشرون',
//   'الواحد و اعلشرون ',
//    'الثاني و العشرون ',
//    'الثالث و العشرون ',
//    'الرابع و العشرون ',
//    'الخامس و العشرون ',
//    'السادس و العشرون ',
//    'السابع و العسرون ',
//    'الثامن و العشرون ',
//    'التاسع و العشرون ',
//   'الثلاين'
// ];