// =========================================================
//Big Data Homework one one IMDB basic statistics
// Code written by: Meisam Hejazi Nia
// Date: 02/01/2015
// Part 1: list all male user id, whose age is less or equal to 7
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
        
public class HW1Q1 {
        
 public static class HW1Q1Map extends Mapper<LongWritable, Text, Text, Text> {
    //private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
    private Text userIDvalue = new Text();
        
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        // Meisam changed tokenizer to recognize :: as delimiter
        StringTokenizer tokenizer = new StringTokenizer(line,"::",false);
        //StringTokenizer tokenizer = new StringTokenizer(line);
        
        //extract elements
        String userID=tokenizer.nextToken();
        String gender = tokenizer.nextToken();
        String age = tokenizer.nextToken();
        if ((Integer.parseInt(age)<= 7) && gender.equals("M")){
        	word.set("M 7");
        	userIDvalue.set(userID);
        	context.write(word, userIDvalue);
        }
        
//        while (tokenizer.hasMoreTokens()) {
//            word.set(tokenizer.nextToken());
//            context.write(word, one);
//        }
    }
 } 
        
 public static class HW1Q1Reduce extends Reducer<Text, Text, Text, Text> {

    public void reduce(Text key, Iterable<Text> values, Context context) 
      throws IOException, InterruptedException {
    	
    	String newLine = System.getProperty("line.separator");//This will retrieve line separator dependent on OS.
    	// use new line as separator
    	String output = "";
    	
        //int sum = 0;
        for (Text val : values) {
        	output += val+" "+key + newLine;
            //sum += val.get();
        }
        Text header = new Text();
       // context.write(key, new IntWritable(sum));
        header.set("UserID,Gender,AgeCategory"+newLine);
        context.write(header, new Text(output));
    }
 }
        
 public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
        
    Job job = new Job(conf, "hw1q1");
    
    String className = args[0];
    if (className.equals("HW1Q1")){
        job.setJarByClass(HW1Q1.class);
    }

    
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);
        
    job.setMapperClass(HW1Q1Map.class);
    job.setReducerClass(HW1Q1Reduce.class);
        
    job.setInputFormatClass(TextInputFormat.class);
    job.setOutputFormatClass(TextOutputFormat.class);
        
    FileInputFormat.addInputPath(job, new Path(args[1]));
    FileOutputFormat.setOutputPath(job, new Path(args[2]));
        
    job.waitForCompletion(true);
 }
        
}