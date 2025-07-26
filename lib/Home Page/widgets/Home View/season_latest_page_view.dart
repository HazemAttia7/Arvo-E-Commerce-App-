
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/backgrounded_text_column.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/custom_arrow_button.dart';
import 'package:flutter/material.dart';

class SeasonLatestPageView extends StatefulWidget {
  const SeasonLatestPageView({super.key});

  @override
  State<SeasonLatestPageView> createState() => _SeasonLatestPageViewState();
}

class _SeasonLatestPageViewState extends State<SeasonLatestPageView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView(
            controller: pageController,
            children: [
              Image.asset(
                "assets/images/fragrances landing image.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/images/groceries landing image.jpg",
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          right: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IgnorePointer(child: BackgroundedTextColumn()),
              const SizedBox(height: 30),
              Row(
                spacing: 2,
                children: [
                  CustomArrowButton(
                    icon: Icons.arrow_back,
                    onTap: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  CustomArrowButton(
                    icon: Icons.arrow_forward,
                    onTap: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
