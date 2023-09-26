import java.util.*;


public class BinaryTree {
    private Node root;

    public BinaryTree(Node root) {
        this.setRoot(root);
    }

    public BinaryTree() {
        this.setRoot(null);
    }

    public Node getRoot() {
        return root;
    }

    public void setRoot(Node root) {
        this.root = root;
    }

    public void insert(Node newNode) {
        if (this.root == null) {
            this.root = newNode;
        } else if (this.root.getLeft() == null) {
            this.root.setLeft(newNode);
        } else if (this.root.getRight() == null) {
            this.root.setRight(newNode);
        } else {
            List<Node> siblingNodes = new LinkedList<Node>();
            siblingNodes.add(this.root.getLeft());
            siblingNodes.add(this.root.getRight());
            insert2(siblingNodes, newNode);
        }
    }

    private void insert2(List<Node> siblingNodes, Node newNode) {
        List<Node> newSiblingNodes = new LinkedList<Node>();
        for (Node siblingNode : siblingNodes) {
            if (siblingNode.getLeft() == null) {
                siblingNode.setLeft(newNode);
                return;
            } else if (siblingNode.getRight() == null) {
                siblingNode.setRight(newNode);
                return;
            } else {
                newSiblingNodes.add(siblingNode.getLeft());
                newSiblingNodes.add(siblingNode.getRight());
            }
        }
        insert2(newSiblingNodes, newNode);
    }
}
