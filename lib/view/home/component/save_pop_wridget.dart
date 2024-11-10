import 'package:denomination/data/model/calculation_item.dart';
import 'package:denomination/view/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SavePopWridget extends StatefulWidget {
  final action;
  final CalculationItem calculationItem;
  final int index;
  final bool isEdit;
  const SavePopWridget(
      {super.key,
      required this.calculationItem,
      this.index = 0,
      this.isEdit = false,
      this.action});

  @override
  State<SavePopWridget> createState() => _SavePopWridgetState();
}

class _SavePopWridgetState extends State<SavePopWridget> {
  List<String> categories = ["General", "Income", "Expanse"];
  String selectedCategory = "General";
  TextEditingController remarkController = TextEditingController();

//Add Item
  addItem() async {
    CalculationItem calculationItem = CalculationItem(
        totalAmount: widget.calculationItem.totalAmount,
        date: widget.calculationItem.date,
        remark: remarkController.text.trim(),
        calculation: widget.calculationItem.calculation,
        type: selectedCategory);
    await Provider.of<HomeProvider>(context, listen: false)
        .addItem(calculationItem);
  }

  //Update Item
  updateItem() async {
    CalculationItem calculationItem = CalculationItem(
        totalAmount: widget.calculationItem.totalAmount,
        date: widget.calculationItem.date,
        remark: remarkController.text.trim(),
        calculation: widget.calculationItem.calculation,
        type: selectedCategory);
    await Provider.of<HomeProvider>(context, listen: false)
        .updateAtItem(calculationItem, widget.index);
  }

  @override
  void dispose() {
    remarkController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      selectedCategory = widget.calculationItem.type ?? '';
      remarkController.text = widget.calculationItem.remark ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(21, 22, 25, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      insetPadding: const EdgeInsets.all(8),
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Close Button
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 36,
                    color: Colors.red,
                  )),
            ),

            //Categories
            DropdownButtonFormField(
              iconEnabledColor: Colors.blue,
              items: categories.map((String category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (newValue) {
                setState(() => selectedCategory = newValue.toString());
              },
              value: selectedCategory,
              decoration: const InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: .5,
                          style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  filled: true,
                  fillColor: Color.fromARGB(255, 46, 52, 57)
                  //  hintText:,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Remark
            TextField(
              minLines: 2,
              maxLines: 4,
              controller: remarkController,
              textInputAction: TextInputAction.done,
              inputFormatters: [LengthLimitingTextInputFormatter(300)],
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  hintText: "Fill your remark(if any)",
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: .5,
                          style: BorderStyle.solid)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 46, 52, 57)),
            ),
            const SizedBox(
              height: 26,
            ),
            //Save Button
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 26, 31, 1),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    //Confirmation Alert Dilog
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor:
                                  const Color.fromRGBO(24, 32, 39, 1),
                              title: const Text(
                                "Confirmation",
                                style: TextStyle(color: Colors.blue),
                              ),
                              content: const Text(
                                "Are you sure?",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "NO",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      widget.isEdit ? updateItem() : addItem();
                                      widget.action();
                                    

                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    ))
                              ],
                            ));
                  },
                  borderRadius: BorderRadius.circular(1000),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
