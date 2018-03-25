// =========================================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 03/05/2015
// Part 1: top 10 movies rated by female: output (title, average rating by female)
// =========================================================

import java.io.IOException;


import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;


public class HW2Q1 { 
	
	//The Mapper classes first and  then the reducer  code
	
	//==========================================================================================	
	// The first mapper that takes the movie title file and
	// emits 'A::movieID,movie Title' to make sure that it comes first to be kept in a hash table in the reducer
	//==========================================================================================	
	
	public static class Map1 extends Mapper<LongWritable, Text, Text, Text>{
		private Text myTitle = new Text();
		private Text movieid = new Text();  // type of output key 
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			String[] mydata = value.toString().split("::");
			//System.out.println(value.toString());
			String title = mydata[1];
			myTitle.set( title);
			movieid.set("A::" + mydata[0].trim());
			context.write(movieid, myTitle);

		}

	}
	
	//==========================================================================================	
	// The second mapper takes the user file and filters it on females
	// so it emits 'B::UserID,""' 
	//==========================================================================================	
	public static class Map2 extends Mapper<LongWritable, Text, Text, Text>{
		private Text fuserIDk = new Text();
		private Text fuserIDv = new Text();  // type of output key 
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			
			// Meisam changed tokenizer to recognize :: as delimiter
			String[] mydata = value.toString().split("::");
	        
	        //extract elements
	        String userID=mydata[0].trim();
	        String gender = mydata[1].trim();
	        String age = mydata[2].trim();		
	        
	        if (gender.equals("F")){
	        	        	
	        	//System.out.println(value.toString());
				fuserIDk.set("B::"+ userID);
				fuserIDv.set(userID);
				context.write(fuserIDk, fuserIDv);
	        }
		}
	}
	
	//==========================================================================================	
	// The third mapper takes the rating file and emits every ratings
	// so it emits 'C::UserID,"movieID::rating"' 
	//==========================================================================================
	
	public static class Map3 extends Mapper<LongWritable, Text, Text, Text>{
		String mymovieid;

		@Override
		protected void setup(Context context)
				throws IOException, InterruptedException {
			// TODO Auto-generated method stu
			super.setup(context);

			Configuration conf = context.getConfiguration();
			//mymovieid = conf.get("movieid"); // to retrieve movieid set in main method

		}

		private Text userID = new Text(); 
		private Text movieIDRating = new Text();  // type of output key 
		
		
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			String[] mydata = value.toString().split("::");
			///	System.out.println(value.toString());
			String userIDtemp = mydata[0];
			String movieID = mydata[1];
			String rate = mydata[2];
			userID.set("C::"+userIDtemp.trim());
			movieIDRating.set(movieID.trim()+"::"+rate.trim());
			context.write(userID, movieIDRating);
		}
	}


	
	//The reducer class	
	public static class Reduce extends Reducer<Text,Text,Text,Text> {
		private Text titleKey = new Text();
		private Text ratingValue = new Text();
		//note you can create a list here to store the values
		private Map<String, String> movieIDMap = new HashMap<String, String>();
		private Map<String, String> userIDMap = new HashMap<String, String>();
		private Map<String, Integer> countMap = new HashMap<String, Integer>();
		private Map<String, Integer> sumMap = new HashMap<String, Integer>();
		
		
		public void reduce(Text key, Iterable<Text> values,Context context ) throws IOException, InterruptedException {

			String[] mydata = key.toString().split("::");
			String table   = mydata[0].trim();
			String keyCore = mydata[1].trim();

			for (Text val : values) {
				// in case it comes from the first table of movie title keep the movie ID and the movie title 
				// in the dictionary
				if (table.equals("A")){
					movieIDMap.put(keyCore, val.toString());
				}else{
					// in case it comes from the second table of userID keep the user ID in the dictionary
					if (table.equals("B")){
						userIDMap.put(keyCore, val.toString());
					}else{
						// in case it comes on the third table make sure that the user is female by checking whether
						// it exists in the userID of females
						if (table.equals("C")){
							String valueExists = userIDMap.get(keyCore);
							if (valueExists != null) { // mKe sure that the user who has rated exists
								String[] mydataVal = val.toString().split("::");
								String movieID   = mydataVal[0].trim();
								int rating = Integer.parseInt(mydataVal[1].trim());
								
								Integer curCount = countMap.get(movieID);
								Integer curSum = sumMap.get(movieID);
								
								// check if this is the first occurrence of the movie in the rating
								if (curCount == null){
									curSum = rating;
									curCount = 1;
									countMap.put(movieID, curCount);
									sumMap.put(movieID, curSum);
								}else{ // if this is NOT the first occurrence of the movie in the rating
									curSum = curSum + rating;
									curCount = curCount + 1;
									countMap.put(movieID, curCount);
									sumMap.put(movieID, curSum);
								} // end of else loop of occurrence of movie in the ratings
							} // end of if loop for female rating only consideration
						} // end of else loop of "C"
					} // end of else loop of "B"
				} // end of else loop of "A"

			} // end of for loop
		}// end of reducer function
		
		
		protected void cleanup (Context context) throws IOException, InterruptedException{
			// output only top ten records
			//create a treemap to keep the ratings sorted, and easy to fetch
			TreeMap<Float,String> ratingToRecordMap = new TreeMap<Float,String>();
			for (String movieID: countMap.keySet()){
				Float averageRating =  sumMap.get(movieID).floatValue() /countMap.get(movieID).floatValue();
				ratingToRecordMap.put(averageRating.toString()+movieID, movieID);
				System.out.println("currently working on"+averageRating.toString()+", "+movieID);
				// Make sure I only keep top 10
				if (ratingToRecordMap.size()>5){
					ratingToRecordMap.remove(ratingToRecordMap.firstKey());
				}
			}
			
			for (Float ratingAvg:ratingToRecordMap.descendingMap().keySet()){
				// output our top ten movie average rated by female consumers, with title as key, and average rating by 
				// female as value
				// first fetch the movie ID
				String movieID = ratingToRecordMap.get(ratingAvg);
				// second fetch the movie Title
				String title = movieIDMap.get(movieID);
				titleKey.set(title);
				ratingValue.set(ratingAvg.toString());
				// output the title and average rating
				context.write(titleKey,ratingValue);
			}
		} // end of the cleanup function
		
	} // end of reducer class


	//Driver code
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		// get all args
		if (otherArgs.length != 5) {
			//hadoop jar HW2Q1.jar HW2Q1 HW1Movies HW1Users HW2Ratings outHW2Q1
			System.err.println("Usage: HW2Q1 <in> <in2> <in3> <out> <anymovieid>");
			System.exit(2);
		}


		//conf.set("movieid", otherArgs[4]); //setting global data variable for hadoop

		// create a job with name "joinexc" 
		Job job = new Job(conf, "joinexc"); 
		job.setJarByClass(HW2Q1.class);

		// set the number of reducer to 1
		job.setNumReduceTasks(1);

		job.setReducerClass(Reduce.class);

		// OPTIONAL :: uncomment the following line to add the Combiner
		// job.setCombinerClass(Reduce.class);
		
		// the otherArgs[1] is HW1Movies
		MultipleInputs.addInputPath(job, new Path(otherArgs[1]), TextInputFormat.class ,
				Map1.class );

		// the otherArgs[2] is HW1Users 
		MultipleInputs.addInputPath(job, new Path(otherArgs[2]),TextInputFormat.class,Map2.class );
		
		
		// the otherArgs[3] is HW2Ratings
		MultipleInputs.addInputPath(job, new Path(otherArgs[3]), TextInputFormat.class ,
				Map3.class );
		

		job.setOutputKeyClass(Text.class);
		// set output value type
		job.setOutputValueClass(Text.class);

		//set the HDFS path of the input data
		// set the HDFS path for the output 
		FileOutputFormat.setOutputPath(job, new Path(otherArgs[4]));

		job.waitForCompletion(true);


	}




}



