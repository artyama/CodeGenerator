<#include "copyright.ftl"/>
package ${basePackage}.entity.${moduleName};

import org.apache.ibatis.type.Alias;

import com.jy.entity.base.BaseEntity;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * <p>Entity类</p>
 * <p>Table: ${table.tableName} - ${table.remarks}</p>
 *
 * @since ${.now}
 */
@Alias("${table.className}")
public class ${table.className} extends BaseEntity {

	private static final long serialVersionUID = 1L;
<#list table.primaryKeys as key>

    /** ${key.columnName} - ${key.remarks} */
    private ${key.javaType} ${key.javaProperty};
</#list>
<#list table.baseColumns as column>

    /** ${column.columnName} - ${column.remarks} */
    private ${column.javaType} ${column.javaProperty};
</#list>
	<#list table.primaryKeys as key>

    public ${key.javaType} ${key.getterMethodName}(){
        return this.${key.javaProperty};
    }
    public void ${key.setterMethodName}(${key.javaType} ${key.javaProperty}){
        this.${key.javaProperty} = ${key.javaProperty};
    }
</#list>
<#list table.baseColumns as column>

    public ${column.javaType} ${column.getterMethodName}(){
        return this.${column.javaProperty};
    }
    public void ${column.setterMethodName}(${column.javaType} ${column.javaProperty}){
        this.${column.javaProperty} = ${column.javaProperty};
    }
</#list>
}
