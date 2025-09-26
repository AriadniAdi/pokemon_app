import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/presentation/splash/splash_screen.dart';

void main() {
  testWidgets('App deve iniciar com SplashScreen e título Pokédex',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'Pokédex');

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
