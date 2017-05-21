# Tomcat8
tomcat源码学习笔记
不用ant build，直接可跑。

#输出日志需要在 vm参数里设置：
-Dcatalina.base=/Users/xxxx/Documents/git/github/Tomcat8/output -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=${catalina.base}/conf/logging.properties
