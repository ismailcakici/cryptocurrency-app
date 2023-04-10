part of 'coin_bloc.dart';

enum CoinStatus { initial, success, failure }

class CoinState {
  final List<CoinModel> coins;
  final bool isReachedMax;
  final CoinStatus status;

  const CoinState(
      {this.coins = const <CoinModel>[],
      this.isReachedMax = false,
      this.status = CoinStatus.initial});

  CoinState copyWith({
    List<CoinModel>? coins,
    bool? isReachedMax,
    CoinStatus? status,
  }) {
    return CoinState(
        coins: coins ?? this.coins,
        isReachedMax: isReachedMax ?? this.isReachedMax,
        status: status ?? this.status);
  }
}
