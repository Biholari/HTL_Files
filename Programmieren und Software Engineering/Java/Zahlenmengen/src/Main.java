public class Main {
    public static void main(String[] args) {
        Set s1 = new Set();
        s1.set(-9);
        s1.set(-5);
        s1.set(-4);
        s1.set(-3);
        s1.set(0);
        s1.set(2);
        s1.set(4);
        s1.set(10);

        Set s2 = new Set();
        s2.set(-2);
        s2.set(-4);
        s2.set(-3);
        s2.set(0);
        s2.set(2);
        s2.set(4);
        s2.set(10);

        Set s3 = s1.union(s2);

        s3.print();
    }
}