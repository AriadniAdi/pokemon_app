import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/presentation/splash/splash_screen.dart';
import 'package:pokemon_app/presentation/splash/splash_store.dart';

class MockSplashStore extends Mock implements SplashStore {}

void main() {
  late MockSplashStore mockStore;

  setUp(() {
    mockStore = MockSplashStore();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: SplashScreen(store: mockStore),
    );
  }

  group('SplashScreen', () {
    testWidgets('exibe CircularProgressIndicator quando está carregando',
        (tester) async {
      when(() => mockStore.isLoading).thenReturn(true);
      when(() => mockStore.errorMessage).thenReturn(null);
      when(() => mockStore.pokemon).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('exibe mensagem de erro e botão de retry quando falha',
        (tester) async {
      when(() => mockStore.isLoading).thenReturn(false);
      when(() => mockStore.errorMessage).thenReturn('Falha ao carregar');
      when(() => mockStore.pokemon).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('Falha ao carregar'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('exibe mensagem de "nenhum Pokémon disponível"',
        (tester) async {
      when(() => mockStore.isLoading).thenReturn(false);
      when(() => mockStore.errorMessage).thenReturn(null);
      when(() => mockStore.pokemon).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('noPokemonAvailable'), findsOneWidget);
    });

    testWidgets('exibe Pokémon carregado corretamente', (tester) async {
      const pokemon = Pokemon(
        id: 25,
        name: 'pikachu',
        height: 0.4,
        weight: 6.0,
        types: ['electric'],
        abilities: ['static'],
        artwork:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
      );

      when(() => mockStore.isLoading).thenReturn(false);
      when(() => mockStore.errorMessage).thenReturn(null);
      when(() => mockStore.pokemon).thenReturn(pokemon);

      await tester.pumpWidget(createWidgetUnderTest());

      // verifica se o nome aparece em maiúsculo
      expect(find.text('PIKACHU'), findsOneWidget);

      // verifica se a imagem foi renderizada
      expect(find.byType(Image), findsWidgets);
    });
  });
}
