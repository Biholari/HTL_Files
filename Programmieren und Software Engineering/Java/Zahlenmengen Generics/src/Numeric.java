public interface Numeric<T extends Number> {
    T zero();
    T add(T a, T b);
    T divide(T a, Integer b);
}

