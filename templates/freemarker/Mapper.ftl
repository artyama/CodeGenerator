<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.repository.${moduleName}.${table.className}Dao">

    <resultMap id="base" type="${table.className}"></resultMap> 
    <resultMap id="pageMap" type="${basePackage}.page.${moduleName}.${table.className}Page"></resultMap>
    
    <!--  #############################后台管理方法#############################  -->
    <!-- 新增一条Activity记录 -->
    <insert id="insert" parameterType="${basePackage}.entity.${moduleName}.${table.className}">
    <selectKey resultType="java.lang.Integer" order="AFTER" keyProperty="fid">
		SELECT LAST_INSERT_ID()
	 </selectKey>
     <![CDATA[
		INSERT INTO ${table.tableName}(
		<#list table.baseColumns as column>
		${column.javaProperty},
		</#list>
		) VALUES (
		<#list table.baseColumns as column>
		#{${column.javaProperty}},
		</#list>
		)
	 ]]>  
    </insert>
    
    <!-- 新增一条Activity记录 -->
    <insert id="pageInsert" keyProperty="fid" parameterType="base">
    	<selectKey resultType="java.lang.Integer" order="AFTER" keyProperty="fid">
		SELECT LAST_INSERT_ID()
	 	</selectKey>
     <![CDATA[
		INSERT INTO t_activity(
		fsubject,fcontent,fbegintime,fendtime,fsignbegintime,
		fsignendtime,fowner_id,fcreatetime,farea_id,fschool_id,
		faddress,factivity_type_id,ftag,fisonline,fmodelid,
		furl,fread,ffocus,fsign,fpay,
		fshare,famount,fmainpic,fstatus,fselectnum,
		fmin,fmax,fappuser_id,fextends,fkeys,
		flocation,fclosetime,freasonNo,fclosereason,fextra
		) VALUES (
		#{fsubject},#{fcontent},#{fbegintime},#{fendtime},#{fsignbegintime},
		#{fsignendtime},#{fowner_id},UNIX_TIMESTAMP(),#{farea_id},#{fschool_id},
		#{faddress},#{factivity_type_id},#{ftag},#{fisonline},#{fmodelid},
		#{furl},#{fread},#{ffocus},#{fsign},#{fpay},
		#{fshare},#{famount},#{fmainpic},#{fstatus},#{fselectnum},
		#{fmin},#{fmax},#{fappuser_id},#{fextends},#{fkeys},
		#{flocation},#{fclosetime},#{freasonNo},#{fclosereason},#{fextra}
		)
	 ]]>  
    </insert>

   <!-- 删除一条Activity记录 -->
   <delete id="delete" parameterType="base">
    <![CDATA[
	DELETE FROM t_activity where fid = #{fid} 
	]]>  
   </delete>
   
    <!-- @author BelovedStocky,@date 2016/9/13 -->
    <!-- 修改一条Activity记录 -->
    <update id="update" parameterType="base" >
	   UPDATE t_activity set 
		   fsubject=#{fsubject},
		   fcontent=#{fcontent},
		   fbegintime=#{fbegintime},
		   fendtime=#{fendtime},
		   fsignbegintime=#{fsignbegintime},
		   fsignendtime=#{fsignendtime},
		   fowner_id=#{fowner_id},
		   farea_id=#{farea_id},
		   fschool_id=#{fschool_id},
		   faddress=#{faddress},
		   factivity_type_id=#{factivity_type_id},
		   ftag=#{ftag},
		   fisonline=#{fisonline},
		   fmodelid=#{fmodelid},
		   furl=#{furl},
		   fread=#{fread},
		   ffocus=#{ffocus},
		   fsign=#{fsign},
		   fpay=#{fpay},
		   fshare=#{fshare},
		   famount=#{famount},
		   fmainpic=#{fmainpic},
		   fstatus=#{fstatus},
		   fselectnum=#{fselectnum},
		   fmin=#{fmin},
		   fmax=#{fmax},
		   fappuser_id=#{fappuser_id},
		   fextends=#{fextends},
		   fkeys=#{fkeys},
		   flocation=#{flocation},
		   fclosetime = #{fclosetime},
		   freasonNo = #{freasonNo},
		   fclosereason = #{fclosereason}
	   where fid=#{fid}
    </update>
   
    <!-- 批量删除Activity记录 -->
    <delete id="deleteBatch" parameterType="list">
    <![CDATA[
	DELETE FROM t_activity where fid in
	]]> 
	<foreach collection="os" index="index" item="item" open="(" separator="," close=")"> 
        #{fid} 
    </foreach> 
   </delete>
    
   <!-- 查询一条Activity -->
   <select id="find" parameterType="base" resultMap="base">
	 SELECT t.* FROM t_activity t where 1=1
	 <if test="fid!=null and fid!=''">
     	AND t.fid = #{fid}
     </if>
   </select>
   
   <!-- 查询Activity列表,分页 -->
   <select id="findByPage" resultMap="activityPageMap" parameterType="base">
	 SELECT t.fid,t.fsubject,t.fcontent,
		date_format(FROM_UNIXTIME(t.fbegintime),'%Y-%m-%d %h:%i:%S') fbegintime,date_format(FROM_UNIXTIME(t.fendtime),'%Y-%m-%d %h:%i:%S') fendtime,
		tarea.fname farea_id,tapp.fusername fappuser_id,
		type.fname factivity_type_id,tmod.fname fmodelid,
		towner.fname fowner_id,tschool.fname fschool_id
		FROM t_activity t 
		LEFT JOIN t_area tarea
		ON t.farea_id = tarea.fid
		
		LEFT JOIN t_appuser tapp
		ON t.fappuser_id = tapp.fid
		
		LEFT JOIN t_activity_type type
		ON t.factivity_type_id = type.fid
		
		LEFT JOIN t_activity_model tmod
		ON t.fmodelid = tmod.fid
		
		LEFT JOIN t_owner towner
		ON t.fowner_id = towner.fid
		
		LEFT JOIN t_school tschool
		ON t.fschool_id = tschool.fid
		where 1=1 and t.fstatus !=8 
		<if test="param!= null and param!=''">
			<if test="param.factivity_type_id!=null and param.factivity_type_id!=''">
			AND t.factivity_type_id=CONVERT(#{param.factivity_type_id},SIGNED)
			</if>
		</if>
		ORDER BY t.fid DESC
   </select>
   
</mapper>