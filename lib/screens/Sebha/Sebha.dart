import 'package:flutter/material.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SebhaScreen extends StatefulWidget {
  @override
  _SebhaScreenState createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {

  @override
  Widget build(BuildContext context) {
    var cubit=appCubit.get(context);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Transform.rotate(
                  angle: appCubit.get(context).currentAngle,
                  child: Image.asset(
                    'assets/images/sebha.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.075,
                child: Center(
                  child: InkWell(
                    onTap: (){
                      if(cubit.duration==0){
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.tspehWord = 'الحمد لله ';
                          cubit.duration++;

                        });
                      }else if(cubit.duration==1){
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.tspehWord = ' الله اكبر';
                          cubit.duration++;
                        });
                      }else if(cubit.duration==2){
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.tspehWord = 'لا اله الا الله';
                          cubit.duration++;
                        });
                      }else if(cubit.duration==3){
                        setState(() {
                          cubit.taspeh = 0.0;
                          cubit.tspehWord = 'سبحان الله';
                          cubit.duration = 0;
                        });
                      }
                    },
                    child: Text(
                      appCubit.get(context).tspehWord.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: appCubit.get(context).IsArabic ? 30 : 20,
                          fontFamily: 'Amiri',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.040,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.60,
            height: MediaQuery.of(context).size.height * 0.075,
            child: Slider(
              min: 0.0,
              max: 33.0,
              value: appCubit.get(context).taspeh,
              activeColor: Colors.purple,
              onChanged: null,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.055,
            child: ElevatedButton(
                onPressed: () {
                 reset();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).primaryColor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '${appCubit.get(context).taspeh.toInt()}',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 2,
                      fontSize: 15,
                      fontFamily: 'Amiri'),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.075,
            child: ElevatedButton(
                onPressed: () {
                  onTasbeh();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).primaryColor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '${AppLocalizations.of(context).click}',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 5,
                      fontSize: appCubit.get(context).IsArabic?25:20 ,
                      fontFamily: 'Amiri'),
                )),
          ),
        ],
      ),
    );
  }

  void onTasbeh() {
    setState(() {
      appCubit.get(context).taspeh++;
      appCubit.get(context).currentAngle += 33;
      if (appCubit.get(context).taspeh == 33 &&
          appCubit.get(context).duration == 0) {
        setState(() {
          appCubit.get(context).taspeh = 0.0;
          appCubit.get(context).tspehWord = 'الحمد لله';
          appCubit.get(context).duration++;
        });
      }
      if (appCubit.get(context).taspeh == 33 &&
          appCubit.get(context).duration == 1) {
        setState(() {
          appCubit.get(context).taspeh = 0.0;
          appCubit.get(context).tspehWord = 'لا إله إلا الله';
          appCubit.get(context).duration++;
        });
      }
      if (appCubit.get(context).taspeh == 33 &&
          appCubit.get(context).duration == 2) {
        setState(() {
          appCubit.get(context).taspeh = 0.0;
          appCubit.get(context).tspehWord = 'الله أكبر';
          appCubit.get(context).duration++;
        });
      }
      if (appCubit.get(context).taspeh == 33 &&
          appCubit.get(context).duration == 3) {
        setState(() {
          appCubit.get(context).taspeh = 0.0;
          appCubit.get(context).tspehWord = 'سبحان الله';
          appCubit.get(context).duration = 0;
        });
      }
    });
  }

  void reset() {
    setState(() {
      appCubit.get(context).taspeh = 0;
      appCubit.get(context).tspehWord = '${AppLocalizations.of(context).subhanallah}'.toUpperCase();
      appCubit.get(context).currentAngle = 0;
      appCubit.get(context).duration = 0;
    });
  }
}
