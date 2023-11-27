public class Set {
    private Node root;

    public boolean contains(int number) {
        if (root != null) {
            return root.contains(number);
        } else {
            return false;
        }
    }

    public void insert(int number) {
        if (root != null) {
            root.insert(number);
        } else {
            root = new Node(number);
        }
    }

    @Override
    public String toString() {
        return root == null ? "" : root.toString();
    }

    Set getLimits()
    {
        //Aufgabe 1
        Set res = new Set();

        if (root != null) {
            res.insert(root.getMin());
            res.insert(root.getMax());
        }

        return res;
    }

    int getNext(int n)
    {
        //Aufgabe 7
        if (root != null) {
            return root.getNext(n);
        }

        return 0;
    }

    public static void main(String[] args) {
        Set s = new Set();
        s.insert(15);
        s.insert(2);
        s.insert(-7);
        s.insert(5);
        s.insert(11);
        s.insert(0);
        System.out.println(s);
        System.out.println("Limits");
        System.out.println(s.getLimits()); //"-7 15"
        System.out.println("Next");
        System.out.println(s.getNext(3)); //"5"
        System.out.println(s.getNext(100)); //"15"
    }
}