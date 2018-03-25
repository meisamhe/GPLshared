package org.apache.spark.examples.streaming
/* SimpleApp.scala */
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

import java.util.Properties

object SimpleApp {
  def main(args: Array[String]) {
    val logFile = "/home/gbaduz/money" // Should be some file on your system
    val conf = new SparkConf().setAppName("Simple Application")
	conf.setMaster("local[2]")
    val sc = new SparkContext(conf)
    val logData = sc.textFile(logFile, 2).cache()
    val numAs = logData.filter(line => line.contains("a")).count()
    val numBs = logData.filter(line => line.contains("b")).count()
    println("Lines with a: %s, Lines with b: %s".format(numAs, numBs))
  }
}
