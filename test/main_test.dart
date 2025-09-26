import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/core/constants.dart';
import 'package:pokemon_app/presentation/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('MyApp deve inicializar com MaterialApp correto',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, Constants.pokeDex);

    expect(find.byType(SplashScreen), findsOneWidget);

    expect(
      materialApp.localizationsDelegates,
      contains(AppLocalizations.delegate),
    );

    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode),
      containsAll(['en', 'pt']),
    );
  });
}
