import 'app_localizations.dart';

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Pokédex';

  @override
  String get splashTitle => 'Quem é esse Pokémon?';

  @override
  String get tapForDetails => 'Toque para ver detalhes';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get loadingError => 'Não foi possível carregar o Pokémon. Verifique sua conexão.';

  @override
  String get noPokemonAvailable => 'Nenhum Pokémon disponível.';

  @override
  String get noDetailsLoaded => 'Nenhum detalhe carregado';

  @override
  String get types => 'Tipos';

  @override
  String get height => 'Altura';

  @override
  String get weight => 'Peso';

  @override
  String get abilities => 'Habilidades';
}
