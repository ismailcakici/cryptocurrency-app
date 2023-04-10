import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptocurrency/product/model/coin_model.dart';
import 'package:cryptocurrency/product/repository/coin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'coin_event.dart';
part 'coin_state.dart';

const Duration duration = Duration(milliseconds: 200);
EventTransformer<T> postDroppable<T>(Duration duration) {
  return (events, mapper) {
    return droppable<T>().call(events.throttle(duration), mapper);
  };
}

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepository repository;
  int page = 1;
  int perPage = 20;
  CoinBloc({required this.repository}) : super(const CoinState()) {
    on<CoinEvent>(_onFetchCoins, transformer: postDroppable(duration));
  }

  FutureOr<void> _onFetchCoins(CoinEvent event, Emitter<CoinState> emit) async {
    if (state.isReachedMax) return;
    try {
      if (state.status == CoinStatus.initial) {
        final List<CoinModel> coins =
            await repository.getCoinList(page, perPage);
        return emit(
          state.copyWith(
            status: CoinStatus.success,
            coins: coins,
            isReachedMax: false,
          ),
        );
      }
      page++;
      final List<CoinModel> coins = await repository.getCoinList(page, perPage);
      coins.isEmpty
          ? emit(state.copyWith(isReachedMax: true))
          : emit(state.copyWith(
              status: CoinStatus.success,
              coins: List.of(state.coins)..addAll(coins)));
    } catch (e) {
      emit(state.copyWith(status: CoinStatus.failure));
    }
  }
}
