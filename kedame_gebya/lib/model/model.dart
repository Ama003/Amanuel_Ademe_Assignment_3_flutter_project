class KedameGebya {
  String category;
  String image;
  num foodPrice;

  KedameGebya(
      {required this.category, required this.foodPrice, required this.image});

  factory KedameGebya.fromJson(Map<String, dynamic> parsedJson) {
    return KedameGebya(
        category: parsedJson["category"],
        foodPrice: parsedJson["price"],
        image: parsedJson["image"]);
  }

  static List kedameGebyaList(List kedameGebya) {
    List kedameGebyas = [];
    for (var i = 0; i < kedameGebya.length; i++) {
      kedameGebyas.add(KedameGebya.fromJson(kedameGebya[i]));
    }
    return kedameGebyas;
  }
}
