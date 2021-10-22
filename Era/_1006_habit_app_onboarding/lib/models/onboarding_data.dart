class OnboardingContent {
  final String title;
  final String image;

  OnboardingContent({required this.title, required this.image});
}

final onboardingContents = [
  OnboardingContent(
    title: 'Welcome to\n Monumental habits',
    image: 'assets/images/onboarding_image_1.png',
  ),
  OnboardingContent(
    title: 'Create new habits easily',
    image: 'assets/images/onboarding_image_2.png',
  ),
  OnboardingContent(
    title: 'Keep track of your progress',
    image: 'assets/images/onboarding_image_3.png',
  ),
  OnboardingContent(
    title: 'Join a supportive community',
    image: 'assets/images/onboarding_image_4.png',
  ),
];
