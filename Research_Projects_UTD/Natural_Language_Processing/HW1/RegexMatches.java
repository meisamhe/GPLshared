// written by Meisam Hejazi Nia
// Jan 31, 2015
// for NLP HW1 Dr. Moldovan class
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexMatches
{
    public static void main( String args[] ) throws IOException{

      // String to be scanned to find the pattern.
      //String line = "This order was placed for QT3000! OK?";
      String fullLine = "";
      String inputPath = args[0];
      //String inputPath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\BackupToRestoreComputerApril15\\NLPSpring2015\\HWs\\testNLPHW1.txt";
     //String part : line.split("\\s+")
      File f = new File(inputPath);
      if(f.exists() && !f.isDirectory()) {
    	  System.out.println("The file exists ");
      }else{
    	  System.out.println("The file does not exist "); 
      }
      String newLine = System.getProperty("line.separator");//This will retrieve line separator dependent on OS.

      System.out.println("====================================================================");
      System.out.println("Identifiying the dates in the file: "+args[0]);
      System.out.println("Code written by: Meisam Hejazi Nia");
      System.out.println("Cause: NLP homework 1 of Dr. Moldovan's Class UTD");
      System.out.println("Date: 02/1/2015");
      System.out.println("====================================================================");
      
      //List<String> strings = new ArrayList<String>();    
      Scanner fileScanner = new Scanner(new File(inputPath));
      while (fileScanner.hasNext()){
         //strings.add(fileScanner.nextString());
    	  fullLine += fileScanner.next()+" ";
      }
     // System.out.println("Text is: "+fullLine);
      
     // for (String line : Files.readAllLines(Paths.get(inputPath))) {
    	//  fullLine += line;
    	//}
      
      String line = fullLine;
      String output = "";
      //===========================================
      // for normal dates
      //===========================================
      String pattern = "((january|february|march|april|may|june|july|august|september|october|november|december|"
      		+ "January|February|March|April|May|June|July|August|September|October|November|December) [0-9]+(st|nd|rd|th)?(, [0-9]{4})?|Christmas|Thanksgiving)[\\.,;:\\?\\!]?";
     // List<String> allMatches = new ArrayList<String>();
      Matcher m = Pattern.compile(pattern)
          .matcher(line);
      while (m.find()) {
        //allMatches.add(m.group());
    	  String matchedString = m.group();
    	  if ( (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0)=='.' ||
    			  (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0)==','){
    		  //System.out.println("Inside Loop");  
    		  matchedString = matchedString.substring(0, matchedString.length() - 1);
    	  }
    	  System.out.println("Found value: " + matchedString);  
    	  output += matchedString + newLine;
    	  
      }
      //===========================================
      // for special dates
      //===========================================
      String pattern1 = "((New Year's|Martin Luther King|Labour|Memorial|IndependencePresident's|Columbus|Veterans) Day)[\\.,;:\\?\\!]?";
     // List<String> allMatches = new ArrayList<String>();
      Matcher m1 = Pattern.compile(pattern1)
          .matcher(line);
      while (m1.find()) {
        //allMatches.add(m.group());
    	  String matchedString = m1.group();
    	  if ( (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0)=='.' ||
    			  (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0)==','){
    		  //System.out.println("Inside Loop");  
    		  matchedString = matchedString.substring(0, matchedString.length() - 1);
    	  }
    	  System.out.println("Found value: " + matchedString);  
    	  output += matchedString + newLine;
      }
      //===========================================
      // another date format
      //===========================================
      String pattern2 = "(the [0-9]+(st|nd|rd|th) of (january|february|march|april|may|june|july|august|september|october|november|december|"
      		+ "January|February|March|April|May|June|July|August|September|October|November|December)(, [0-9]{4})?( [0-9]{4})?)[\\.,;:\\?\\!]?";
     // List<String> allMatches = new ArrayList<String>();
      Matcher m2 = Pattern.compile(pattern2)
          .matcher(line);
      while (m2.find()) {
        //allMatches.add(m.group());
    	  String matchedString = m2.group();
    	  //matchedString = matchedString.replaceAll("[\\.,;:\\?\\!]", "");
    	  //matchedString=matchedString.replaceAll("\\.", "");
    	  //System.out.println( (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0));
    	  if ( (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0)=='.' ||
    			  (matchedString.substring(matchedString.length()-1,matchedString.length())).charAt(0)==','){
    		  //System.out.println("Inside Loop");  
    		  matchedString = matchedString.substring(0, matchedString.length() - 1);
    	  }
    	  System.out.println("Found value: " + matchedString);  
    	  output += matchedString + newLine;
      }
      
      System.out.println("====================================================================");
      System.out.println("I have saved the matched date in outputIdenfiedDatemxh109420.txt");
      System.out.println("====================================================================");
      //save the results into the output
      PrintWriter writer = new PrintWriter("outputIdenfiedDatemxh109420.txt", "UTF-8");
      writer.println("Output File");
      writer.println("====================================================================");
      writer.println("Identifiying the dates in the file: "+args[0]);
      writer.println("Code written by: Meisam Hejazi Nia");
      writer.println("Cause: NLP homework 1 of Dr. Moldovan's Class UTD");
      writer.println("Date: 02/1/2015");
      writer.println("====================================================================");
      writer.println(output);
      writer.println("====================================================================");
      writer.println("End of the File");
      writer.println("====================================================================");
      writer.close();
      
      // Create a Pattern object
      //Pattern r = Pattern.compile(pattern);
      // Now create matcher object.
//      Matcher m = r.matcher(line);
//      if (m.find( )) {
//         System.out.println("Found value: " + m.group(0) );
//        // System.out.println("Found value: " + m.group(1) );
//        //  System.out.println("Found value: " + m.group(2) );
//      } else {
//         System.out.println("NO MATCH");
//      }
   }
}