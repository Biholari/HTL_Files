public class IntegerNumeric implements Numeric<Integer> {
    @Override
    public Integer zero()
    {
        return 0;
    }

    @Override
    public Integer add(Integer a, Integer b) {
        return a + b;
    }

    @Override
    public Integer divide(Integer a, Integer b) {
        return a / b;
    }
}
