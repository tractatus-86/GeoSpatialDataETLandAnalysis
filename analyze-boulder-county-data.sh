#!/bin/bash


spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --jars $(pwd)/target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --packages org.locationtech.geomesa:geomesa-tools_2.12:3.2.0,tech.units:indriya:2.1.2 --repositories https://repo.osgeo.org/repository/release/  target/scala-2.12/GeoSpatialDataETLandAnaysis-assembly-1.0.jar src/main/resources/configs/analyzed/Analyzed-JSON-TotalResidentialAcreageBoulderCounty.yaml

spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --jars $(pwd)/target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --packages org.locationtech.geomesa:geomesa-tools_2.12:3.2.0,tech.units:indriya:2.1.2 --repositories https://repo.osgeo.org/repository/release/  target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar src/main/resources/configs/analyzed/Analyzed-JSON-OwnerMostResidentialAcreageBoulderCounty.yaml

spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --jars $(pwd)/target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --packages org.locationtech.geomesa:geomesa-tools_2.12:3.2.0,tech.units:indriya:2.1.2 --repositories https://repo.osgeo.org/repository/release/  target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar src/main/resources/configs/analyzed/Analyzed-JSON-OwnerMostNonManufacturedPropertiesBoulderCounty.yaml

