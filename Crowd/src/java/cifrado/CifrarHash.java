/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cifrado;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.MessageDigestAlgorithms;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class CifrarHash {
    public String CifrarMD5(String clave) throws NoSuchAlgorithmException{
    MessageDigest md = MessageDigest.getInstance(MessageDigestAlgorithms.MD5);
      md.update(clave.getBytes());
      byte[] digest = md.digest();
      String nuevaClave = "";
      // Se escribe byte a byte en hexadecimal
      for (byte b : digest) {
          nuevaClave = Integer.toHexString(0xFF & b);
         System.out.print(nuevaClave);
      }
      System.out.println();

      // Se escribe codificado base 64. Se necesita la librería
      // commons-codec-x.x.x.jar de Apache
      byte[] encoded = Base64.encodeBase64(digest);
      System.out.println(new String(encoded));
    return nuevaClave;
    }
}
