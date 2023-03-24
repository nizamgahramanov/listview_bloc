part of './destination_bloc.dart';

@immutable
abstract class DestinationEvent extends Equatable {
  const DestinationEvent();

  @override
  List<Object?> get props => [];
}

class DestinationFetched extends DestinationEvent{
  const DestinationFetched();
}
