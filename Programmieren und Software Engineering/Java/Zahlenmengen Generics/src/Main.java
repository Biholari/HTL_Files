import java.util.Collections;
import java.util.TreeSet;

public class Main {
    public static void main(String[] args) {
        /*Zahlenmenge<Integer> z = new Zahlenmenge<>();

        z.set(-9);
        z.set(-5);
        z.set(-4);
        z.set(-3);
        z.set(0);
        z.set(2);
        z.set(4);
        z.set(10);

        System.out.println(z.range(-4, 4));*/

        TreeSet<Integer> z = new TreeSet<>();

        z.add(-9);
        z.add(-5);
        z.add(-4);
        z.add(-3);
        z.add(0);
        z.add(2);
        z.add(4);
        z.add(10);

        // System.out.println(z.subSet(-4, true, 4, true));

        System.out.println(z.higher(4));

    }
}