import 'package:flutter/material.dart';
import 'package:raou/counter/counter.dart';
import 'package:raou/l10n/l10n.dart';
import 'package:raou/shared/utils/ui_helper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: UIHelper.scaffoldMessengerKey,
      navigatorKey: UIHelper.navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
