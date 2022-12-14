import 'package:flutter/material.dart';
import 'package:movna/core/domain/entities/gear_type.dart';
import 'package:movna/core/domain/entities/settings.dart';
import 'package:movna/core/domain/entities/sport.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Translates [sport] according to given [context].
String translateSport(Sport sport, BuildContext context) {
  late String translation;
  switch (sport) {
    case Sport.other:
      translation = AppLocalizations.of(context)!.other;
      break;
    case Sport.walk:
      translation = AppLocalizations.of(context)!.sportWalk;
      break;
    case Sport.walkNordic:
      translation = AppLocalizations.of(context)!.sportWalkNordic;
      break;
    case Sport.hiking:
      translation = AppLocalizations.of(context)!.sportHiking;
      break;
    case Sport.running:
      translation = AppLocalizations.of(context)!.sportRunning;
      break;
    case Sport.runningTrail:
      translation = AppLocalizations.of(context)!.sportRunningTrail;
      break;
    case Sport.biking:
      translation = AppLocalizations.of(context)!.sportBiking;
      break;
    case Sport.bikingMountain:
      translation = AppLocalizations.of(context)!.sportBikingMountain;
      break;
    case Sport.bikingRoad:
      translation = AppLocalizations.of(context)!.sportBikingRoad;
      break;
    case Sport.bikingElectric:
      translation = AppLocalizations.of(context)!.sportBikingElectric;
      break;
    case Sport.skiingCrossCountry:
      translation = AppLocalizations.of(context)!.sportSkiingCrossCountry;
      break;
    case Sport.skiingOffPiste:
      translation = AppLocalizations.of(context)!.sportSkiingOffPiste;
      break;
    case Sport.snowboard:
      translation = AppLocalizations.of(context)!.sportSnowboard;
      break;
    case Sport.crossSkating:
      translation = AppLocalizations.of(context)!.sportCrossSkating;
      break;
    case Sport.iceSkating:
      translation = AppLocalizations.of(context)!.sportIceSkating;
      break;
    case Sport.swimming:
      translation = AppLocalizations.of(context)!.sportSwimming;
      break;
    case Sport.scubaDiving:
      translation = AppLocalizations.of(context)!.sportScubaDiving;
      break;
    case Sport.kayak:
      translation = AppLocalizations.of(context)!.sportKayak;
      break;
    case Sport.paddle:
      translation = AppLocalizations.of(context)!.sportPaddle;
      break;
    case Sport.surf:
      translation = AppLocalizations.of(context)!.sportSurf;
      break;
    case Sport.windsurfing:
      translation = AppLocalizations.of(context)!.sportWindsurfing;
      break;
    case Sport.kitesurfing:
      translation = AppLocalizations.of(context)!.sportKitesurfing;
      break;
    case Sport.scooter:
      translation = AppLocalizations.of(context)!.sportScooter;
      break;
    case Sport.skateboarding:
      translation = AppLocalizations.of(context)!.sportSkateboarding;
      break;
    case Sport.rollerblading:
      translation = AppLocalizations.of(context)!.sportRollerblading;
      break;
    case Sport.horseRiding:
      translation = AppLocalizations.of(context)!.sportHorseRiding;
      break;
  }
  return translation;
}

/// Translates [gender] according to given [context].
String translateGender(Gender gender, BuildContext context) {
  late String translation;
  switch (gender) {
    case Gender.male:
      translation = AppLocalizations.of(context)!.genderMale;
      break;
    case Gender.female:
      translation = AppLocalizations.of(context)!.genderFemale;
      break;
    case Gender.undefined:
      translation = AppLocalizations.of(context)!.genderUndefined;
      break;
  }
  return translation;
}

String translateGearType(GearType gearType, BuildContext context) {
  late String translation;
  switch (gearType) {
    case GearType.other:
      translation = AppLocalizations.of(context)!.other;
      break;
    case GearType.shoes:
      translation = AppLocalizations.of(context)!.gearTypeShoes;
      break;
    case GearType.bike:
      translation = AppLocalizations.of(context)!.gearTypeBike;
      break;
    case GearType.electricBike:
      translation = AppLocalizations.of(context)!.gearTypeElectricBike;
      break;
    case GearType.skis:
      translation = AppLocalizations.of(context)!.gearTypeSkis;
      break;
    case GearType.snowboard:
      translation = AppLocalizations.of(context)!.gearTypeSnowboard;
      break;
    case GearType.iceSkates:
      translation = AppLocalizations.of(context)!.gearTypeIceSkates;
      break;
    case GearType.flippers:
      translation = AppLocalizations.of(context)!.gearTypeFlippers;
      break;
    case GearType.kayak:
      translation = AppLocalizations.of(context)!.gearTypeKayak;
      break;
    case GearType.paddleBoard:
      translation = AppLocalizations.of(context)!.gearTypePaddleBoard;
      break;
    case GearType.surfBoard:
      translation = AppLocalizations.of(context)!.gearTypeSurfBoard;
      break;
    case GearType.windsurfBoard:
      translation = AppLocalizations.of(context)!.gearTypeWindsurfBoard;
      break;
    case GearType.scooter:
      translation = AppLocalizations.of(context)!.gearTypeScooter;
      break;
    case GearType.skateboard:
      translation = AppLocalizations.of(context)!.gearTypeSkateboard;
      break;
    case GearType.rollerblades:
      translation = AppLocalizations.of(context)!.gearTypeRollerblades;
      break;
    case GearType.horse:
      translation = AppLocalizations.of(context)!.gearTypeHorse;
      break;
  }
  return translation;
}
