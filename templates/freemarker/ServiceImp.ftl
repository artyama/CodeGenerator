<#include "copyright.ftl"/>
package ${basePackage}.service.${moduleName};

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jy.common.mybatis.Page;
import com.jy.common.utils.JsonUtil;
import com.jy.common.utils.base.Const;
import com.jy.service.base.BaseServiceImp;
import ${basePackage}.common.utils.JavaNSUnixTimeFormat;
import ${basePackage}.common.utils.MarsBeanUtils;
import ${basePackage}.entity.${moduleName}.${table.className};
import ${basePackage}.entity.${moduleName}.${table.className}WithBLOBs;
import ${basePackage}.entity.${moduleName}.${table.className}Example;
import ${basePackage}.repository.${moduleName}.${table.className}Mapper;

import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

@Service("${table.className}Service")
public class ${table.className}ServiceImp extends BaseServiceImp<${table.className}> implements ${table.className}Service {

	@Autowired
	private ${table.className}Mapper ${table.tableAlias}BaseDao;
	
	@Override
	public Integer saveOrUpdate(${table.className}WithBLOBs entity) {
		if(entity.getId()==null){
			${table.tableAlias}BaseDao.insertSelective(entity);
		}
		else{
			${table.tableAlias}BaseDao.updateByPrimaryKey(entity);
		}
		return entity.getId();
	}
	@Override
	public Page<${table.className}> findByPage(${table.className} o, Page<${table.className}> page) {
		${table.className}Example example = new ${table.className}Example();
		example.setLimitStart(page.getPageSize()*(page.getPageNum()-1));
		example.setLimitEnd(page.getPageSize()*page.getPageNum());
		List<${table.className}> list= ${table.tableAlias}BaseDao.selectByExample(example);
		long totalRecord = ${table.tableAlias}BaseDao.countByExample(example);
		page.setResults(list);
		page.setTotalPage((int)totalRecord/page.getPageSize());
		page.setTotalRecord((int)totalRecord);
		return page;
	}
	
	
	public ${table.className} findById(Integer id){
		return ${table.tableAlias}BaseDao.selectByPrimaryKey(id);
	}
	@Override
	public int saveSelective(${table.className} record) {
		return ${table.tableAlias}BaseDao.insertSelective(record);
	}
	
	@Override
	public List<${table.className}> findByExample(${table.className}Example example) {
		return ${table.tableAlias}BaseDao.selectByExample(example);
	}
	@Override
	public int updateByIdSelective(${table.className} record) {
		return ${table.tableAlias}BaseDao.updateByPrimaryKeySelective(record);
	}
	@Override
	public int deleteById(Integer id) {
		return ${table.tableAlias}BaseDao.deleteByPrimaryKey(id);
	}
	
	@Override
	@Transactional
	public void afterdeploy() {
		super.afterdeploy();
	}
	
}