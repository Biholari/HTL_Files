public class Tree {
    private Node root;

    public void add(int number) {
        if (root == null) {
            root = new Node(number);
        } else {
            root.add(number);
        }
    }

    @Override
    public String toString() {
        return "" + (root == null ? "" : root);
    }

    public Tree clone() {
        Tree res = new Tree();
        if (root != null) {
            root.fill(res);
        }
        return res;
    }
}
