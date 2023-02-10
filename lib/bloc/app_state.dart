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

  const DisplayAppState({
    required this.brandsList,
    required this.incomingList,
    required this.goodsList,
  });

  @override
  List<Object?> get props => [
        brandsList,
        incomingList,
        goodsList,
      ];
}
