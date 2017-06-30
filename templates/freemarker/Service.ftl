<#include "copyright.ftl"/>
package ${basePackage}.service.${moduleName};

import java.util.List;
import java.util.Map;

import com.jy.common.mybatis.Page;
import com.jy.service.base.BaseService;
import ${basePackage}.entity.${moduleName}.${table.className};
import ${basePackage}.entity.${moduleName}.${table.className}Example;
import ${basePackage}.entity.${moduleName}.${table.className}WithBLOBs;

import net.sf.json.JSONObject;

/**
 * <p>服务接口</p>
 * <p>Table: ${table.tableName} - ${table.remarks}</p>
 *
 * @since ${.now}
 */
public interface ${table.className}Service extends BaseService<${table.className}> {
	
	/**
	 * @description 插入或更新
	 * @retrun
	*/
	public Integer saveOrUpdate(${table.className}WithBLOBs entity);
	
	/**
	 * @description 分页查询 
	 * @return ${table.className}<L>
	 */
	public Page<${table.className}> findByPage(${table.className} o, Page<${table.className}> page);
	
	
	/**
	 * @description ID查询
	*/
	public ${table.className} findById(Integer id);
	
	/**
	 * @description 选择性插入
	*/
	int saveSelective(${table.className} record);
	
	/**
	 * @description 选择性查询
	*/
	public List<${table.className}> findByExample(${table.className}Example example);
	
	/**
	 * @description 选择性查询
	*/
	public int updateByIdSelective(${table.className} record);
	
	/**
	 * @description ID删除
	*/
	public int deleteById(Integer id);
	
	@Override
	public void afterdeploy();
	
}
