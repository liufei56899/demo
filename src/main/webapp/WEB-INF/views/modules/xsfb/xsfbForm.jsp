<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新生分班管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        function divideClass(){     
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function(){
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
					}
				}
			});
			if(count>0){
				if(ids!=null && ids!=""){
				   var bjid=$("#id").val();	
				  		 			   				 												   
				   window.location.href="${ctx}/xsfb/xsfb/fb?id="+ids+"&bjid="+bjid; 				   				  			   
				}
			}
			else if(count==0){
				alertx('请选择学生信息！');
			}    
        }
     </script>
     <ul class="nav nav-tabs">
		<li><a href="${ctx}/xsfb/xsfb/">新生分班管理列表</a></li>
		<li class="active"><a href="${ctx}/xsfb/xsfb/form?id=${xsfb.id}">新生分班</a></li>
	</ul><br/>  
	<form:form id="searchForm" modelAttribute="xsfb" action="${ctx}/xsfb/xsfb/form" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="id" name="id" type="hidden" value="${xsfb.id}"/>
		<input id="yyrs" name="yyrs" type="hidden" value="${yyrs}"/>
		<table class="ul-form">
			<tr>
				<th>招生计划</th>
				<td>
					<select style="width:185px;" id="zsjhid"  name="zsjhid" class="input-xlarge required">
						<option value="">--请选择--</option>
						<c:forEach items="${fns:findListZsjh()}" var="zsjh">
							<option value="${zsjh.id }"<c:if test="${zsjh.id==zsjhid}">selected="selected"</c:if>>${zsjh.jhmc}</option>
						</c:forEach>
					</select>
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
				<th>班级名称</th>
				<td>
					<input type="text" name="bjmc" value="${xsfb.bjmc}" disabled="disabled"/>	
				</td>
				<th>班级专业</th>
				<td>
					<input type="text" name="zyId.zymc" value="${xsfb.zyId.zymc}" disabled="disabled"/>
				</td>
				<th>容纳学生</th>
				<td>
					<input type="text" name="rnrs" value="${xsfb.rnrs}" disabled="disabled"/>
				</td>
				<th>已有学生</th>
				<td>
					<input type="text" name="yyrs" value="${yyrs}" disabled="disabled"/>
				</td>
			</tr>
		</table>
	</form:form>
	<div style="color: red;">选择招生计划，给选中批次学生进行分班！</div>
	<sys:message content="${message}"/>
	<input id="btnAdd" class="btn btn-primary" type="button" onclick="divideClass()" value="分班"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>招生计划名称</th>
				<th>学生姓名</th>	
				<th>性别</th>			
				<th>身份证件号码</th>
				<th>专业类别</th>
				<th>专业名称</th>
				<th>出生日期</th>
				<th>家庭住址</th>
				<th>联系电话</th>		
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsdj">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${zsdj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zsdj.id}" />
			    </td>
			    <td>
					${zsdj.zsjh.jhmc}
				</td>
				<td>
					${zsdj.xm}
				</td>
				<td>
					${fns:getDictLabel(zsdj.xbm, 'sex', '')}
				</td>
				<td>
					${zsdj.sfzjh}
				</td>
				<td>
					${zsdj.zylx.lxmc}
				</td>
				<td>
					${zsdj.zy.zymc}
				</td>
				<td>
					<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>
				</td>
				<td title="${zsdj.jtzz }">
					${fns:abbr(zsdj.jtzz,15)}
				</td>
				<td>
					${zsdj.lxdh}
				</td>		
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>