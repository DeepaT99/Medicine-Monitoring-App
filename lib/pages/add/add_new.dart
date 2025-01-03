import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:medicine_tracker/models/errors.dart';
import 'package:medicine_tracker/pages/add/new_entry_bloc.dart';
import 'package:medicine_tracker/pages/add/success_page.dart';
import 'package:medicine_tracker/pages/homepage/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../assets/constants.dart';
import '../../models/convert_time.dart';
import '../../models/medicine.dart';
import '../../models/medicine_type.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotification();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryColor,
            size: 30.px,),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Add New Medication',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.primaryColor,
          ),
          ),
        ),

      body: SingleChildScrollView(
        child: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PanelTitle(
                  title: 'Medicine Name',
                  isRequired: true,
                ),
                TextFormField(
                  maxLength: 18,
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder()),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey[800],
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const PanelTitle(
                  title: 'Dosage in mg/ml',
                  isRequired: false,
                ),
                TextFormField(
                  maxLength: 6,
                  controller: dosageController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(border: UnderlineInputBorder()),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey[800],
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const PanelTitle(title: 'Medicine Type', isRequired: false),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: StreamBuilder<MedicineType>(
                    //new entry block

                    stream: _newEntryBloc.selectedMedicineType,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MedicineTypeColumn(
                            medicineType: MedicineType.Bottle,
                            name: 'Bottle',
                            iconValue: 'lib/assets/icons/medicine.png',
                            isSelected: snapshot.data == MedicineType.Bottle
                                ? true
                                : false,
                          ),
                          MedicineTypeColumn(
                            medicineType: MedicineType.Pill,
                            name: 'Pill',
                            iconValue: 'lib/assets/icons/pill.png',
                            isSelected:
                                snapshot.data == MedicineType.Pill ? true : false,
                          ),
                          MedicineTypeColumn(
                            medicineType: MedicineType.Syringe,
                            name: 'Syringe',
                            iconValue: 'lib/assets/icons/syringe.png',
                            isSelected: snapshot.data == MedicineType.Syringe
                                ? true
                                : false,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                const PanelTitle(title: 'Time between each dosage', isRequired: true),
                SizedBox(height: 0.1.h,),
                const IntervalSelection(),
                SizedBox(
                  height: 2.h,
                ),
                const PanelTitle(title: 'Notification Reminder', isRequired: true),
                SizedBox(
                  height: 2.h,
                ),
                const SelectTime(),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    height: 8.h,
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
                                fontSize: 20.sp,
                              ),
                        ),
                      ),
                      onPressed: () {
                        //add medicine
                        String? medicineName;
                        int? dosage;
                        String medicineType = _newEntryBloc
                            .selectedMedicineType!.value
                            .toString()
                            .substring(13);
                        int interval = _newEntryBloc.selectIntervals!.value;
                        String startTime =
                            _newEntryBloc.selectedTimeOfDay$!.value;

                        //medicine name
                        if (nameController.text == "") {
                          _newEntryBloc.submitError(EntryError.nameNull);
                          return;
                        }
                        if (nameController.text != "") {
                          medicineName = nameController.text;
                        }

                        //dosage
                        if (dosageController.text == "") {
                          dosage = 0;
                        }
                        if (dosageController.text != "") {
                          dosage = int.parse(dosageController.text);
                        }

                        for (var medicine in globalBloc.medicineList$!.value) {
                          if (medicineName == medicine.medicineName) {
                            _newEntryBloc.submitError(EntryError.nameDuplicate);
                            return;
                          }
                        }
                        if (_newEntryBloc.selectIntervals!.value == 0) {
                          _newEntryBloc.submitError(EntryError.interval);
                          return;
                        }
                        if (_newEntryBloc.selectedTimeOfDay$!.value == 'None') {
                          _newEntryBloc.submitError(EntryError.startTime);
                          return;
                        }
                        List<int> intIDs =
                            makeIDs(24 / _newEntryBloc.selectIntervals!.value);
                        List<String> notificationIDs =
                            intIDs.map((i) => i.toString()).toList();

                        Medicine newEntryMedicine = Medicine(
                            notificationIDs: notificationIDs,
                            medicineName: medicineName,
                            dosage: dosage,
                            medicineType: medicineType,
                            interval: interval,
                            startTime: startTime);
                        //update medicine list
                        globalBloc.updateMedicineList(newEntryMedicine);

                        //schedule notification
                        scheduleNotification(newEntryMedicine);

                        //success screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessScreen()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError("Please enter the medicine's name");
          break;

        case EntryError.nameDuplicate:
          displayError("Medicine name already exists!");
          break;

        case EntryError.dosage:
          displayError("Please enter the dosage required");
          break;

        case EntryError.interval:
          displayError("Please select the reminder's interval");
          break;

        case EntryError.startTime:
          displayError("Please select the reminder's starting time");
          break;
        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.deepOrangeAccent,
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }



  initializeNotification() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Future<void> scheduleNotification(Medicine medicine) async {
    int interval = medicine.interval!;
    int hour = int.parse(medicine.startTime!.substring(0, 2));
    int minute = int.parse(medicine.startTime!.substring(2, 4));

    for (int i = 0; i < (24 / interval).floor(); i++) {
      int notificationHour = (hour + (interval * i)) % 24;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(medicine.notificationIDs![i]),
        'Reminder: ${medicine.medicineName}',
        'It\'s time to take your ${medicine.medicineType!.toLowerCase()}!',
        tz.TZDateTime.now(tz.local)
            .add(Duration(hours: notificationHour - DateTime.now().hour, minutes: minute - DateTime.now().minute)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'repeatDailyAtTime channel id',
            'Repeat Daily Notifications',
            channelDescription: 'Channel for daily medicine reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
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
    final NewEntryBloc newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);

    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        //update state via provider
        newEntryBloc.updateTime(convertTime(_time.hour.toString()) +
            convertTime(_time.minute.toString()));
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              shape: const StadiumBorder()),
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? 'Schedule Time'
                  : '${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600
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
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary
                    ),
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                () {
                  _selected = newVal!;
                  newEntryBloc.updateInterval(newVal);
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
            height: 0.5.h,
          ),
          Container(
            width: 20.w,
            height: 9.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white54,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.5.h),
                child: Image.asset(
                  iconValue,
                  color: isSelected
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: Container(
              width: 24.w,
              height: 4.h,
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
                            : Theme.of(context).colorScheme.inversePrimary,
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
      padding: EdgeInsets.only(top: 0.1.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
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
