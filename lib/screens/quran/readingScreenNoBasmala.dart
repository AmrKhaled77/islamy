import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import 'package:qurann/screens/quran/readingItem.dart';
import 'package:qurann/screens/quran/SurahAndJuz2Item.dart';

class readingScreenNoBasmala extends StatefulWidget {
  List<verssModel> list;
  bool lastSura = false;
  int suraNum;

  readingScreenNoBasmala({this.list, this.lastSura,this.suraNum});

  @override
  State<readingScreenNoBasmala> createState() => _readingScreenNoBasmalaState();
}

class _readingScreenNoBasmalaState extends State<readingScreenNoBasmala> {
  double suraOffset;

  @override
  Widget build(BuildContext context) {
    widget.lastSura
        ? WidgetsBinding.instance.addPostFrameCallback(
            (_) => appCubit.get(context).GoToLastAyaIndex(appCubit.get(context).currentSurahNumber ))
        : () {};

    appCubit.get(context).currentSurahName =
        cacheHelper.getdata(key: 'suraName');
    appCubit.get(context).currentSurahNumber =
        cacheHelper.getdata(key: 'suraID');
    return Scaffold(
      backgroundColor: appCubit.get(context).isDark
          ? Color.fromARGB(255, 22, 31, 87)
          : Color.fromARGB(255, 251, 228, 189),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appCubit.get(context).isDark
                  ? Color.fromARGB(255, 16, 15, 54)
                  : Color.fromARGB(255, 150, 121, 89).withOpacity(0.75),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Expanded(child: buildReadingScreen(context, widget.list)),
                InkWell(
                  onTap: (){
                    suraOffset = appCubit.get(context).Scrollcontroller.offset;
                    cacheHelper.saveData(key: 'lastverss', value: suraOffset);
                    cacheHelper.saveData(key: 'lastsuraCheck', value:widget.suraNum
                    );
                    appCubit.get(context).ShowToast(context, 'تم الحفظ');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.11,
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: Icon(
                      Icons.save,
                      size: 30,
                      color:appCubit.get(context).isDark
                          ? Color.fromARGB(255, 22, 31, 87)
                          :  Color.fromARGB(255, 45, 37, 20) ,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 251, 228, 189),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.009,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildReadingScreen(context, List<verssModel> list) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, bottom: 7),
      child: ListView.builder(
          controller: appCubit.get(context).Scrollcontroller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                readingItem(
                    appCubit.get(context).isDark
                        ? Colors.white
                        : Color.fromARGB(255, 45, 37, 20),
                    list,
                    index),
              ],
            );
          },
          itemCount: list.length),
    );
  }
}
