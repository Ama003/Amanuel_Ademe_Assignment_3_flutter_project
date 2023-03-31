class KedameGebya {
  int id;
  String category;
  String image;
  num foodPrice;

  KedameGebya(
      {required this.id,
      required this.category,
      required this.foodPrice,
      required this.image});

  factory KedameGebya.fromJson(Map<String, dynamic> parsedJson) {
    return KedameGebya(
        id: parsedJson["id"],
        category: parsedJson["category"],
        foodPrice: parsedJson["price"],
        image: parsedJson["image"]);
  }

  factory KedameGebya.historyfromJson(Map<String, dynamic> parsedJson) {
    return KedameGebya(
        id: parsedJson["id"],
        category: parsedJson["category"],
        foodPrice: parsedJson["foodPrice"],
        image: parsedJson["image"]);
  }

  toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['category'] = category;
    json['foodPrice'] = foodPrice;
    json['image'] = image;
    return json;
  }

  static List kedameGebyaList(List kedameGebya) {
    List kedameGebyas = [];
    for (var i = 0; i < kedameGebya.length; i++) {
      kedameGebyas.add(KedameGebya.fromJson(kedameGebya[i]));
    }
    return kedameGebyas;
  }

  static List historyList(List kedameGebya) {
    List kedameGebyas = [];
    for (var i = 0; i < kedameGebya.length; i++) {
      kedameGebyas.add(KedameGebya.historyfromJson(kedameGebya[i]));
    }

    return kedameGebyas;
  }
}
