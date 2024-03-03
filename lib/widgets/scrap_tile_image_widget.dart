import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';

class ScrapTileImageWidget extends ConsumerWidget {
  const ScrapTileImageWidget(
      {super.key, required this.callback, this.imageUrl});

  final String? imageUrl;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        if (!imageUrl.isNotNull)
          const Icon(Icons.abc)
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  // repeat: ImageRepeat.repeatX,
                ),
              ),
            ),
          ),
        Positioned(
            bottom: 5,
            right: 5,
            child:
                ElevatedButton(onPressed: callback, child: const Text("ADD")))
      ],
    );
  }
}
