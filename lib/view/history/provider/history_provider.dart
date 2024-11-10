import 'package:denomination/data/repository/calculation_item_repository.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
   final CalculationItemRepository _calculationItemRepository;
  HistoryProvider({required CalculationItemRepository calculationItemRepository}) : _calculationItemRepository = calculationItemRepository; 
}
