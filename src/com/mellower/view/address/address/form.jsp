<%@ page contentType="text/html;charset=UTF-8" %>
<div id="auDiv" class="hide">
		<form id="auForm" method="POST" onsubmit="return false;" >
			<table cellspacing="0" cellpadding="0" border="0" class="customTable">
				<tbody>
					<tr style="display:none">
						<td colspan="2" class="ui-state-error"><input type="hidden" name="id" ></td>
					</tr>		
										<tr class="FormData">
						<td class="CaptionTD"><font color="red">*</font>：</td>
						<td class="DataTD">&nbsp;
						<input type="text" jyValidate="required"  maxlength="16" name="name" class="FormElement ui-widget-content ui-corner-all"></td>
					</tr>
					<tr class="FormData">
						<td class="CaptionTD"><font color="red">*</font>：</td>
						<td class="DataTD">&nbsp;
						<input type="text" jyValidate="required"  maxlength="16" name="tel" class="FormElement ui-widget-content ui-corner-all"></td>
					</tr>
					<tr class="FormData">
						<td class="CaptionTD"><font color="red">*</font>：</td>
						<td class="DataTD">&nbsp;
						<input type="text" jyValidate="required"  maxlength="16" name="address" class="FormElement ui-widget-content ui-corner-all"></td>
					</tr>
					<tr class="FormData">
						<td class="CaptionTD"><font color="red">*</font>：</td>
						<td class="DataTD">&nbsp;
						<input type="text" jyValidate="required"  maxlength="16" name="remark" class="FormElement ui-widget-content ui-corner-all"></td>
					</tr>
					<tr class="FormData">
						<td class="CaptionTD"><font color="red">*</font>：</td>
						<td class="DataTD">&nbsp;
						<input type="text" jyValidate="required"  maxlength="16" name="userId" class="FormElement ui-widget-content ui-corner-all"></td>
					</tr>
					
				</tbody>
			</table>
		</form>
</div>
