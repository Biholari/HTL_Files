public class DoubleNumeric implements Numeric<Double> {
    @Override
    public Double zero()
    {
        return 0.0;
    }

    @Override
    public Double add(Double a, Double b) {
        return a + b;
    }

    @Override
    public Double divide(Double a, Integer b) {
        return a / b;
    }
}