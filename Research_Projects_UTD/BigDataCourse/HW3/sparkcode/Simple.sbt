name := "Simple Project"

version := "1.0"

scalaVersion := "2.10.4"

libraryDependencies += "org.apache.spark" %% "spark-core" % "1.3.0"

mainClass in (Compile,run) := Some("org.apache.spark.examples.streaming.SimpleApp")
