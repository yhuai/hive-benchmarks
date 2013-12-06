# add in ~/.bash_profile in red hat
export JAVA_HOME="/usr/lib/jvm/java-1.7.0"
export M2_HOME="/home/ec2-user/apache-maven-3.1.1"
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms512m -Xmx512m"
export ANT_HOME="/home/ec2-user/apache-ant-1.9.2"
export ANT=$ANT_HOME/bin
export ANT_OPTS="-Xms1024m -XX:PermSize=512m -XX:ReservedCodeCacheSize=512m"
export BENCH_HOME="/mnt/mnt0/hive-benchmarks"
export HADOOP_HOME="/home/ec2-user/hadoop-1.2.1"
export HADOOP=$HADOOP_HOME/bin/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/conf
export HIVE_HOME="/home/ec2-user/apache-hive-0.13.0-SNAPSHOT-bin"
export HIVE_CONF_DIR=$HIVE_HOME/conf
export PATH=$JAVA_HOME/bin:$ANT:$M2:$HADOOP_HOME/bin:$HIVE_HOME/bin:$PATH

# add in ~/.profile in ubuntu
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export M2_HOME="/home/ubuntu/apache-maven-3.1.1"
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms512m -Xmx512m"
export ANT_HOME="/home/ubuntu/apache-ant-1.9.2"
export ANT=$ANT_HOME/bin
export ANT_OPTS="-Xms1024m -XX:PermSize=512m -XX:ReservedCodeCacheSize=512m"
export BENCH_HOME="/mnt/mnt0/hive-benchmarks"
export HADOOP_HOME="/home/ubuntu/hadoop-1.2.1"
export HADOOP=$HADOOP_HOME/bin/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/conf
export HIVE_HOME="/home/ubuntu/apache-hive-0.13.0-SNAPSHOT-bin"
export HIVE_CONF_DIR=$HIVE_HOME/conf
export PATH=$JAVA_HOME/bin:$ANT:$M2:$HADOOP_HOME/bin:$HIVE_HOME/bin:$PATH