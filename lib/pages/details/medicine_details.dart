import 'package:flutter/material.dart';
import 'package:medicine_tracker/components/button.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails({super.key});

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MainSection(),
            ExtendedSection(),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: MyButton(
                  onTap: () {
                    //open alert dialog
                    openAlertBox(context);
                  },
                  text: 'Delete'),
            ),
          ],
        ),
      ),
    );
  }
  openAlertBox(BuildContext context){

  }
}

class ExtendedSection extends StatelessWidget {
  const ExtendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,

        children: const [
          ExtendedInfo(
            fieldTitle: 'Medicine Type',
            fieldInfo: 'Pill',
          ),
          SizedBox(height: 10),
          ExtendedInfo(
            fieldTitle: 'Dose Interval',
            fieldInfo: 'Every 8 hours | 3 times a day',
          ),
          SizedBox(height: 10),
          ExtendedInfo(
            fieldTitle: 'Start Time',
            fieldInfo: '02:10',
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'lib/assets/icons/pill.png',
          height: 80,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(width: 2),
        const Column(
          children: [
            InfoTab(
              fieldTitle: 'Medicine Name',
              fieldInfo: 'Lorem',
            ),
            InfoTab(
              fieldTitle: 'Dosage',
              fieldInfo: '500 mg',
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
      height: 80,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
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
