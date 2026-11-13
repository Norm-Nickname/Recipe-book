import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Кнопка «назад» для шапки. Если экран был открыт переходом, возвращает
/// на предыдущий экран, а если приложение открыли сразу по ссылке — на главную.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Назад',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/home');
        }
      },
    );
  }
}
