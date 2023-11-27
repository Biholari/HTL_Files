import java.util.Collections;

public class Main {
    public static void main(String[] args) {
        Zahlenmenge<Integer> z = new Zahlenmenge<>();

        z.set(-9);
        z.set(-5);
        z.set(-4);
        z.set(-3);
        z.set(0);
        z.set(2);
        z.set(4);
        z.set(10);

        System.out.println(z.range(-4, 4));
    }
}