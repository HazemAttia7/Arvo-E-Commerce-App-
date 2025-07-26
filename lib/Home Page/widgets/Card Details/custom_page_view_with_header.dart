import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/animated_text_underline.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/custom_bold_clickable_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/details_section.dart';
import 'package:flutter/material.dart';

class CustomPageViewWithHeader extends StatefulWidget {
  const CustomPageViewWithHeader({
    super.key,
    required this.description,
    required this.shippingInfo,
  });
  final String description, shippingInfo;
  @override
  State<CustomPageViewWithHeader> createState() =>
      _CustomPageViewWithHeaderState();
}

class _CustomPageViewWithHeaderState extends State<CustomPageViewWithHeader> {
  int index = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomBoldClickableText(
                    text: 'Description',
                    onTap: () {
                      setState(() {
                        index = 0;
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                  CustomBoldClickableText(
                    text: 'Shipping info',
                    onTap: () {
                      setState(() {
                        index = 1;
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                  CustomBoldClickableText(
                    text: 'Payment options',
                    onTap: () {
                      setState(() {
                        index = 2;
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AnimatedTextUnderline(index: index),
            ],
          ),
          const SizedBox(height: 35),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                DetailsSection(
                  text: widget.description,
                  midSectionTitle: "Material & care",
                  midSectionText:
                      """All products are made with carefully selected materials. Please handle with care for longer product life.
- Protect from direct light, heat and rain. If it become wet, dry it immediately with a soft cloth
- Store in the provided flannel bag or box
- Clean with a soft, dry cloth""",
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shippingInfo,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 165, 50, 50),
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2,
                        height: 1.5,
                      ),
                    ),
                    const DetailsSection(
                      text:
                          "Please note: Pre-order, Made to Order, and DIY items have their own estimated ship dates and will be dispatched via Premium Express once they become available.",
                      midSectionTitle: "Return policy",
                      midSectionText:
                          "Returns may be made by mail or in store. The return window for online purchases is 30 days (10 days in the case of beauty items) from the date of delivery. You may return products by mail using the complimentary prepaid return label included with your order, and following the return instructions provided in your digital invoice.",
                    ),
                  ],
                ),
                const DetailsSection(
                  text:
                      "We accepts the following forms of payment for online purchases:",
                  spaceBetweenTitleAndMidSection: 0,
                  midSectionText:
                      "PayPal may not be used to purchase Made to Order Décor or DIY items.\n\nThe full transaction value will be charged to your credit card after we have verified your card details, received credit authorisation, confirmed availability and prepared your order for shipping. For Made To Order, DIY, personalised and selected Décor products, payment will be taken at the time the order is placed.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
