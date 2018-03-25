// program to be used in PIG to reformate GENRE
// Children's ==> 1) Children's mxh109420:hive
// Animation|Children's ==> 1) Children's & 2) Animation mxh109420:hive
// Children's|Adventure|Animation ==> 1) Children's, 2) Adventure & 3) Animation mxh109420:hive
// Written by Meisam Hejazi Nia
// March 24rd, 2015

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.io.Text;

@Description(name = "FORMAT_GENRE_HIVE",
value = "_FUNC_(str) - Reformats the Genre that it receives, e.g. Children's ==> 1) Children's mxh109420 :hive, Animation|Children's ==> 1) Children's & 2) Animation mxh109420 :hive, Children's|Adventure|Animation ==> 1) Children's, 2) Adventure & 3) Animation mxh109420 :hive",
extended = "Example:\n"
+ "  > SELECT Title,FORMAT_GENRE_HIVE(GENRE) FROM movies m;")

public class FORMAT_GENRE_HIVE extends UDF {
    public Text evaluate(Text s) {		
		Text to_value = new Text("");
		int genreCount = -2;
		String output = "";
        try {
            String str = s.toString();
			// First split Genre by the seperator '|'
			String[] separated = str.split("\\|");
            genreCount = separated.length;
            
			if (genreCount == 1){
				output+="1) ";
				output+=separated[0];
				output+=" mxh109420 :hive";
				to_value.set(output);
				return to_value;
			}else{
					if (genreCount == 2){
							output+="1) ";
							output+=separated[0];
							output+=" & 2) ";
							output+=separated[1];
							output+=" mxh109420 :hive";
							to_value.set(output);
							return to_value;
				   }else{
						output+="1) ";
						output+=separated[0];
						output+=", 2) ";
						output+=separated[1];
						output+=" & 3) ";
						output+=separated[2];
						output+=" mxh109420 :hive";
						to_value.set(output);
						return to_value;
				
				   }
			}
        } catch (Exception ex) {
            System.out.println("Meisam Error: " + ex.toString());
        }
		output +="Exited with Error, with the followingNumber Of genre:";
		output += Integer.toString(genreCount);
		to_value.set(output);
        return to_value;
		
    }
}
