import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/presentation/splash/splash_screen.dart';
import 'package:pokemon_app/presentation/splash/splash_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Stub bem simples da store só pra testes
class StubSplashStore implements ISplashStore {
  @override
  bool isLoading;
  @override
  String? errorMessage;
  @override
  Pokemon? pokemon;

  StubSplashStore({
    this.isLoading = false,
    this.errorMessage,
    this.pokemon,
  });

  @override
  Future<void> loadRandomPokemon() async {
    // não faz nada nos testes
  }
}

void main() {
  Widget makeTestableWidget(ISplashStore store) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: SplashScreen(store: store, skipInit: true),
    );
  }

  group('SplashScreen', () {
    testWidgets('mostra CircularProgressIndicator quando está carregando',
        (tester) async {
      final store = StubSplashStore(isLoading: true);

      await tester.pumpWidget(makeTestableWidget(store));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('mostra mensagem quando nenhum Pokémon está disponível',
        (tester) async {
      final store = StubSplashStore(pokemon: null);

      await tester.pumpWidget(makeTestableWidget(store));

      expect(find.text('No Pokémon available'), findsOneWidget);
    });

    testWidgets('mostra Pokémon carregado corretamente', (tester) async {
      final store = StubSplashStore(
        pokemon: const Pokemon(
          id: 25,
          name: 'pikachu',
          height: 0.4,
          weight: 6.0,
          types: ['electric'],
          abilities: ['static'],
          artwork:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
        ),
      );

      await tester.pumpWidget(makeTestableWidget(store));

      expect(find.text('PIKACHU'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
    });
  });
}
