import 'package:denomination/data/hive/hive_data_source.dart';
import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/data/repository/calculation_item_repository.dart';

class CalculationItemRepositoryImpl extends CalculationItemRepository {
  final HiveDataSource _hiveDataSource;
  CalculationItemRepositoryImpl({required HiveDataSource hiveDataSource})
      : _hiveDataSource = hiveDataSource;
  @override
  Future<void> addItem(CalculationItem calculationItem) async {
    await _hiveDataSource.addItem(calculationItem);
  }

  @override
  List<CalculationItem> getItems() => _hiveDataSource.getItems();

  @override
  Future<void> updateItem(CalculationItem calculationItem, int index) async =>
      await _hiveDataSource.updateItem(calculationItem, index);

  @override
  Future<void> deleteAtItem(int index) async =>
      await _hiveDataSource.deleteAtItem(index);
}
