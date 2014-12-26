package Retrieval;

import java.security.*;

import javax.crypto.*;

/**
 *  Security Services (Open Source - none).
 *
 *  @author     douran
 *  @version    $Id: Secure.java,v 1.1 2005/04/29 04:48:58 bahramian Exp $
 */
public class Secure
{
	/*************************************************************************/

	private static Cipher 			s_cipher = null;
	private static SecretKey 		s_key = null;

	/** Clear Text Indiactor		**/
	public static final String		CLEARTEXT = "xyz";

	/**
	 * 	Initialize Cipher & Key
	 */
	private static void initCipher()
	{
		try
		{
			s_cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
			//	Key
			if (false)
			{
				KeyGenerator keygen = KeyGenerator.getInstance("DES");
				s_key = keygen.generateKey();
				byte[] key = s_key.getEncoded();
				System.out.print("Key " + s_key.getAlgorithm() + "(" + key.length + ")= ");
				for (int i = 0; i < key.length; i++)
					System.out.print(key[i] + ",");
				System.out.println("");
			}
			else
				s_key = new javax.crypto.spec.SecretKeySpec(new byte[] {100,25,28,-122,-26,94,-3,-26}, "DES");
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}	//	initCipher

	/**
	 *	Encryption
	 *  @param value clear value
	 *  @return encrypted String
	 */
	public static String encrypt (String value)
	{
		String clearText = value;
		if (clearText == null)
			clearText = "";
		//	Init
		if (s_cipher == null)
			initCipher();
		//	Encrypt
		if (s_cipher != null)
		{
			try
			{
				s_cipher.init(Cipher.ENCRYPT_MODE, s_key);
				byte[] encBytes = s_cipher.doFinal(clearText.getBytes());
				String encString = convertToHexString(encBytes);
			//	System.out.println("Secure.encrypt=" + encString);
				return encString;
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}
		return CLEARTEXT + value;
	}   //  encrypt

	/**
	 *	Decryption
	 *  @param value encrypted value
	 *  @return decrypted String
	 */
	public static String decrypt (String value)
	{
		if (value == null)
			return null;
		if (value.length() == 0)
			return value;
		if (value.startsWith(CLEARTEXT))
			return value.substring(3);
		//	Init
		if (s_cipher == null)
			initCipher();

		//	Encrypt
		if (s_cipher != null && value != null && value.length() > 0)
		{
			try
			{
				AlgorithmParameters ap = s_cipher.getParameters();
				s_cipher.init(Cipher.DECRYPT_MODE, s_key, ap);
				byte[] out = s_cipher.doFinal(convertHexString(value));
			//	System.out.println ("Secure.decrypt=" + value + " => " + new String(out));
				return new String(out);
			}
			catch (Exception ex)
			{
				System.err.println ("Secure.decrypt=" + value + " - " + ex.getLocalizedMessage());
			//	ex.printStackTrace();
			}
		}
		return value;
	}   //  decrypt

	/*************************************************************************/

	/**
	 *	Hash checksum number
	 *  @param key key
	 *  @return checksum number
	 */
	public static int hash (String key)
	{
		long tableSize = 2147483647;	// one less than max int
		long hashValue = 0;

		for (int i = 0; i < key.length(); i++)
			hashValue = (37 * hashValue) + (key.charAt(i) -31);

		hashValue %= tableSize;
		if (hashValue < 0)
			hashValue += tableSize;

		int retValue = (int)hashValue;
		return retValue;
	}	//	hash

	/*************************************************************************/

	/**
	 *  Convert Message to Digest.
	 *  JavaScript version see - http://pajhome.org.uk/crypt/md5/index.html
	 *
	 *  @param message message
	 *  @return HexString of message (length = 32 characters)
	 */
	public static String getDigest (String message)
	{
		MessageDigest md = null;
		try
		{
			md = MessageDigest.getInstance("MD5");
		//	md = MessageDigest.getInstance("SHA-1");
		}
		catch (NoSuchAlgorithmException nsae)
		{
			nsae.printStackTrace();
		}
		//	Reset MessageDigest object
		md.reset();
		//	Convert String to array of bytes
		byte[] input = message.getBytes();
		//	feed this array of bytes to the MessageDigest object
		md.update(input);
		//	 Get the resulting bytes after the encryption process
		byte[] output = md.digest();
		md.reset();
		//
		return convertToHexString(output);
	}   //  getDigest

	/**
	 * 	Checks, if value is a valid digest
	 *  @param value digest string
	 *  @return true if valid digest
	 */
	public static boolean isDigest (String value)
	{
		if (value == null || value.length() != 32)
			return false;
		//	needs to be a hex string, so try to convert it
		return (convertHexString(value) != null);
	}	//	isDigest

	
	/**************************************************************************
	 *  Convert Byte Array to Hex String
	 *  @param bytes bytes
	 *  @return HexString
	 */
	static private String convertToHexString (byte[] bytes)
	{
		//	see also Util.toHex
		int size = bytes.length;
		StringBuffer buffer = new StringBuffer(size*2);
		for(int i=0; i<size; i++)
		{
			// convert byte to an int
			int x = bytes[i];
			// account for int being a signed type and byte being unsigned
			if (x < 0)
				x += 256;
			String tmp = Integer.toHexString(x);
			// pad out "1" to "01" etc.
			if (tmp.length() == 1)
				buffer.append("0");
			buffer.append(tmp);
		}
		return buffer.toString();
	}   //  convertToHexString


	/**
	 *  Convert Hex String to Byte Array
	 *  @param hexString hex string
	 *  @return byte array
	 */
	static private byte[] convertHexString (String hexString)
	{
		int size = hexString.length()/2;
		byte[] retValue = new byte[size];
		String inString = hexString.toLowerCase();

		try
		{
			for (int i = 0; i < size; i++)
			{
				int index = i*2;
				int ii = Integer.parseInt(inString.substring(index, index+2), 16);
				retValue[i] = (byte)ii;
			}
			return retValue;
		}
		catch (Exception e)
		{
		//	System.err.println("Secure.convertHexString error - " + e.getMessage());
		}
		return null;
	}   //  convertToHexString

	/*************************************************************************/

	/**
	 * 	Test
	 * 	@param args ignored
	 */
	public static void main (String[] args)
	{
		String[] testString = new String[]
			{"This is a test!", "", "This is a verly long test string 1624$%"};
		String[] digestResult = new String[]
			{"702edca0b2181c15d457eacac39de39b", "d41d8cd98f00b204e9800998ecf8427e", "934e7c5c6f5508ff50bc425770a10f45"};

		for (int i = 0; i < testString.length; i++)
		{
			String digestString = getDigest(testString[i]);
			if (digestResult[i].equals(digestString))
				System.out.println("OK - digest");
			else
				System.err.println("Digest=" + digestString + " <> " + digestResult[i]);
		}

		System.out.println("IsDigest true=" + isDigest(digestResult[0]));
		System.out.println("IsDigest false=" + isDigest("702edca0b2181c15d457eacac39DE39J"));
		System.out.println("IsDigest false=" + isDigest("702e"));

	//	-----------------------------------------------------------------------

	//	System.out.println(convertToHexString(new byte[]{Byte.MIN_VALUE, -1, 1, Byte.MAX_VALUE} ));
		//
		String in = "4115da655707807F00FF";
		byte[] bb = convertHexString(in);
		String out = convertToHexString(bb);
		if (in.equalsIgnoreCase(out))
			System.out.println("OK - conversion");
		else
			System.err.println("Conversion Error " + in + " <> " + out );

	//	-----------------------------------------------------------------------

		String test = "This is a test!!";
		String result = "28bd14203bcefba1c5eaef976e44f1746dc2facaa9e0623c";
		//
		String test_1 = decrypt(result);
		if (test.equals(test_1))
			System.out.println("OK - dec_1");
		else
			System.out.println("TestDec=" + test_1 + " <> " + test);

	//	-----------------------------------------------------------------------

		String testEnc = encrypt(test);
		if (result.equals(testEnc))
			System.out.println("OK - enc");
		else
			System.err.println("TestEnc=" + testEnc + " <> " + result);

		String testDec = decrypt(testEnc);
		if (test.equals(testDec))
			System.out.println("OK - dec");
		else
			System.out.println("TestDec=" + testDec + " <> " + test);


	}	//	main

}   //  Secure
