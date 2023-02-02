part of 'brands_bloc.dart';

@immutable
abstract class BrandsState extends Equatable {
  const BrandsState();
}

@immutable
class BrandsStateInitial extends BrandsState {
  const BrandsStateInitial();

  @override
  List<Object?> get props => [];
}

@immutable
class DisplayBrandsState extends BrandsState {
  final List<BrandsModel> brandsList;

  const DisplayBrandsState({required this.brandsList});

  @override
  List<Object?> get props => [brandsList];
}
