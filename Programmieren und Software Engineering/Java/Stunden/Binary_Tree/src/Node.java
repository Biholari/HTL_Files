public class Node {
    private final int number;
    private Node left;
    private Node right;

    public Node(int number) {
        this.number = number;
    }

    public void add(int number) {
        if (this.number > number) {
            if (left == null) {
                left = new Node(number);
            } else {
                left.add(number);
            }
        } else {
            if (right == null) {
                right = new Node(number);
            } else {
                right.add(number);
            }
        }
    }

    @Override
    public String toString() {
        return "" + (left == null ? "" : left + " ") + number + (right == null ? "" : " " + right);
    }

    void fill(Tree t) {
        t.add(number);
        if (left != null) {
            left.fill(t);
        }
        if (right != null) {
            right.fill(t);
        }
    }
}
