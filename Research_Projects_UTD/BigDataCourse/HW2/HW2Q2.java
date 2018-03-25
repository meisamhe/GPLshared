// =========================================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 03/05/2015
// Part 2: Given the id of a movie, find all userids,gender and age of users who rated the
// movie 4 or greater.
// You will input the movie id from command line.
// =========================================================



import java.io.IOException;

import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.filecache.DistributedCache;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;


public class HW2Q2 {

	//The Mapper classes and  reducer  code
	public static class Map1 extends Mapper<LongWritable, Text, Text, Text>{
		String mymovieid;
		
		private static HashMap<String, String> userMap = new HashMap<String, String>();
		private BufferedReader brReader;

		private Text txtMapOutputKey = new Text("");
		private Text txtMapOutputValue = new Text("");
		//private Text rating;
		//private Text movieid = new Text();  // type of output key 
		
		enum MYCOUNTER {
			RECORD_COUNT, FILE_EXISTS, FILE_NOT_FOUND, SOME_OTHER_ERROR
		}
		
		@Override
		protected void setup(Context context) throws IOException,
				InterruptedException {
			
			// get the configuration to fetch the movie id, and also fetch the cache file of Distributed Cache
			super.setup(context);
			Configuration conf = context.getConfiguration();
			
			//URI[] uris = DistributedCache.getCacheFiles(conf);
			Path[] localPaths = context.getLocalCacheFiles();
			
			//Path[] cacheFilesLocal = DistributedCache.getLocalCacheFiles(conf);
			//Path path = new Path(uris[0].getPath());
			Path path = localPaths[0];
			loadUsersHashMap(path, context);
			
			/*for (Path eachPath : cacheFilesLocal) {
				if (eachPath.getName().toString().trim().equals("users.dat")) {
					context.getCounter(MYCOUNTER.FILE_EXISTS).increment(1);
					
				}
				loadUsersHashMap(eachPath, context);
			}*/
			
			mymovieid = conf.get("movieid"); // to retrieve movieid set in main method

		}
		
		
		// function to load the data of user.dat table into a hash table
		private void loadUsersHashMap(Path filePath, Context context)
				throws IOException {

			String strLineRead = "";

			try {
				brReader = new BufferedReader(new FileReader(filePath.toString()));

				// Read each line, split and load to HashMap
				while ((strLineRead = brReader.readLine()) != null) {
					String userFieldArray[] = strLineRead.split("::");
					userMap.put(userFieldArray[0].trim(),
							userFieldArray[1].trim()+","+userFieldArray[2].trim());
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				context.getCounter(MYCOUNTER.FILE_NOT_FOUND).increment(1);
			} catch (IOException e) {
				context.getCounter(MYCOUNTER.SOME_OTHER_ERROR).increment(1);
				e.printStackTrace();
			}finally {
				if (brReader != null) {
					brReader.close();
				}

			}
		}


		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			
			context.getCounter(MYCOUNTER.RECORD_COUNT).increment(1);
			
			String[] mydata = value.toString().split("::");
			///	System.out.println(value.toString());
			String userID = mydata[0].trim();
			String movieID = mydata[1].trim();
			String ratingCur = mydata[2].trim();
			
			String userIDGenderAge = userMap.get(userID);
			
			if ((Float.parseFloat(ratingCur)>=4) && (mymovieid.equals(movieID))) {
				txtMapOutputKey.set(userID);
				txtMapOutputValue.set(userIDGenderAge);
				context.write(txtMapOutputKey, txtMapOutputValue);
			}
		}

	}


	//The reducer class	
	public static class Reduce extends Reducer<Text,Text,Text,Text> {
		private Text result = new Text();
		private Text myKey = new Text();
		//note you can create a list here to store the values

		public void reduce(Text key, Iterable<Text> values,Context context ) throws IOException, InterruptedException {

			// direct emit without any modification
			for (Text val : values) {
				result.set(val.toString());
				myKey.set(key.toString());
				context.write(myKey,result );
			}
		}		
	}


	//Driver code
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		// get all args
		if (otherArgs.length != 5) {
			// hadoop jar HW2Q2.jar HW2Q2 HW2Ratings HW1Users outHW2Q2 movieID
			System.err.println("Usage: HW2Q1 <in> <in2> <out> <anymovieid>");
			System.exit(2);
		}


		conf.set("movieid", otherArgs[4]); //setting global data variable for hadoop

		// create a job with name "joinexc" 
		Job job = new Job(conf, "joinexc"); 
		job.setJarByClass(HW2Q2.class);
		job.setJobName("Map-side join with gender, age lookup file in DCache for HW2Q2 by Meisam Hejazi Nia");
		// define distributed Cache to keep the Users file in
		// DistributedCache.addCacheFile(p.toUri(), conf);
		//DistributedCache.addCacheFile(new URI("/"+otherArgs[2]+"/users.dat"),conf);
		//DistributedCache.addCacheFile(new URI("/myapp/lookup.dat#lookup.dat"), job);
		String filePath = otherArgs[2]+"/users.dat";
		job.addCacheFile(new Path(filePath).toUri());

		job.setReducerClass(Reduce.class);

		// OPTIONAL :: uncomment the following line to add the Combiner
		// job.setCombinerClass(Reduce.class);


		MultipleInputs.addInputPath(job, new Path(otherArgs[1]), TextInputFormat.class ,
				Map1.class );


		job.setOutputKeyClass(Text.class);
		// set output value type
		job.setOutputValueClass(Text.class);

		//set the HDFS path of the input data
		// set the HDFS path for the output 
		FileOutputFormat.setOutputPath(job, new Path(otherArgs[3]));

		job.waitForCompletion(true);


	}




}



