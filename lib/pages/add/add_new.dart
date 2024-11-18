import 'package:flutter/material.dart';
import 'package:medicine_tracker/pages/add/new_entry_bloc.dart';
import 'package:provider/provider.dart';

import '../../models/convert_time.dart';
import '../../models/medicine_type.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late TextEditingController nameController;
  late TextEditingController dosageController;

  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();

    _newEntryBloc = NewEntryBloc();
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
      body: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
                height: 20,
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
                height: 20,
              ),
              const PanelTitle(title: 'Medicine Type', isRequired: false),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: StreamBuilder<MedicineType>(
                  //new entry block
        
                  stream: _newEntryBloc.selectedMedicineType,
                  builder:
                      (context, snapshot) {
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
                          medicineType: MedicineType.pill,
                          name: 'Pill',
                          iconValue: 'lib/assets/icons/pill.png',
                          isSelected:
                              snapshot.data == MedicineType.pill ? true : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.syringe,
                          name: 'Syringe',
                          iconValue: 'lib/assets/icons/syringe.png',
                          isSelected:
                              snapshot.data == MedicineType.syringe ? true : false,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const PanelTitle(title: 'Interval Selection', isRequired: true),
              const SizedBox(
                height: 5,
              ),
              const IntervalSelection(),
              const SizedBox(
                height: 25,
              ),
              const PanelTitle(title: 'Starting Time', isRequired: true),
              const SizedBox(
                height: 10,
              ),
              const SelectTime(),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: SizedBox(
                  height: 70,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const StadiumBorder(),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 20,
                            ),
                      ),
                    ),
                    onPressed: () {
                      //add medicine
                      //validations
                      //success page
        
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        //update state via provider here
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, left: 20, right: 20),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const StadiumBorder()),
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? 'Select Time'
                  : '${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
            ),
          ),
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
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me every',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          DropdownButton(
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            dropdownColor: Theme.of(context).colorScheme.surface,
            hint: _selected == 0
                ? Text(
                    'Select an Interval',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                () {
                  _selected = newVal!;
                },
              );
            },
          ),
          Text(
            _selected == 1 ? "hour" : "hours",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
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
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        //selected type of medicine
        newEntryBloc.updateSelectedMedicine(medicineType);

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
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Image.asset(
                  iconValue,
                  color: isSelected
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
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
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Theme.of(context).colorScheme.surface
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
                color: Theme.of(context).colorScheme.secondary,
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
