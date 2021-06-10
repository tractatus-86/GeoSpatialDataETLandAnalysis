#!/bin/bash
sbt "runMain com.datasource.DataSourcing src/main/resources/configs/sourced/Source-BoulderCountyParcels.yaml"
sbt "runMain com.datasource.DataSourcing src/main/resources/configs/sourced/Source-ASR_PublicDataFiles.yaml"
