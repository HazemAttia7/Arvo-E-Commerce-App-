import 'package:e_commerce_app/Home%20Page/widgets/Browse%20Products/custom_category_list_item.dart';
import 'package:e_commerce_app/global/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoriesListView extends ConsumerWidget {
  const SubCategoriesListView({super.key, required this.subCategoriesList});
  final List<String> subCategoriesList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelectedSubcategory = ref.watch(selectedSubcategoryProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subCategoriesList.length,
          itemBuilder: (context, index) {
            final String categoryText = subCategoriesList[index];
            return CustomCategoryListItem(
              text: categoryText.replaceAll("-", " "),
              onTap: () {
                ref.read(selectedSubcategoryProvider.notifier).state =
                    categoryText;
              },
              isSelected: categoryText == currentSelectedSubcategory,
            );
          },
        ),
      ),
    );
  }
}
