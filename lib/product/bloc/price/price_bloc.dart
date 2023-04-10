import 'dart:async';

import 'package:cryptocurrency/product/repository/coin_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final CoinRepository repository;
  PriceBloc({required this.repository})
      : super(
          const PriceState(
            spots1d: [],
            spots1m: [],
            spots1y: [],
            spots3m: [],
            spots7d: [],
          ),
        ) {
    on<FetchPriceEvent>(_fetchPriceEvent);
    on<RemovePriceEvent>(_removePriceEvent);
  }
  FutureOr<void> _removePriceEvent(
      RemovePriceEvent event, Emitter<PriceState> emit) {
    emit(
      const PriceState(
        spots1d: [],
        spots7d: [],
        spots1m: [],
        spots3m: [],
        spots1y: [],
      ),
    );
  }

  FutureOr<void> _fetchPriceEvent(
      FetchPriceEvent event, Emitter<PriceState> emit) async {
    final List<FlSpot> spots1d = await repository.getSpots(event.id, 1);
    emit(PriceState(
      spots1d: spots1d,
      spots7d: [],
      spots1m: [],
      spots3m: [],
      spots1y: [],
    ));
    final List<FlSpot> spots7d = await repository.getSpots(event.id, 7);
    final List<FlSpot> spots1m = await repository.getSpots(event.id, 30);
    final List<FlSpot> spots3m = await repository.getSpots(event.id, 90);
    final List<FlSpot> spots1y = await repository.getSpots(event.id, 365);
    emit(PriceState(
        spots1d: spots1d,
        spots7d: spots7d,
        spots1m: spots1m,
        spots3m: spots3m,
        spots1y: spots1y));
  }
}
