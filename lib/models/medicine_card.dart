import 'package:flutter/material.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:medicine_tracker/models/medicine.dart';
import 'package:medicine_tracker/pages/details/medicine_details.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.medicine,
  });
  final Medicine medicine;

  Hero makeIcon() {
    if (medicine.medicineType == 'Bottle') {
      return Hero(
          tag: medicine.medicineName! + medicine.medicineType!,
          child: Image.asset(
            'lib/assets/icons/medicine.png',
            height: 40,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    } else if (medicine.medicineType == 'Pill') {
      return Hero(
          tag: medicine.medicineName! + medicine.medicineType!,
          child: Image.asset(
            'lib/assets/icons/pill.png',
            height: 44,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    } else if (medicine.medicineType == 'Syringe') {
      return Hero(
          tag: medicine.medicineName! + medicine.medicineType!,
          child: Image.asset(
            'lib/assets/icons/syringe.png',
            height: 42,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    }
    //no medicine type icon selection
    return Hero(
      tag: medicine.medicineName! + medicine.medicineType!,
      child: Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        //goto details activity

        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: MedicineDetails(medicine: medicine),
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerLeft, child: makeIcon()),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 6, bottom: 2),
                        child: Hero(
                          tag: medicine.medicineName!,
                          child: Text(
                            medicine.medicineName!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2),
                            Text(
                              "${medicine!.dosage} mg/ml",
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(height: 2),
                            Text(
                              medicine.interval == 1
                                  ? "Every ${medicine.interval} hour"
                                  : "${medicine!.interval == 24 ? "One time per day" : "${(24 / medicine!.interval!).floor()} times a day"}",
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //checkbox


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
