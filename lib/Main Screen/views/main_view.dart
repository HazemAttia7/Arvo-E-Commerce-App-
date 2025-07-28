import 'package:e_commerce_app/Cart%20Sheet/widgets/custom_cart_draggable_scrollable_sheet.dart';
import 'package:e_commerce_app/Fav%20Sheet/widgets/custom_fav_draggable_scrollable_sheet.dart';
import 'package:e_commerce_app/Home%20Page/views/home_view.dart';
import 'package:e_commerce_app/Main%20Screen/widgets/bottom_nav_bar_item.dart';
import 'package:e_commerce_app/Main%20Screen/widgets/custom_shopping_cart_icon_button.dart';
import 'package:e_commerce_app/Search%20Page/views/search_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static String route = "/Main";

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _pages = const [HomeView(), SearchView()];
  final PageController _controller = PageController();
  int _prevAppBarSelectedIndex = -1;
  int _appBarSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 30,
                      spreadRadius: -10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomNavBarItem(
                      image: "assets/images/home icon.png",
                      onTap: () {
                        setState(() {
                          _controller.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                        _appBarSelectedIndex = 0;
                      },
                      isSelected: _appBarSelectedIndex == 0,
                    ),
                    BottomNavBarItem(
                      image: "assets/images/search icon.png",
                      onTap: () {
                        setState(() {
                          _controller.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                        _appBarSelectedIndex = 1;
                      },
                      isSelected: _appBarSelectedIndex == 1,
                    ),
                    BottomNavBarItem(
                      image: "assets/images/fav icon.png",
                      onTap: () async {
                        _prevAppBarSelectedIndex = _controller.page!.toInt();
                        setState(() {
                          _appBarSelectedIndex = 2;
                        });
                        await Future.delayed(const Duration(milliseconds: 200));
                        showModalBottomSheet(
                          barrierColor:
                              (_controller.page == 1)
                                  // ignore: deprecated_member_use
                                  ? Colors.black.withOpacity(0.15)
                                  : Colors.transparent,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder:
                              (context) =>
                                  const CustomFavDraggablleScrollableSheet(),
                        ).then((result) {
                          setState(() {
                            _appBarSelectedIndex = _prevAppBarSelectedIndex;
                          });
                        });
                      },
                      isSelected: _appBarSelectedIndex == 2,
                    ),
                    CustomShoppingCartIconButton(
                      onTap: () async {
                        _prevAppBarSelectedIndex = _controller.page!.toInt();
                        setState(() {
                          _appBarSelectedIndex = 3;
                        });
                        await Future.delayed(const Duration(milliseconds: 200));
                        showModalBottomSheet(
                          barrierColor:
                              (_controller.page == 1)
                                  // ignore: deprecated_member_use
                                  ? Colors.black.withOpacity(0.15)
                                  : Colors.transparent,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder:
                              (context) =>
                                  const CustomCartDraggablleScrollableSheet(),
                        ).then((result) {
                          setState(() {
                            _appBarSelectedIndex = _prevAppBarSelectedIndex;
                          });
                        });
                      },
                      isSelected: _appBarSelectedIndex == 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
