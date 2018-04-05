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
		if(num >0)
		{
			obj.find("td :eq(0)").attr("rowspan",num);
		}
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
				<th>招生年度</th>
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
					<td 
						<c:if test="${fn:length(yearList) <3 }">
							rowspan="2"
						</c:if>
						<c:if test="${fn:length(yearList) >=3 }">
							rowspan="3"
						</c:if>
					>${zsjg.zsbmmc }</td>
					<td>${yearList[0] }</td>
					<td>${zszyrwsMap.zsrs }</td>
					<c:forEach items="${nowYearList }" var="zy">
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
						<c:if test="${tdIndex eq 0 }">
							<td>0</td>
							<td>0</td>
						</c:if>
				   </tr>
					
				<tr>
					<td></td>
					<td>${yearList[1] }</td>
					<td>${zszyrwsMap1.zsrs }</td>
					<c:set value="0" var="tdIndex1"></c:set>
					<c:forEach items="${oldYearList }" var="ozy">
						<c:if test="${zsjg.zsbm eq ozy.zsbm }">
							<c:if test="${ozy.zstype eq '2' }">
								<td>${ozy.zsrs }</td>
							</c:if>
							<c:if test="${ozy.zstype eq '3' }">
								<td>${ozy.zsrs }</td>
							</c:if>
							<c:set value="${tdIndex1+1 }" var="tdIndex1"></c:set>
						</c:if>
					</c:forEach>
						<c:if test="${tdIndex1 eq 1 }">
							<td>0</td>
						</c:if>
						<c:if test="${tdIndex1 eq 0 }">
							<td>0</td>
							<td>0</td>
						</c:if>
				</tr>
				
				<c:if test="${fn:length(yearList) >=3 }">
					<tr>
							<td></td>
							<td>${yearList[2] }</td>
							<td>${zszyrwsMap2.zsrs }</td>
							<c:set value="0" var="tdIndex2"></c:set>
							<c:forEach items="${list1 }" var="zy1">
								<c:if test="${zsjg.zsbm eq zy1.zsbm }">
									<c:if test="${zy1.zstype eq '2' }">
										<td>${zy1.zsrs }</td>
									</c:if>
									<c:if test="${zy1.zstype eq '3' }">
										<td>${zy1.zsrs }</td>
									</c:if>
									<c:set value="${tdIndex2+1 }" var="tdIndex2"></c:set>
								</c:if>
							</c:forEach>
								<c:if test="${tdIndex2 eq 1 }">
									<td>0</td>
								</c:if>
								<c:if test="${tdIndex2 eq 0 }">
									<td>0</td>
									<td>0</td>
								</c:if>
					</tr>
				</c:if>
			
			</c:forEach>
		
		</tbody>
		
	</table>
	<div class="form-actions" style="text-align: center;">
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog1();"/>
		</div>
</body>
</html>