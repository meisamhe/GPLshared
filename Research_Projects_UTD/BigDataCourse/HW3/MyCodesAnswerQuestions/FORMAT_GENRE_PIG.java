// program to be used in PIG to reformate GENRE
// Children's ==> 1) Children's mxh109420
// Animation|Children's ==> 1) Children's & 2) Animation mxh109420
// Children's|Adventure|Animation ==> 1) Children's, 2) Adventure & 3) Animation mxh109420
// Written by Meisam Hejazi Nia
// March 23rd, 2015

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.pig.EvalFunc;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;

public class FORMAT_GENRE_PIG extends EvalFunc <String> {

@Override
    public String exec(Tuple input) {
		int genreCount = -2;
		String output = "";
        try {
            if (input == null || input.size() == 0) {
                return null;
            }

            String str = (String) input.get(0);
			// First split Genre by the seperator '|'
			String[] separated = str.split("\\|");
            genreCount = separated.length;
            
			if (genreCount == 1){
				output+="1) ";
				output+=separated[0];
				output+=" mxh109420";
				return output;
			}else{
					if (genreCount == 2){
							output+="1) ";
							output+=separated[0];
							output+=" & 2) ";
							output+=separated[1];
							output+=" mxh109420";
							return output;
				   }else{
						output+="1) ";
						output+=separated[0];
						output+=", 2) ";
						output+=separated[1];
						output+=" & 3) ";
						output+=separated[2];
						output+=" mxh109420";
						return output;
				
				   }
			}
        } catch (ExecException ex) {
            System.out.println("Meisam Error: " + ex.toString());
        }
		output +="Exited with Error, with the followingNumber Of genre:";
		output += Integer.toString(genreCount);
        return output;
    }
}