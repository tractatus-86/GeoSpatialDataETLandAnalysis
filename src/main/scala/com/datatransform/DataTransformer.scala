package com.datatransformer

import org.apache.spark.SparkFiles
import org.apache.sedona.sql.utils.SedonaSQLRegistrator
import org.apache.sedona.sql.utils.Adapter
import org.apache.sedona.core.formatMapper.shapefileParser.ShapefileReader
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.DataFrame
import net.jcazevedo.moultingyaml._


case class DataStruct(var project: String, var sourcePath: String, var sourceRelativePaths: Seq[String], var sourceFormat: String, var sqlOperation: String, var targetPath: String, var targetFormat: String, var targetWriteMode: String) 
object DataStructYaml extends DefaultYamlProtocol {
  implicit val dataStructFormat = yamlFormat8(DataStruct)
}

object DataTransformer {
  /**sparkSession loaded with all the special geometry datatypes **/
 val sparkSession :SparkSession = SparkSession.builder().
        config("spark.serializer","org.apache.spark.serializer.KryoSerializer").
        config("spark.kryo.registrator", "org.apache.sedona.core.serde.SedonaKryoRegistrator").
        master("local[*]").
        appName("DataStructure").
        getOrCreate()


  def main(args: Array[String]) :Unit = {
      // loading implicits
      import better.files._
      import DataStructYaml._
      // registering all geometry udf functions
      SedonaSQLRegistrator.registerAll(sparkSession)


      // configuration isntructions for data manipulation
      val dataToStruct = File(args(0)).contentAsString.parseYaml.convertTo[DataStruct]
      
      // special conversion for shape files
      val dfMap = dataToStruct.sourceFormat match {
        case "shape" => readShapeFile(dataToStruct)
        case _ => read(dataToStruct)
      }
      println(dataToStruct)
      val resultMap = dataToStruct.sqlOperation == "" match {
        case false =>  Map(dataToStruct.project -> sparkSession.sql(dataToStruct.sqlOperation))
        case true => dfMap
      }
     resultMap.foreach{case (name, df) => df.write.format(dataToStruct.targetFormat).mode(dataToStruct.targetWriteMode).save(dataToStruct.targetPath+name)}
    }

  /** Reads a shape file and converts it into a dataframe
   *
   *  @param ds datastruct class defining what to read
   *  @return a of the named dataframe for reference later
   */
    def readShapeFile(ds :DataStruct): Map[String,DataFrame] = {
      val spatialRDD = ShapefileReader.readToGeometryRDD(sparkSession.sparkContext, ds.sourcePath)
      val df = Adapter.toDf(spatialRDD,sparkSession)
      df.createOrReplaceTempView(ds.project)
      Map(ds.project -> df)
    }
    
    def read(ds :DataStruct): Map[String,DataFrame] = {
       val format = ds.sourceFormat match {
        case "parquet" => "/"
        case _ => "."+ds.sourceFormat
      }
      ds.sourceRelativePaths.map( name => {
        val df = sparkSession.read.format(ds.sourceFormat).option("header",true).option("inferSchema",true).load(ds.sourcePath+name+format)
        df.createOrReplaceTempView(name)
        name -> df 
        }
        ).toMap
  
    }

}
