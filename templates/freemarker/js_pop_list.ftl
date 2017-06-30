$(function () {
	//下拉框
	JY.Dict.setSelect("selectisValid","isValid",2,"全部");
	getbaseList();
	//增加回车事件
	$("#baseForm").keydown(function(e){
		 keycode = e.which || e.keyCode;
		 if (keycode==13) {
			 search();
		 } 
	});
	//新加
	$('#addBtn').on('click', function(e) {
		//通知浏览器不要执行与事件关联的默认动作		
		e.preventDefault();
		cleanForm();	
		JY.Model.edit("auDiv","新增",function(){
			 if(JY.Validate.form("auForm")){
				 var that =$(this);
				 JY.Ajax.doRequest("auForm",jypath +'/backstage/${table.tableAlias}/add',null,function(data){
				     that.dialog("close");      
				     JY.Model.info(data.resMsg,function(){search();});
				 });
			 }	
		});
	});
	//批量删除
	$('#delBatchBtn').on('click', function(e) {
		//通知浏览器不要执行与事件关联的默认动作		
		e.preventDefault();
		var chks =[];    
		$('#baseTable input[name="ids"]:checked').each(function(){    
			chks.push($(this).val());    
		});     
		if(chks.length==0) {
			JY.Model.info("您没有选择任何内容!"); 
		}else{
			JY.Model.confirm("确认要删除选中的数据吗?",function(){	
				JY.Ajax.doRequest(null,jypath +'/backstage/${table.tableAlias}/delBatch',{chks:chks.toString()},function(data){
					JY.Model.info(data.resMsg,function(){search();});
				});
			});		
		}		
	});
});
function search(){
	$("#searchBtn").trigger("click");
}

var preisShow=false;//窗口是否显示

function getbaseList(init){
	if(init==1)$("#baseForm .pageNum").val(1);	
	JY.Model.loading();
	JY.Ajax.doRequest("baseForm",jypath +'/backstage/${table.tableAlias}/findByPage',null,function(data){
		 $("#baseTable tbody").empty();
        	 var obj=data.obj;
        	 var list=obj.list;
        	 var results=list.results;
        	 var permitBtn=obj.permitBtn;
         	 var pageNum=list.pageNum,pageSize=list.pageSize,totalRecord=list.totalRecord;
        	 var html="";
    		 if(results!=null&&results.length>0){
        		 var leng=(pageNum-1)*pageSize;//计算序号
        		 for(var i = 0;i<results.length;i++){
            		 var l=results[i];
            		 html+="<tr>";
            		 html+="<td class='center'><label> <input type='checkbox' name='ids' value='"+l.id+"' class='ace' /> <span class='lbl'></span></label></td>";
            		 html+="<td class='center hidden-480'>"+(i+leng+1)+"</td>";
            		<#list table.baseColumns as column>
					html += "<td class='center'>" + JY.Object.notEmpty(l.${column.javaProperty}) + "</td>";//${column.remark}
					</#list>
            		 html+=JY.Tags.setFunction(l.id,permitBtn);
            		 html+="</tr>";		 
            	 } 
        		 $("#baseTable tbody").append(html);
        		 JY.Page.setPage("baseForm","pageing",pageSize,pageNum,totalRecord,"getbaseList");
        	 }else{
        		html+="<tr><td colspan='10' class='center'>没有相关数据</td></tr>";
        		$("#baseTable tbody").append(html);
        		$("#pageing ul").empty();//清空分页
        	 }	
 	 
    	 JY.Model.loadingClose();
	 });
}

function del(id){
	JY.Model.confirm("确认删除吗？",function(){	
		JY.Ajax.doRequest(null,jypath +'/backstage/${table.tableAlias}/del',{id:id},function(data){
			JY.Model.info(data.resMsg,function(){getbaseList();});
		});
	});
}
function edit(id){
	cleanForm();
		JY.Ajax.doRequest(null,jypath +'/backstage/${table.tableAlias}/find',{id:id},function(data){
		    setForm(data);   
		    JY.Model.edit("auDiv","修改",function(){
		    	if(JY.Validate.form("auForm")){
					var that =$(this);
					JY.Ajax.doRequest("auForm",jypath +'/backstage/${table.tableAlias}/update',null,function(data){
					    that.dialog("close");
					    JY.Model.info(data.resMsg,function(){getbaseList();});	
					});
				}	
		    });
		});
}
function check(id){
	cleanForm();
		JY.Ajax.doRequest(null,jypath +'/backstage/${table.tableAlias}/find',{id:id},function(data){
		    setForm(data);
		    JY.Model.check("auDiv");       
		});
}
function cleanForm(){
	JY.Tags.isValid("auForm","1");
	JY.Tags.cleanForm("auForm");
}
function setForm(data){
	var l=data.obj;
	<#list table.primaryKeys as key>
	$("#auForm input[name$='${key.javaProperty}']").val(JY.Object.notEmpty(l.${key.javaProperty}));
	</#list>
	<#list table.baseColumns as column>
	$("#auForm input[name$='${column.javaProperty}']").val(JY.Object.notEmpty(l.${column.javaProperty}));//${column.remarks}
	</#list>
}
