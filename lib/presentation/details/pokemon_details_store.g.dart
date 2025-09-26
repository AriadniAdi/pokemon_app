// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonDetailsStore on _PokemonDetailsStore, Store {
  late final _$pokemonDetailsAtom =
      Atom(name: '_PokemonDetailsStore.pokemonDetails', context: context);

  @override
  Pokemon? get pokemonDetails {
    _$pokemonDetailsAtom.reportRead();
    return super.pokemonDetails;
  }

  @override
  set pokemonDetails(Pokemon? value) {
    _$pokemonDetailsAtom.reportWrite(value, super.pokemonDetails, () {
      super.pokemonDetails = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PokemonDetailsStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_PokemonDetailsStore.state', context: context);

  @override
  PokemonDetailsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PokemonDetailsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fetchDetailsAsyncAction =
      AsyncAction('_PokemonDetailsStore.fetchDetails', context: context);

  @override
  Future<void> fetchDetails(String idOrName) {
    return _$fetchDetailsAsyncAction.run(() => super.fetchDetails(idOrName));
  }

  @override
  String toString() {
    return '''
pokemonDetails: ${pokemonDetails},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
