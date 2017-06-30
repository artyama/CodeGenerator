<#include "copyright.ftl"/>
package ${basePackage}.entity.${moduleName};

import org.apache.ibatis.type.Alias;

import com.jy.entity.base.BaseEntity;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * <p>Entity大数类</p>
 * <p>Table: ${table.tableName} - ${table.remarks}</p>
 *
 * @since ${.now}
 */
@Alias("${table.className}WithBLOBs")
public class ${table.className}WithBLOBs extends ${table.className} {

}
