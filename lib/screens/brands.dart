import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/brands_model.dart';
import '../providers/brands_provider.dart';
import '../widgets/screens_style.dart';

class Brands extends StatelessWidget {
  static const routeName = '/brands';

  Brands({Key? key}) : super(key: key);

  var textController = TextEditingController();

  void _showModalBottomSheet(BuildContext context, double width) {
    showModalBottomSheet(
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
                    const Text(
                      'لطفا نام برند مورد نظر خود را وارد کنید و دکمه ثبت را بزنید...',
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
                              onPressed: () {
                                Navigator.of(context).pop();
                                Provider.of<BrandsProvider>(context,
                                        listen: false)
                                    .insertData(BrandsModel(
                                        brandName: textController.text));
                              },
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
                      : GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
                          shrinkWrap:
                              true, //! You won't see infinite size error
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            margin: const EdgeInsets.all(3),
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
                            child: GridTile(
                              child: Center(
                                  child:
                                      Text(value.brandsItems[index].brandName)),
                            ),
                          ),
                          itemCount: value.brandsItems.length,
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
          _showModalBottomSheet(context, width);
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
