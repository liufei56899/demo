<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
</head>
<body>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<script type="text/javascript">
	
		$(document).ready(function() {
		 	getzytjList(); 
		 	$(".highcharts-container").find("text[text-anchor='end']").last().html("");
		});
		
		
		
		function getzytjList()
		{
			var newYear = $("#newYearId").find("option:selected").val();
			var zszyId = $("#zszyId").find("option:selected").val();
			 jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/tj/ndzyzstj/zytjList",
		        data: {newYear:newYear,id:zszyId},
		        dataType:'json',
		        async:false,
				success: function(data){
					viewZstjbmDbInfo(data);
			   }
		    }); 
		}
		
		
		function viewZstjbmDbInfo(data) {
	$("#container")
			.highcharts(
					{
						chart : {
							type : 'column',
                   		 	margin: [50, 50, 100, 80]
						},
						title : {
							text : '<span style="color:red">'+data.titleStr+'</span> 专业招生任务完成情况',
							style:{
						        fontWeight:"bold"
						    }
						},
						credits : {
							enabled : true
						},
						subtitle : {
							text : "",//部门招生任务完成统计
							useHTML : true
						},
						xAxis : {
							categories : data.zy
						},
						yAxis : {
							title : {
								text : ''
							}
						},
						tooltip : {
				            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
				            '<td style="padding:0"><b>{point.y:.1f} 个</b></td></tr>',
				            footerFormat: '</table>',
				            shared: true,
				            useHTML: true
				        },
						plotOptions : {
							column : {
								pointPadding : 0.2,
								borderWidth : 0,
								pointWidth : 15
							}
						},
						legend : {
							enabled : true
						},
						series : [ {
							name : '招生专业任务数',
							data : data.zsrws,
							/* color : '#6495ED' */
							color : '#FA4E4E'
						}, {
							name : '招生专业登记数',
							data : data.zsdjs,
							/* color : '#8085e9' */
							color : '#4476CA'
						}, {
							name : '招生专业完成数',
							data : data.zswcs,
							/* color : '#90ed7d' */
							color : '#BDDB77'
						} ]
					});
}
	</script>
	
	<div id="container" style="min-width:400px;height:400px"></div>
</body>
</html>