import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lyrics with Chords',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 1.0);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  selectedTileColor: Colors.indigoAccent.shade100,
                  title: Text(
                    "Checkout Our new Added Chords",
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                        ),
                  ),
                  subtitle: Text(
                    "Sing with Us",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: PopUpMen(
                    menuList: const [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.person_alt,
                          ),
                          title: Text("My Profile"),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.heart_fill,
                          ),
                          title: Text("Favourite"),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text("Settings"),
                      ),
                      PopupMenuItem(
                        child: Text("About Us"),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("Log Out"),
                        ),
                      ),
                    ],
                    icon: CircleAvatar(
                      backgroundImage: const AssetImage(
                        'images/music.png',
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Hello you tapped at ${index + 1} "),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 24, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? Colors.indigoAccent
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: GridB(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: showBtmAppBr
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        child: BottomAppBar(
          notchMargin: 8.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.cart,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bell,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOutSine,
        height: showBtmAppBr ? 70 : 0,
      ),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}

class FabExt extends StatelessWidget {
  const FabExt({
    Key? key,
    required this.showFabTitle,
  }) : super(key: key);

  final bool showFabTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.cart),
            SizedBox(width: showFabTitle ? 12.0 : 0),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: showFabTitle ? const Text("Go to cart") : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Bartika Eam Rai",
      "songs": "12",
      "images":
          "https://assets-cdn.kathmandupost.com/uploads/source/news/2018/entertainment/BARTIKA_EAM_RAI_12042018BARTIKA_EM_RAI_12042018_D6A9253-05122018105749.jpg",
    },
    {
      "title": "Sajjan Raj Vaidya",
      "songs": "23",
      "images":
          'https://wownepal.com.np/wp-content/uploads/2022/03/musical-conversation.jpg',
    },
    {
      "title": "Sushant KC",
      "songs": "21",
      "images":
          "https://i0.wp.com/www.nepalitrends.com/wp-content/uploads/2020/10/sushant-kc.jpg?fit=960%2C959&ssl=1",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 310,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
            color: Colors.amberAccent.shade100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  "${gridMap.elementAt(index)['images']}",
                  height: 195,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${gridMap.elementAt(index)['title']}",
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "${gridMap.elementAt(index)['songs']}",
                      style: Theme.of(context).textTheme.subtitle2!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.heart,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
