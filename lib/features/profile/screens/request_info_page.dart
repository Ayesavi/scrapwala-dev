import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/address_tile.dart';
import 'package:scrapwala_dev/widgets/dotted_line.dart';
import 'package:scrapwala_dev/widgets/table_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class RequestInfoPage extends ConsumerWidget {
  final String requestId;

  const RequestInfoPage({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: TitleMedium(
          text: "#$requestId",
          weight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              child: const Text('Help'),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Column(
        children: [
          AddressTile(
            model: AddressModel(
              address: '123 Main Street',
              landmark: 'Central Park',
              latlng: (lat: 51.5074, lng: 0.1278),
              ownerId: 'user123',
              createdAt: DateTime.now(),
              id: '1',
              category: AddressCategory.friend,
              label: 'Home',
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.check_circle_sharp,
              color: Colors.greenAccent,
            ),
            title: LabelMedium(
                text:
                    'Scrap picked on ${DateFormat('d MMMM h:mm a').format(DateTime.now())}'),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.onInverseSurface,
            child: const Text('Scrap Details'),
          ),
          const Flexible(
              child: MapTableWidget(data: {
            'Scrap 1': 10,
            'Scrap 2': 20,
            'Scrap 3': 30,
          })),
          const SizedBox(
            height: 20,
          ),
          DottedLine(height: MediaQuery.sizeOf(context).width - 32),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleMedium(text: "Total Bill Paid"),
                TitleMedium(text: "$kRupeeSymbol 320")
              ],
            ),
          ),
          DottedLine(height: MediaQuery.sizeOf(context).width - 32),
        ],
      ),
    );
  }
}
