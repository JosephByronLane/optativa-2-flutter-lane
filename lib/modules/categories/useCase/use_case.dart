abstract class UseCase<I, O> {
  Future<I> execute(O params);
}
