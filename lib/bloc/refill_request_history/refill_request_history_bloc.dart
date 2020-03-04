import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/repositories.dart';
import './refill_request_history.dart';

class RefillRequestHistoryBloc
    extends Bloc<RefillRequestHistoryEvent, RefillRequestHistoryState> {
  final RefillRequestHistoryRepository refillRequestHistoryRepository;

  RefillRequestHistoryBloc({@required this.refillRequestHistoryRepository});
  @override
  RefillRequestHistoryState get initialState => RefillRequestHistoryLoading();

  @override
  Stream<RefillRequestHistoryState> mapEventToState(
    RefillRequestHistoryEvent event,
  ) async* {
    if (event is FetchRefillRequestHistory) {
      yield RefillRequestHistoryLoading();

      try {
        final history = await refillRequestHistoryRepository
            .getRefillRequestHistory(consumerId: event.consumerId);

        yield RefillRequestHistoryLoaded(histories: history);
      } catch (e) {
        yield RefillRequestHistoryError(error: e.toString());
      }
    }
  }
}
