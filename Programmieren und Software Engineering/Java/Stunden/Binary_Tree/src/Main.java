public class Main {
    public static void main(String[] args) {
        Tree t = new Tree();

        t.add(17);
        t.add(10);
        t.add(20);
        t.add(12);
        t.add(13);
        Tree x = t.clone(); // Deep copy with pre-order
        /*
        Pre order
        in order
        post order
         */
    }
}