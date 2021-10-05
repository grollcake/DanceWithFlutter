import 'package:flutter/material.dart';
import 'package:onboarding_intro/model/onboarding_data.dart';
import 'package:onboarding_intro/screens/home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                style: TextButton.styleFrom(
                  // padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: PageView.builder(
                itemCount: onboardingDatas.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  Text title = Text(
                    onboardingDatas[index].title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  );
                  Image image = Image.asset(onboardingDatas[index].image, fit: BoxFit.cover);
                  Text subTitle = Text(
                    onboardingDatas[index].subTitle,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (onboardingDatas[index].imageFirst) ...[image, SizedBox(height: 40)],
                        title,
                        SizedBox(height: 20),
                        subTitle,
                        if (!onboardingDatas[index].imageFirst) ...[SizedBox(height: 40), image],
                      ],
                    ),
                  );
                },
              ),
            ),
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingDatas.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: _pageIndex == index ? 12 * 3 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _pageIndex == index ? Colors.orange[300] : Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
