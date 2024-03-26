import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/widgets/request_status_preview_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

showStatusBottomSheet(
  BuildContext context, {
  required List<PickupRequestModel> models,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return RequestStatusCombinedWidget(models: models);
    },
  );
}

class RequestStatusCombinedWidget extends ConsumerWidget {
  final List<PickupRequestModel> models;

  const RequestStatusCombinedWidget({super.key, required this.models});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (models.length == 1) {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TitleMedium(
                text: DateFormat('d MMMM h:mm a')
                    .format(models.first.requestDateTime.toLocal()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RequestStatusPreviewWidget(model: models.first),
            ),
          ],
        ),
      );
    } else {
      final selectedModelNotifier = ValueNotifier(models[0]);
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder<PickupRequestModel?>(
                valueListenable: selectedModelNotifier,
                builder: (context, selectedModel, _) {
                  return Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedModel?.id,
                          onChanged: (selectedId) {
                            final newModel = models.firstWhere(
                              (model) => model.id == selectedId,
                            );
                            selectedModelNotifier.value = newModel;
                          },
                          items: models.map((model) {
                            return DropdownMenuItem<String>(
                              value: model.id,
                              child: Text(DateFormat('d MMMM h:mm a')
                                  .format(model.requestDateTime.toLocal())),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: selectedModelNotifier,
                builder: (BuildContext context,  value, Widget? child) {
                  return RequestStatusPreviewWidget(model: value);
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
