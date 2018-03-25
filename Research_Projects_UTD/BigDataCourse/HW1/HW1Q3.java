// =========================================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 02/01/2015
// Part 3: List all movie titles where genre is "Fantasy"
// =========================================================

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
        
public class HW1Q3 {
	public static String genre= "Fantasy";
        
 public static class HW1Q3Map extends Mapper<LongWritable, Text, Text, Text> {
    //private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
    private Text movieTitlevalue = new Text();
    private String genre="Fantasy";
        
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        // Meisam changed tokenizer to recognize :: as delimiter
        StringTokenizer tokenizer = new StringTokenizer(line,"::",false);
        //StringTokenizer tokenizer = new StringTokenizer(line);
        
        //extract elements
        String movieID=tokenizer.nextToken();
        String movieTitle = tokenizer.nextToken();
        String genreListString = tokenizer.nextToken();
        
        // extract genre
        StringTokenizer genreTokenizer = new StringTokenizer(genreListString,"|",false);
        
        // first elemnt to test
        //String firstElement = genreTokenizer.nextToken();
        String lastElement = "";
        boolean genreSwitch = false;
		while (genreTokenizer.hasMoreTokens()) {
			  lastElement = genreTokenizer.nextToken();
		      if (lastElement.equals(genre)){
		    	  genreSwitch = true;
		      }
		    //  context.write(word, one);
		 }

        if (genreSwitch==true){
        	word.set(genre);
        	movieTitlevalue.set(movieTitle);
        	context.write(word, movieTitlevalue);
        }
    }
    @Override
    protected void setup(Context context) throws IOException,
            InterruptedException {
        Configuration conf = context.getConfiguration();

        genre = conf.get("genre");
    }
 } 
        
 public static class HW1Q3Reduce extends Reducer<Text, Text, Text, Text> {
	private String genre="Fantasy";

    public void reduce(Text key, Iterable<Text> values, Context context) 
      throws IOException, InterruptedException {
    	
    	String newLine = System.getProperty("line.separator");//This will retrieve line separator dependent on OS.
    	// use new line as separator
    	String output = "";
    	
        //int sum = 0;
        for (Text val : values) {
        	output += val+","+key+newLine;
            //sum += val.get();
        }
        Text header = new Text();
       // context.write(key, new IntWritable(sum));
        header.set("Movie Titles for genre:"+genre+newLine);
        context.write(header, new Text(output));
    }
    @Override
    protected void setup(Context context) throws IOException,
            InterruptedException {
        Configuration conf = context.getConfiguration();

        genre = conf.get("genre");
    }
 }
        
 public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
        
    Job job = new Job(conf, "hw1q1");
    
    String className = args[0];
    if (className.equals("HW1Q3")){
        job.setJarByClass(HW1Q3.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
            
        job.setMapperClass(HW1Q3Map.class);
        job.setReducerClass(HW1Q3Reduce.class);
            
        job.setInputFormatClass(TextInputFormat.class);
        job.setOutputFormatClass(TextOutputFormat.class);
            
        FileInputFormat.addInputPath(job, new Path(args[1]));
        FileOutputFormat.setOutputPath(job, new Path(args[2]));
        
        // Use configuration file to send the type of the Genre
        Configuration confTemp = job.getConfiguration();
        // as input: Fantasy
        String genreInput = args[3];
        confTemp.set("genre", genreInput);
        //genre = genreInput;
    }
    
    
   
        
    job.waitForCompletion(true);
 }
        
}