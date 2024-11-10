import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/utils/format_indian_number_system.dart';
import 'package:denomination/utils/image_resource.dart';
import 'package:denomination/view/history/history_view.dart';
import 'package:denomination/view/home/component/save_pop_wridget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:indian_currency_to_word/indian_currency_to_word.dart';

class HomeView extends StatefulWidget {
  final CalculationItem? calculationItem;
  final int index;
  const HomeView({super.key, this.calculationItem, this.index = 0});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Map<int, TextEditingController> controllers = {};
  final List<int> denominations = [2000, 500, 200, 100, 50, 20, 10, 5, 2, 1];
  double totalAmount = 0;
  bool isEdit = false;

  final converter = AmountToWords();

  @override
  void initState() {
    super.initState();
    for (int denomination in denominations) {
      controllers[denomination] = TextEditingController();
    }

    //For Edditing the field
    if (widget.calculationItem != null) {
      isEdit = true;
      totalAmount = double.parse(widget.calculationItem!.totalAmount ?? "0");

      for (var calculation in widget.calculationItem!.calculation!) {
        controllers[int.parse(calculation.multiplier ?? '1')]!.text =
            calculation.multiplicand == "0"
                ? ""
                : calculation.multiplicand ?? "";
      }
    }
  }

  //Calculate the total amount
  void calculateTotal() {
    double sum = 0;
    for (int denomination in denominations) {
      double count = double.tryParse(controllers[denomination]!.text) ?? 0;
      sum += denomination * count;
    }
    setState(() {
      totalAmount = sum;
    });
  }

  //Clear all the text field values
  void clearAll() {
    for (int denomination in denominations) {
      controllers[denomination]!.clear();
    }
    totalAmount = 0;
    isEdit = false;
    FocusManager.instance.primaryFocus!.unfocus();
    setState(() {});
  }

  CalculationItem makeModel() {
    List<Calculation> calulations = [];
    for (int denomination in denominations) {
      double count = double.tryParse(controllers[denomination]!.text) ?? 0;
      calulations.add(Calculation(
          multiplier: denomination.toString(),
          multiplicand: count.toInt().toString(),
          product: "${denomination * count}"));
    }
    return CalculationItem(
        remark: isEdit ? widget.calculationItem!.remark ?? "" : "",
        type: isEdit ? widget.calculationItem!.type ?? "" : "General",
        totalAmount: totalAmount.toString(),
        date: DateTime.now().toString(),
        calculation: calulations);
  }

  @override
  void dispose() {
    for (int denomination in denominations) {
      controllers[denomination]!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[sliverAppBar()];
          },
          body: ListView.separated(
            padding: const EdgeInsets.only(left: 14, right: 14, top: 18),
            itemCount: denominations.length,
            itemBuilder: (context, index) {
              int denomination = denominations[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      '₹ $denomination',
                      textScaler: TextScaler.noScaling,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("x",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 14),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: controllers[denomination],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8)
                          ],
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 6),
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              hintText:
                                  denominations[index] == 2000 ? "Try 6" : "",
                              suffixIcon:
                                  controllers[denomination]!.text.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () {
                                            controllers[denomination]!.clear();
                                            calculateTotal();
                                            setState(() {});
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 18,
                                          ))
                                      : const SizedBox.shrink(),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: .5,
                                      style: BorderStyle.solid)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: .5,
                                      style: BorderStyle.solid)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: .5,
                                      style: BorderStyle.solid)),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 46, 52, 57)),
                          onChanged: (value) => calculateTotal(),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "=",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 20,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' ₹ ${FormatIndianNumberSystem.formatIndianNumber(denomination * (int.tryParse(controllers[denomination]!.text) ?? 0))}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 14,
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Visibility(
          visible: totalAmount != 0,
          child: SpeedDial(
            backgroundColor: const Color.fromRGBO(12, 84, 145, 1),
            icon: Icons.flash_on_rounded,
            iconTheme: const IconThemeData(color: Colors.white),
            children: [
              SpeedDialChild(
                  onTap: clearAll,
                  label: "Clear",
                  child: const Icon(Icons.restart_alt_rounded)),
              SpeedDialChild(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => SavePopWridget(
                              action: clearAll,
                              isEdit: isEdit,
                              index: widget.index,
                              calculationItem: makeModel(),
                            ));
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  label: "Save",
                  child: const Icon(Icons.save_alt_rounded)),
            ],
          ),
        ));
  }

  //Sliver appbar
  Widget sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 160.0,
      toolbarHeight: 70,
      floating: false,
      pinned: true,
      actions: [
        PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == "open_history") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryView()));
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "open_history",
                  child: ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Colors.blue,
                    ),
                    title: Text('History'),
                  ),
                ),
              ];
            })
      ],
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(
            left: 12,
            bottom: 6,
            right: 18,
          ),
          centerTitle: false,
          title: totalAmount == 0
              ? const Text("Denomination",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text("Total Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                        "₹ ${FormatIndianNumberSystem.formatIndianNumber(totalAmount.toInt())}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                        "${converter.convertAmountToWords(totalAmount, ignoreDecimal: true)} Only/-",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),
                  ],
                ),
          background: Image.asset(
            color: const Color.fromARGB(71, 0, 0, 0),
            colorBlendMode: BlendMode.multiply,
            ImageResource.currencyBanner,
            fit: BoxFit.cover,
          )),
    );
  }
}

// 
