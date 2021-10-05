class OnboardingData {
  final String title;
  final String subTitle;
  final String image;
  final bool imageFirst;

  OnboardingData({required this.title, required this.subTitle, required this.image, required this.imageFirst});
}

List<OnboardingData> onboardingDatas = [
  OnboardingData(
    title: 'Farm Driving',
    subTitle: 'There are all kinds of equipment to build your farm better harvest',
    image: 'assets/images/step-one.png',
    imageFirst: true,
  ),
  OnboardingData(
    title: 'Plant Growing',
    subTitle: 'Be part of the agriculture and gives your team the  power you need to do your best',
    image: 'assets/images/step-two.png',
    imageFirst: false,
  ),
  OnboardingData(
    title: 'Fast Harvesting',
    subTitle: 'Your will be proud to be part of agriculture and it’s harvest',
    image: 'assets/images/step-three.png',
    imageFirst: true,
  ),
];
