import 'package:flutter/material.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/models/transaction_model/transaction_model.dart';

class MapTableWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const MapTableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(
            color: Theme.of(context).colorScheme.outline,
            borderRadius: BorderRadius.circular(12)),
        columnWidths: const {
          0: FractionColumnWidth(0.4),
          1: FractionColumnWidth(0.3),
          2: FractionColumnWidth(0.3),
        },
        children: [
          const TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Scrap Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Value',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          for (var entry in data.entries)
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(entry.key)),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Center(child: Text(entry.value['quantity'].toString())),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                            '$kRupeeSymbol${entry.value['amount'].toString()} x ${entry.value['quantity'].toString()}')),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
