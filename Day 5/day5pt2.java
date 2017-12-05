import java.util.Scanner;
import java.util.Vector;

public class Day5 {
    private static Vector<Integer> stdinToVector() {
        Scanner scan = new Scanner(System.in);
        Vector v = new Vector();
        do {
            int i = scan.nextInt();
            v.add(i);
        } while (scan.hasNext());
        return v;
    }
    
    public static void main(String args[]) {
        Vector<Integer> v = Day5.stdinToVector();
        int vlength = v.size();
        int position = 0;
        int steps = 0;
        
        while (position < vlength) {
            int opos = position;
            int elem = v.elementAt(position);
            position += elem;
            if (elem >= 3) v.set(opos, elem - 1);
            else v.set(opos, elem + 1);
            steps++;
        }
        
        System.out.println(steps);
    }
}
