import 'package:flutter/material.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/refill_request/refill_request.dart';

class RefillRequestRepository {
  final RefillRequestApiClient refillRequestApiClient;

  RefillRequestRepository({@required this.refillRequestApiClient})
      : assert(refillRequestApiClient != null);

  Future<void> refillRequest({@required RefillRequest refillRequest}) async {
    await refillRequestApiClient.fetchRefillRequests(
        refillRequest: refillRequest);
  }
}
