part of './destination_bloc.dart';

enum DestinationStatus { initial,success, failure }

class DestinationState extends Equatable {
  final List<Destination> destinations;
  final bool hasReachedMax;
  final DestinationStatus status;

  const DestinationState({
    this.destinations = const [],
    this.hasReachedMax = false,
    this.status = DestinationStatus.initial,
  });

  DestinationState copyWith({
    List<Destination>? destinations,
    bool? hasReachedMax,
    DestinationStatus? status,
  }) {
    return DestinationState(
      destinations: destinations ?? this.destinations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        destinations,
        hasReachedMax,
        status,
      ];
}
