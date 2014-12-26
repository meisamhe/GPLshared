package board;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class TextFilter {
  public static final char CH07 = (char) 7;
  public static final char CH10 = (char) 10;
  public static final char CH13 = (char) 13;
  public static final char[] DEFAULT_FORBIDDEN_CHARACTERS =
    { CH07, CH10, CH13 };
  public static final char SPACE = (char) 32;

  public static String filterForbiddenCharacters (
    String s, char[] forbidden) {
    if (s == null || s.trim().length() <= 0) return s;
      for (int i = 0; i<forbidden.length; i++) {
        char c = forbidden[i];
        s = s.replace (c, SPACE);
      }
      return s;
    }
  }
