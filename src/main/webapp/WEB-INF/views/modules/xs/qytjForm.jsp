<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>招生统计</title>

 <link rel="stylesheet" type="text/css" href="${ctxMap_static}/css/main.css">
    
    <script type="text/javascript" src="${ctxMap_static}/js/echarts.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="${ctxMap_static}/js/citymap.js" charset="UTF-8"></script>
   
<!-- <style type="text/css">
.tabTreeselect {
	width: 120px;
}
</style> -->
<!-- <script type="text/javascript">
		$(document).ready(function() {
			//加载省份
				$.getJSON("${ctx}/sys/area/findallbychr",{parentId:1},function(data){
						if(data.length >0){
								var strSheng = "";
								strSheng += "<option value='0' selected='selected'>--请选择--</option>";
								$.each(data,function(index,m){
									strSheng += "<option value='"+m.id+"'>"+m.name+"</option>";
								});
								$("#shengSelect").html(strSheng);
							}
				});
		});
		
		function chengshi(shengId){
			    //加载城市
				$.getJSON("${ctx}/sys/area/findallbychr",{parentId:shengId},function(data){
						if(data.length >0){
								var strShi = "";
								strShi += "<select id=\"shiSelect\" style=\"width:175px;\">";
								strShi += "<option value='0' selected='selected'>--请选择--</option>";
								$.each(data,function(index,m){
									strShi += "<option value='"+m.id+"'>"+m.name+"</option>";
								});
								strShi += "</select>";
								$("#ShiChoose").html(strShi);
								$("#shiSelect").select2();
							}
				});
		}
		function SearchQytj() {
			var shiSelectValue = $("#shiSelect").val();
		    var zsjhidval = $("#selector").find("option:selected").val();
			$.getJSON("${ctx}/xs/xsJbxx/qytjList", {
				csid : shiSelectValue,
				zsjhid : zsjhidval
			}, function(data) {
				$("#qytjTable").html(data.qytjTable);
				var qyid = data.qyidlist;//区域信息
				var rwl = data.rwllist;//任务量
				var zsl = data.zsllist;//招生量
				var bml = data.bmllist;//报名量
				//填充柱形图
			    viewRegionalAdmissions(qyid,rwl,zsl,bml);
			});
		}
		//填充柱形图
		function viewRegionalAdmissions(qyid,rwl,zsl,bml){
           $('#container').highcharts(
							{
								chart : {
									type : "column"
								},
								title : {
									text : "各区域招生情况统计"
								},
								subtitle : {
									text : "<div><img src=\"${ctxStatic}/images/blue.png\">任务量<img src=\"${ctxStatic}/images/orange.png\">招生量<img src=\"${ctxStatic}/images/green.png\">报名量</div>",
									useHTML : true
								},
								xAxis : {
									categories :qyid
								},
								yAxis : {
									min : 0,
									title : {
										text : ""
									}
								},
								tooltip : {
									headerFormat : "<span style='font-size:10px'>{point.key}</span><table>",
									pointFormat : "<tr><td style='color:{series.color};padding:0'>{series.name}: </td>"
											    + "<td style='padding:0'><b>{point.y:.1f}</b></td></tr>",
									footerFormat : "</table>",
									shared : true,
									useHTML : true
								},
								plotOptions : {
									column : {
										pointPadding : 0.2,
										borderWidth : 0
									}
								},
								series : [
								       {
										    color : "#1874CD",
											name : '任务量',
											data : rwl,
											dataLabels: {
									          enabled: true,
									          format: "{y}"
									        }
										},
										{ 
										    color : "#CD661D",
											name : '招生量',
											data : zsl,
											dataLabels: {
									           enabled: true,
									           format: "{y}"
									        }
										},
										{
										    color : "#00FF00",
											name : '报名量',
											data : bml,
											dataLabels: {
									          enabled: true,
									          format: "{y}"
									        }
										} ]
							});
		}
	</script> -->
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/xs/xsJbxx/qytjForm/">各区域招生情况统计</a>
		</li>
	</ul> --%>
	<%-- <form:form id="searchForm1" modelAttribute="zsdj" action="${ctx}/xs/xsJbxx/qytjForm/" method="post" class="breadcrumb form-search">
	<div class="cxtj">统计条件</div>
	<table class="ul-form">
		<tr>
			<th style="width:200px;">统计方式</th>
	     	<td style="width:300px;">
				<select style="width:175px;">
					<option value="区域">区域</option>
	       		</select>
	       </td>
	       <th style="width:200px;">招生计划</th>
		   <td style="width:300px;">
				<form:select id="selector" path="zsjh.id" maxlength="64" class="input-medium" style="width:175px;">
					<form:option value="" label="" />
				    <form:options items="${fns:getZsjhList()}" itemLabel="jhmc"
						itemValue="id" htmlEscape="false" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th>省份</th>
			<td>
		    	<select id="shengSelect"
			    	class="input-medium" style="width:175px;"
			    	onchange="chengshi(this.value)">
			    	<option value='0' selected='selected'>--请选择--</option>
			 	</select>
			</td>
			<th>城市</th>
		 	<td id="ShiChoose">
				<select id="shiSelect" class="input-medium" style="width:175px;">
			    	<option value='0' selected='selected'>--请选择--</option>
		   		</select>
			</td>
		</tr>
		<tr>
		<td class="btns" colspan="4" align="center">
		    <input id="btnSearch" onclick="SearchQytj();" class="btn btn-primary" type="button" value="查询" />
		</td>
		</tr>
	</table>
	</form:form>
	<sys:message content="${message}" />
	<div class="cxjg">统计结果</div>
	<div id="qytjTable"></div>
	<div id="container"></div> --%>
	
	 <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<%-- 	<div id="main" style="width: 1000px;height:500px;"></div>
	 <script type="text/javascript" src="${ctxMap_static}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctxMap_static}/js/app.js" charset="UTF-8"></script>
    
 --%>
   
</body>
</html>