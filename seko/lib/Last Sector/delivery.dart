import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[600],
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center elements vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Status',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              StatusItem(
                icon: Icons.inventory_2, // Box icon
                label: 'Pickup',
              ),
              SizedBox(height: 20),
              Icon(Icons.arrow_downward, size: 30, color: Colors.black),
              SizedBox(height: 20),
              StatusItem(
                icon: Icons.local_shipping, // Truck icon
                label: 'Delivery',
              ),
              SizedBox(height: 20),
              Icon(Icons.arrow_downward, size: 30, color: Colors.black),
              SizedBox(height: 20),
              StatusItem(
                icon: Icons.location_on, // Location icon
                label: 'Drop',
              ),
              Spacer(),
              Text(
                'Order Id: 12845235481',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const StatusItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 50, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
