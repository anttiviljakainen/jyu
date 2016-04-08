package fi.sondeco.algo2;

public class HeapSort {
  
  public static void heapSort(int[] a, int n) {
    a[0] = n;
    teeKeko(a);
    
    for (int i = n; i > 1; i--) {
      swap(a, 1, i);
      a[0]--;
      korjaaKeko(a, 1);
    }
  }
  
  private static void swap(int[] a, int ind1, int ind2) {
    int tmp = a[ind1];
    a[ind1] = a[ind2];
    a[ind2] = tmp;
  }
  
  //Muodostaa keon taulukkoon tallennetuista n:stä alkiosta.
  //a[0] sisältää jo alkioiden lukumäärän.

  public static void teeKeko(int[] a) {
    for (int i = a[0] / 2; i >= 1; i--) {
      korjaaKeko(a, i);
    }
  }
  
  public static void korjaaKeko(int[] a, int i) {
    if (2 * i > a[0])
      return; // i:llä ei enää lapsia, ei tehdä mitään
    
    int j = 2 * i;
    int alkio = a[i];
    
    // Siirretään alkiota tarpeen mukaan kohti lehtisolmuja
    while (j <= a[0]) {
      if ((j < a[0]) && (a[j] > a[j + 1]))
        j = j + 1;
      if (alkio <= a[j])
        break; // Lopetetaan silmukka
      a[j / 2] = a[j];
      j = 2 * j;
    }
    a[j / 2] = alkio;
  }
}
