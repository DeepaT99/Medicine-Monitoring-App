import 'package:flutter/material.dart';
import 'package:medicine_tracker/assets/constants.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:medicine_tracker/models/medicine.dart';
import 'package:medicine_tracker/pages/details/medicine_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MedicineCard extends StatefulWidget {
  const MedicineCard({
    super.key,
    required this.medicine,

  });
  final Medicine medicine;


  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {


  Hero makeIcon() {
    if (widget.medicine.medicineType == 'Bottle') {
      return Hero(
          tag: widget.medicine.medicineName! + widget.medicine.medicineType!,
          child: Image.asset(
            'lib/assets/icons/medicine.png',
            height: 5.h,
            alignment: Alignment.centerLeft,
            color: const Color(0xFF201E45),
          ));
    } else if (widget.medicine.medicineType == 'Pill') {
      return Hero(
          tag: widget.medicine.medicineName! + widget.medicine.medicineType!,
          child: Image.asset(
            'lib/assets/icons/pill.png',
            height: 5.h,
            alignment: Alignment.centerLeft,
            color: const Color(0xFF201E45),
          ));
    } else if (widget.medicine.medicineType == 'Syringe') {
      return Hero(
          tag: widget.medicine.medicineName! + widget.medicine.medicineType!,
          child: Image.asset(
            'lib/assets/icons/syringe.png',
            height: 5.h,
            alignment: Alignment.centerLeft,
            color: const Color(0xFF201E45),
          ));
    }
    //no medicine type icon selection
    return Hero(
      tag: widget.medicine.medicineName! + widget.medicine.medicineType!,
      child: const Icon(Icons.error),
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
                    child: MedicineDetails(medicine: widget.medicine),
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Container(
          height: 15.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            boxShadow: kElevationToShadow[1],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(1.h),
                    child: Container(
                        alignment: Alignment.centerLeft, child: makeIcon()),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 2.w, top: 1.h, bottom: 0.5.h),
                        child: Hero(
                          tag: widget.medicine.medicineName!,
                          child: SizedBox(
                            width: 50.w,
                            height: 6.h,
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              widget.medicine.medicineName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, bottom: 0.5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.medicine!.dosage} mg/ml",
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              widget.medicine.interval == 1
                                  ? "Every ${widget.medicine.interval} hour"
                                  : widget.medicine!.interval == 24
                                      ? "One time per day"
                                      : "${(24 / widget.medicine!.interval!).floor()} times a day",
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            // SizedBox(height: 0.5.h,),
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
