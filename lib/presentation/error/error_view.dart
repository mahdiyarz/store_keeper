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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p40,
            AppPadding.p16,
            AppPadding.p16,
          ),
          child: Column(
            children: [
              Icon(
                Icons.error_rounded,
                color: ColorManager.white,
                size: AppSize.s150,
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Text(
                AppStrings.errorTitle,
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: AppSize.s14,
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
                child: SelectableText(
                  errorDetails.exception.toString(),
                  style: TextStyle(
                    color: ColorManager.error,
                    fontSize: AppSize.s12,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
