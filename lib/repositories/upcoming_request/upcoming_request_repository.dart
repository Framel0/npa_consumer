import 'package:meta/meta.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/upcoming_request/upcoming_request.dart';

class UpcomingRequestRepository {
  final UpcomingRequestApiClient upcomingRequestApiClient;
  UpcomingRequestRepository({@required this.upcomingRequestApiClient});

  List<UpcomingRequest> _upcomingRequests = [];

  Future<void> getUpcomingRequests({@required int userId}) async {
    _upcomingRequests =
        await upcomingRequestApiClient.fetchUpcomingRequests(userId: userId);
  }

  List<UpcomingRequest> get upcomingRequests {
    return List.from(_upcomingRequests);
  }
}
