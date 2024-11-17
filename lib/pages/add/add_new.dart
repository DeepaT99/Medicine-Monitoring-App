import 'package:flutter/material.dart';

import '../../models/medicine_type.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late TextEditingController nameController;
  late TextEditingController dosageController;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();

    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Add New Medication',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PanelTitle(
              title: 'Medicine Name',
              isRequired: true,
            ),
            TextFormField(
              maxLength: 20,
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const PanelTitle(
              title: 'Dosage in mg/ml',
              isRequired: false,
            ),
            TextFormField(
              maxLength: 12,
              controller: dosageController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const PanelTitle(title: 'Medicine Type', isRequired: false),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: StreamBuilder(
                //new entry block

                stream: null,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MedicineTypeColumn(
                        medicineType: MedicineType.bottle,
                        name: 'Bottle',
                        iconValue: 'lib/assets/icons/medicine.png',
                        isSelected:
                            snapshot.data == MedicineType.bottle ? true : false,
                      ),
                      MedicineTypeColumn(
                        medicineType: MedicineType.bottle,
                        name: 'Pill',
                        iconValue: 'lib/assets/icons/pill.png',
                        isSelected:
                            snapshot.data == MedicineType.bottle ? true : false,
                      ),
                      MedicineTypeColumn(
                        medicineType: MedicineType.bottle,
                        name: 'Syringe',
                        iconValue: 'lib/assets/icons/syringe.png',
                        isSelected:
                            snapshot.data == MedicineType.bottle ? true : false,
                      ),
                    ],
                  );
                },
              ),
            ),
            const PanelTitle(title: 'Interval Selection', isRequired: true),
            const IntervalSelection(),
          ],
        ),
      ),
    );
  }
}
class IntervalSelection extends StatefulWidget {
  const IntervalSelection({super.key});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

      ],
    );
  }
}


class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn(
      {super.key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected});
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //selected type of medicine
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white70,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: Image.asset(
                  iconValue,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            TextSpan(
              text: isRequired ? ' *' : '',
            ),
          ],
        ),
      ),
    );
  }
}
