import 'package:flutter/material.dart';
import 'notifications_settings_view_model.dart';

class NotificationsSettingsView extends NotificationsSettingsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Configuração de notificações',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Personalize sua experiência selecionando as editoriais de seu interesse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var item in notificationOptions.entries)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  item.key,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                if (updatedPreferences)
                                  SizedBox(
                                    height: 40,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch(
                                        value: item.value,
                                        thumbColor: WidgetStatePropertyAll(
                                          item.value
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        inactiveTrackColor: Colors.white,
                                        activeTrackColor: Colors.green,
                                        inactiveThumbColor: Colors.black,
                                        onChanged: (value) {
                                          setState(() {
                                            notificationOptions[item.key] =
                                                value;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: onSavePreferences,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Salvar Preferências'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
