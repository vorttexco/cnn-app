import 'package:flutter/material.dart';

import '../../core/index.dart';
import 'login_view_model.dart';

class LoginView extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLabel.profile,
          fontSize: AppConstants.KFONTSIZE_18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Theme.of(context).colorScheme.primaryContainer,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Text(
              'Acesse sua conta CNN',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: RichText(
                text: TextSpan(
                    text: 'Ao criar uma conta ou fazer login, concordo com os ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Termos de Uso',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' e li nosso '),
                      TextSpan(
                        text: 'Política de Privacidade.',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final login =
                    UserRepository(ApiConnector()).login(LoginType.google);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                maximumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/Google_logo.png',
                          width: 26,
                          height: 26,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Conectar com Google',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final login =
                    UserRepository(ApiConnector()).login(LoginType.apple);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                maximumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Apple_logo.svg',
                          width: 26,
                          height: 26,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Conectar com Apple',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                NavigatorManager(context).back();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                maximumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Não desejo logar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
