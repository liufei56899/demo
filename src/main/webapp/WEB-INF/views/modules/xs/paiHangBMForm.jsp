<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生统计</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/main/main.js"></script>
	<script type="text/javascript" src="${ctxStatic}/main/mainHighchartsGR.js"></script>
	<style type="text/css">
	 	.table{
	 	 padding: 0 1px;
	 	}
	 	.mclb>td,.mc_head>tr>th{
	 	padding:0;
	 	height: 50px;
	 	line-height: 50px;
	 	padding-left: 40px;
	 	}
	 	.mclb #mc_1{
	 	 background:url("${ctxStatic}/images/g_1.png") no-repeat 7px 15px; 
	 	 
	 	}
	 	.mclb #mc_2{
	 	background:url("${ctxStatic}/images/g_2.png") no-repeat 7px 15px; 
	 	}
	 	.mclb #mc_3{
	 	background:url("${ctxStatic}/images/g_3.png") no-repeat 7px 15px; 
	 	}
	</style>
	<script type="text/javascript">
		function exportBM(){
			var jhId = $("#jhId").val();	
		window.location.href = "${ctx}/statistics/exportBMpaiHang?jhId="+jhId;
		}
	</script>
</head>
<body>
	<form:form id="searchForm1" modelAttribute="jhFjRw" action="${ctx}/xs/xsJbxx/paiHangBMForm" method="post" class="breadcrumb form-search">
	<div class="cxtj">查询条件</div>
		<table class="ul-form">
		   <tr>
	       <th style="width:50%;font-size: 14px;">招生计划</th>
		   <td style="width:50%;">
				<form:select id="jhId" path="jhId" maxlength="64" class="input-medium" style="width:175px;">
					<form:option value="" label="" />
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc"
						itemValue="id" htmlEscape="false" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td class="btns" colspan="2" align="center">
			    <input id="btnSearch" class="btn btn-primary" type="submit" value="查询"/>
			    <input id="btnSearch" class="btn btn-primary" type="button" value="导出" onclick="exportBM()"/>
			</td>
		</tr>
		</table>
	</form:form>
	<div class="cxjg">查询结果</div>
	<div class="content_style" id="zstjgr_info">
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead class="mc_head">
			<tr>
				<th>名次</th>
				<th>部门</th>
				<th>招生任务数</th>
				<th>招生登记数</th>
				<th>招生完成数</th>
				<th>招生完成率</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="paihang">
			<tr class="mclb">
				<td id="mc_${paihang.ranking}">
					第${paihang.ranking}名
				</td>
				<td>
					${paihang.name}
				</td>
				<td>
					${paihang.num1}
				</td>
				<td>
					${paihang.num2}
				</td>
				<td>
					${paihang.num3}
				</td>
				<td>
					${paihang.num4}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
</body>
</html>