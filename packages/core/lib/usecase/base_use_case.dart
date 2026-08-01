abstract class BaseUseCase<T, P> {
  Future<T> call(P params);
}
