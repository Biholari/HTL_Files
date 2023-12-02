import java.util.Iterator;
import java.util.NoSuchElementException;

public class PermutationenGenerator implements Iterable<Integer[]>, Iterator<Integer[]> {
    private boolean hasNext;
    private final int n;
    private final Integer[] currentPermutation;

    public PermutationenGenerator(int n) {
        this.n = n;
        hasNext = true;
        currentPermutation = new Integer[n];
        for (int i = 0; i < n; i++) {
            currentPermutation[i] = i;
        }
    }
    @Override
    public Iterator<Integer[]> iterator() {
        return new PermutationenGenerator(n);
    }

    @Override
    public boolean hasNext() {
        return hasNext;
    }

    @Override
    public Integer[] next() {
        if (!hasNext) {
            throw new NoSuchElementException("No more permutations");
        }
        Integer[] result = currentPermutation.clone();

        calcNextPermutation();

        return result;
    }

    private void calcNextPermutation() {
        //Find the largest index k such that a[k] < a[k + 1]. If no such index exists, the permutation is the last permutation.
        int k = n - 2;
        while (k >= 0 && currentPermutation[k] > currentPermutation[k + 1]) {
            k--;
        }


        if (k < 0) {
            hasNext = false;
            return;
        }

        int l = n - 1;
        while (currentPermutation[k] > currentPermutation[l]) {
            l--;
        }

        // Swap i and j
        int tmp = currentPermutation[k];
        currentPermutation[k] = currentPermutation[l];
        currentPermutation[l] = tmp;

        // Reverse the sequence from a[k + 1] up to and including the final element a[n].
        int i = k + 1;
        int j = n - 1;
        while (i < j) {
            tmp = currentPermutation[i];
            currentPermutation[i] = currentPermutation[j];
            currentPermutation[j] = tmp;
            i++;
            l--;
        }
    }

    public static void main(String[] args) {
        PermutationenGenerator pg = new PermutationenGenerator(4);
        for (Integer[] permutation : pg) {
            for (Integer integer : permutation) {
                System.out.print(integer + " ");
            }
            System.out.println();
        }
    }
}
