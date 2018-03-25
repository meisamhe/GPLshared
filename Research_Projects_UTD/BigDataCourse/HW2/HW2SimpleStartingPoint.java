
import java.io.IOException;


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


public class HW2SimpleStartingPoint {

	//The Mapper classes and  reducer  code
	public static class Map1 extends Mapper<LongWritable, Text, Text, Text>{
		String mymovieid;

		@Override
		protected void setup(Context context)
				throws IOException, InterruptedException {
			// TODO Auto-generated method stu
			super.setup(context);

			Configuration conf = context.getConfiguration();
			mymovieid = conf.get("movieid"); // to retrieve movieid set in main method

		}


		private Text rating;
		private Text movieid = new Text();  // type of output key 
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			String[] mydata = value.toString().split("::");
			///	System.out.println(value.toString());
			String intrating = mydata[2];
			rating = new Text("rat~" + intrating);
			movieid.set(mydata[1].trim());
			context.write(movieid, rating);


		}


	}


	public static class Map2 extends Mapper<LongWritable, Text, Text, Text>{
		private Text myTitle = new Text();
		private Text movieid = new Text();  // type of output key 
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			String[] mydata = value.toString().split("::");
			System.out.println(value.toString());
			String title = mydata[1];
			myTitle.set("mov~" + title);
			movieid.set(mydata[0].trim());
			context.write(movieid, myTitle);


		}


	}
	//The reducer class	
	public static class Reduce extends Reducer<Text,Text,Text,Text> {
		private Text result = new Text();
		private Text myKey = new Text();
		//note you can create a list here to store the values

		public void reduce(Text key, Iterable<Text> values,Context context ) throws IOException, InterruptedException {


			for (Text val : values) {
				result.set(val.toString());
				myKey.set(key.toString());
				if(key.toString().trim().compareTo("2")== 0){
				context.write(myKey,result );
				}

			}



		}		
	}


	//Driver code
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		// get all args
		if (otherArgs.length != 5) {
			// hadoop jar HW2Q1.jar HW2Q1 HW2Ratings HW1Movies outHW2Q1 12333
			System.err.println("Usage: HW2Q1 <in> <in2> <out> <anymovieid>");
			System.exit(2);
		}


		conf.set("movieid", otherArgs[4]); //setting global data variable for hadoop

		// create a job with name "joinexc" 
		Job job = new Job(conf, "joinexc"); 
		job.setJarByClass(HW2SimpleStartingPoint.class);


		job.setReducerClass(Reduce.class);

		// OPTIONAL :: uncomment the following line to add the Combiner
		// job.setCombinerClass(Reduce.class);


		MultipleInputs.addInputPath(job, new Path(otherArgs[1]), TextInputFormat.class ,
				Map1.class );

		MultipleInputs.addInputPath(job, new Path(otherArgs[2]),TextInputFormat.class,Map2.class );

		job.setOutputKeyClass(Text.class);
		// set output value type
		job.setOutputValueClass(Text.class);

		//set the HDFS path of the input data
		// set the HDFS path for the output 
		FileOutputFormat.setOutputPath(job, new Path(otherArgs[3]));

		job.waitForCompletion(true);


	}




}



