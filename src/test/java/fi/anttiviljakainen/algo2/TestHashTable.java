package fi.anttiviljakainen.algo2;

import static org.junit.Assert.*;

import org.junit.Test;

import fi.anttiviljakainen.algo2.HashTable;

public class TestHashTable {

  @Test
  public void test() {
    HashTable ht = new HashTable(10);
    
    int[] testdata = new int[] { 21, 55, 31, 49, 52, 72, 26, 19 };
    
    // One constant element
    ht.add(10);

    /**
     * Test adding of the elements
     */
    for (int i = 0; i < testdata.length; i++) {
      ht.add(testdata[i]);
      
      assertTrue(ht.contains(testdata[i]));
    }

    /**
     * Test removing of the elements
     */
    for (int i = 0; i < testdata.length; i++) {
      ht.remove(testdata[i]);
      
      assertFalse(ht.contains(testdata[i]));
    }
    
    /**
     * Test successive adding and removing on a used table
     */
    for (int i = 0; i < testdata.length; i++) {
      ht.add(testdata[i]);
      assertTrue(ht.contains(testdata[i]));

      ht.remove(testdata[i]);
      assertFalse(ht.contains(testdata[i]));
    }
  }

}
