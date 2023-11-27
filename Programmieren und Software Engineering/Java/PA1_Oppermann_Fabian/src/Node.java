public class Node {
    private final int number;
    private Node left;
    private Node right;
    public Node(int number) {
        this.number = number;
    }
    @Override
    public String toString() {

        String res = "";
        if (left != null) {
            res += left + " ";
        }
        res += number;
        if (right != null) {
            res += " " + right;
        }
        return res;
    }
    boolean contains(int number) {
        if (number == this.number) {
            return true;
        } else if (number < this.number) {
            if (left != null) {
                return left.contains(number);
            } else {
                return false;
            }
        } else {
            if (right != null) {
                return right.contains(number);
            } else {
                return false;
            }
        }
    }
    void insert(int number) {
        if (number < this.number) {
            if (left == null) {
                left = new Node(number);
            } else {
                left.insert(number);
            }
        } else if (number > this.number) {
            if (right == null) {
                right = new Node(number);
            } else {
                right.insert(number);
            }
        }
    }

    public int getNext(int n) {
        if (n == number) {
            if (right != null) {
                return right.getMin();
            } else {
                return 0;
            }
        } else if (n < number) {
            if (left != null) {
                return left.getNext(n);
            } else {
                return number;
            }
        } else {
            if (right != null) {
                return right.getNext(n);
            } else {
                return number;
            }
        }
    }

    //Aufgabe 1
    public int getMin() {
        if (left != null) {
            return left.getMin();
        } else {
            return number;
        }
    }

    public int getMax() {
        if (right != null) {
            return right.getMax();
        } else {
            return number;
        }
    }
}