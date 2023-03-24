import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:listview_bloc/core/extension/log.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../../domain/model/destination.dart';

part 'destination_event.dart';
part 'destination_state.dart';

typedef HttpClient = http.Client;
const _duration = Duration(milliseconds: 100);

EventTransformer<T> destinationDroppable<T>(Duration duration) {
  return (events, mapper) {
    return droppable<T>().call(events.throttle(duration), mapper);
  };
}

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DestinationBloc() : super(const DestinationState()) {
    on<DestinationFetched>(
      _onDestinationFetched,
      transformer: destinationDroppable(_duration),
    );
  }
  Future<void> _onDestinationFetched(
      DestinationFetched event, Emitter<DestinationState> emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == DestinationStatus.initial) {
        final destinations = await _fetchDestinations();
        'Destination ${destinations.length}'.log();
        return emit(
          state.copyWith(
            status: DestinationStatus.success,
            destinations: destinations,
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      e.log();
      emit(
        state.copyWith(
          status: DestinationStatus.failure,
        ),
      );
    }
  }

  Future<List<Destination>> _fetchDestinations() async {
    final response = await _db.collection('destinations').get();
    return response.docs
        .map(
          (document) => Destination.fromFirestore(
            document.data(),
          ),
        )
        .toList();
  }
}
