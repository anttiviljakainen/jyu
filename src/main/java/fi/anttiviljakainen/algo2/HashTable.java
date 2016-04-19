package fi.anttiviljakainen.algo2;

public class HashTable {

  /**
   * Constructs new HashTable with capacity m.
   * 
   * @param m capacity.
   */
  public HashTable(int m) {
    this.table = new int[m];
  }
  
  /**
   * Adds a key to the table. If the table is full, 
   * throws a runtime exception.
   * 
   * @param key key to be added
   */
  public void add(int key) {
    int h = hash(key);
    
    for (int i = 0; i < table.length; i++) {
      int index = (h + i) % table.length;
      
      if (table[index] <= 0) {
        table[index] = key;
        return;
      }
    }
    
    throw new RuntimeException("HashTable is full.");
  }
  
  /**
   * Removes key from table. Returns true if key was removed, 
   * false if the key didn't exist.
   * 
   * @param key key to be removed.
   * @return true if operation was successful
   */
  public boolean remove(int key) {
    int h = hash(key);
    
    for (int i = 0; i < table.length; i++) {
      int index = (h + i) % table.length;
      
      if (table[index] == key) {
        table[index] = REMOVED;
        return true;
      } else if (table[index] == EMPTY)
        return false;
    }
    
    return false;
  }
  
  /**
   * Returns true if the table contains the item.
   * 
   * @param key the key
   * @return true if the key exists in the table, false otherwise
   */
  public boolean contains(int key) {
    int h = hash(key);
    
    for (int i = 0; i < table.length; i++) {
      int index = (h + i) % table.length;
      
      if (table[index] == key)
        return true;
      else if (table[index] == EMPTY)
        return false;
    }
    
    return false;
  }
  
  private int hash(int key) {
    return key % table.length;
  }

  private static final int EMPTY = 0;
  private static final int REMOVED = -1;
  
  private int[] table;
}
