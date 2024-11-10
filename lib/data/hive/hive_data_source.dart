import 'package:denomination/data/model/calculation_item.dart';
import 'package:hive/hive.dart';

class HiveDataSource {
  final Box<CalculationItem> _box;
  HiveDataSource({required Box<CalculationItem> box}) : _box = box;
  //Add item
  Future<void> addItem(CalculationItem calculationItem) async =>
      await _box.add(calculationItem);
  //Get List of Item
  List<CalculationItem> getItems() => _box.values.toList();

  //Update a item
  Future<void> updateItem(CalculationItem calculationItem, int index) async =>
      await _box.putAt(index, calculationItem);
  //Delete a item
  Future<void> deleteAtItem(int index) async => await _box.deleteAt(index);
}
