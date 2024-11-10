import 'dart:developer';

import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/data/repository/calculation_item_repository.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final CalculationItemRepository _calculationItemRepository;
  HomeProvider({required CalculationItemRepository calculationItemRepository})
      : _calculationItemRepository = calculationItemRepository;

  //Add Item
  Future<void> addItem(CalculationItem calculationItem) async {
    try {
      await _calculationItemRepository.addItem(calculationItem);
    } catch (e) {
      log(e.toString());
    }
  }
}
