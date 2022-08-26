import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:quran/quran.dart' as quran;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import 'package:qurann/screens/quran/SurahAndJuz2Item.dart';
import 'package:qurann/screens/quran/readingItem.dart';

class audioPlayerScreen extends StatefulWidget {
  int index;
  int kare2Num;

  audioPlayerScreen(this.index, this.kare2Num);

  @override
  _audioPlayerScreenState createState() => _audioPlayerScreenState();
}

class _audioPlayerScreenState extends State<audioPlayerScreen> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;
  bool hasInternet = false;
  AudioPlayer _player;
  AudioCache cache;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying;
  String url;
  double suraOffset;
  bool isReading = false;

  play() async {
    if (widget.index >= 9 && widget.index < 99) {
      int result = await _audioPlayer
          .play('${URL[widget.kare2Num]}0${widget.index + 1}.mp3');
    } else if (widget.index >= 99) {
      int result = await _audioPlayer
          .play('${URL[widget.kare2Num]}${widget.index + 1}.mp3');
    }
    int result = await _audioPlayer
        .play('${URL[widget.kare2Num]}00${widget.index + 1}.mp3');

    if (result == 1) {
      setState(() {
        playing = true;
      });
      print('Success');
    }
  }

  pause() async {
    await _audioPlayer.pause();
    playing = false;
  }

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 220.0,
      child: Slider.adaptive(
          activeColor: appCubit.get(context).isDark
              ? Color.fromARGB(255, 22, 31, 87)
              : Color.fromARGB(255, 251, 228, 189),
          inactiveColor: Colors.grey,
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _audioPlayer.seek(newPos);
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    _audioPlayer.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
      _audioPlayer.completionHandler = () {
        setState(() {
          playBtn = playBtn = Icons.play_arrow;
        });
      };
    };

    _audioPlayer.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  checkConnection(hasInternet, context) async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    final color = hasInternet ? Colors.green : Colors.red;
    final error = hasInternet
        ? AppLocalizations.of(context).internetnoerror
        : AppLocalizations.of(context).interneterror;
    showSimpleNotification(
      Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: color),
        child: Center(
          child: Text(
            '$error'.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: appCubit.get(context).IsArabic ? 15 : 12,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void getSoraverss() {
    appCubit.get(context).AudioList.clear();
    for (int i = 1; i < quran.getVerseCount(widget.index + 1) + 1; i++) {
      verssModel v = verssModel(quran.getVerse(widget.index + 1, i), i);
      appCubit.get(context).AudioList.add(v);
    }

    appCubit.get(context).currentSurahNumber = widget.index + 1;
    appCubit.get(context).currentSurahName =
        quran.getSurahNameArabic(widget.index + 1);

    appCubit.get(context).saveDataCache(
        context, appCubit.get(context).currentSurahName, 'suraName');
    appCubit
        .get(context)
        .saveInt(context, appCubit.get(context).currentSurahNumber, 'suraID');
    setState(() {
      isReading = !isReading;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: appCubit.get(context).isDark
              ? Colors.white
              : Color.fromARGB(255, 45, 37, 20),
        ),
      ),
      backgroundColor: appCubit.get(context).isDark
          ? Color.fromARGB(255, 22, 31, 87)
          : Color.fromARGB(255, 251, 228, 189),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          isReading
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
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
                        Besmallah(),
                        Expanded(
                            flex: 2,
                            child: buildReadingScreen(
                                context, appCubit.get(context).AudioList)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.009,
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Text(SuraName(),
                        style: TextStyle(
                            color: appCubit.get(context).isDark
                                ? Colors.white
                                : Color.fromARGB(255, 45, 37, 20),
                            fontSize: 35,
                            fontFamily: 'Amiri',
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: appCubit.get(context).isDark
                            ? Color.fromARGB(255, 134, 48, 177)
                            : Color.fromARGB(255, 150, 121, 89),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: Image.asset(
                                'assets/images/${photos[widget.kare2Num]}',
                                scale: 1.5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appCubit.get(context).isDark
                      ? Color.fromARGB(255, 134, 48, 177)
                      : Color.fromARGB(255, 150, 121, 89),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "${position.inHours.remainder(60)}:${position.inMinutes.remainder(60)}:${position.inSeconds.remainder(60)}",
                              style: TextStyle(
                                  color: appCubit.get(context).isDark
                                      ? Colors.white
                                      : Color.fromARGB(255, 45, 37, 20),
                                  fontSize: 16,
                                  fontFamily: 'Amiri',
                                  fontWeight: FontWeight.bold)),
                          slider(),
                          Text(
                              "${musicLength.inHours.remainder(60)}:${musicLength.inMinutes.remainder(60)}:${musicLength.inSeconds.remainder(60)}",
                              style: TextStyle(
                                  color: appCubit.get(context).isDark
                                      ? Colors.white
                                      : Color.fromARGB(255, 45, 37, 20),
                                  fontSize: 16,
                                  fontFamily: 'Amiri',
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 60.0,
                          color: appCubit.get(context).isDark
                              ? Color.fromARGB(255, 22, 31, 87)
                              : Color.fromARGB(255, 251, 228, 189),
                          onPressed: () {
                            if (!playing) {
                              checkConnection(hasInternet, context);
                              play();
                              setState(() {
                                playBtn = Icons.pause;
                                playing = true;
                              });
                            } else {
                              pause();
                              setState(() {
                                playBtn = Icons.play_arrow;
                                playing = false;
                              });
                            }
                          },
                          icon: Icon(
                            playBtn,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        IconButton(
                          iconSize: 50.0,
                          color: appCubit.get(context).isDark
                              ? Color.fromARGB(255, 22, 31, 87)
                              : Color.fromARGB(255, 251, 228, 189),
                          onPressed: () {
                            getSoraverss();
                          },
                          icon: Icon(
                            Icons.layers,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String SuraName() {
    String suratext;
    if (appCubit.get(context).IsArabic) {
      suratext = quran.getSurahNameArabic(widget.index + 1) == 'اللهب'
          ? 'المسد'
          : quran.getSurahNameArabic(widget.index + 1);
      return suratext;
    } else {
      suratext = quran.getSurahName(widget.index + 1).toUpperCase();
      return suratext;
    }
  }

  @override
  void dispose() {
    // appCubit.get(context).isReading=true;
    _audioPlayer.stop();
    super.dispose();
  }

  List photos = [
    'سعود الشريم.jpg',
    'سعد الغامدي.jpg',
    'عبدالباسط عبدالصمد.jpg',
    'عبدالرحمن السديس.jpg',
    'محمد صديق المنشاوي.jpg',
    'محمود الرفاعي.jpg',
    'محمد الطبلاوي.jpg',
    'ماهر المعيقلي.jpg',
    'محمد جبريل.jpg',
    'محمود خليل الحصري.jpg',
    'مشاري العفاسي.jpg',
    'ياسر الدوسري.jpg',
  ];

  List URL = [
    'https://server7.mp3quran.net/shur/',
    'https://server7.mp3quran.net/s_gmd/',
    'https://server7.mp3quran.net/basit/Almusshaf-Al-Mojawwad/',
    'https://server11.mp3quran.net/sds/',
    'https://server10.mp3quran.net/minsh/',
    'https://server11.mp3quran.net/mrifai/',
    'https://server12.mp3quran.net/tblawi/',
    'https://server12.mp3quran.net/maher/',
    'https://server8.mp3quran.net/jbrl/',
    'https://server13.mp3quran.net/husr/',
    'https://server8.mp3quran.net/afs/',
    'https://server11.mp3quran.net/yasser/',
  ];

  Besmallah() {
    if (widget.index == 0 || widget.index == 8) {
      return Container();
    } else
      return Container(
        height: MediaQuery.of(context).size.height * 0.095,
        child: Center(
            child: Image.asset(
          'assets/images/basmala.png',
          fit: BoxFit.fill,
          color: appCubit.get(context).isDark ? Colors.white : Colors.black,
        )),
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
