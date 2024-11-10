import 'package:denomination/data/model/calculation_item.dart';

abstract class CalculationItemRepository {
  Future<void> addItem(CalculationItem calculationItem);
  List<CalculationItem> getItems();
  Future<void> updateItem(CalculationItem calculationItem, int index);
  Future<void> deleteAtItem(int index);
}
