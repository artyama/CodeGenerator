<?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE generatorConfiguration
   PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
   "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
 <generatorConfiguration>
     <!--数据库驱动-->
     <classPathEntry    location="lib/mysql-connector-java-5.1.36-bin.jar"/>
     <context id="DB2Tables"    targetRuntime="MyBatis3">
     <plugin type="org.artyama.generator.mapper.PaginationPlugin"></plugin>
         <commentGenerator>
             <property name="suppressDate" value="true"/>
             <property name="suppressAllComments" value="true"/>
         </commentGenerator>
         <!--数据库链接地址账号密码-->
         <jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="${connectionUrl}" userId="${username}" password="${password}">
         </jdbcConnection>
         <javaTypeResolver>
             <property name="forceBigDecimals" value="false"/>
         </javaTypeResolver>
         <!--生成Model类存放位置-->
         <javaModelGenerator targetPackage="${basePackage}.entity.${moduleName}" targetProject="src">
             <property name="enableSubPackages" value="true"/>
             <property name="trimStrings" value="true"/>
         </javaModelGenerator>
         <!--生成映射文件存放位置-->
         <sqlMapGenerator targetPackage="${basePackage}.mapper.${moduleName}" targetProject="src">
             <property name="enableSubPackages" value="true"/>
         </sqlMapGenerator>
         <!--生成Dao类存放位置-->
         <javaClientGenerator type="XMLMAPPER" targetPackage="${basePackage}.repository.${moduleName}" targetProject="src">
             <property name="enableSubPackages" value="true"/>
         </javaClientGenerator>
         <!--生成对应表及类名-->
         <table tableName="${table.tableName}" 
         domainObjectName="${table.className}" 
         enableCountByExample="true" 
         enableUpdateByExample="true" 
         enableDeleteByExample="false" 
         enableSelectByExample="true" 
         selectByExampleQueryId="true"></table>
		 
     </context>
 </generatorConfiguration>