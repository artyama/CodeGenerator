<%@ page contentType="text/html;charset=UTF-8" %>
<div id="auDiv" class="hide">
		<form id="auForm" method="POST" onsubmit="return false;" >
			<table cellspacing="0" cellpadding="0" border="0" class="customTable">
				<tbody>
					<tr style="display:none">
						<td colspan="2" class="ui-state-error"><input type="hidden" name="id" ></td>
					</tr>		
					<#list table.baseColumns as column>
					<tr class="FormData">
						<td class="CaptionTD"><font color="red">*</font>${column.remark}：</td>
						<td class="DataTD">&nbsp;
						<input type="text" jyValidate="required"  maxlength="16" name="${column.javaProperty}" class="FormElement ui-widget-content ui-corner-all"></td>
					</tr>
					</#list>
					
				</tbody>
			</table>
		</form>
</div>
