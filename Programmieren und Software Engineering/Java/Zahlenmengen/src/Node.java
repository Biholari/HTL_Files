public class Node {
    private int num;
    private Node right;
    private Node left;

    public Node(int num) {
        this.num = num;
    }

    public void add(int val) {
        // Break if the number already exists.
        if (get(val)) {
            return;
        }
        if (this.num > val) {
            if (left == null) {
                left = new Node(val);
            } else {
                left.add(val);
            }
        } else {
            if (right == null) {
                right = new Node(val);
            } else {
                right.add(val);
            }
        }
    }

    public boolean get(int val) {
        if (num == val) {
            return true;
        }
        if (num > val) {
            if (left == null) {
                return false;
            }
            return left.get(val);
        } else {
            if (right == null) {
                return false;
            }
            return right.get(val);
        }
    }

    public int size() {
        int size = 1;
        if (left != null) {
            size += left.size();
        }
        if (right != null) {
            size += right.size();
        }
        return size;
    }

    public void fill(Set res) {
        res.set(num);
        if (left != null) {
            left.fill(res);
        }
        if (right != null) {
            right.fill(res);
        }
    }

    public Node remove(Node root, int key) {
        if (root == null) {
            return null;
        }

        if (root.right == null && root.left == null) {
            return null;
        }

        if (key > root.num) {
            root.right = remove(root.right, key);
        } else if (key < root.num) {
            root.left = remove(root.left, key);
        } else { // else if(key == root.num)
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            // Find the min from right subtree
            Node cur = root.right;
            while (cur.left != null) {
                cur = cur.left;
            }
            root.num = cur.num;
            root.right = remove(root.right, root.num);
        }
        return root;
    }

    public void print() {
        System.out.print(num + " ");
        if (left != null) {
            left.print();
        }
        if (right != null) {
            right.print();
        }
    }

    public void diff(Set other, Set result) {
        if (!other.get(num)) {
            result.set(num);
        }
        if (left != null) {
            left.diff(other, result);
        }
        if (right != null) {
            right.diff(other, result);
        }
    }

    public void intersect(Set other, Set result) {
        if (other.get(num)) {
            result.set(num);
        }
        if (left != null) {
            left.intersect(other, result);
        }
        if (right != null) {
            right.intersect(other, result);
        }
    }

    public void range(Set result, int a, int b) {
        if (num >= a && num <= b) {
            result.set(num);
        }
        if (left != null && num > a) {
            left.range(result, a, b);
        }
        if (right != null && num < b) {
            right.range(result, a, b);
        }
    }

    public void union(Set res) {
        if (res != null) {
            res.set(num);
            if (left != null) {
                left.union(res);
            }
            if (right != null) {
                right.union(res);
            }
        }
    }
}
