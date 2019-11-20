import 'package:equatable/equatable.dart';

abstract class CylinderState extends Equatable {
   CylinderState();
}

class InitialCylinderState extends CylinderState {
  @override
  List<Object> get props => [];
}
