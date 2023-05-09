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
  final List<GoodsModel> goodsList;
  final List<PersonsModel> personsList;
  final List<WarehousesModel> warehousesList;
  final List<StockModel> stocksList;
  final List<StockEachWarehouseModel> stockEachWarehouseList;
  final List<CountGoodsModel> countGoodsList;
  final List<IncomingsModel> incomingList;
  final List<CountedIncomingsModel> countedIncomingsList;
  final String failureMessage;
  final String successMessage;

  const DisplayAppState({
    required this.brandsList,
    required this.incomingList,
    required this.countedIncomingsList,
    required this.goodsList,
    required this.personsList,
    required this.warehousesList,
    required this.stocksList,
    required this.stockEachWarehouseList,
    required this.countGoodsList,
    required this.failureMessage,
    required this.successMessage,
  });

  @override
  List<Object?> get props => [
        brandsList,
        incomingList,
        countedIncomingsList,
        goodsList,
        personsList,
        warehousesList,
        stocksList,
        stockEachWarehouseList,
        countGoodsList,
        failureMessage,
        successMessage,
      ];
}
