import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/refill_request_history/refill_request_history.dart';

class RefillRequestHistoryRepository {
  final RefillRequestHistoryApiClient refillRequestHistoryApiClient;

  RefillRequestHistoryRepository({@required this.refillRequestHistoryApiClient})
      : assert(refillRequestHistoryApiClient != null);

  Future<List<RequestHistory>> getRefillRequestHistory(
      {@required int userId}) async {
    return await refillRequestHistoryApiClient.fetchRefillRequestHistorys(
        userId: userId);
  }
}
