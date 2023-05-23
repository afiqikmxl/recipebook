class CategoriesDrinkModel {
  List<Drinks>? drinks;

  CategoriesDrinkModel({this.drinks});

  CategoriesDrinkModel.fromJson(Map<String, dynamic> json) {
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (drinks != null) {
      data['drinks'] = drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drinks {
  String? strThumb;
  String? strCategory;

  Drinks({this.strCategory, this.strThumb});

  Drinks.fromJson(Map<String, dynamic> json) {
    strCategory = json['strCategory'];
    strThumb = json['strThumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strCategory'] = strCategory;
    data['strThumb'] = strThumb;
    return data;
  }
}
