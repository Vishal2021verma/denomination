import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/utils/format_indian_number_system.dart';
import 'package:denomination/view/history/provider/history_provider.dart';
import 'package:denomination/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:indian_currency_to_word/indian_currency_to_word.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final converter = AmountToWords();
  @override
  void initState() {
    super.initState();
    Provider.of<HistoryProvider>(context, listen: false).getItems();
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
                                  builder: (context) => HomeView(calculationItem: provider.calculationItems[index], index: index,)),
                              (route) => false);
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                      ),
                      SlidableAction(
                        onPressed: (value) {
                          //Implement Share feature
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
