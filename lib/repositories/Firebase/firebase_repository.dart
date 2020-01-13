import 'package:meta/meta.dart';
import 'package:npa_user/repositories/Firebase/firebase_api_client.dart';

class FirebaseRepository {
  final FirebaseApiClient firebaseApiClient;

  FirebaseRepository({@required this.firebaseApiClient});

  Future sendNotification(
      {@required String title,
      @required String body,
      @required String token}) async {
    await firebaseApiClient.sendNotification(
        title: title, body: body, token: token);
  }
}
