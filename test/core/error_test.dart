import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/core/error.dart';

void main() {
  group('Failure', () {
    test('deve armazenar a mensagem corretamente', () {
      const msg = 'Erro inesperado';
      final failure = Failure(msg);

      expect(failure.message, msg);
      expect(failure.cause, isNull);
    });

    test('deve armazenar a causa opcional corretamente', () {
      const msg = 'Erro com causa';
      final exception = Exception('Detalhes');
      final failure = Failure(msg, exception);

      expect(failure.message, msg);
      expect(failure.cause, exception);
    });

    test('toString deve retornar no formato esperado', () {
      const msg = 'Falha no processo';
      final failure = Failure(msg);

      expect(failure.toString(), 'Failure($msg)');
    });
  });
}
