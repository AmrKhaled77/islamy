import 'package:flutter/material.dart';

import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import 'package:qurann/screens/quran/readingItem.dart';
import 'package:qurann/screens/quran/surahItem.dart';

class ReadingScreen extends StatefulWidget {

  List<verssModel> list;
bool lastSura=false;

  ReadingScreen({this.list,this.lastSura});

  @override

  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {


  double suraOffset;

  @override
  Widget build(BuildContext context) {

    appCubit.get(context).currentSurahName = cacheHelper.getdata(key: 'suraName');
    appCubit.get(context).currentSurahNumber = cacheHelper.getdata(key: 'suraID');
    widget.lastSura?WidgetsBinding.instance.addPostFrameCallback((_) => appCubit.get(context).GoToLastAyaIndex())
        :(){print('');};

    return Scaffold(
      body: Stack(

        alignment: Alignment.center,
        children: [
          Image(
            image: appCubit.get(context).isDark
                ? AssetImage('assets/images/backgroundupperdraw.png')
                : AssetImage('assets/images/light.jpg'),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 25),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: appCubit.get(context).isDark
                    ? Color.fromARGB(255, 16, 15, 54)
                    : Colors.grey[350],
              ),
              child: Column(

                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.095,
                    child: Center(
                        child: Image.asset(
                      'assets/images/basmala.png',
                      fit: BoxFit.fill,
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
                    child: ListView.builder(
                        controller: appCubit.get(context).Scrollcontroller,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              readingItem(
                                  appCubit.get(context).isDark ? Colors.white : Colors.black,
                                  widget.list,
                                  index),

                            ],
                          );
                        },
                        itemCount: widget.list.length),
                  )

                  ),
                  FloatingActionButton(onPressed: (){
                    suraOffset=appCubit.get(context).Scrollcontroller.offset;
                    cacheHelper.saveData(key: 'lastverss', value:suraOffset );}
                    ,child: Icon(Icons.save),


                  ),



                  // FloatingActionButton(onPressed: GoToLastAyaIndex)
                ],
              ),
            ),

          ),
          


        ],
      ),
    );
  }
}
