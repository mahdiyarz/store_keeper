import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/arrival-goods-list');
                },
                icon: const Icon(Icons.store_mall_directory_rounded),
                label: const Text('شمارش ورودی انبار')),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.storage_rounded),
                label: const Text('انبار گردانی')),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('بروزرسانی اطلاعات')),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/brands');
                },
                icon: const Icon(Icons.ballot_rounded),
                label: const Text('ثبت اطلاعات اولیه')),
          ],
        ),
      ),
    );
  }
}
