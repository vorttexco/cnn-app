import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  final VoidCallback onReload;

  const CustomErrorWidget(
      {super.key, required this.errorDetails, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomText(
            'Ocorreu um erro inesperado:',
            fontSize: AppConstants.KFONTSIZE_18,
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          CustomText(
            errorDetails.exceptionAsString(),
            textColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          // CustomButton(
          //   onPressed: onReload,
          //   title: 'Recarregar',
          // ),
        ],
      ),
    );
  }
}
