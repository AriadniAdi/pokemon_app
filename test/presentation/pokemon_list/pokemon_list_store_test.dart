import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_app/data/dtos/pokemon_info_dto.dart';
import 'package:pokemon_app/data/services/poke_api_service.dart';
import 'package:pokemon_app/presentation/pokemon_list/pokemon_list_store.dart';

class MockPokeApiService extends Mock implements PokeApiService {}

void main() {
  late MockPokeApiService mockApi;
  late PokemonListStore store;

  setUp(() {
    mockApi = MockPokeApiService();
    store = PokemonListStore(mockApi);
  });

  const dtoBulba = PokemonInfoDto(
    name: 'bulbasaur',
    url: 'https://pokeapi.co/api/v2/pokemon/1/',
  );

  group('PokemonListStore', () {
    test('refresh limpa lista, carrega primeira página e avança offset',
        () async {
      when(() => mockApi.fetchPokemonPage(
            limit: kPageSize,
            offset: 0,
          )).thenAnswer((_) async => ([dtoBulba], 'next', null));

      await store.refresh();

      expect(store.isLoading, false);
      expect(store.errorMessage, isNull);

      expect(store.pokemonList.length, 1);
      expect(store.pokemonList.first.name, 'bulbasaur');

      expect(store.offset, kPageSize);
    });

    test('loadMore adiciona itens e atualiza offset quando há "next"',
        () async {
      when(() => mockApi.fetchPokemonPage(
            limit: kPageSize,
            offset: 0,
          )).thenAnswer((_) async => ([dtoBulba], 'next', null));

      await store.loadMore();

      expect(store.pokemonList.length, 1);
      expect(store.pokemonList.first.name, 'bulbasaur');
      expect(store.offset, kPageSize);
      expect(store.errorMessage, isNull);
    });

    test('loadMore mantém offset quando "next" é null', () async {
      when(() => mockApi.fetchPokemonPage(
            limit: kPageSize,
            offset: 0,
          )).thenAnswer((_) async => ([dtoBulba], null, null));

      await store.loadMore();

      expect(store.pokemonList.length, 1);
      expect(store.offset, 0); // sem "next" não avança
    });

    test('loadMore seta errorMessage quando API falhar', () async {
      when(() => mockApi.fetchPokemonPage(
            limit: kPageSize,
            offset: 0,
          )).thenThrow(Exception('boom'));

      await store.loadMore();

      expect(store.isLoading, false);
      expect(store.pokemonList, isEmpty);
      expect(store.errorMessage, isNotNull);
      expect(store.errorMessage, contains('Falha ao carregar Pokémon'));
    });

    test('canLoadMore fica false enquanto está carregando', () async {
      final completer = Completer<(List<PokemonInfoDto>, String?, String?)>();
      when(() => mockApi.fetchPokemonPage(
            limit: kPageSize,
            offset: 0,
          )).thenAnswer((_) => completer.future);

      final future = store.loadMore();

      expect(store.isLoading, true);
      expect(store.canLoadMore, false);

      completer.complete(([dtoBulba], 'next', null));
      await future;

      expect(store.isLoading, false);
      expect(store.canLoadMore, true);
    });

    test('refresh zera offset e limpa lista antes de recarregar', () async {
      // primeiro loadMore, adiciona bulbasaur
      when(() => mockApi.fetchPokemonPage(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer((_) async => ([dtoBulba], 'next', null));

      await store.loadMore();
      expect(store.pokemonList, isNotEmpty);

      // agora mocka refresh devolvendo lista vazia
      when(() => mockApi.fetchPokemonPage(
                limit: any(named: 'limit'),
                offset: any(named: 'offset'),
              ))
          .thenAnswer(
              (_) async => (List<PokemonInfoDto>.empty(), 'next', null));

      await store.refresh();

      // ASSERT
      expect(store.offset, kPageSize); // avançou
      expect(store.pokemonList, isEmpty); // limpou antes de carregar
    });
  });
}
