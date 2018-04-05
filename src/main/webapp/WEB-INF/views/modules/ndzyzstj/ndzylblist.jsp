<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
</head>
<body>
	<style >
		.table th, .table td 
		{
			text-align :center;
		}
	</style>
	<script type="text/javascript">
	$(document).ready(function() {
		
		$("#zytjTab tr").each(function(index){
			if(index !=0)
			{
				var rws = $(this).find("td :eq(1)").html();
				var wcs =$(this).find("td :eq(3)").html();
				if(rws!=0 )
				{
					var lv = parseFloat(wcs/rws);
					$(this).find("td :eq(4)").html((lv*100).toFixed(2)+"%");
				}
			}
		});
	});
	
	function zhuanYeOnclick(id)
	{
		var newYear = $("#newYearId").find("option:selected").val();
		openDialog("${ctx}/tj/ndzyzstj/findndzytjByid?id="+id+"&newYear="+newYear,"专业",800,450);
	}
	
</script>
	<table id="zytjTab"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>招生专业名称</th>
				<th>专业招生任务数</th>
				<th>专业招生登记数</th>
				<th>专业招生完成数</th>
				<th>专业招生完成率</th>
			</tr>
		</thead>
		<tbody>
		
		
			<c:forEach items="${zytjList }" var="zy" varStatus="zyVar">
				<c:set value="0" var="zyIndex" ></c:set>
				<c:set value="0" var="zytype1" ></c:set>
				<c:set value="0" var="zytd" ></c:set>
				<c:if test="${zyVar.count eq 1 }">
					<c:set value="0" var="zyid" ></c:set>
				</c:if>
				
				<c:if test="${zyid ne zy.id }">
					<tr>
						<td> <a href="javascript:void(0);" onclick="zhuanYeOnclick('${zy.id }');"> ${zy.zymc }( ${zy.zyxzmc })</a></td>
						<c:if test="${zy.zstype eq '1' }">
							<td id="zyrw${zy.id }">${zy.zsrs }</td>
							<c:set value="${zy.zstype }" var="zytd" ></c:set>
						</c:if>
						<c:if test="${zy.zstype eq '2' }">
							<td id="zyrw${zy.id }">0</td>
							<td>${zy.zsrs }</td>
							<c:set value="${zy.zstype }" var="zytd" ></c:set>
						</c:if>
						<c:if test="${zy.zstype eq '3' }">
							<td>0</td>
							<td>0</td>
							<td id="zswc${zy.id }">${zy.zsrs }</td>
							<c:set value="${zy.zstype }" var="zytd" ></c:set>
						</c:if>
						<c:set value="0" var="zyid" ></c:set>
						<c:if test="${zy.zstype ne 3 }">
							<c:forEach items="${zytjList }" var="tj" varStatus="tj1">
								<c:if test="${zy.zstype ne tj.zstype }">
									<c:if test="${zy.id eq tj.id }">
										
										<c:if test="${tj.zstype eq '2' }">
											<td>${tj.zsrs }</td>
										</c:if>
										<c:if test="${tj.zstype eq '3' }">
											<td id="zswc${zy.id }">${tj.zsrs }</td>
										</c:if>
										<c:set value="${zytype1 +1 }" var="zytype1" ></c:set>
										<c:set value="${tj.id }" var="zyid" ></c:set>
									</c:if>
								</c:if>	
							</c:forEach>
					  </c:if>
					  
					  <c:if test="${zytype1 eq '0' }">
					  	<c:if test="${zytd eq 1  }">
					  		<td>0</td>
					  		<td  id="zswc${zy.id }">0</td>
					  	</c:if>
					  	<c:if test="${zytd eq 2  }">
					  		<td  id="zswc${zy.id }">0</td>
					  	</c:if>
					  </c:if>
					  
					  <c:if test="${zytype1 eq '1' }">
						  	<c:if test="${zytd eq 1  }">
						  		<td  id="zswc${zy.id }">0</td>
						  	</c:if>
					  </c:if>
										
					<td>0.00%</td>
				
				</tr></c:if>
				
			</c:forEach>
		</tbody>
	</table>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>