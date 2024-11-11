import 'dart:developer';

import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/utils/format_indian_number_system.dart';
import 'package:denomination/view/history/provider/history_provider.dart';
import 'package:denomination/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:indian_currency_to_word/indian_currency_to_word.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final converter = AmountToWords();

  share(CalculationItem calculationItem) async {
    DateTime dateTime = DateTime.parse(calculationItem.date ?? '');
    String date = DateFormat('dd-MMM-yyyy').format(dateTime);
    String time = DateFormat('hh:mm a').format(dateTime);
    int totalCount = 0;
    for (var denomination in calculationItem.calculation!) {
      totalCount = totalCount + int.parse(denomination.multiplicand ?? '0');
    }
    String text = '''
${calculationItem.type}
Denomination
$date $time
${calculationItem.remark}
---------------------------------------
Rupee x Counts = Total
₹ 2,000  x ${calculationItem.calculation![0].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![0].product ?? "0").toInt())}
₹ 500    x ${calculationItem.calculation![1].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![1].product ?? "0").toInt())}
₹ 200    x ${calculationItem.calculation![2].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![2].product ?? "0").toInt())}
₹ 100    x ${calculationItem.calculation![3].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![3].product ?? "0").toInt())}
₹ 50     x ${calculationItem.calculation![4].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![4].product ?? "0").toInt())}
₹ 20     x ${calculationItem.calculation![5].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![5].product ?? "0").toInt())}
₹ 10     x ${calculationItem.calculation![6].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![6].product ?? "0").toInt())}
₹ 5      x ${calculationItem.calculation![7].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![7].product ?? "0").toInt())}
₹ 2      x ${calculationItem.calculation![8].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![8].product ?? "0").toInt())}
₹ 1      x ${calculationItem.calculation![9].multiplicand} = ₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.calculation![9].product ?? "0").toInt())}
---------------------------------------
Total Counts:
$totalCount
Grand Total Amount:
₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.totalAmount ?? "0").toInt())}
${converter.convertAmountToWords(double.parse(calculationItem.totalAmount!), ignoreDecimal: true)} Only/-
''';

    log(text);

    //To share
    ShareResult shareResult = await Share.share(
      text,
      subject: "Denomination Calculation",
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) => Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (value) {
                          //Implement Delete Feature
                          provider.deleteAtItem(index);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                      SlidableAction(
                        onPressed: (value) {
                          //Implement Edit Feature
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView(
                                        calculationItem:
                                            provider.calculationItems[index],
                                        index: index,
                                      )),
                              (route) => false);
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                      ),
                      SlidableAction(
                        onPressed: (value) {
                          //Implement Share feature
                          share(provider.calculationItems[index]);
                        },
                        backgroundColor: const Color(0xFF21CA46),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                      ),
                    ],
                  ),
                  child: listItem(provider.calculationItems[index])),
              itemCount: provider.calculationItems.length);
        },
      ),
    );
  }

  Widget listItem(CalculationItem calculationItem) {
    return Card(
      color: const Color.fromARGB(255, 23, 28, 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(calculationItem.type ?? ""),

            Row(
              children: [
                //Amount
                Expanded(
                    child: Text(
                  "₹ ${FormatIndianNumberSystem.formatIndianNumber(double.parse(calculationItem.totalAmount ?? "0").toInt())}",
                  
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: calculationItem.type == "General"
                          ? Colors.blue
                          : calculationItem.type == "Income"
                              ? Colors.green
                              : Colors.red,
                      fontSize: 24),
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //Date
                    Text(
                      (() {
                        try {
                          DateTime dateTime =
                              DateTime.parse(calculationItem.date ?? '');
                          String formattedDate =
                              DateFormat('MMM dd, yyyy').format(dateTime);
                          return formattedDate;
                        } catch (e) {
                          return "";
                        }
                      }()),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    //Time
                    Text(
                      (() {
                        try {
                          DateTime dateTime =
                              DateTime.parse(calculationItem.date ?? '');
                          String formattedDate =
                              DateFormat('hh:mm a').format(dateTime);
                          return formattedDate;
                        } catch (e) {
                          return "";
                        }
                      }()),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            //Remark
            Text(
              calculationItem.remark ?? "",
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
