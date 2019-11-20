import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/upcoming_request/upcoming_request.dart';

class UpcomingRequestRepository {
  final UpcomingRequestApiClient upcomingRequestApiClient;
  UpcomingRequestRepository({@required this.upcomingRequestApiClient});

  Future<List<UpcomingRequest>> getUpcomingRequests() async {
    return null;
  }
}
