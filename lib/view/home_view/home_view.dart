import 'package:denomination/utils/image_resource.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[sliverAppBar()];
        },
        body: const Text("Denomination"),
      ),
    );
  }

  Widget sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 160.0,
      toolbarHeight: 80,
      floating: false,
      pinned: true,
      actions: [
        PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) {},
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
          // title: const Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //       height: 25,
          //     ),
          //     Text("Total Amount",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 14,
          //         )),
          //     SizedBox(
          //       height: 3,
          //     ),
          //     Text("₹ 91,29,09,32,000",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 16,
          //         )),
          //     SizedBox(
          //       height: 2,
          //     ),
          //     Text(
          //         "One Hundred Twenty Nine Core Nine Lakh Thirty Two Thousand Only/-",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 12,
          //         )),
          //   ],
          // ),
          title: const Text("Denomination",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              )),
          background: Image.asset(
            color: const Color.fromARGB(71, 0, 0, 0),
            colorBlendMode: BlendMode.multiply,
            ImageResource.currencyBanner,
            fit: BoxFit.cover,
          )),
    );
  }
}
