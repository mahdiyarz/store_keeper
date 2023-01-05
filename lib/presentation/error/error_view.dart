import 'package:flutter/material.dart';

import '../resources/import_resources.dart';

@immutable
class ErrorView extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorView({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.error,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p40,
          AppPadding.p90,
          AppPadding.p40,
          AppPadding.p0,
        ),
        child: Column(
          children: [
            Icon(
              Icons.error_rounded,
              color: ColorManager.white,
              size: AppSize.s150,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              AppStrings.errorTitle,
              style: TextStyle(
                color: ColorManager.white,
                fontSize: AppSize.s16,
                fontWeight: FontWeightManager.bold,
              ),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p5,
                horizontal: AppPadding.p8,
              ),
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s12)),
              child: Text(
                errorDetails.exception.toString(),
                style: TextStyle(
                  color: ColorManager.error,
                  fontSize: AppSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
