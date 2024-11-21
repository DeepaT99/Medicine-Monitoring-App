import 'package:flutter/material.dart';
import 'package:medicine_tracker/pages/details/medicine_details.dart';

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {

        return const MedicineCard();
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        //goto details activity
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MedicineDetails()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: kElevationToShadow[1],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'lib/assets/icons/pill.png',
                      height: 75,
                      alignment: Alignment.centerLeft,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Lorem',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'dosage',
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),

                  //time interval data

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      'Every 8 hours',
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
