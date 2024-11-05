abstract class Repository<T, P> {
  Future<T> execute(P params);
}
