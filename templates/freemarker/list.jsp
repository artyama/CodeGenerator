<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="a" uri="/ayui-tags" %>
<!DOCTYPE html >
<html lang="en">
	<head>
		<%@include file="../../../system/common/includeBaseSet.jsp" %>
		<%@include file="../../../system/common/includeSystemSet.jsp" %>
		<link rel="stylesheet" href="${jypath}/static/plugins/zTree/3.5/zTreeStyle.css" />
		<link rel="stylesheet" href="${jypath}/static/apidoc/JYUI/assets/css/bootstrap-datetimepicker.css">
		<link rel="stylesheet" href="${jypath}/static/apidoc/JYUI/assets/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${jypath}/static/apidoc/JYUI/assets/css/font-awesome.min.css" />
		<script type="text/javascript" src="${jypath}/static/plugins/zTree/3.5/jquery.ztree.core-3.5.min.js"></script>
		<script type="text/javascript" src="${jypath}/static/plugins/zTree/3.5/jquery.ztree.excheck-3.5.js"></script>
		<script type="text/javascript" src="${jypath}/static/apidoc/JYUI/assets/js/bootstrap-datetimepicker.zh-CN.js"></script>
		<script type="text/javascript" src="${jypath}/static/apidoc/JYUI/assets/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="${jypath}/static/apidoc/JYUI/assets/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${jypath}/static/css/system/system/weixin.css" />
		<link rel="stylesheet" href="${jypath}/static/plugins/webuploader/css/webuploader.css" />
		<script src="${jypath}/static/plugins/webuploader/js/webuploader.nolog.min.js"></script>
		<script type="text/javascript" src="${jypath}/ckfinder/ckfinder.js"></script>
		<script type="text/javascript" src="${jypath}/ckeditor/ckeditor.js"></script>
		<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css" />
		<script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
		<script type="text/javascript">
			function decode(value, id) { // value传入值,id接受值
				var last = value.lastIndexOf("/");
				var filename = value.substring(last + 1, value.length);
				$("#" + id).text(decodeURIComponent(filename));
			}

			function browse(inputId, file, type) { // 文件管理器，可多个上传共用
				var finder = new CKFinder();
				finder.selectActionFunction = function(fileUrl, data) { // 设置文件被选中时的函数
					$("#" + inputId).attr("value", fileUrl);
					if("Images" != type) {
						$("#" + file).attr("href", fileUrl);
						alert(fileUrl);
						decode(fileUrl, file);
					} else {
						$("#" + file).attr("src", fileUrl);
						$("#" + file).attr("hidden", false);
					}
				};
				finder.resourceType = type; // 指定ckfinder只为type进行管理
				finder.selectActionData = inputId; // 接收地址的input ID
				finder.removePlugins = 'help'; // 移除帮助(只有英文)
				finder.defaultLanguage = 'zh-cn';
				finder.popup();
			}
		</script>
		<style>
			#wrong {
				height: 24px;
				display: block;
				text-indent: 25px;
				margin-left: 41%;
				color: red;
			}
			#myPageTop {
			    position: absolute;
			    top: 5px;
			    left: 40px;
			    right:0px;
			    background: #fff none repeat scroll 0 0;
			    border: 1px solid #ccc;
			    margin: 10px auto;
			    padding: 6px;
			    font-family: "Microsoft Yahei", "Î¢ÈíÑÅºÚ", "Pinghei";
			    font-size: 14px;
			}
		</style>
	</head>

	<body>
		<%@include file="../../../system/common/dialog.jsp"%>
		<%@include file="form.jsp"%>
		<div class="col-xs-12">
			<div class="col-sm-6">
				<form id="baseForm" class="form-inline" method="POST" onsubmit="return false;">
					<div class="widget-main customBtn">
						<input type="text" name="keyWord" placeholder="这里输入关键词" class="input-large"> &nbsp;&nbsp;
						<span id="selectisValid"><label></label>：<select id="queryActType" name="queryActType" ></select></span> &nbsp;&nbsp;
						<button id='searchBtn' class="btn btn-warning  btn-xs" title="过滤" type="button" onclick="getbaseList(1)"><i class="icon-search bigger-110 icon-only"></i></button>
					</div>
					<input type='hidden' class='pageNum' name='pageNum' value='1' />
					<input type='hidden' class='pageSize' name='pageSize' value='8' />
					<input type='hidden' name='projId' />
					<input type='hidden' name='nodesEventId' value=''>
				</form>
				<table id="baseTable" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th style="width:3%" class="center">
								<label><input type="checkbox" class="ace" ><span class="lbl"></span></label>
							</th>
							<th style="width:7%" class="center hidden-480">序号</th>
							<th style="width:10%" class="center">活动主题</th>
							<th style="width:10%" class="center hidden-480">开始时间</th>
							<th style="width:20%" class="center">操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="row">

					<div class="dataTables_info customBtn">
						<%-- <c:forEach var="pbtn" items="${permitBtn}">
										<a href="#" title="${pbtn.name}" id="${pbtn.btnId}" class="lrspace3" ><i class='${pbtn.icon} bigger-220'></i></a>
									</c:forEach> --%>

					</div>
					<div class="col-sm-10">
						<!--设置分页位置-->
						<div id="pageing" class="dataTables_paginate paging_bootstrap">
							<ul class="pagination"></ul>
						</div>
					</div>
				</div>

			</div>

			<div class="col-sm-6">
				<div class="widget-box">
					<div class="widget-header">
						<h4 id="menuTile">编辑区域</h4>
						<div class="widget-toolbar ">
							<button id="resetting" class="btn btn-minier btn-danger">新增</button>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main">
							<div>
								<form id="menuForm" method="POST" class="form-horizontal" onsubmit="return false;">
									<input type="hidden" name="pId" value="0">
									<input type="hidden" name="fid" value="">
									<input type="hidden" name="type" value="click">
									<input type="hidden" name="keyId" value="">
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right">
								<font color="red">*</font>活动名称：</label>
										<div class="col-sm-9">
											<input type="text" jyValidate="required" name="fsubject" maxlength="30" class="col-xs-10 col-sm-5">
										</div>
									</div>
									
									<div class="center">
										<button type="button" class="btn btn-info" onclick="saveActivity()">
											<i class="icon-save bigger-110"></i>保存
									</button>

									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="${jypath}/static/js/mars/activity/flat/activity.js"></script>
	</body>
	<script src="${jypath}/static/js/bootstrap/js/select2.min.js"></script>
	<link rel="stylesheet" href="${jypath}/static/js/bootstrap/css/select2.min.css" />
	<script type="text/javascript">
		$(".selection__rendered").select2({
			maximumSelectionLength: 2
		});
	</script>
</html>