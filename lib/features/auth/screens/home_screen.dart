import 'package:flutter/material.dart';
import 'package:scrapwala_dev/features/auth/screens/login_screen.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              text: HomeScreenConstants.getStarted,
            )),
      ),
    );
  }
}

class HomeScreenConstants {
  static const getStarted = "Get Started";
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
