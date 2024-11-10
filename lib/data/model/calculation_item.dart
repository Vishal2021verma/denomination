import 'package:hive/hive.dart';

part 'calculation_item.g.dart';

@HiveType(typeId: 0)
class CalculationItem extends HiveObject {
  @HiveField(0)
  String? type;

  @HiveField(1)
  String? date;

  @HiveField(2)
  String? remark;

  @HiveField(3)
  String? totalAmount;

  @HiveField(4)
  List<Calculation>? calculation;

  CalculationItem({
    this.type,
    this.date,
    this.remark,
    this.totalAmount,
    this.calculation,
  });

  

 
}

@HiveType(typeId: 1)
class Calculation extends HiveObject {
  @HiveField(0)
  String? multiplier;

  @HiveField(1)
  String? multiplicand;

  @HiveField(2)
  String? product;

  Calculation({
    this.multiplier,
    this.multiplicand,
    this.product,
  });

 
}
