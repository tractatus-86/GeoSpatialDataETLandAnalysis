# GeoSpatialDataETLandAnalysis

Please run on machine with at least 6GB hard drive space and 4GB memory.


To Run Locally use Debian

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


Otherwise use docker 

For clean install with no prepped data

    cd docker/interactive/
    docker build -t geo .
    docker run -t geo
    

For install with all data prepped

    cd docker/answer/
    docker build -t geo .
    docker run -t geo
    
