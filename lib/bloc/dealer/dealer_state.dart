import 'package:equatable/equatable.dart';
import 'package:npa_user/model/models.dart';

abstract class DealerState extends Equatable {
  DealerState();

  @override
  List<Object> get props => [];
}

class DealerEmpty extends DealerState {
  @override
  String toString() {
    return "DealerEmpty";
  }
}

class DealerLoading extends DealerState {
  @override
  String toString() {
    return "DealerLaoding";
  }
}

class DealerLoaded extends DealerState {
  final List<Dealer> dealers;

  DealerLoaded(this.dealers);

  @override
  List<Object> get props => [dealers];

  @override
  String toString() {
    return "DealerLoadeed";
  }
}

class DealerError extends DealerState {
  final String error;

  DealerError(this.error);
  @override
  String toString() {
    return "DealerError: $error";
  }
}
