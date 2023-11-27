import java.util.*;

public class Zahlenmenge<T extends Number & Comparable<T>> {
    private TreeSet<T> numbers = new TreeSet<>();

    void set(T val) {
        numbers.add(val);
    }

    boolean get(T val) {
        return numbers.contains(val);
    }

    int size() {
        return numbers.size();
    }

    void remove(T val) {
        numbers.remove(val);
    }

    @Override
    public Zahlenmenge<T> clone() {
        Zahlenmenge<T> result = new Zahlenmenge<>();
        for (T number : numbers) {
            result.set(number);
        }
        return result;
    }

    void print() {
        System.out.println(numbers);
    }

    Zahlenmenge<T> intersect(Zahlenmenge<T> s) {
        Zahlenmenge<T> result = (Zahlenmenge<T>) numbers.clone();
        result.numbers.retainAll(s.numbers);
        return result;
    }

    Zahlenmenge<T> union(Zahlenmenge<T> s) {
        Zahlenmenge<T> result = (Zahlenmenge<T>) numbers.clone();
        for (T number : s.numbers) {
            result.set(number);
        }
        return result;
    }

    Zahlenmenge<T> diff(Zahlenmenge<T> s) {
        Zahlenmenge<T> result = (Zahlenmenge<T>) numbers.clone();
        result.numbers.removeAll(s.numbers);
        return result;
    }

    Zahlenmenge<T> range(T from, T to) {
        Zahlenmenge<T> result = (Zahlenmenge<T>) numbers.clone();
        result.numbers.subSet(from, true, to, true);
        return result;
    }

    Numeric<T> getNumeric() {
        if (numbers.iterator().next() instanceof Integer) {
            return (Numeric<T>) new IntegerNumeric();
        } else if (numbers.iterator().next() instanceof Double) {
            return (Numeric<T>) new DoubleNumeric();
        } else if (numbers.iterator().next() instanceof Float) {
            return (Numeric<T>) new FloatNumeric();
        } else {
            throw new IllegalArgumentException("Unsupported type");
        }
    }

    T total() {
        Numeric<T> numeric = getNumeric();
        T result = numeric.zero();
        for (T number : numbers) {
            result = numeric.add(result, number);
        }
        return result;
    }

    T average() {
        Numeric<T> numeric = getNumeric();
        return numeric.divide(total(), numbers.size());
    }
    T min() {
        return numbers.first();
    }

    T max() {
        return numbers.last();
    }

    boolean equals(Zahlenmenge<T> s) {
        return numbers.equals(s.numbers);
    }

    public T zufallsZahl() {
        if (numbers.isEmpty()) {
            return null;
        }
        List<T> list = new ArrayList<>(numbers);
        Random random = new Random();
        return list.get(random.nextInt(list.size()));
    }
}
