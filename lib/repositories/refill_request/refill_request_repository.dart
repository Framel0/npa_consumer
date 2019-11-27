import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/refill_request/refill_request.dart';

class RefillRequestRepository {
  final RefillRequestApiClient refillRequestApiClient;

  List<RefillRequest> _refillRequests = [];
  RefillRequestRepository({@required this.refillRequestApiClient})
      : assert(refillRequestApiClient != null);

  Future<void> getRefillRequests() async {
    await refillRequestApiClient.fetchRefillRequests();
  }

  List<RefillRequest> get refillRequests {
    return List.from(_refillRequests);
  }
}
