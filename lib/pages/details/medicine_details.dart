import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'lib/assets/icons/pill.png',
                height: 80,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.centerLeft,
              ),
              Column(
               
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
          )
        ],
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldTitle,
            style: Theme.of(context).textTheme.titleMedium,
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
    );
  }
}
