part of 'price_bloc.dart';

@immutable
abstract class PriceEvent {}

class FetchPriceEvent extends PriceEvent {
  final String id;

  FetchPriceEvent({required this.id});
}

class RemovePriceEvent extends PriceEvent {}
