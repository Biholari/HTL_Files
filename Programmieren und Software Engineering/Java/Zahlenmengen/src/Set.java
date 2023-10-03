public class Set {
    private Node root;

    /**
     * Fügt eine neue Zahl in die Menge ein, wenn diese Zahl noch nicht enthalten
     * ist.
     */
    public void set(int val) {
        if (root == null) {
            root = new Node(val);
        } else {
            root.add(val);
        }
    }

    /**
     * Prüft, ob eine Zahl in der Menge enthalten ist.
     */
    public boolean get(int val) {
        if (root == null) {
            return false;
        }
        return root.get(val);
    }

    /**
     * Gibt die Anzahl der Elemente in der Menge zurück.
     */
    public int size() {
        if (root == null) {
            return 0;
        }
        return root.size();
    }

    /**
     * Entfernt eine Zahl aus der Menge, wenn diese enthalten ist.
     */
    public void remove(int val) {
        if (root == null) {
            return;
        }

        root.remove(root, val);
    }

    /**
     * Gibt eine Kopie der Menge zurück.
     */
    @Override
    public Set clone() {
        Set res = new Set();
        if (root != null) {
            root.fill(res);
        }
        return res;
    }

    /**
     * Gibt die Menge auf der Konsole aus.
     */
    public void print() {
        if (root != null) {
            System.out.print("{ ");
            root.print();
            System.out.print("}");
        } else {
            System.out.println("empty");
        }
    }

    /**
     * Liefert Schnittmenge aus this und s als neue Menge.
     */
    public Set intersect(Set s) {
        Set res = new Set();
        if (root != null && s.root != null) {
            root.intersect(s, res);
        }
        return res;
    }

    /**
     * Liefert Vereinigungsmenge aus this und s als neue Menge.
     */
    public Set union(Set s) {
        Set res = clone();
        if (s.root != null) {
            s.root.fill(res);
        }
        return res;
    }

    /**
     * Liefert Differenzmenge aus this und s als neue Menge.
     */
    public Set diff(Set other) {
        Set res = new Set();
        if (root != null) {
            root.diff(other, res);
        }
        return res;
    }

    /**
     * Liefert die Menge aller Zahlen zwischen a und b als neue Menge.
     */
    public Set range(int a, int b) {
        Set res = new Set();
        if (root != null) {
            root.range(res, a, b);
        }
        return res;
    }

    /**
     * Liefert die Summe aller Zahlen in der Menge
     */
    public int total() {
        if (root == null) {
            return 0;
        }
        return root.total();
    }

    /**
     * Liefer den Durchschnitt aller Zahlen in der Menge
     */
    public double average() {
        if (root == null) {
            return 0;
        }
        return (double) total() / size();
    }

    /**
     * Liefer die kleine Zahl in der Menge
     */
    public int min() {
        if (root == null) {
            return 0;
        }
        return root.min();
    }

    /**
     * Liefert die größte Zahl in der Menge
     */
    public int max() {
        if (root == null) {
            return 0;
        }
        return root.max();
    }

    /**
     * Liefert true, wenn beide Mengen die gleichen Zahlen beinhalten
     */
    boolean equals(Set other) {
    if (root == null && other.root == null) {
            return true;
        }
        if (root == null || other.root == null) {
            return false;
        }
        return root.equals(other.root);
    }

    /**
     * Liefert eine zufällige Zahl aus der Menge
     */
    public int randomNumber() {
        if (root == null) {
            return 0;
        }
        return root.randomNumber();
    }
}
