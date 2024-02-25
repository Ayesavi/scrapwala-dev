import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/widgets/address_category_chip.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

void showLocationFormBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const _LocationFormBottomSheetContent();
    },
  );
}

class _LocationFormBottomSheetContent extends ConsumerWidget {
  const _LocationFormBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 10),
                  TitleLarge(
                    text: "Devpuri",
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: LabelMedium(
                  text: "Devpuri Chattisgarh,  4920125, INDIA",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.2),
                    ),
                    child: const Text(
                        'A detailed address will help our delivery partner to reach you accurately.'),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter house number',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.home),
                    ),
                  ),
                  const Divider(),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter apartment/road/area',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.location_city),
                    ),
                  ),
                  const Divider(),
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Directions to reach (max 100 chars)',
                    ),
                    maxLines: 5,
                    maxLength: 100,
                  ),
                  const Divider(),
                  const TitleMedium(text: 'Save As'),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChipWidget(
                        label: 'Home',
                        isSelected: true,
                        icon: Icons.home,
                        onTap: () {},
                      ),
                      const ChipWidget(
                        label: 'Work',
                        isSelected: false,
                        icon: Icons.work,
                      ),
                      const ChipWidget(
                        label: 'Friend & Family',
                        isSelected: false,
                        icon: Icons.person,
                      ),
                      const ChipWidget(
                        label: 'Others',
                        isSelected: false,
                        icon: Icons.category,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppFilledButton(
                    label: 'Save And Proceed',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
