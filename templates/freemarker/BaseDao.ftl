<#include "copyright.ftl"/>
package ${basePackage}.repository.${moduleName};

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jy.repository.base.BaseDao;
import com.jy.repository.base.JYBatis;
import ${basePackage}.entity.${moduleName}.${table.className};
import ${basePackage}.entity.${moduleName}.${table.className}Example;
@JYBatis
public interface ${table.className}Mapper extends BaseDao<${table.className}> {
	long countByExample(${table.className}Example example);

    int deleteByPrimaryKey(Integer fid);

    void insert(${table.className} record);

    int insertSelective(${table.className} record);

    List<${table.className}> selectByExample(${table.className}Example example);

    ${table.className} selectByPrimaryKey(Integer fid);

    int updateByExampleSelective(@Param("record") ${table.className} record, @Param("example") ${table.className}Example example);

    int updateByExample(@Param("record") ${table.className} record, @Param("example") ${table.className}Example example);

    int updateByPrimaryKeySelective(${table.className} record);

    int updateByPrimaryKey(${table.className} record);
}
