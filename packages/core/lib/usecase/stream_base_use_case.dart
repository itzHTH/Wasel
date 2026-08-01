abstract class StreamBaseUseCase<T, P> {
  Stream<T> call(P params);
}
