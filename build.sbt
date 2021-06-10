name := "GeoSpatialDataETLandAnalysis"
version := "1.0"
scalaVersion := "2.12.10"


libraryDependencies ++= Seq( 
  	"org.apache.spark" %% "spark-core" % "3.0.2",
 	"org.apache.spark" %% "spark-sql" % "3.0.2",
	"org.apache.sedona" %% "sedona-python-adapter-3.0" % "1.0.1-incubating",
	//"org.apache.sedona" %% "sedona-core-3.0" % "1.0.1-incubating",
	"org.locationtech.geomesa" % "geomesa-tools_2.12" % "3.2.0",
	//"org.geotools" % "gt-transform" % "25.1",
	//"org.locationtech.jts" % "jts-core" % "1.18.1",
	"org.datasyslab" % "geotools-wrapper" % "geotools-24.1",
	//"org.apache.sedona" %% "sedona-viz-3.0" % "1.0.1-incubating",
	//"org.apache.sedona" %% "sedona-sql-3.0" % "1.0.1-incubating",
	//"org.locationtech.geomesa" %% "geomesa-spark-sql" % "3.2.0",
	//"org.wololo" % "jts2geojson" % "0.16.1",
	"com.github.pathikrit" %% "better-files" % "3.9.1",
	"net.jcazevedo" %% "moultingyaml" % "0.4.2",
	"org.datasyslab" % "sernetcdf" % "0.1.0",
	"tech.units" % "indriya" % "2.1.2",
	"com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.12.2"
)

resolvers += "osgeo-repo" at "https://repo.osgeo.org/repository/release/"
assemblyMergeStrategy in assembly := {
	 case PathList("META-INF", xs @ _*) => MergeStrategy.discard
	 case x => MergeStrategy.first
}
