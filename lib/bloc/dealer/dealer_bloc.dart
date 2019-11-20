import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/repositories/dealer/dealer.dart';
import './dealer.dart';

class DealerBloc extends Bloc<DealerEvent, DealerState> {
  final DealerRepository dealerRepository;

  DealerBloc({@required this.dealerRepository});
  @override
  DealerState get initialState => DealerLoading();

  @override
  Stream<DealerState> mapEventToState(
    DealerEvent event,
  ) async* {
    if (event is FetchDealers) {
      yield DealerLoading();

      try {
        final dealers = await dealerRepository.getDealers();
        // final dealers = await dealerRepository.getDealers(int id);
        yield DealerLoaded(dealers);
      } catch (ex) {
        yield DealerError(ex.toString());
      }
    }
  }
}
