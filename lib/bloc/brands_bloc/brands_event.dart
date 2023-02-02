part of 'brands_bloc.dart';

@immutable
abstract class BrandsEvent extends Equatable {
  const BrandsEvent();

  @override
  List<Object> get props => [];
}

class FetchBrands extends BrandsEvent {
  const FetchBrands();

  @override
  List<Object> get props => [];
}

@immutable
class FetchSpecificBrand extends BrandsEvent {
  final BrandsModel brand;
  const FetchSpecificBrand({required this.brand});

  @override
  List<Object> get props => [brand];
}

@immutable
class AddBrand extends BrandsEvent {
  final BrandsModel brand;
  const AddBrand({
    required this.brand,
  });

  @override
  List<Object> get props => [
        brand,
      ];
}

@immutable
class DeleteBrand extends BrandsEvent {
  final BrandsModel brand;
  const DeleteBrand({
    required this.brand,
  });

  @override
  List<Object> get props => [
        brand,
      ];
}

@immutable
class EditBrand extends BrandsEvent {
  final BrandsModel oldBrand;
  final BrandsModel newBrand;
  const EditBrand({
    required this.oldBrand,
    required this.newBrand,
  });

  @override
  List<Object> get props => [
        oldBrand,
        newBrand,
      ];
}
