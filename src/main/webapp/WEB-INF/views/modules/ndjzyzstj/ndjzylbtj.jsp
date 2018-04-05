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
		//招生完成数÷招生任务数的百分比
		var num ="${fn:length(map.nf)}";
		$("#zytjTab tr").each(function(index){
			if(index !=0)
			{
				if(num ==2)
			   {
			   		if(index%2== 1)
					{
						$(this).find("td :eq(0)").attr("rowspan",2);
					}else
					{
						$(this).find("td :eq(0)").remove();
					}
			   }
			   else if(num ==3)
			   {
			   		if(index%3==1)
					{
						$(this).find("td :eq(0)").attr("rowspan",3);
					}else{
						$(this).find("td :eq(0)").remove();
					}
			   }
			}
		});
		
		
		$("#zytjTab tr").each(function(index){
			if(index !=0)
			{
				var rws = 0;
				var wcs =0;
			   if(num ==2)
			   {
					if(index%2== 0)
					{
						rws = $.trim($(this).find("td :eq(1)").html());
						wcs =$.trim($(this).find("td :eq(3)").html());
					}else
					{
						rws = $.trim($(this).find("td :eq(2)").html());
						wcs =$.trim($(this).find("td :eq(4)").html());
					}
					if(rws!=0 )
					{
						var lv = parseFloat(wcs/rws);
						if(index%2== 0)
						{
							$(this).find("td :eq(4)").html((lv*100).toFixed(2)+"%");
						}else
						{
							$(this).find("td :eq(5)").html((lv*100).toFixed(2)+"%");
						}
					
					}
				
			}else
			{
				if(index%3==1)
				{
					rws = $.trim($(this).find("td :eq(2)").html());
					wcs =$.trim($(this).find("td :eq(4)").html());
				}else
				{
					rws = $.trim($(this).find("td :eq(1)").html());
					wcs =$.trim($(this).find("td :eq(3)").html());
				}
				if(rws!=0 )
				{
					var lv = parseFloat(wcs/rws);
					if(index%3==1)
					{
						$(this).find("td :eq(5)").html(Number((lv*100)).toFixed(2)+"%");
					}else
					{
						$(this).find("td :eq(4)").html(Number((lv*100)).toFixed(2)+"%");
					}
				
				}
			}
			
			   }
				
		});
		
	});
	
	function zhuanYeOnclick(id)
	{
		var zyjhId = $("#zyjhId").find("option:selected").val();
		var newYearId = $("#newYearId").val();
		var newYear = $("#newYeartxtId").val(newYearId);
		var year = $("#newYeartxtId").val();
		openDialog("${ctx}/tj/ndzyzstj/findndjzytj?id="+id+"&zsnd1="+year,"专业",800,450);
	}
	
</script>
	<table id="zytjTab"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>招生专业名称</th>
				<th>招生年度</th>
				<th>专业招生任务数</th>
				<th>专业招生登记数</th>
				<th>专业招生完成数</th>
				<th>专业招生完成率</th>
			</tr>
		</thead>
		<c:forEach items="${map.zymapList }" var="zy" varStatus="zyInx">
			<c:forEach items="${map.listMap }" var="zymap">
				<tr>
					<td
					><a href="javascript:void(0);" onclick="zhuanYeOnclick('${zy.zyid }');"> ${zy.zymc }(${zy.zyxzmc })</a></td>
					<td>${zymap.nf }</td>
					<td>
						${zymap.nfMap.zsrws[zyInx.index] }
					</td>
					<td>
						${zymap.nfMap.zsdjs[zyInx.index] }
					</td>
					<td>
						${zymap.nfMap.zswcs[zyInx.index] }
					</td>
					<td>0.00%</td>
				</tr>
			</c:forEach>
		</c:forEach>
		
		
		<tbody>
		
		</tbody>
	</table>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>