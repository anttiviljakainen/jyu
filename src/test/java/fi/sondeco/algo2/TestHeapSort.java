package fi.sondeco.algo2;

import static org.junit.Assert.*;

import java.util.Random;

import org.junit.Test;

public class TestHeapSort {

  @Test
  public void test() {
    int[] a = new int[] { 9, 5, 7, 3, 6, 2, 8, 1, 9, 4 };
    HeapSort.heapSort(a, a[0]);
    
    // Tarkistetaan järjestys (suurin ensin, tässä testissä 9..1)
    for (int i = 1; i < a.length; i++)
      assertEquals(10 - i, a[i]);
  }

  /**
   * Testaa kekolajittelua arvotuilla numeroilla ja lopuksi 
   * tarkistaa, että peräkkäisten numeroiden järjestys on oikea.
   */
  @Test
  public void testRandom() {
    int[] a = new int[101];
    a[0] = a.length - 1;
    
    Random r = new Random();
    
    for (int i = 1; i < a.length; i++)
      a[i] = r.nextInt(500);
    
    HeapSort.heapSort(a, a[0]);
    
    for (int i = 2; i < a.length; i++)
      assertTrue(a[i - 1] >= a[i]);
  }
}
