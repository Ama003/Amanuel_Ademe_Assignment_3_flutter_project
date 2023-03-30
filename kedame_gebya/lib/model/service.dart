import 'package:kedame_gebya/model/model.dart';

import 'local_db.dart';

class Service {
  Repository? _repository;

  Service() {
    _repository = Repository();
  }

  saveKedameGebya(KedameGebya kedameGebya) async {
    return await _repository!.insertData('kedameGebya', kedameGebya.toJson());
  }

  readKedameGebya() async {
    return await _repository!.readData('kedameGebya');
  }

  updateKedameGebya(KedameGebya kedameGebya) async {
    return await _repository!.updateData('kedameGebya', kedameGebya.toJson());
  }

  deleteKedameGebya(dispatchId) async {
    return await _repository!.deleteData('kedameGebya', dispatchId);
  }

  wipeDate() async {
    await _repository!.deleteAllData('kedameGebya');
  }
}
