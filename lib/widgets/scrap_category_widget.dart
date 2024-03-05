

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/string_extension.dart';
import 'package:scrapwala_dev/models/scrap_category/scrap_category_model.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key, required this.model});

  final ScrapCategoryModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onInverseSurface,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              model.photoUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        LabelMedium(text: model.name.capitalize)
      ],
    );
  }
}
