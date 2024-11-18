import 'package:flutter/material.dart';
import 'package:medicine_tracker/models/medicine_type.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc{
  BehaviorSubject<MedicineType>? _selectedMedicineType$;
  ValueStream<MedicineType>? get selectedMedicineType =>
      _selectedMedicineType$!.stream;

  BehaviorSubject<int>? _selectedInterval$;
  BehaviorSubject<int>? get selectIntervals => _selectedInterval$;

  BehaviorSubject<String>? _selectedTimeOfDay$;
  BehaviorSubject<String>? get selectedTimeOfDay$ => _selectedTimeOfDay$;

  //error state


}