public class FloatNumeric implements Numeric<Float> {
    @Override
    public Float zero()
    {
        return 0f;
    }

    @Override
    public Float add(Float a, Float b) {
        return a + b;
    }

    @Override
    public Float divide(Float a, Integer b) {
        return a / b;
    }
}