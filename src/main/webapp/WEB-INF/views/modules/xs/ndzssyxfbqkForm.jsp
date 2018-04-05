<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
<title>年度招生生源校分布情况</title>
<link rel="stylesheet" type="text/css"
	href="${ctxMap_static}/css/main.css">
<script type="text/javascript" src="${ctxMap_static}/js/echarts.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxMap_static}/js/citymap.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-ui-jqLoding.js"></script>
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<style type="text/css">
table,tr,td {
	border: 1px solid;
}
tr>td{
	font-size: 12px !important;
}

.txtb {
	height: 50px;
	line-height: 50px;
	border: 1px solid #ddd;
	padding-left: 50px;
}

.txtb>button {
	width: 80px;
	height: 30px;
	line-height: 30px;
	font-size: 14px;
	border: none;
	border-radius: 4px;
}
.zt{
	font-weight: bold;
}
.tbtr>th{
	text-align: center;
	font-size: 14px;
}
.tbtr2>td{
	border:none;
	border-top: 1px solid #ddd;
	border-right: 1px solid #ddd;
	text-align: center;
}
  .select2-search-choice{
	  	border:none !important;
	  	background: none !important;
	  	padding: 0 !important;
	  	line-height: 26px !important;
	  	padding-left: 15px !important;
	  }
</style>
<!-- <script type="text/javascript">
	 jQuery.fn.rowspan = function(colIdx) { //封装的一个JQuery小插件，合并相同id的td行
	        return this.each(function(){
	            var that;
	            $('tr', this).each(function(row) {
	                $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
	                    if (that!=null && $(this).text() == $(that).text()) {
	                        rowspan = $(that).attr("rowSpan");
	                        if (rowspan == undefined) {
	                            $(that).attr("rowSpan",1);
	                            rowspan = $(that).attr("rowSpan"); 
	                        }
	                        rowspan = Number(rowspan)+1;
	                        $(that).attr("rowSpan",rowspan);
	                        $(this).hide();
	                    } else {
	                        that = this;
	                    }
	                });
	            });
	        });
    }
	
		$(document).ready(function() {
					$("#tb").rowspan(0);
		});
	</script> -->
</head>
<body>
	<div class="ZSND">
		<form action="#" id="formSelect" class="breadcrumb form-search"
			method="post">
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
			<tr>
				<th style="width:200px;font-size:14px; ">招生年度</th>
				<td style="width:300px;font-size:14px; "> 
					<select class="input-medium"  name="zsnd" id="zsnd" onchange="getSyx(this.value)"
				style="margin-top: -4px; margin-bottom: 0;width: 220px">
				<c:forEach var="jh" items="${jh }">
					<!--  遍历所有的招生计划 -->

					<option value="${jh.zsnd}"
						<c:if test="${jh.zsnd==zsnd}">selected="selected"</c:if>>${jh.zsnd}</option>

				</c:forEach>
			</select> 
				</td>
			
				<th style="width:200px;font-size:14px; ">生源校</th>
				<td  style="width:300px;font-size:14px;"> <select name="syx" id="syx"
				style="margin-top: -4px; margin-bottom: 0; margin-right: 20px;width: 220px">
				<option value="" id="ss">
					请选择
					<c:forEach var="school" items="${school}">
						<option value="${school.fromSchool }"
							<c:if test="${school.fromSchool ==fromSchool}">selected="selected"</c:if>>${school.fromSchool}
						
					</c:forEach>
			</select>
			</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;"><input type="button" class="btn btn-primary" onclick="seach()"
				value="查询"> <input type="button" class="btn btn-primary"
				onclick="exportMx()" value="导出"></td>
			</tr>
			</table> 
		</form>
	</div>
	<div class="cxjg">查询结果</div>
<!-- 	<div class="txtb">
		<button onclick="changeTX()" id="tuxing">图形</button>
		<button onclick="changeTB()" id="tubiao">图表</button>
	</div> -->
<!-- <div class="easyui-tabs" style=""> -->

<%-- <div title="图形" style="padding:20px;min-width:100px;">
		<table cellspacing="0" style="width: 80%; margin: 0 auto;" id="tx">
			<!-- 外层循环 -->
			<c:forEach var="zymc" items="${zymcs }" varStatus="main">
				<!-- 外层循环设置div的ID -->
				<c:set var="divId" value="main_${main.index}"></c:set>
				<script type="text/javascript">
			　　 var namess = [];//类别数组（实际用来盛放X轴坐标值）
					var nums1 = [];//值数组（用来填充数据）
					var nums2 = [];//值数组（用来填充数据）
					var nums3 = [];//值数组（用来填充数据）
				</script>
				<c:forEach var="zy" items="${zymc }">
					<c:set var="schoolName" value="${zy.fromSchool}"></c:set>
					<script type="text/javascript">
				$(document).ready(function(){ 
　　                     			 changeTX();
                     }); 
							 namess.push('${zy.zymc }');
							/*  nums1.push('${zy.rws }'); */
							 nums2.push('${zy.djs}');
							 nums3.push('${zy.wcs }');
						</script>
				</c:forEach>
				<!-- 外层循环 -->
				<tr>
					<td style="width: 200px;">${schoolName }</td>
					<td>
					
							<div id="${divId }" style="height:200px;"></div>
						
						</td>
				</tr>
				<script type="text/javascript">
				// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main_'+${main.index}));
			// 指定图表的配置项和数据
			var option = {
				title : {
				/*  text: '世界人口总量',
				 subtext: '数据来自网络' */
				},
				tooltip : {
					trigger : 'axis',
					axisPointer : {
						type : 'shadow'
					}
				},
				legend : {
					data : [ '专业任务数', '专业登记数', '专业完成数' ]
				},
				grid : {
					left : '1%',
					right : '1%',
					bottom : '5%',
					containLabel : true
				},
				xAxis : {
					type : 'value',
					boundaryGap : [ 0, 1 ]
				},
				yAxis : {
					type : 'category',
					data : namess
				},
				series : [ /* {
					name : '专业任务数',
					type : 'bar',
					data : nums1
				}, */ {
					name : '专业登记数',
					type : 'bar',
					data : nums2
				}, {
					name : '专业完成数',
					type : 'bar',
					data :  nums3 
				} ]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
				</script>
			</c:forEach>
		</table>
		</div> --%>
	</center>
	
	<table id="tb" cellspacing="0" style="width: 100%;margin-bottom: 30px" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr class="tbtr">
			<th>学校名称</th>
			<th>专业名称</th>
			<!-- <th>专业招生任务数</th> -->
			<th>专业招生登记数</th>
			<th>专业招生完成数</th>
		</tr>
		</thead>
		<tbody>
			 <c:set var="tempCount" value="0"></c:set><%--临时变量 --%> 
			 <c:set var="rowspanCount" value="0"></c:set><%--记录合并列数 --%> 
			 <c:set var="tempFrist" value="0"></c:set><%--记录合并开始位置 --%> 
			 <c:set var="tempEnd" value="-1"></c:set><%--记录合并结束位置 --%> 
			 <c:forEach var="zy" items="${zymcs}">
			  <c:forEach items="${zy}" var="zymc" varStatus="status" > 
		<%-- <c:forEach var="zymc" items="${zymcs}" varStatus="main"> --%>
			<%-- <c:forEach var="zy" items="${zymc}"> --%>
				<tr class="tbtr2">
				
					<c:if test="${status.index>=tempEnd}"> 
						<c:set var="rowspanCount" value="0"></c:set><%--清除历史数据 --%> 
						<c:forEach var="zymc2" items="${zy}" varStatus="status2"> 
							<%-- fromSchool指要合并的属性 --%> 
							<c:if test="${zymc.fromSchool==zymc2.fromSchool}"> 
								<c:set var="tempFrist" value="${status.index }"></c:set> 
								<c:set var="rowspanCount" value="${rowspanCount+1 }"></c:set> 
								<c:set var="tempEnd" value="${tempFrist+rowspanCount }"></c:set> 
							</c:if> 
						</c:forEach> 
					</c:if> 
					
						<c:if test="${status.index==tempFrist}"> 
						<td rowspan="${rowspanCount}"> 
							<%-- fromSchool指要合并的属性 --%> 
							${zymc.fromSchool} 
						</td> 
					</c:if> 
					<td>${zymc.zymc }</td>
					<td>${zymc.djs }</td>
					<td>${zymc.wcs }</td>
				</tr>
		</c:forEach>
		</c:forEach>
		</tbody>
	</table>
	</div>

</body>
<script type="text/javascript">
          function seach(){
          $("#formSelect").attr("action","${ctx}/xs/xsJbxx/ndzssyxfbqkForm");
          $("#formSelect").submit();
          }
          function getSyx(zsnd){
           $.ajax({
				        type: "POST",
				        url: "${ctx}/statistics/seachResources",
				        data: {zsnd:zsnd},
				        dataType:'json',
				        async:false,
						success: function(result){
						$("#syx").empty();
						$("#syx").append('<option value="">'+'请选择'+'</option>');
						for(var i=0;i<result.length;i++){
						var r=result[i];
						$("#syx").append('<option value="'+r.fromSchool+'">'+r.fromSchool+'</option>');
						}
						}
						});
                   }
           function exportMx(){
           		   $.fn.jqLoading({backgroundImage: "${ctxStatic}/js/loading.gif",
                			height: 100, width: 240, text: "正在加载中，请耐心等待...." });
           	var zsnd = $("#zsnd").val();
          	var syx=$("#syx").val();
			window.location.href = "${ctx}/statistics/getAll?zsnd="+zsnd+"&syx="+encodeURI(encodeURI(syx));
         	zz();
          }
            function zz(){
              $.ajax({
				        type: "POST",
				        url: "${ctx}/statistics/exportSuccess",
				        dataType:'json',
				        async:true,
						success: function(result){
							if(result=="1"||result==1){
						 		$.fn.jqLoading("destroy");
						}else{
								zz();
						}
						}
						});
             }
</script>
</html>