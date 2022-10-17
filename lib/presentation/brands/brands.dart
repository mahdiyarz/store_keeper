import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brands_model.dart';
import '../../providers/brands_provider.dart';
import '../../widgets/screens_style.dart';

class Brands extends StatefulWidget {
  static const routeName = '/brands';

  const Brands({Key? key}) : super(key: key);

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  var textController = TextEditingController();

  @override
  void dispose() {
    textController;

    // TODO: implement dispose
    super.dispose();
  }

  void _showModalBottomSheet(
      BuildContext context, double width, BrandsModel? brandsModel) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: width * 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    brandsModel == null
                        ? const Text(
                            'لطفا نام برند مورد نظر خود را وارد کنید و دکمه ثبت را بزنید...',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const Text(
                            'لطفا نام برند را ویرایش کنید و دکمه ثبت را بزنید...',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: 'نام برند',
                        hintStyle: TextStyle(color: Colors.black26),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'نام برند را وارد نکردید!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: textController.text.isNotEmpty
                                  ? () {
                                      Navigator.of(context).pop();
                                      if (brandsModel != null) {
                                        final BrandsModel updateBrand =
                                            BrandsModel(
                                          brandId: brandsModel.brandId,
                                          brandName: textController.text,
                                        );
                                        Provider.of<BrandsProvider>(context,
                                                listen: false)
                                            .updateData(updateBrand);
                                      } else {
                                        Provider.of<BrandsProvider>(context,
                                                listen: false)
                                            .insertData(BrandsModel(
                                                brandName:
                                                    textController.text));
                                      }
                                    }
                                  : null,
                              child: const Text('ثبت')),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('انصراف')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      screenTitle: 'برندهای موجود',
      screenDescription: 'ثبت یا اصلاح برندهای موجود',
      screenWidget: FutureBuilder(
        future: Provider.of<BrandsProvider>(context, listen: false).fetchData(),
        builder: (context, snapShots) => snapShots.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<BrandsProvider>(
                builder: ((context, value, child) {
                  return value.brandsItems.isEmpty
                      ? child as Widget
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GridView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
                            shrinkWrap:
                                true, //! You won't see infinite size error
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: width * .4,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) => Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 99,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: ListTile(
                                  title: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                          value.brandsItems[index].brandName)),
                                  onTap: () {
                                    _showModalBottomSheet(context, width,
                                        value.brandsItems[index]);
                                    textController.text =
                                        value.brandsItems[index].brandName;
                                  },
                                ),
                              ),
                            ),
                            itemCount: value.brandsItems.length,
                          ),
                        );
                }),
                child: const Center(
                  child: Text('هنوز هیچ برندی ثبت نشده است'),
                )),
      ),
      mainButton: CircleAvatar(
        backgroundColor: Colors.black12,
        child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )),
      ),
      bottomWidget: ElevatedButton.icon(
        onPressed: () {
          _showModalBottomSheet(context, width, null);
          textController.text = '';
        },
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('اضافه کردن برند جدید'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}