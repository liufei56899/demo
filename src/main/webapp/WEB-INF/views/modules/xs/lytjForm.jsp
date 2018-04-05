<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生统计</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function SearchLytj(){
		    var zsjhidval = $("#selector").find("option:selected").val();
			$.getJSON("${ctx}/xs/xsJbxx/lytjList",{zsjhid : zsjhidval},function(data){
				$("#lytjTable").html(data.lytjTable);
				 var zymc = data.zymclist;//专业名称  
				 var zswdj = data.zswdjlist;//招生网登记
				 var zslsdj = data.zslsdjist;//招生老师登记
				 var mmdj = data.mmdjlist;//慕名登记
				 var zsdj = data.zsdjlist;//招生代理机构登记
				 //填充柱形图
			     viewMajorSources(zymc,zswdj,zslsdj,mmdj,zsdj);
			});
		}
		
		function viewMajorSources(zymc,zswdj,zslsdj,mmdj,zsdj){  
		   $('#container').highcharts({
								chart : {
									type : "column"
								},
								title : {
									text : "各专业名称来源统计"
								},
								subtitle : {
									text : "<div><img src=\"${ctxStatic}/images/blue.png\">招生网登记<img src=\"${ctxStatic}/images/orange.png\">招生老师登记<img src=\"${ctxStatic}/images/green.png\">慕名登记<img src=\"${ctxStatic}/images/purple.png\">招生代理机构登记</div>",
									useHTML : true
								},
								xAxis : {
									categories : zymc
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
								series : [ {
									color : "#1874CD",
									name : "招生网登记",
									data : zswdj,
									dataLabels: {
									          enabled: true,
									          format: "{y}"
									}

								}, {
									color : "#CD661D",
									name : "招生老师登记",
									data : zslsdj,
									dataLabels: {
									          enabled: true,
									          format: "{y}"
									}

								}, {
									color : "#00FF00",
									name : "慕名登记",
									data : mmdj,
									dataLabels: {
									          enabled: true,
									          format: "{y}"
									        }
								}, {
									color : "#BA55D3",
									name : "招生代理机构登记",
									data : zsdj,
									dataLabels: {
									          enabled: true,
									          format: "{y}"
									        }
								} ]
							});

		}
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/xs/xsJbxx/lytjForm/">各专业来源情况统计</a></li>
	</ul> --%>
	<form:form id="searchForm1" modelAttribute="zsdj" action="${ctx}/xs/xsJbxx/lytjForm/" method="post" class="breadcrumb form-search">
	<div class="cxtj">统计条件</div>
		<table class="ul-form">
		   <tr>
			<th style="width:200px;">统计方式</th>
	     	<td style="width:300px;">
				<select  style="width:175px;">
				<option value="来源">来源</option>
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
			<td class="btns" colspan="4" align="center"><input id="btnSearch" onclick="SearchLytj();" class="btn btn-primary" type="button" value="查询"/>
			</td>
		</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<div class="cxjg">统计结果</div>
	<div id="lytjTable" style="width: 98%"></div>
	<div id="container" style="width: 98%"></div>
</body>
</html>