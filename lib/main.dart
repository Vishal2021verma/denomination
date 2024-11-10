import 'package:denomination/data/hive/hive_data_source.dart';
import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/data/repository/calculation_item_repository_impl.dart';
import 'package:denomination/view/history/provider/history_provider.dart';
import 'package:denomination/view/home/home_view.dart';
import 'package:denomination/view/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CalculationItemAdapter());
  Hive.registerAdapter(CalculationAdapter());
  await Hive.openBox<CalculationItem>("myBox");
  final hiveDataSource = HiveDataSource(box: Hive.box('myBox'));
  final calulationItemRepository =
      CalculationItemRepositoryImpl(hiveDataSource: hiveDataSource);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HistoryProvider(calculationItemRepository: calulationItemRepository)),
      ChangeNotifierProvider(create: (context) => HomeProvider(calculationItemRepository: calulationItemRepository)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Denomination',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
