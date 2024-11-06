// abstract class Repository<T, P> {
//   Future<T> execute(P params);
// }
abstract class Repository<O, I> {
  Future<O> execute(I params);
}
