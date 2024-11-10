import 'package:denomination/data/repository/calculation_item_repository.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final CalculationItemRepository _calculationItemRepository;
  HomeProvider({required CalculationItemRepository calculationItemRepository}) : _calculationItemRepository = calculationItemRepository; 
}
