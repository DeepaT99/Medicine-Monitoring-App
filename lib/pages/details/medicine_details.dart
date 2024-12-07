import 'package:flutter/material.dart';
import 'package:medicine_tracker/assets/constants.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:medicine_tracker/models/medicine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails({this.medicine, super.key});
  final Medicine? medicine;

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryColor,
        size: 28.px),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Medicine Details',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
               color: AppColors.primaryColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [
            MainSection(medicine: widget.medicine),
            ExtendedSection(medicine: widget.medicine),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 6.h),
              child: SizedBox(
                height: 7.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    shape: const StadiumBorder(),
                  ),
                  child: Center(
                    child: Text(
                      'Remove',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                    ),
                  ),
                  onPressed: () {
                    openAlertBox(context, _globalBloc);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(2.h),
          title: Text(
            'Delete this Medication?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                )),
            TextButton(
              onPressed: () {
                //bloc to delete medication
                _globalBloc.removeMedicine(widget.medicine!);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'Yes',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.redAccent, fontSize: 18.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ExtendedSection extends StatelessWidget {
  const ExtendedSection({super.key, this.medicine});
  final Medicine? medicine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: ListView(
        shrinkWrap: true,
        children: [
          ExtendedInfo(
            fieldTitle: 'Medicine Type',
            fieldInfo: medicine!.medicineType! == 'None'
                ? 'Not Specified'
                : medicine!.medicineType!,
          ),
          SizedBox(height: 1.h),
          ExtendedInfo(
            fieldTitle: 'Dosage Interval',
            fieldInfo:
                "Every ${medicine!.interval} hours  | ${medicine!.interval == 24 ? "One time per day" : "${(24 / medicine!.interval!).floor()} times a day"} ",
          ),
          SizedBox(height: 1.h),
          ExtendedInfo(
            fieldTitle: 'Start Time',
            fieldInfo:
                '${medicine!.startTime![0]}${medicine!.startTime![1]}:${medicine!.startTime![2]}${medicine!.startTime![3]}',
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({super.key, this.medicine});
  final Medicine? medicine;

  Hero makeIcon() {
    if (medicine!.medicineType == 'Bottle') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset(
            'lib/assets/icons/medicine.png',
            height: 8.h,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    } else if (medicine!.medicineType == 'Pill') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset(
            'lib/assets/icons/pill.png',
            height: 8.h,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    } else if (medicine!.medicineType == 'Syringe') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset(
            'lib/assets/icons/syringe.png',
            height: 8.h,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    }
    //no medicine type icon selection
    return Hero(
      tag: medicine!.medicineName! + medicine!.medicineType!,
      child: Icon(Icons.error),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        makeIcon(),
        SizedBox(width: 1.w),
        Column(
          children: [
            Hero(
              tag: medicine!.medicineName!,
              child: Material(
                color: Colors.transparent,
                child: InfoTab(
                    fieldTitle: 'Medicine Name',
                    fieldInfo: medicine!.medicineName!),
              ),
            ),
            SizedBox(width: 1.w),
            InfoTab(
              fieldTitle: 'Dosage',
              fieldInfo: medicine!.dosage == 0
                  ? 'Not Specified'
                  : "${medicine!.dosage}  mg / ml",
            ),

          ],
        )
      ],
    );
  }
}

class InfoTab extends StatelessWidget {
  const InfoTab({super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 14.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 0.5.h),
            Text(
              fieldInfo,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class ExtendedInfo extends StatelessWidget {
  const ExtendedInfo(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Text(
            fieldInfo,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
        ],
      ),
    );
  }
}
