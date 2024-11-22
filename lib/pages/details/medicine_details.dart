import 'package:flutter/material.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:medicine_tracker/models/medicine.dart';
import 'package:provider/provider.dart';

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
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MainSection(medicine: widget.medicine),
            ExtendedSection(medicine: widget.medicine),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
              child: SizedBox(
                height: 70,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const StadiumBorder(),
                  ),
                  child: Center(
                    child: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
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
          contentPadding: const EdgeInsets.only(top: 2),
          title: Text('Delete this Medication?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                //bloc to delete medication
                _globalBloc.removeMedicine(widget.medicine!);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
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
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          ExtendedInfo(
            fieldTitle: 'Medicine Type',
            fieldInfo: medicine!.medicineType! == 'None'
                ? 'Not Specified'
                : medicine!.medicineType!,
          ),
          const SizedBox(height: 10),
          ExtendedInfo(
            fieldTitle: 'Dosage Interval',
            fieldInfo:
                "Every ${medicine!.interval} hours  | ${medicine!.interval == 24 ? "One time per day" : "${(24 / medicine!.interval!).floor()} times a day"} ",
          ),
          const SizedBox(height: 10),
          ExtendedInfo(
            fieldTitle: 'Start Time',
            fieldInfo:
                '${medicine!.startTime![0]}${medicine!.startTime![1]}:${medicine!.startTime![2]}${medicine!.startTime![3]}',
          ),
          const SizedBox(height: 10),
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
            height: 80,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    } else if (medicine!.medicineType == 'Pill') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset(
            'lib/assets/icons/pill.png',
            height: 80,
            alignment: Alignment.centerLeft,
            color: Color(0xFF201E45),
          ));
    } else if (medicine!.medicineType == 'Syringe') {
      return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: Image.asset(
            'lib/assets/icons/syringe.png',
            height: 80,
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
        const SizedBox(width: 2),
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
            const SizedBox(width: 4),
            InfoTab(
              fieldTitle: 'Dosage',
              fieldInfo: medicine!.dosage == 0
                  ? 'Not Specified'
                  : "${medicine!.dosage} mg/ml",
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
      width: 200,
      height: 120,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              fieldInfo,
              style: Theme.of(context).textTheme.headlineSmall,
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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Text(
            fieldInfo,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
        ],
      ),
    );
  }
}
