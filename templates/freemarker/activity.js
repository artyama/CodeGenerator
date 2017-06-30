var type_click = "click";
var type_view = "view";
$(function() {
	JY.Dict.setSelect("selectisValid","queryActType",2,'全部');
	getbaseList();
	setOptions();
	$("input[name='fbegintime']").datetimepicker({
		format: 'yyyy-mm-dd hh:ii:00',
		language: 'zh-CN',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
	}).on('changeDate',function(ev){
		$("#fsignbegintime").val($("#fbegintime").val());
	});
	$("input[name='ftime']").datetimepicker({
		format: 'yyyy-mm-dd hh:ii:00',
		language: 'zh-CN',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
	});
	$("input[name='fendtime']").datetimepicker({
		format: 'yyyy-mm-dd hh:ii:00',
		language: 'zh-CN',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
	}).on('changeDate',function(ev){
		$("#fsignendtime").val($("#fendtime").val());
	});
	$("input[name='fsignbegintime']").datetimepicker({
		format: 'yyyy-mm-dd hh:ii:00',
		language: 'zh-CN',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
	});
	$("input[name='fsignendtime']").datetimepicker({
		format: 'yyyy-mm-dd hh:ii:00',
		language: 'zh-CN',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
	});
	$("input[name='fcreatetime']").datetimepicker({
		format: 'yyyy-mm-dd hh:ii:00',
		language: 'zh-CN',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
	});

	$("#menuForm input[name$='selectType']").bind("click", function() {
		var v = this.value;
		if(v == 0) {
			$("#selectVote").removeClass('hide');
			$("#selectTheme").addClass('hide');
			$("#menuForm input[name$='type']").val(type_click);
		} else {
			$("#selectTheme").removeClass('hide');
			$("#selectVote").addClass('hide');
			$("#menuForm input[name$='type']").val(type_view);
		}
	});
	$('#itemformAdd').on('click', function(e) {
		e.preventDefault();
		cleanItemForm();
		JY.Model.edit("itemDiv", "新增选票", function() {
			var html = "";
			var fdescription = $("#itemDiv input[name$='fdescription']").val();
			var fqty = $("#itemDiv input[name$='fqty']").val();
			if(JY.Validate.form("itemDiv")) {
				html += "<tr id='temtr" + itemNum + "' >";
				html += "<td>" + fdescription + "</td>";
				html += "<td>" + fqty + "</td>";
				html += "<td class='center'>";
				html += "<a class='aBtnNoTD' onclick='editItem(&apos;" + itemNum + "&apos;)' title='修改' href='#'><i class='icon-edit color-blue bigger-120'></i></a>";
				html += "<a class='aBtnNoTD' onclick='delItem(&apos;" + itemNum + "&apos;)' title='删除' href='#'><i class='icon-remove-sign color-red bigger-120'></i></a>";
				html += "<input type='hidden' name='items' id='item" + itemNum + "' value='" + itemNum + "' fdescription='" + fdescription + "' fqty='" + fqty + "' >";
				html += "</td>";
				html += "</tr>";
				itemNum++;
				$("#itemsTable").append(html);
				$(this).dialog("close");
			}
		});
	});
});

function setForm(data) {
	var l = data.obj;
	fulfillForm(data);
	$("#fmainpic_herf").attr("src", $("#menuForm input[name$='fmainpic']").val());
	$("#menuForm input[name='id']").val(l.id);
	$("#menuForm input[name$='keyId']").val(l.keyId);
	
	//获取数据
	 var zNodes=l.extras;
   //设置
	 var setting = {check: {enable: true,chkDisabledInherit: true,chkboxType:{"Y":"ps","N":"s"}},data:{simpleData:{enable: true}}};
   $.fn.zTree.init($("#fextra_nodes"),setting,zNodes);
	
	var pId = l.pId;
	if("0" != pId) {
		$("#menuForm input[name$='pId']").val(pId);
		$("#menuTile").html("编辑活动【" + l.fsubject + "】");
	} else {
		$("#menuList div ul li").removeClass('current');
		$("#menuTile").html("编辑活动【" + l.fsubject + "】");
	}
	var type = l.type;
}

function cleanForm() {
	$("#menuTile").html("选择菜单位置");
	$("#delMenuBtn").addClass('hide');
	JY.Tags.cleanForm("menuForm");
	$("#menuForm input[name$='id']").val("");
	$("#menuForm input[name$='pId']").val("0");
	$("#menuForm input[name$='sort']").val("1");
	$("#menuForm input[name$='type']").val(type_click);
	$("#menuForm input[name$='keyId']").val("");
	$("#selectVote").removeClass('hide');
	$("#selectTheme").addClass('hide');
	$("#menuForm input[name$='selectType'][value='0']").parent("label").trigger("click");
	$("#itemDiv input[name$='sort']").val('1');
	$("#itemsTable tbody").empty();
	removeTab();
	$("#tabText").addClass("active");
	$("#text").addClass("active");
	
	$("#fmainpic_herf").attr("hidden", true);
	
}

function removeTab() {
	$("#tabText").removeClass("active");
	$("#text").removeClass("active");
	$("#tabimageText").removeClass("active");
	$("#imageText").removeClass("active");
	$("#tabimage").removeClass("active");
	$("#image").removeClass("active");
}

function saveActivity() {
	$("#menuForm input[name$='factivity_type_id']").val(JY.Object.notEmpty($("#selectbox_activity_type").val()));
	$("#menuForm input[name$='farea_id']").val(JY.Object.notEmpty($("#selectbox_activity_area").val()));
	$("#menuForm input[name$='fowner_id']").val(JY.Object.notEmpty($("#selectbox_activity_owner").val()));
	$("#menuForm input[name$='fschool_id']").val(JY.Object.notEmpty($("#selectbox_activity_school").val()));
	$("#menuForm input[name$='fstatus']").val(JY.Object.notEmpty($("#selectbox_act_fstatus").val()));
	var zTree = $.fn.zTree.getZTreeObj("fextra_nodes"),
		nodes = zTree.getCheckedNodes(),aus ="";
		for (var i=0, l=nodes.length; i<l; i++) {
			aus += nodes[i].id + ",";
		}
	if (aus.length > 0 ) aus = aus.substring(0, aus.length-1);
	$("#menuForm input[name$='fextra']").val(aus);
	
	for(instance in CKEDITOR.instances) {
		CKEDITOR.instances[instance].updateElement();
	}
	if(JY.Validate.form("menuForm")){
		var fbegintime = $("#menuForm input[name$='fbegintime']").val();
		var fsignbegintime = $("#menuForm input[name$='fsignbegintime']").val();
		var fendtime = $("#menuForm input[name$='fendtime']").val();
		var fsignendtime = $("#menuForm input[name$='fsignendtime']").val();
		var localTime = new Date().Format("yyyy-MM-dd hh:mm:ss");
		var sst = JY.Date.Default(localTime);
				JY.Ajax.doRequest("menuForm", jypath + '/backstage/activity/flat/addOrUpdate', {
					pars: ''
				}, function(data) {
					JY.Model.info(data.resMsg, function() {
						search();
					});
				});
	}
}

function getbaseList(init) {
	if(init == 1) $("#baseForm .pageNum").val(1);
	JY.Model.loading();
	var queryActType = $("#queryActType").val();
	JY.Ajax.doRequest("baseForm", jypath + '/backstage/activity/flat/findByPage', {
		queryActType: queryActType
	}, function(data) {
		$("#baseTable tbody").empty();
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
				html += "<td class='center'>" + JY.Object.notEmpty(l.fsubject) + "</td>";
				html += "<td class='center hidden-480'>" + JY.Date.Default(l.fbegintime) + "</td>";
				html += JY.Tags.setFunction(l.fid, permitBtn);
				html += "</tr>";
			}
			$("#baseTable tbody").append(html);
			JY.Page.setPage("baseForm", "pageing", pageSize, pageNum, totalRecord, "getbaseList");
		} else {
			html += "<tr id='tr1'><td colspan='6' class='center'>没有相关数据</td></tr>";
			$("#baseTable tbody").append(html);
			$("#pageing ul").empty(); //清空分页
		}
		
		//获取数据
		 var zNodes=data.obj.extras;
	    //设置
		 var setting = {check: {enable: true,chkDisabledInherit: true,chkboxType:{"Y":"ps","N":"s"}},data:{simpleData:{enable: true}}};
	    $.fn.zTree.init($("#fextra_nodes"),setting,zNodes);
		
		JY.Model.loadingClose();
	});
	
}

function editActivity(id) { //编辑
	cleanForm();
	JY.Model.loading();
	JY.Ajax.doRequest(null, jypath + '/backstage/activity/flat/find', {
		fid: id
	}, function(data) {
		setForm(data);
		JY.Model.loadingClose();
	});
	saveBtn = "edit";
}
//下拉选择方法
function setOptions() {
	
}
//在输入框填入，对应下拉选项的数据
$("#selectbox_activity_type").bind("change", function() {
	$("#menuForm input[name$='factivity_type_id']").val(JY.Object.notEmpty($(this).val()));
})
$("#selectbox_activity_area").bind("change", function() {
	$("#menuForm input[name$='farea_id']").val(JY.Object.notEmpty($(this).val()));
})
$("#selectbox_activity_owner").bind("change", function() {
	$("#menuForm input[name$='fowner_id']").val(JY.Object.notEmpty($(this).val()));
})
$("#selectbox_activity_school").bind("change", function() {
	$("#menuForm input[name$='fschool_id']").val(JY.Object.notEmpty($(this).val()));
})
$("#selectbox_act_fstatus").bind("change", function() {
	$("#menuForm input[name$='fstatus']").val(JY.Object.notEmpty($(this).val()));
})

$("#resetting").click(function() {
	cleanForm();
	$("#menuForm input[name$='fid']").val("");
	$("#menuForm input[name$='famount']").val("");
	$("#menuForm input[name$='fsubject']").val("");
	$("#menuForm textarea[name$='fcontent']").val("");
	$("#menuForm input[name$='fbegintime']").val("");
	$("#menuForm input[name$='fendtime']").val("");
	$("#menuForm input[name$='faddress']").val("");
	$("#menuForm input[name$='fstatus']").val("");
	$("#menuForm input[name$='fowner_id']").val("");
	$("#menuForm input[name$='fextends']").val("");
	$("#menuForm input[name$='farea_id']").val("");
	$("#menuForm input[name$='fschool_id']").val("");
	$("#menuForm input[name$='factivity_type_id']").val("");
	$("#menuForm input[name$='ftag']").val("");
	$("#menuForm input[name$='fisonline']").val("");
	$("#menuForm input[name$='furl']").val("");
	$("#menuForm input[name$='fread']").val("");
	$("#menuForm input[name$='ffocus']").val("");
	$("#menuForm input[name$='fsign']").val("");
	$("#menuForm input[name$='fpay']").val("");
	$("#menuForm input[name$='fshare']").val("");
	$("#menuForm input[name$='fmainpic']").val("");
	$("#menuForm input[name$='fselectnum']").val("");
	$("#menuForm input[name$='fmin']").val("");
	$("#menuForm input[name$='fmax']").val("");
	$("#menuForm input[name$='fkeys']").val("");
	$("#menuForm input[name$='fappuser_id']").val("");
	$("#menuForm input[name$='fsignendtime']").val("");
	$("#menuForm input[name$='fsignbegintime']").val("");
	$("#menuForm input[name$='fcreatetime']").val("");
});

function fulfillForm(data) {
	var l = data.obj;
	$("#menuForm input[name$='fid']").val(JY.Object.notEmpty(l.fid));
	$("#menuForm input[name$='famount']").val(JY.Object.notEmpty(l.famount));
	$("#menuForm input[name$='fsubject']").val(JY.Object.notEmpty(l.fsubject));
	$("#menuForm textarea[name$='fcontent']").val(JY.Object.notEmpty(l.fcontent)); //描述
	$("#menuForm input[name$='fbegintime']").val(JY.Date.Default(l.fbegintime));
	$("#menuForm input[name$='fendtime']").val(JY.Date.Default(l.fendtime));
	$("#menuForm input[name$='faddress']").val(JY.Object.notEmpty(l.faddress));
	$("#menuForm input[name$='flocation']").val(JY.Object.notEmpty(l.flocation));

	$("#menuForm input[name$='fowner_id']").val(JY.Object.notEmpty(l.fowner_id));
	$("#menuForm input[name$='fextends']").val(JY.Object.notEmpty(l.fextends));
	$("#farea_id").val(JY.Object.notEmpty(l.farea_id));
	$("#menuForm input[name$='fschool_id']").val(JY.Object.notEmpty(l.fschool_id));
	$("#menuForm input[name$='factivity_type_id']").val(JY.Object.notEmpty(l.factivity_type_id));
	$("#menuForm input[name$='ftag']").val(JY.Object.notEmpty(l.ftag));
	JY.Tags.isValid("menuForm", (JY.Object.notNull(l.fisonline) ? l.fisonline : "0"));
	$("#menuForm input[name$='fstatus']").val(JY.Object.notEmpty(l.fstatus));

	//$("#selectbox_activity_model").val(JY.Object.notEmpty(l.fmodelid));
	$("#menuForm input[name$='furl']").val(JY.Object.notEmpty(l.furl));
	$("#menuForm input[name$='fread']").val(JY.Object.notEmpty(l.fread));
	$("#menuForm input[name$='ffocus']").val(JY.Object.notEmpty(l.ffocus));
	$("#menuForm input[name$='fsign']").val(JY.Object.notEmpty(l.fsign));
	$("#menuForm input[name$='fpay']").val(JY.Object.notEmpty(l.fpay));
	$("#menuForm input[name$='fshare']").val(JY.Object.notEmpty(l.fshare));
	$("#menuForm input[name$='fmainpic']").val(JY.Object.notEmpty(l.fmainpic));
	$("#menuForm input[name$='fselectnum']").val(JY.Object.notEmpty(l.fselectnum));
	$("#menuForm input[name$='fmin']").val(JY.Object.notEmpty(l.fmin));
	$("#menuForm input[name$='fmax']").val(JY.Object.notEmpty(l.fmax));
	$("#menuForm input[name$='fkeys']").val(JY.Object.notEmpty(l.fkeys));
	$("#menuForm input[name$='fappuser_id']").val(JY.Object.notEmpty(l.fappuser_id));
	$("#menuForm input[name$='fsignendtime']").val(JY.Date.Default(l.fsignendtime));
	$("#menuForm input[name$='fsignbegintime']").val(JY.Date.Default(l.fsignbegintime));
	$("#menuForm input[name$='fcreatetime']").val(JY.Date.Default(l.fcreatetime));
	
	$("#fmainpic_herf").attr("hidden", false);

	setOptions();
}
