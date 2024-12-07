import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/assets/constants.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:medicine_tracker/pages/app_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/medicine.dart';
import '../../models/medicine_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Never miss your medications!',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.primaryColor,
                      fontSize: 20.sp
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        fontSize: 16.sp,
                        color: AppColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 0.4.h,)
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [

            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                // LinearCalendar(
                //   selectedColor: Theme.of(context).colorScheme.primary,
                //   unselectedColor: Colors.white,
                //   monthVisibility: false,
                //   selectedBorderColor: Theme.of(context).colorScheme.primary,
                //   onChanged: (DateTime value) {
                //     debugPrint(
                //         "*****************$value***************************");
                //   },
                //   height: 9.h,
                //   itemWidth: 14.w,
                //   backgroundColor: Colors.transparent,
                // ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Text(
                  'Your total Medications: ',
                  style: TextStyle(
                    fontSize: 20.sp,
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
                                fontSize: 20.sp,
                              ),
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            const Flexible(
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

  //checkbox was ticked
  void checkBoxChanged(int index) {}
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
            itemBuilder: (BuildContext context, index) {
              return MedicineCard(
                medicine: snapshot.data![index],
              );
            },
          );
        }
      },
    );
  }
}
