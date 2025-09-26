sealed class Result<T> {
  const Result();
  R when<R>({required R Function(T) ok, required R Function(String) err});
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
  @override
  R when<R>({required R Function(T) ok, required R Function(String) err}) =>
      ok(value);
}

class Err<T> extends Result<T> {
  final String message;
  const Err(this.message);
  @override
  R when<R>({required R Function(T) ok, required R Function(String) err}) =>
      err(message);
}
