import 'package:flutter/material.dart';
import 'package:linear_calender/linear_calender.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:provider/provider.dart';

import '../../models/medicine.dart';
import '../../models/medicine_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stay on track with your health ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                LinearCalendar(
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Colors.white,
                  monthVisibility: false,
                  selectedBorderColor: Theme.of(context).colorScheme.primary,
                  onChanged: (DateTime value) {
                    debugPrint(
                        "*****************$value***************************");
                  },
                  height: 80,
                  itemWidth: 55,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Your total Medications: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder<List<Medicine>>(
                    stream: globalBloc.medicineList$,
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          !snapshot.hasData
                              ? '0'
                              : snapshot.data!.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                        ),
                      );
                    }),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Flexible(
              child: ListItems(),
            )
          ],
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return StreamBuilder(
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // if no data is saved
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Medicine',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MedicineCard(medicine: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
