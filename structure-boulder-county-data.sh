#!/bin/bash
spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar src/main/resources/configs/structured/Structured-Parquet-BoulderCountyParcels.yaml


spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar src/main/resources/configs/structured/Structured-Parquet-ASR_PublicDataFiles.yaml
