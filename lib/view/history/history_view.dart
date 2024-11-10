import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) => Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (value) {
                      //Implement Delete Feature
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      //Implement Edit Feature
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
              child: listItem()),
          itemCount: 10),
    );
  }

  Widget listItem() {
    return Card(
      color: const Color.fromARGB(255, 23, 28, 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("General"),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "₹ 10000 00",
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Nov 10, 2024",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      "08:22 AM",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Remark",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
