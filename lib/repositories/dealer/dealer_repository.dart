import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/dealer/dealer.dart';

class DealerRepository {
  final DealerApiClient dealerApiClient;
  DealerRepository({@required this.dealerApiClient});

  Future<List<Dealer>> getDealers() async {
    return await dealerApiClient.fetchDealers();
  }

  Future<List<Dealer>> getDealersByLpgmc({@required int lpgmcId}) async {
    return await dealerApiClient.fetchDealersByLpgmc(lpgmcId: lpgmcId);
  }
}
