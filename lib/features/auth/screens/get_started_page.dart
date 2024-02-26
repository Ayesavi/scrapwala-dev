import 'package:flutter/material.dart';
import 'package:scrapwala_dev/features/auth/screens/login_page.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.deepOrange,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const TitleMedium(
              text: GetStartedPageConstants.getStartedPage,
            )),
      ),
    );
  }
}

class GetStartedPageConstants {
  static const getStartedPage = "Get Started";
}

List<AddressModel> _buildRandomAddressModels() {
  return [
    AddressModel(
      address: '123 Main Street',
      landmark: 'Central Park',
      latlng: (lat: 51.5074, lng: 0.1278),
      ownerId: 'user123',
      createdAt: DateTime.now(),
      id: '1',
      category: AddressCategory.friend,
      label: 'Home',
    ),
    AddressModel(
      address: '456 Elm Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      createdAt: DateTime.now(),
      id: '2',
      category: AddressCategory.office,
      label: 'Work',
    ),
    AddressModel(
      address: '789 Oak Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      createdAt: DateTime.now(),
      id: '3',
      category: AddressCategory.house,
      label: 'Vacation Home',
    ),
  ];
}
