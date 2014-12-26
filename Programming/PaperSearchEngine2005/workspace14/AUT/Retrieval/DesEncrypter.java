 package Retrieval;

import java.io.UnsupportedEncodingException;
import javax.crypto.*;


 public class DesEncrypter {
    Cipher ecipher;
    Cipher dcipher;

    public DesEncrypter(SecretKey key) {
        try {
            ecipher = Cipher.getInstance("DES");
            dcipher = Cipher.getInstance("DES");
            ecipher.init(Cipher.ENCRYPT_MODE, key);
            dcipher.init(Cipher.DECRYPT_MODE, key);

        } catch (javax.crypto.NoSuchPaddingException e) {
        	System.out.println(e.getMessage());
        } catch (java.security.NoSuchAlgorithmException e) {
        	System.out.println(e.getMessage());
        } catch (java.security.InvalidKeyException e) {
        	System.out.println(e.getMessage());
        }
    }

    public String encrypt(String str) {
        try {
            // Encode the string into bytes using utf-8
            byte[] utf8 = str.getBytes("UTF8");

            // Encrypt
            byte[] enc = ecipher.doFinal(utf8);

            // Encode bytes to base64 to get a string
            return new sun.misc.BASE64Encoder().encode(enc);
        } catch (javax.crypto.BadPaddingException e) {
        	System.out.println(e.getMessage());
        } catch (IllegalBlockSizeException e) {
        	System.out.println(e.getMessage());
        } catch (UnsupportedEncodingException e) {
        	System.out.println(e.getMessage());
        }
        return null;
    }

    public String decrypt(String str) {
        try {
            // Decode base64 to get bytes
            byte[] dec = new sun.misc.BASE64Decoder().decodeBuffer(str);

            // Decrypt
            byte[] utf8 = dcipher.doFinal(dec);

            // Decode using utf-8
            return new String(utf8, "UTF8");
        } catch (javax.crypto.BadPaddingException e) {
        	System.out.println(e.getMessage());
        } catch (IllegalBlockSizeException e) {
        	System.out.println(e.getMessage());
        } catch (UnsupportedEncodingException e) {
        	System.out.println(e.getMessage());
        } catch (java.io.IOException e) {
        	System.out.println(e.getMessage());
        }
        return null;
    }
}
