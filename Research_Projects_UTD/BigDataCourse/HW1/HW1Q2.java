// =========================================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 02/01/2015
// Part 2: Find a count of female and male users in each age group
// =========================================================

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.Reducer.Context;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
        
public class HW1Q2 {
        
 public static class HW1Q2Map extends Mapper<LongWritable, Text, Text, IntWritable> {
    //private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
    private final static IntWritable one = new IntWritable(1);
        
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        // Meisam changed tokenizer to recognize :: as delimiter
        StringTokenizer tokenizer = new StringTokenizer(line,"::",false);
        //StringTokenizer tokenizer = new StringTokenizer(line);
        
        //extract elements
        String userID=tokenizer.nextToken();
        String gender = tokenizer.nextToken();
        String age = tokenizer.nextToken();
        String outKey = age+" "+gender;
        word.set(outKey);
        context.write(word, one);
       
//        while (tokenizer.hasMoreTokens()) {
//            word.set(tokenizer.nextToken());
//            context.write(word, one);
//        }
    }
 } 
        
 public static class HW1Q2Reduce extends Reducer<Text, IntWritable, Text, IntWritable> {

	    public void reduce(Text key, Iterable<IntWritable> values, Context context) 
	      throws IOException, InterruptedException {
	        int sum = 0;
	        for (IntWritable val : values) {
	            sum += val.get();
	        }
	        context.write(key, new IntWritable(sum));
	    }
	 }
        
 public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
        
    Job job = new Job(conf, "hw1q2");
    
    String className = args[0];
    if (className.equals("HW1Q2")){
        job.setJarByClass(HW1Q2.class);
    }

    
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
        
    job.setMapperClass(HW1Q2Map.class);
    job.setReducerClass(HW1Q2Reduce.class);
        
    job.setInputFormatClass(TextInputFormat.class);
    job.setOutputFormatClass(TextOutputFormat.class);
        
    FileInputFormat.addInputPath(job, new Path(args[1]));
    FileOutputFormat.setOutputPath(job, new Path(args[2]));
        
    job.waitForCompletion(true);
 }
        
}