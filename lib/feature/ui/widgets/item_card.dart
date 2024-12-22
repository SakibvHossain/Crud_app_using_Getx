import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {


  const ItemCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10), // Ensures splash effect respects corners
        color: Colors.transparent, // Avoid overlaying color
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Constrain ripple to rounded corners
          onTap: () {
            print('Bob tapped');
          },
          child: ListTile(
            // Splash effect
            splashColor: Colors.blue.withOpacity(0.2),

            // Leading avatar icon
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20, // Ensures consistent size
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            // Title
            title: const Text(
              'Argus',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            // Subtitle
            subtitle: const Text(
              'You still working...',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            // Trailing delete button
            trailing: IconButton(
              onPressed: () {
                print('Delete button tapped');
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              tooltip: 'Delete',
            ),
          ),
        ),
      ),
    );
  }
}
