import com.google.common.base.Joiner;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;

import java.util.*;
import java.util.function.Function;
/Using Google Guava Library 
public class SetOperations {

    public static void main(String args[]) {

        Set<Integer> S = new HashSet<Integer>();
        S.addAll(Arrays.asList(1, 2, 3, 4));


        Set<Integer> T = new HashSet<Integer>();
        T.addAll(Arrays.asList(3, 4, 5, 6));



 
    /*
      Union:
    */
        Set<Integer> union = new HashSet<Integer>();
        union.addAll(S);
        union.addAll(T);
 
    /*
      Intersection:
    */
        Set<Integer> intersection = new HashSet<Integer>();
        intersection.addAll(S);
        intersection.retainAll(T);
 
    /*
      Difference:
    */
        Set<Integer> difference = new HashSet<Integer>();
        difference.addAll(S);
        difference.removeAll(T);
 
    /*
      Complement:
    */
        Set<Integer> complement = new HashSet<Integer>();
        complement.addAll(S);
        complement.removeAll(T);


        System.out.println("S: " + S);
        System.out.println("T: " + T);

    /*
        PowerSet
     */
        Set<Integer> powerSetS = new HashSet<Integer>();
        Set<Set<Integer>> resultS = Sets.powerSet(S);

        Set<Integer> powerSetT = new HashSet<Integer>();
        Set<Set<Integer>> resultT = Sets.powerSet(T);


        // print results
        System.out.println("PowerSet of S: ");
        for (Set<Integer> set : resultS)
            System.out.println(set);

        System.out.println("PowerSet of T: ");
        for (Set<Integer> set : resultT)
            System.out.println(set);

         /*
        Cartesian Product
     */
         Set<List<Integer>> result = Sets.cartesianProduct(ImmutableList.of(S,T));

        System.out.println("Cartesian Product of S x T: " + result);



        System.out.println("union: " + union);
        System.out.println("intersection: " + intersection);
        System.out.println("difference(S-T): " + difference);
        System.out.println("complement(S):  All natural numbers except " + complement);

    }


}
