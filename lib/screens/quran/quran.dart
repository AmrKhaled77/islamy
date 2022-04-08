
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:qurann/screens/quran/readingScreen.dart';
import 'package:qurann/screens/quran/readingScreenNoBasmala.dart';
import 'package:qurann/screens/quran/surahItem.dart';
import '../../MainCubit/AppCubit/AppCubitStates.dart';
import 'package:quran/quran.dart' as quran;

class quranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<appCubit, AppCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(

          children: [

            InkWell(
              onTap: () {

                List<verssModel> list=[];
                for(int i=1;i<quran.getVerseCount(appCubit.get(context).currentSurahNumber)+1;i++){
                  String  verss=quran.getVerse(appCubit.get(context).currentSurahNumber, i);
                  verssModel v=    verssModel(quran.getVerse(appCubit.get(context).currentSurahNumber, i),i );
                  list.add(v);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            appCubit.get(context).currentSurahNumber == 9 ||
                                    appCubit.get(context).currentSurahNumber ==
                                        1
                                ? readingScreenNoBasmala(list:list,lastSura: true,)
                                : ReadingScreen(list: list,lastSura: true)));
              },

              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12,),

                child: Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent, //color of border
                        //width of border
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Stack(fit: StackFit.expand, children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage(appCubit.get(context).IsArabic
                            ? 'assets/images/lastread_flipped.png'
                            : 'assets/images/lastread.png'),
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.001,
                          ),
                          Row(
                            children: [
                              ImageIcon(
                                AssetImage(
                                  'assets/images/bookmark.png',
                                ),
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  '${AppLocalizations.of(context).lastRead}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          'Amiri',
                                      fontWeight: appCubit.get(context).IsArabic
                                          ? FontWeight.w800
                                          : FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: appCubit.get(context).IsArabic
                                ? MediaQuery.of(context).size.height * 0.01
                                : MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${GetlastRead(context)}'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18)),
                                Text(
                                    '${AppLocalizations.of(context).surahno} : ${appCubit.get(context).currentSurahNumber
                                    ==null?'1':appCubit.get(context).currentSurahNumber
                                    }',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            appCubit.get(context).IsArabic
                                                ? 'Amiri'
                                                : '',
                                        fontSize: appCubit.get(context).IsArabic
                                            ? 16
                                            : 15)),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),buildQuranScreen(context,appCubit.get(context).juzaPattern),

          ],
        );
      },
    );
  }

  Widget buildQuranScreen(context,juzaPattern) {
if(juzaPattern==true){
  return Expanded(
    child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return JuzaItem(context,index);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 1,
              color: Color.fromARGB(255, 87, 89, 116),
            ),
          );
        },
        itemCount: quran.totalJuzCount),
  );
}else{
  return Expanded(
    child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return surahItem(context,index);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 1,
              color: Color.fromARGB(255, 87, 89, 116),
            ),
          );
        },
        itemCount: quran.totalSurahCount),
  );
}


    }
  }

  String GetlastRead(context) {
    if (appCubit.get(context).currentSurahName == null) {
      return 'الفاتحة';
    } else {
      return appCubit.get(context).currentSurahName=='اللهب'?'المسد':
      appCubit.get(context).currentSurahName;
    }
  }

