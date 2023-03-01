import 'package:flutter/material.dart';
import 'package:store_keeper/models/brands_model.dart';
import 'package:store_keeper/models/goods_model.dart';
import 'package:store_keeper/widgets/goods_list_view.dart';

import '../resources/import_resources.dart';

class AddingGoodManagement extends StatefulWidget {
  final List<BrandsModel> brandsList;
  final List<GoodsModel> goodsList;
  final int incomingGoodId;
  const AddingGoodManagement({
    Key? key,
    required this.goodsList,
    required this.brandsList,
    required this.incomingGoodId,
  }) : super(key: key);

  @override
  State<AddingGoodManagement> createState() => _AddingGoodManagementState();
}

class _AddingGoodManagementState extends State<AddingGoodManagement> {
  TextEditingController searchController = TextEditingController();
  late List<GoodsModel> allGoodsList = List.from(widget.goodsList);
  late List<GoodsModel> filteredGoods = List.from(allGoodsList);

  void searchSpecificGood(String value) {
    setState(() {
      filteredGoods = allGoodsList
          .where((element) => element.goodName.contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return widget.goodsList.isNotEmpty
        ? Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ColorManager.primaryContainer,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ColorManager.primaryContainer,
                        width: 0,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: ColorManager.primary,
                    ),
                    errorStyle: TextStyle(
                      color: ColorManager.error.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 0),
                          color: ColorManager.onError,
                          blurRadius: 30,
                        )
                      ],
                    ),
                    hintText: 'سرچ کن...',
                  ),
                  onChanged: (value) => searchSpecificGood(value),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Visibility(
                  visible: filteredGoods.isNotEmpty,
                  replacement: Padding(
                    padding: EdgeInsets.only(top: width * .08),
                    child: const Text('کالایی که دنبالشی پیدا نشد!'),
                  ),
                  child: GoodsListView(
                    width: width,
                    brandsList: widget.brandsList,
                    goodsList: filteredGoods,
                    isAdding: true,
                    incomingListId: widget.incomingGoodId,
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Image.asset(ImageAssets.goodsScreen),
              const Text('هیچ کالایی ایجاد نشده هنوز!'),
            ],
          );
  }
}
