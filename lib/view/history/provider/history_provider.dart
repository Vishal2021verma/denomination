import 'dart:developer';

import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/data/repository/calculation_item_repository.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  final CalculationItemRepository _calculationItemRepository;
  HistoryProvider(
      {required CalculationItemRepository calculationItemRepository})
      : _calculationItemRepository = calculationItemRepository;

  List<CalculationItem> _calculationItems = [];
  List<CalculationItem> get calculationItems => _calculationItems;

  void getItems() {
    try {
      _calculationItems = _calculationItemRepository.getItems();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void deleteAtItem(int index) {
    try {
      _calculationItemRepository.deleteAtItem(index);
      _calculationItems = _calculationItemRepository.getItems();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
