// public with sharing class Exercice1 
// {
//     public static Map<String, Integer> Exercice1(List<String> s) 
//     {
//         Map<String, Integer> occ = new Map<String, Integer>();
//         Integer count;
//         for (String item : s)
//         {
//             count = 0;
//             for (Integer i = 0; i < s.size(); i++)
//             {
//                 if (s[i] == item)
//                     count++;
//             }
//             occ.put(item, count);
//         }
//         return occ;
//     }
// }

//method 2: optimized
public with sharing class Exercice1 
{
    public static Map<String, Integer> Exercice1(List<String> s) 
    {
        Map<String, Integer> occ = new Map<String, Integer>();
        for (String item : s)
        {
            if (occ.containsKey(item))
                occ.put(item, occ.get(item) + 1);
            else
                occ.put(item, 1);
        }
        return occ;
    }
}
