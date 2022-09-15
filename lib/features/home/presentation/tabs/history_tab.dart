import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movna/core/injection.dart';
import 'package:movna/core/domain/entities/activity.dart';
import 'package:movna/core/domain/repositories/activities_repository.dart';
import 'package:movna/features/home/presentation/widgets/activity_card.dart';
import 'package:movna/features/home/presentation/widgets/history_titled_box.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: HistoryTitledBox(
            title: AppLocalizations.of(context)!.activities,
            onMorePressed: () {
              //TODO : Navigator push pastActivitiesPage
            },
            child: FutureBuilder(
              future: injector<ActivitiesRepository>().getActivities(),
              builder: (context, AsyncSnapshot<List<Activity>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitRotatingCircle(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 50.0,
                    ),
                  );
                } else {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noActivityYet,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    List<Activity> activities = snapshot.data!;
                    return ListView(
                      children: activities
                          .map((activity) => ActivityCard(activity: activity))
                          .toList(),
                    );
                  }
                }
              },
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: HistoryTitledBox(
            title: AppLocalizations.of(context)!.statistics,
            //TODO
            child: const Center(child: Text('TODO')),
            onMorePressed: () {
              //TODO : Navigator push statistics page
            },
          ),
        ),
      ],
    );
  }
}
