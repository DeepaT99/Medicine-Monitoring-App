import 'package:flutter/material.dart';
import 'package:linear_calender/linear_calender.dart';

import '../../models/medicine_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stay on track with your health ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                LinearCalendar(
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Colors.white,
                  monthVisibility: false,
                  selectedBorderColor: Theme.of(context).colorScheme.primary,
                  onChanged: (DateTime value) {
                    debugPrint(
                        "*****************$value***************************");
                  },
                  height: 80,
                  itemWidth: 55,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Your Medications',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Flexible(child: ListItems(),)
          ],
        ),
      ),
    );
  }
}

