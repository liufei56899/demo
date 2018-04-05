<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
</head>
<body>
	<script type="text/javascript">
	$(document).ready(function() {
		
		var num=0;
		var obj;
		$("#zytjForm tr").each(function(index)
		{
			if(index>1)
			{
				num++;
				$(this).find("td :eq(0)").remove();
			}
			if(index==1)
			{
				num++;
				obj = $(this);
			}
		});
		obj.find("td :eq(0)").attr("rowspan",num);
	});
	
	function closeDialog1()
	{
		$("#dialogDiv").parent().css("display", "none");
		$(".window-shadow").css("display", "none");
		$(".window-mask").css("display", "none");
	}
</script>
	<table id="zytjForm"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>专业名称</th>
				<th>招生来源渠道</th>
				<th>招生专业任务数</th>
				<th>招生专业登记数</th>
				<th>招生专业完成数</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${jgList }" var ='zsjg'>
					<c:set value="0" var="tdIndex"></c:set>
					<tr>
							<td rowspan="1">${zyEntity.zyxzmc }</td>
							<td>${zsjg.zsbmmc }</td>
							<td>${zszyrwsMap.zsrs }</td>
					<c:forEach items="${list }" var="zy">
						<c:if test="${zsjg.zsbm eq zy.zsbm }">
							<c:if test="${zy.zstype eq '2' }">
								<td>${zy.zsrs }</td>
							</c:if>
							<c:if test="${zy.zstype eq '3' }">
								<td>${zy.zsrs }</td>
							</c:if>
							<c:set value="${tdIndex+1 }" var="tdIndex"></c:set>
						</c:if>
					</c:forEach>
						<c:if test="${tdIndex eq 1 }">
							<td>0</td>
						</c:if>
						</tr>
			</c:forEach>
			
		
		</tbody>
		
	</table>
	<div class="form-actions" style="text-align: center;">
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog1();"/>
		</div>
</body>
</html>