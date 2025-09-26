import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_app/core/constants.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app/domain/usecases/get_random_pokemon.dart';
import 'package:pokemon_app/presentation/splash/splash_screen.dart';
import 'package:pokemon_app/presentation/splash/splash_store.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: Colors.red);

    // Injeta o SplashStore de verdade
    final repository = PokemonRepositoryImpl(Dio());
    final getRandomPokemon = GetRandomPokemon(repository);
    final splashStore = SplashStore(getRandomPokemon);

    return MaterialApp(
      title: Constants.pokeDex,
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
      ),
      home: SplashScreen(store: splashStore),
      debugShowCheckedModeBanner: false,
    );
  }
}
