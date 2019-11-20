import 'package:npa_user/model/models.dart';

class RefillRepository {
  List<RefillType> _refillTypes = [];

  List<RefillType> get getRefilltypes {
    return List.from(_refillTypes);
  }

  addAddress(RefillType address) {
    _refillTypes.add(address);
  }

  void clearDonwload() {
    _refillTypes.clear();
  }
}
