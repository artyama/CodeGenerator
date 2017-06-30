$(function() {
	JY.Dict.setSelect("selectisValid","queryActType",2,'全部');
	getbaseList();
	setOptions();
});
function search(){
	$("#searchBtn").trigger("click");
}
function setForm(data) {
	var l = data.obj;
	fulfillForm(data);
	$("#${table.tableAlias}Form input[name='id']").val(l.id);
	$("#${table.tableAlias}Form input[name$='keyId']").val(l.keyId);
	
	var pId = l.pId;
	if("0" != pId) {
		$("#${table.tableAlias}Form input[name$='pId']").val(pId);
		$("#${table.tableAlias}Tile").html("编辑【" + l.fsubject + "】");
	} else {
		$("#${table.tableAlias}List div ul li").removeClass('current');
		$("#${table.tableAlias}Tile").html("编辑【" + l.fsubject + "】");
	}
}

function cleanForm() {
	$("#${table.tableAlias}Tile").html("选择菜单位置");
	JY.Tags.cleanForm("${table.tableAlias}Form");
	$("#${table.tableAlias}Form input[name$='id']").val("");
	$("#${table.tableAlias}Form input[name$='pId']").val("0");
	$("#${table.tableAlias}Form input[name$='sort']").val("1");
	$("#${table.tableAlias}Form input[name$='keyId']").val("");
	
}

function save() {
	if(JY.Validate.form("${table.tableAlias}Form")){
				JY.Ajax.doRequest("${table.tableAlias}Form", jypath + '/backstage/${table.tableAlias}/addOrUpdate', {
					pars: null
				}, function(data) {
					JY.Model.info(data.resMsg, function() {
						cleanForm();
						getbaseList();
					});
				});
	}
}

function getbaseList(init) {
	if(init == 1) $("#${table.tableAlias}BaseForm .pageNum").val(1);
	JY.Model.loading();
	JY.Ajax.doRequest("${table.tableAlias}BaseForm", jypath + '/backstage/${table.tableAlias}/findByPage', {
	}, function(data) {
		$("#${table.tableAlias}BaseTable tbody").empty();
		var obj = data.obj;
		var list = obj.list;
		var results = list.results;
		var pageNum = list.pageNum,
			pageSize = list.pageSize,
			totalRecord = list.totalRecord;
		var permitBtn = obj.permitBtn;
		var html = "";
		if(results != null && results.length > 0) {
			var leng = (pageNum - 1) * pageSize; //计算序号
			for(var i = 0; i < results.length; i++) {
				var l = results[i];
				html += "<tr>";
				html += "<td class='center'><label> <input type='checkbox' name='ids' value='" + l.fid + "' class='ace' /> <span class='lbl'></span></label></td>";
				html += "<td class='center hidden-480'>" + (i + leng + 1) + "</td>";
				<#list table.baseColumns as column>
				html += "<td class='center'>" + JY.Object.notEmpty(l.${column.javaProperty}) + "</td>";//${column.remark}
				</#list>
				html += JY.Tags.setFunction(l.id, permitBtn);
				html += "</tr>";
			}
			$("#${table.tableAlias}BaseTable tbody").append(html);
			JY.Page.setPage("${table.tableAlias}BaseForm", "pageing", pageSize, pageNum, totalRecord, "getbaseList");
		} else {
			html += "<tr id='tr1'><td colspan='6' class='center'>没有相关数据</td></tr>";
			$("#${table.tableAlias}BaseTable tbody").append(html);
			$("#pageing ul").empty(); //清空分页
		}
		
		JY.Model.loadingClose();
	});
	
}

function edit(id) { //编辑
	cleanForm();
	JY.Model.loading();
	JY.Ajax.doRequest(null, jypath + '/backstage/${table.tableAlias}/find', {
		id: id
	}, function(data) {
		setForm(data);
		JY.Model.loadingClose();
	});
}

//下拉选择方法
function setOptions() {
	
}

$("#resetting").click(function() {
	cleanForm();
});

function fulfillForm(data) {
	var l = data.obj;
	<#list table.primaryKeys as key>
	$("#${table.tableAlias}Form input[name$='${key.javaProperty}']").val(JY.Object.notEmpty(l.${key.javaProperty}));
	</#list>
	<#list table.baseColumns as column>
	$("#${table.tableAlias}Form input[name$='${column.javaProperty}']").val(JY.Object.notEmpty(l.${column.javaProperty}));//${column.remarks}
	</#list>
	setOptions();
}

function del(id){
	JY.Model.confirm("确认删除？",function(){	
		JY.Ajax.doRequest(null,jypath+'/backstage/${table.tableAlias}/del',{id:id},function(data){
			 JY.Model.info(data.resMsg,function(){getbaseList();});
		});
	});	
}
