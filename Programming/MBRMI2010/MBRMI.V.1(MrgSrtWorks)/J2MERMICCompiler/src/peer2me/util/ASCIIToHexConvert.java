package peer2me.util;

/**
 * 
 * This class converts ASCII letters into hexadecimal numbers
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class ASCIIToHexConvert {

	/**
	 * Constructor
	 * 
	 */
	public ASCIIToHexConvert(){		
	}
	
	/**
	 * 
	 * This method returns a String with hex representations of each character in the provided String
	 *
	 * @param ascii The String to convert
	 * @return A String with hex representations
	 */
	public String convertASCIIToHex(String ascii){		
		String hexString = "";
		
		for(int i=0; i<ascii.length(); i++){
            hexString = new StringBuffer().append(hexString).append(findHexValue(ascii.charAt(i))).toString();
		}		
		return hexString;
	}
	
	/**
	 * 
	 * This method has a switch case structure that contains the hex values for the symbols:
	 * 0-9, A-Z and a-z
	 *
	 * @param input The char to convert to hex
	 * @return The retrived hex value, "00" is returned in cases where no value is found in the switch
	 */
	private String findHexValue(char input){
		
		String hex = "";
		
		switch(input){
			case '0' : hex = "30"; break; case 'V' : hex = "56"; break;
			case '1' : hex = "31"; break; case 'W' : hex = "57"; break; 
			case '2' : hex = "32"; break; case 'X' : hex = "58"; break; 
			case '3' : hex = "33"; break; case 'Y' : hex = "59"; break; 
			case '4' : hex = "34"; break; case 'Z' : hex = "5A"; break; 
			case '5' : hex = "35"; break; case 'a' : hex = "61"; break; 
			case '6' : hex = "36"; break; case 'b' : hex = "62"; break; 
			case '7' : hex = "37"; break; case 'c' : hex = "63"; break; 
			case '8' : hex = "38"; break; case 'd' : hex = "64"; break; 
			case '9' : hex = "39"; break; case 'e' : hex = "65"; break; 
			case 'A' : hex = "41"; break; case 'f' : hex = "66"; break; 
			case 'B' : hex = "42"; break; case 'g' : hex = "67"; break; 
			case 'C' : hex = "43"; break; case 'h' : hex = "68"; break; 
			case 'D' : hex = "44"; break; case 'i' : hex = "69"; break; 
			case 'E' : hex = "45"; break; case 'j' : hex = "6A"; break; 
			case 'F' : hex = "46"; break; case 'k' : hex = "6B"; break; 
			case 'G' : hex = "47"; break; case 'l' : hex = "6C"; break; 
			case 'H' : hex = "48"; break; case 'm' : hex = "6D"; break; 
			case 'I' : hex = "49"; break; case 'n' : hex = "6E"; break; 
			case 'J' : hex = "4A"; break; case 'o' : hex = "6F"; break; 
			case 'K' : hex = "4B"; break; case 'p' : hex = "70"; break; 
			case 'L' : hex = "4C"; break; case 'q' : hex = "71"; break; 
			case 'M' : hex = "4D"; break; case 'r' : hex = "72"; break; 
			case 'N' : hex = "4E"; break; case 's' : hex = "73"; break; 
			case 'O' : hex = "4F"; break; case 't' : hex = "74"; break; 
			case 'P' : hex = "50"; break; case 'u' : hex = "75"; break; 
			case 'Q' : hex = "51"; break; case 'v' : hex = "76"; break; 
			case 'R' : hex = "52"; break; case 'w' : hex = "77"; break; 
			case 'S' : hex = "53"; break; case 'x' : hex = "78"; break; 
			case 'T' : hex = "54"; break; case 'y' : hex = "79"; break; 
			case 'U' : hex = "55"; break; case 'z' : hex = "7A"; break; 
			
			default:
				hex = "00";
			
		}
		
		// the retrived hex value
		return hex;
	}
}
