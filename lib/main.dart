import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';

import 'package:pokemon_app/core/constants.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app/domain/usecases/get_random_pokemon.dart';
import 'package:pokemon_app/presentation/splash/splash_screen.dart';
import 'package:pokemon_app/presentation/splash/splash_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PokemonRepositoryImpl(Dio());
    final getRandomPokemon = GetRandomPokemon(repository);
    final splashStore = SplashStore(getRandomPokemon);

    return MaterialApp(
      title: Constants.pokeDex,
      theme: ThemeData(primarySwatch: Colors.red),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: SplashScreen(store: splashStore),
      debugShowCheckedModeBanner: false,
    );
  }
}
