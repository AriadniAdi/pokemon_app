import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/core/result.dart'; // ajuste o caminho conforme sua pasta

void main() {
  group('Result', () {
    test('Ok.when deve chamar o callback ok com o valor correto', () {
      const result = Ok<int>(42);

      final output = result.when(
        ok: (value) => 'Valor: $value',
        err: (msg) => 'Erro: $msg',
      );

      expect(output, 'Valor: 42');
    });

    test('Err.when deve chamar o callback err com a mensagem correta', () {
      const result = Err<int>('Algo deu errado');

      final output = result.when(
        ok: (value) => 'Valor: $value',
        err: (msg) => 'Erro: $msg',
      );

      expect(output, 'Erro: Algo deu errado');
    });

    test('Ok deve armazenar corretamente o valor', () {
      const result = Ok<String>('sucesso');
      expect(result.value, 'sucesso');
    });

    test('Err deve armazenar corretamente a mensagem', () {
      const result = Err<String>('falhou');
      expect(result.message, 'falhou');
    });
  });
}
