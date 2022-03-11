import 'package:flutter/material.dart';
import 'package:qurann/cache_helper/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../HomeScreen.dart';
class boardingModel {
  final String image, title, body;

  boardingModel({this.body, this.image, this.title});
}

class OnBording extends StatefulWidget {
  @override
  _OnBordingState createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  @override
  bool isLast = false;

  Widget build(BuildContext context) {
    var pageController = PageController();
    List<boardingModel> boarding = [
      boardingModel(
          image: 'assets/images/icon.png',
          title: "القرآن",
          body: "استمتع بجميع سور القرآن الكريم كاملة"),
      boardingModel(
          image: 'assets/images/iconm.png',
          title: "مواعيد الصلاة",
          body: "تحديد مواعيد الصلاة في مدينتك"),
      boardingModel(
          image: 'assets/images/icons.png',
          title: "القبلة",
          body: "قم بتحديد القبلة و اقم صلاتك في اي مكان"),
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 21, 81),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:Color.fromARGB(255, 23, 21, 81),
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "تخطي",
                  style:
                      TextStyle(
                          fontSize: 20,
                          fontFamily: 'Amiri',
                          color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index) =>
                    BuildBordingItem(boarding[index]),
                physics: PageScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                      expansionFactor: 4.0,
                      activeDotColor: Colors.white),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    isLast
                        ? submit()
                        : pageController.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.ease);
                  },
                  child: Icon(Icons.arrow_forward_ios,color: Color.fromARGB(
                      255, 23, 21, 81),),
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBordingItem(boardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Text(
            model.title,
            style: TextStyle(
                fontFamily: 'Amiri',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontFamily: 'Amiri',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      );

  void submit() {
    cacheHelper.saveData(key: "OnBoarding", value: true).then((value) => {
          if (value)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false)
        });
  }
}
