<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
</head>
<body>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style>
		#container 
		{
			width:3000px !important;
			overflow-x:scroll !important;
		}
		.highcharts-container 
		{
			width:5300px !important;
			overflow:initial !important;
		}
	
	</style>
	<script type="text/javascript">
	
		$(document).ready(function() {
		 	getzytjList();
		 	$(".highcharts-container").find("text[text-anchor='end']").last().html("");
		});
		
		
		
		function getzytjList()
		{
			var newYearId = $("#newYearId").val(); 
			var newYear = $("#newYeartxtId").val(newYearId);
			var year = $("#newYeartxtId").val();
			var zszyId = $("#zszyId").find("option:selected").val();
			 jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/tj/ndzyzstj/ndjzytjJson",
		        data: {zsnd1:year,id:zszyId},
		        dataType:'json',
		        async:false,
				success: function(data){
					nianduJianzhuanye(data);
			   }
		    }); 
		}
		
		function nianduJianzhuanye(data)
		{
			var series = [];
			var zsnd = data.nf;
			var inx =0;
			var ndStr ="";
			if(zsnd.length>0)
			{
				for(var j =0;j<zsnd.length;j++)
				{
					ndStr += zsnd[j]+"-";
				}
				ndStr = ndStr.substring(0,ndStr.length-1);
				if(data.listMap!=null && data.listMap!='')
				{
					for(var i=0;i<data.listMap.length;i++)
					{
						series.push(
						{"name":data.listMap[i].nf+'年招生任务数',
						 "data":data.listMap[i].nfMap.zsrws}
						);
					}
					for(var i=0;i<data.listMap.length;i++)
					{
						series.push(
						{"name":data.listMap[i].nf+'年招生登记数',
						 "data":data.listMap[i].nfMap.zsdjs}
						);
					}
					for(var i=0;i<data.listMap.length;i++)
					{
						series.push(
						{"name":data.listMap[i].nf+'年招生完成数',
						 "data":data.listMap[i].nfMap.zswcs}
						);
					}
				}
			}
		
			$('#container').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: '<span style="color:red">'+ndStr+'</span> 年度间招生任务对比分析图',
                    x : -800 ,
					style:{
				        fontWeight:"bold"
				    }
				    
                },
                credits : {
					enabled : true
				},
				subtitle : {
					text : "",
					useHTML : true
				},
                xAxis: {
                    categories: data.zy
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: ''
                    }
                },
				plotOptions : {
					column : {
					    pointPadding: 0.2,
					    borderWidth: 0,
					    pointWidth: 15
					}
				},
				  scrollbar: {
				       enabled: true
				   },
                legend: {
                	enabled : true
                },
                tooltip: {
                    pointFormat: '<span style="color:tomato">{series.name}</span> <b><span style="color:red">{point.y}</span> (人)</b>',
                },
                series: series,
                colors:[    /* 设置颜色 */
					'#fb143a',
					'#E06278',
					'#31B1BA',
					'#54B4CD',
					'#6BA840',
					'#BDDB77',
					'#C0BBDC',
					'#6256A6',
					'#FBC058'
					]
            });
		}
		
		
	</script>
	
	<div id="container" style="height:400px"></div>
</body>
</html>