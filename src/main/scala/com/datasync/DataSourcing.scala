package com.datasource

import better.files.File._
import sys.process._
import java.net.URL
import net.jcazevedo.moultingyaml._



case class DataSync(var project: String, var sourceRootPath: String, var sourceRelativePaths: Seq[String], var sourceFormat: String, var targetPath: String) 

object DataSyncYaml extends DefaultYamlProtocol {
        implicit val datasyncFormat = yamlFormat5(DataSync)
}
object DataSourcing {
    def main(args: Array[String]): Unit = {
          import better.files._
          import DataSyncYaml._
          val dataToSync = File(args(0)).contentAsString.parseYaml.convertTo[DataSync]
          println(s"Preparing to sync $dataToSync")
          executeDataSync(dataToSync)
    }

    def executeDataSync(ds : DataSync) : Unit = {
        import better.files._
        var targetRoot = s"${ds.targetPath}${ds.project}/"
        targetRoot.toFile.createIfNotExists(true)
        targetRoot.toFile.delete()
        val sourceTarget  = ds.sourceRelativePaths.isEmpty match {
              case false => ds.sourceRelativePaths.map(relativePath => s"${ds.sourceRootPath}$relativePath.${ds.sourceFormat}" ->  s"${targetRoot}$relativePath.${ds.sourceFormat}")
              case true => Map(s"${ds.sourceRootPath}" -> s"${targetRoot}${ds.sourceFormat}")
        
        }
        
        sourceTarget.foreach{case (source,target) =>   
                println(s"Syncing from $source")
                s"/tmp/datasync/${targetRoot}".toFile.createIfNotExists(true)
                new URL(source) #> File("/tmp/datasync/"+target).toJava !!

                s"${targetRoot}".toFile.createIfNotExists(true)
                target.split("\\.").last match {
                  case "zip" => File(s"/tmp/datasync/$target").unzipTo(destination = File(s"${targetRoot}"))
                  case _ => File(s"/tmp/datasync/$target").moveTo(File(target))
                }
                println(s"Written to $target")
          }
                File(s"/tmp/datasync").delete()
        }
}
