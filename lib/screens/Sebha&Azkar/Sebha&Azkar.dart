import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';
import 'package:qurann/screens/Sebha&Azkar/Azkar.dart';
import 'package:qurann/screens/Sebha&Azkar/Sebha.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../MainCubit/AppCubit/AppCubitStates.dart';

class SebhaAzkarScreen extends StatefulWidget {
  @override
  _SebhaAzkarScreenState createState() => _SebhaAzkarScreenState();
}

class _SebhaAzkarScreenState extends State<SebhaAzkarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sebha()));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          appCubit.get(context).isDark
                              ? 'assets/images/M-design-rotated.png'
                              : 'assets/images/M-design-light.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/beads.png'),
                            color: appCubit.get(context).isDark
                                ? Colors.white
                                : Color.fromARGB(255, 251, 228, 189),
                            size: 25,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            AppLocalizations.of(context).sebha,
                            style: TextStyle(
                                color: appCubit.get(context).isDark
                                    ? Colors.white
                                    : Color.fromARGB(255, 251, 228, 189),
                                fontSize: 30,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Azkar()));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          appCubit.get(context).isDark
                              ? 'assets/images/M-design-rotated.png'
                              : 'assets/images/M-design-light.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/azkarhands.png'),
                            color: appCubit.get(context).isDark
                                ? Colors.white
                                : Color.fromARGB(255, 251, 228, 189),
                            size: 28,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            AppLocalizations.of(context).azkar,
                            style: TextStyle(
                                color: appCubit.get(context).isDark
                                    ? Colors.white
                                    : Color.fromARGB(255, 251, 228, 189),
                                fontSize: 30,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
