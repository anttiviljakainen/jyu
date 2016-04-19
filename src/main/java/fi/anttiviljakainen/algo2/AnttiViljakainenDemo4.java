package fi.anttiviljakainen.algo2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Algoritmit 2 Demo 4
 * 
 * @author Antti Viljakainen
 */
public class AnttiViljakainenDemo4 {

  public static void main(String[] args) throws IOException {
    String text = "algoritmien opiskelu on kivaa";
    System.out.println("Merkkijonon: \"" + text + "\"");
    System.out.println("sanat käänteisessä järjestyksessä: \"" + reverseWords(text) + "\"");
    System.out.println();
    
    text = "  algoritmien     opiskelu    on   kivaa   ";
    System.out.println("Merkkijonon: \"" + text + "\"");
    System.out.println("sanat käänteisessä järjestyksessä: \"" + reverseWords(text) + "\"");
    System.out.println();
    
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    System.out.print("Syötä merkkijono: ");
    text = br.readLine();
    System.out.println("Merkkijonon: \"" + text + "\"");
    System.out.println("sanat käänteisessä järjestyksessä: \"" + reverseWords(text) + "\"");
  }

  private static String reverseWords(String text) {
    StringBuffer output = new StringBuffer();
    int index = text.length() - 1;
    int endindex = index + 1;
    
    // Käydään indeksejä lopusta alkaen
    while (index >= 0) {
      if (text.charAt(index) == ' ') {
        // Katkaistaan sana, jos loppuindeksi <> nykyinen indeksi
        if (endindex > (index + 1)) {
          // Välilyönti, jos on jo tulostettavaa tekstiä
          if (output.length() > 0)
            output.append(' ');
          output.append(text.substring(index + 1, endindex));
        }

        endindex = index;
      }
      
      index--;
    }
    // Merkkijonon alussa oleva sana, jos olemassa
    if (endindex != 0) {
      // Välilyönti, jos on jo tulostettavaa tekstiä
      if (output.length() > 0)
        output.append(' ');
      output.append(text.substring(0, endindex));
    }
    
    return output.toString();
  }

}
