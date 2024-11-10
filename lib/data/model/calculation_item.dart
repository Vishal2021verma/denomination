class CalculationItem {
  String? type;
  String? date;
  String? reamrk;
  String? totalAmount;
  List<Calculation>? calculation;

  CalculationItem(
      {this.type, this.date, this.reamrk, this.totalAmount, this.calculation});

  CalculationItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
    reamrk = json['reamrk'];
    totalAmount = json['totalAmount'];
    if (json['calculation'] != null) {
      calculation = <Calculation>[];
      json['calculation'].forEach((v) {
        calculation!.add( Calculation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['date'] = date;
    data['reamrk'] = reamrk;
    data['totalAmount'] = totalAmount;
    if (calculation != null) {
      data['calculation'] = calculation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Calculation {
  String? multiplier;
  String? multiplicand;
  String? product;

  Calculation({this.multiplier, this.multiplicand, this.product});

  Calculation.fromJson(Map<String, dynamic> json) {
    multiplier = json['multiplier'];
    multiplicand = json['multiplicand'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['multiplier'] = multiplier;
    data['multiplicand'] = multiplicand;
    data['product'] = product;
    return data;
  }
}
