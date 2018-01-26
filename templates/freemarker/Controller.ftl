<#include "copyright.ftl"/>
package ${basePackage}.controller.${moduleName};

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.ajax.AjaxRes;
import com.jy.common.mybatis.Page;
import com.jy.common.utils.base.Const;
import com.jy.controller.base.BaseController;
import com.jy.interceptor.core.DateConvertEditor;
import ${basePackage}.common.utils.JavaNSUnixTimeFormat;
import ${basePackage}.common.utils.MarsBeanUtils;
import ${basePackage}.entity.${moduleName}.${table.className};
import ${basePackage}.entity.${moduleName}.${table.className}WithBLOBs;
import ${basePackage}.service.${moduleName}.${table.className}Service;

/**
 * <p>Controller类</p>
 * <p>Table: ${table.tableName} - ${table.remarks}</p>
 *
 * @since ${.now}
 */

@Controller
@RequestMapping("/backstage/${table.tableAlias}/")
public class ${table.className}Controller extends BaseController<${table.className}> {
	/**
	 * 将前台传递过来的日期格式的字符串，自动转化为Date类型
	 * 
	 * @param binder
	 */
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		binder.registerCustomEditor(Date.class, new DateConvertEditor());
	}


	@Autowired
	private ${table.className}Service ${table.javaProperty}Service;

	/**
	 * @Description: 菜单入口
	 * @since ${.now}
	 */
	@RequestMapping("index")
	public String themeIndex(Model model) {
		 if (doSecurityIntercept(Const.RESOURCES_TYPE_MENU)) {
		 model.addAttribute("permitBtn",
		 getPermitBtn(Const.RESOURCES_TYPE_FUNCTION));
			return "/mellower/${moduleName}/${table.tableAlias}/list";
		 }
		 return Const.NO_AUTHORIZED_URL;
	}

	/**
	 * @Description: 分页查询
	 * @since ${.now}
	 */
	@RequestMapping(value = "findByPage", method = RequestMethod.POST)
	@ResponseBody
	public AjaxRes findByPage(Page<${table.className}> page, ${table.className} o) {
		AjaxRes ar = getAjaxRes();
		if (ar.setNoAuth(doSecurityIntercept(Const.RESOURCES_TYPE_MENU, "/backstage/${table.tableAlias}/index"))) {
			try {
				Page<${table.className}> list = ${table.javaProperty}Service.findByPage(o, page);
				Map<String, Object> p = new HashMap<String, Object>();
				p.put("permitBtn", getPermitBtn(Const.RESOURCES_TYPE_BUTTON));
				p.put("list", list);
				ar.setSucceed(p);
			} catch (Exception e) {
				logger.error(e.toString(), e);
				ar.setFailMsg(Const.DATA_FAIL);
			}
		}
		return ar;

	}

	/**
	 * @Description: 查询详情
	 * @since ${.now}
	 */
	@RequestMapping(value = "find", method = RequestMethod.POST)
	@ResponseBody
	public AjaxRes find(${table.className} entity) {
		AjaxRes ar = getAjaxRes();
		if (ar.setNoAuth(doSecurityIntercept(Const.RESOURCES_TYPE_BUTTON))) {
			try {
				${table.className} o = ${table.javaProperty}Service.findById(entity.getId());
				ar.setSucceed(o);
			} catch (Exception e) {
				logger.error(e.toString(), e);
				ar.setFailMsg(Const.DATA_FAIL);
			}
		}
		return ar;
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	@ResponseBody
	public AjaxRes add(${table.className}WithBLOBs wbs){
		AjaxRes ar=getAjaxRes();
		if(ar.setNoAuth(doSecurityIntercept(Const.RESOURCES_TYPE_FUNCTION))){			
			try {
				${table.javaProperty}Service.saveOrUpdate(wbs);
				ar.setSucceedMsg(Const.SAVE_SUCCEED);
			} catch (Exception e) {
				logger.error(e.toString(),e);
				ar.setFailMsg(Const.SAVE_FAIL);
			}
		}
		return ar;
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	@ResponseBody
	public AjaxRes update(${table.className}WithBLOBs wbs){
		AjaxRes ar=getAjaxRes();
		if(ar.setNoAuth(doSecurityIntercept(Const.RESOURCES_TYPE_BUTTON))){
			try {
				${table.javaProperty}Service.saveOrUpdate(wbs);
				ar.setSucceedMsg(Const.SAVE_SUCCEED);
			} catch (Exception e) {
				logger.error(e.toString(),e);
				ar.setFailMsg(Const.UPDATE_FAIL);
			}
		}	
		return ar;
	}

	/**
	 * @Description: 实体更新
	 * @since ${.now}
	 */
	@RequestMapping(value="addOrUpdate", method=RequestMethod.POST)
	@ResponseBody
	public AjaxRes addOrUpdate(${table.className}WithBLOBs wbs){
		AjaxRes ar=getAjaxRes();
		if(ar.setNoAuth(doSecurityIntercept(Const.RESOURCES_TYPE_FUNCTION))){
			try {
				
				${table.javaProperty}Service.saveOrUpdate(wbs);
				ar.setSucceedMsg(Const.UPDATE_SUCCEED);
			} catch (Exception e) {
				logger.error(e.toString(),e);
				ar.setFailMsg(Const.UPDATE_FAIL);
			}
		}	
		return ar;
	}
	
	/**
	 * @Description: 实体删除
	 * @since ${.now}
	 */
	@RequestMapping(value="del", method=RequestMethod.POST)
	@ResponseBody
	public AjaxRes del(${table.className} entity){
		AjaxRes ar=getAjaxRes();
		if(ar.setNoAuth(doSecurityIntercept(Const.RESOURCES_TYPE_BUTTON))){
			try {
				
				${table.javaProperty}Service.deleteById(entity.getId());
				ar.setSucceedMsg(Const.DEL_SUCCEED);
			} catch (Exception e) {
				logger.error(e.toString(),e);
				ar.setFailMsg(Const.DEL_FAIL);
			}
		}	
		return ar;
	}
	
}
