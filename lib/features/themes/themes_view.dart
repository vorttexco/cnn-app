import 'package:cnn_brasil_app/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/index.dart';
import 'themes_view_model.dart';

class ThemesView extends ThemesViewModel {
  Widget _buildThemeOption(bool active, Function() onClick, String svg,
      String title, String description) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          height: 111,
          child: Row(
            children: [
              IgnorePointer(
                child: Checkbox(value: active, onChanged: (value) {}),
              ),
              const SizedBox(width: 20),
              // Container(height: 111, width: 62, color: Colors.red),
              SvgPicture.asset(svg),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLabel.themes,
          fontSize: AppConstants.KFONTSIZE_18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          _buildThemeOption(
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
            () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(ThemeMode.dark);
            },
            'assets/images/theme_dark.svg',
            'Sempre escuro',
            'manter a aparência escura no aplicativo CNN Brasil',
          ),
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          _buildThemeOption(
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.system,
            () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(ThemeMode.system);
            },
            'assets/images/theme_system.svg',
            'Automático',
            'seguir a configuração de aparência do seu celular',
          ),
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          const SizedBox(height: 30),
          _buildThemeOption(
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light,
            () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(ThemeMode.light);
            },
            'assets/images/theme_light.svg',
            'Sempre claro',
            'manter a aparência clara no aplicativo CNN Brasil',
          ),
          const SizedBox(height: 30),
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          const SizedBox(height: 49),
        ],
      ),
    );
  }
}
