import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:movna/core/data/datasources/local/database_source.dart';
import 'package:movna/core/data/models/gear_model.dart';
import 'package:movna/core/domain/entities/gear.dart';
import 'package:movna/core/domain/repositories/gear_repository.dart';
import 'package:movna/core/typedefs.dart';

@Injectable(as: GearRepository)
class GearRepositoryImpl implements GearRepository {
  DataBaseSource dataBaseSource;

  GearRepositoryImpl({required this.dataBaseSource});

  @override
  Future<List<Gear>> getGear([int? maxCount]) async {
    try {
      List<GearModel> models = await dataBaseSource.getGear(maxCount);

      return models.map((e) => e.toGear()).toList();
    } catch (e, stackTrace) {
      Logger logger = Logger();
      logger.e(e.toString(), e, stackTrace);
      return [];
    }
  }

  @override
  Future<ErrorState> saveGear(Gear gear) async {
    try {
      GearModel model = GearModel.fromGear(gear);

      await dataBaseSource.saveGearToDatabase(model);

      return false;
    } catch (e, stackTrace) {
      Logger logger = Logger();
      logger.e(e.toString(), e, stackTrace);
      return true;
    }
  }

  @override
  Future<ErrorState> deleteGear(Gear gear) async {
    try {
      GearModel model = GearModel.fromGear(gear);

      await dataBaseSource.removeGearFromDatabase(model);

      return false;
    } catch (e, stackTrace) {
      Logger logger = Logger();
      logger.e(e.toString(), e, stackTrace);
      return true;
    }
  }

  @override
  Future<int> getGearCount() async {
    try {
      int count = await dataBaseSource.getGearCount();

      return count;
    } catch (e, stackTrace) {
      Logger logger = Logger();
      logger.e(e.toString(), e, stackTrace);
      return -1;
    }
  }
}
