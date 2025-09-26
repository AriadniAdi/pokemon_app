import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pokédex';

  @override
  String get splashTitle => 'Who\'s that Pokémon?';

  @override
  String get tapForDetails => 'Tap to see details';

  @override
  String get retry => 'Try again';

  @override
  String get loadingError => 'Failed to load Pokémon. Check your connection.';

  @override
  String get noPokemonAvailable => 'No Pokémon available';

  @override
  String get noDetailsLoaded => 'No details loaded';

  @override
  String get types => 'Types';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get abilities => 'Abilities';
}
