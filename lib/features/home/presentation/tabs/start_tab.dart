import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:movna/core/domain/entities/itinerary.dart';
import 'package:movna/core/domain/entities/sport.dart';
import 'package:movna/core/injection.dart';
import 'package:movna/core/presentation/router/router.dart';
import 'package:movna/core/presentation/utils/translator.dart';
import 'package:movna/core/presentation/widgets/movna_loading_spinner.dart';
import 'package:movna/core/presentation/widgets/movna_map_layers.dart';
import 'package:movna/core/presentation/widgets/presentation_constants.dart';
import 'package:movna/features/home/presentation/bloc/start_tab_bloc.dart';
import 'package:movna/features/ongoing_activity/presentation/widgets/ongoing_activity_page.dart';

class StartTab extends StatelessWidget {
  const StartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<StartTabBloc>(),
      child: _StartTabView(),
    );
  }
}

class _StartTabView extends StatelessWidget {
  _StartTabView();

  final MapController _mapController = MapController();

  Widget _buildStartBottomSheet(BuildContext context) {
    return BlocBuilder<StartTabBloc, StartTabState>(
      builder: (context, state) {
        if (state is! StartTabLoaded) {
          return const MovnaLoadingSpinner();
        }
        return Container(
          padding: const EdgeInsets.all(globalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.sport),
                  DropdownButton<Sport>(
                    value: state.settings.sport,
                    onChanged: (Sport? value) {
                      if (value != null) {
                        context
                            .read<StartTabBloc>()
                            .add(SportSettingChanged(sport: value));
                      }
                    },
                    items: Sport.values
                        .map<DropdownMenuItem<Sport>>((Sport value) {
                      return DropdownMenuItem<Sport>(
                        value: value,
                        child: Text(translateSport(value, context)),
                      );
                    }).toList(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.automaticPause),
                  Checkbox(
                    tristate: false,
                    value: state.settings.automaticPause,
                    onChanged: (bool? value) => context
                        .read<StartTabBloc>()
                        .add(AutoPauseSettingChanged(autoPause: value!)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.automaticLock),
                  Checkbox(
                    tristate: false,
                    value: state.settings.automaticLock,
                    onChanged: (bool? value) => context
                        .read<StartTabBloc>()
                        .add(AutoLockSettingChanged(autoLock: value!)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.itinerary),
                  // TODO : fix size of dropdown button to accommodate for long itineraries name
                  const SizedBox(width: globalPadding),
                  DropdownButton<Itinerary>(
                    value: state.ongoingActivitySettings.itinerary,
                    onChanged: (Itinerary? value) {
                      context
                          .read<StartTabBloc>()
                          .add(ItinerarySettingChanged(itinerary: value));
                    },
                    items: [
                      DropdownMenuItem<Itinerary>(
                        value: null,
                        child: Text(AppLocalizations.of(context)!.none),
                      ),
                      ...state.itineraries
                          .map<DropdownMenuItem<Itinerary>>((value) {
                        return DropdownMenuItem<Itinerary>(
                          value: value,
                          child: Text(value.name),
                        );
                      }),
                    ],
                  )
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  navigateTo(
                    RouteName.ongoingActivity,
                    OngoingActivityPageParams(
                        ongoingActivitySettings: state.ongoingActivitySettings),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(AppLocalizations.of(context)!.start),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTabBloc, StartTabState>(
      buildWhen: (previous, current) =>
          (previous is! StartTabLoaded && current is StartTabLoaded),
      builder: (context, state) {
        return state is! StartTabLoaded
            ? const MovnaLoadingSpinner()
            : Scaffold(
                body: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    zoom: 16.0,
                    maxZoom: 18.0,
                    minZoom: 6.0,
                    interactiveFlags:
                        InteractiveFlag.all & ~InteractiveFlag.rotate,
                    center: LatLng(state.position.latitudeInDegrees,
                        state.position.longitudeInDegrees),
                  ),
                  children: [
                    // Tile layer
                    getOpenStreetMapTileLayer(),
                    // Itinerary layer
                    BlocBuilder<StartTabBloc, StartTabState>(
                      buildWhen: (previous, current) =>
                          (previous is StartTabLoaded &&
                              current is StartTabLoaded &&
                              previous.ongoingActivitySettings.itinerary !=
                                  current.ongoingActivitySettings.itinerary),
                      builder: (context, state) {
                        final stateLoaded = state as StartTabLoaded;
                        return stateLoaded.ongoingActivitySettings.itinerary !=
                                null
                            ? getItineraryPolylineLayer(
                                stateLoaded.ongoingActivitySettings.itinerary!)
                            : const SizedBox();
                      },
                    ),
                    // Marker Layer
                    BlocBuilder<StartTabBloc, StartTabState>(
                      buildWhen: (previous, current) =>
                          (previous is StartTabLoaded &&
                              current is StartTabLoaded &&
                              previous.position != current.position),
                      builder: (context, state) {
                        final stateLoaded = state as StartTabLoaded;
                        return getPathMarkerLayer(user: stateLoaded.position);
                      },
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (newContext) {
                        return BlocProvider.value(
                          value: context.read<StartTabBloc>(),
                          child: _buildStartBottomSheet(context),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.play_arrow_rounded),
                ),
              );
      },
    );
  }
}
