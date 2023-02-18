part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

@immutable
class AppStateInitial extends AppState {
  const AppStateInitial();

  @override
  List<Object?> get props => [];
}

@immutable
class DisplayAppState extends AppState {
  final List<BrandsModel> brandsList;
  final List<IncomingListModel> incomingList;
  final List<GoodsModel> goodsList;
  final List<CountGoodsModel> countGoodsList;
  final List<LakingModel> lakingList;
  final String failureMessage;
  final String successMessage;

  const DisplayAppState({
    required this.brandsList,
    required this.incomingList,
    required this.goodsList,
    required this.countGoodsList,
    required this.lakingList,
    required this.failureMessage,
    required this.successMessage,
  });

  @override
  List<Object?> get props => [
        brandsList,
        incomingList,
        goodsList,
        countGoodsList,
        lakingList,
        failureMessage,
        successMessage,
      ];
}
