#!/bin/bash
mkdir -p /opt/spark/
mkdir -p /usr/share/man/man1

apt update -y
apt-get update && \
      apt-get -y install sudo
sudo apt install default-jdk -y
sudo apt-get install wget -y
sudo apt install curl wget -y
wget https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop3.2.tgz
tar -xvzf spark-*
rm spark-3.0.2-bin-hadoop3.2.tgz
mv spark-3.0.2-bin-hadoop3.2/* /opt/spark
echo "export SPARK_HOME=/opt/spark" >> ~/.profile
echo "export PATH=$PATH:/opt/spark/bin:/opt/spark/sbin" >> ~/.profile
sudo apt-get update && apt-get install -y gnupg2
source ~/.profile
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
sudo curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update -y
sudo apt-key update
sudo apt-get -y --force-yes install sbt
sudo apt install git -y

sudo git clone https://github.com/tractatus-86/GeoSpatialDataETLandAnalysis.git
sudo apt install tree
cd GeoSpatialDataETLandAnalysis
sudo sbt assembly
chmod 755 source-boulder-county-data.sh
chmod 755 structure-boulder-county-data.sh

./source-boulder-county-data.sh
./structure-boulder-county-data.sh

spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --jars $(pwd)/target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --packages org.locationtech.geomesa:geomesa-tools_2.12:3.2.0,tech.units:indriya:2.1.2 --repositories https://repo.osgeo.org/repository/release/  target/scala-2.12/GeoSpatialDataETLandAnaysis-assembly-1.0.jar src/main/resources/configs/analyzed/Analyzed-JSON-TotalResidentialAcreageBoulderCounty.yaml

spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --jars $(pwd)/target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --packages org.locationtech.geomesa:geomesa-tools_2.12:3.2.0,tech.units:indriya:2.1.2 --repositories https://repo.osgeo.org/repository/release/  target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar src/main/resources/configs/analyzed/Analyzed-JSON-OwnerMostResidentialAcreageBoulderCounty.yaml 

spark-submit --class com.datatransformer.DataTransformer  --master local --driver-class-path target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --jars $(pwd)/target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar --packages org.locationtech.geomesa:geomesa-tools_2.12:3.2.0,tech.units:indriya:2.1.2 --repositories https://repo.osgeo.org/repository/release/  target/scala-2.12/GeoSpatialDataETLandAnalysis-assembly-1.0.jar src/main/resources/configs/analyzed/Analyzed-JSON-OwnerMostNonManufacturedPropertiesBoulderCounty.yaml

tree Datalake
