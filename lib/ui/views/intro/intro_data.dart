class IntroData {
  final String image;
  final String tittle;
  final String description;

  IntroData({
    required this.image,
    required this.tittle,
    required this.description,
  });
}

final List<IntroData> introItem = [
  IntroData(
      image: "assets/images/img_pv_1.png",
      tittle: "Skybase Getx",
      description: "Code base for mobile platform using Getx, Dio, etc."),
  IntroData(
      image: "assets/images/img_pv_2.png",
      tittle: "Skybase Getx",
      description: "Lets create beautiful apps with us."),
  IntroData(
      image: "assets/images/img_pv_3.png",
      tittle: "Skybase Getx",
      description: "Created By Varcant"),
];
