<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度间招生任务完成情况</title>
<link rel="stylesheet" type="text/css"
	href="${ctxMap_static}/css/main.css">
<%@include file="/WEB-INF/views/include/head.jsp"%>
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<style type="text/css">
table,tr,td {
	border: 1px solid #ddd;
	text-align: center; 
}

td {
	height: 40px;
	font-size: 14px;
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

.ndzs_title {
	height: 45px;
	line-height: 45px;
	font-size: 16px;
	border: 1px solid #ddd;
}

.select2-container {
	width: 230px;
}

.select2-container>ul {
	border-radius: 4px;
}


.btn-primary_1 {
	margin: 0 20px;
}
.select2-search-choice{
	  	border:none !important;
	  	background: none !important;
	  	padding: 0 !important;
	  	line-height: 26px !important;
	  	padding-left: 15px !important;
	  	
	  }
	  .select2-choices>li{
	   height: 26px !important;
	  }
</style>
<script type="text/javascript" src="${ctxMap_static}/js/echarts.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxMap_static}/js/echarts.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxMap_static}/js/citymap.js"
	charset="UTF-8"></script>

<script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
<script src="http://cdn.hcharts.cn/highstock/highstock.js"></script>
<script src="http://cdn.hcharts.cn/highmaps/highmaps.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/highcharts-3d.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
					  $("#zsnd").select2({
					         	allowClear: true,
						        newYearId: true,
						        maximumSelectionSize:3
						    });
		});
	
	jQuery.fn.rowspan = function(colIdx) { //封装的一个JQuery小插件，合并相同id的td行
		return this.each(function() {
			var that;
			$('tr', this).each(
					function(row) {
						$('td:eq(' + colIdx + ')', this).filter(':visible')
								.each(
										function(col) {
											if (that != null
													&& $(this).attr("id") == $(
															that).attr("id")) {
												rowspan = $(that).attr(
														"rowSpan");
												if (rowspan == undefined) {
													$(that).attr("rowSpan", 1);
													rowspan = $(that).attr(
															"rowSpan");
												}
												rowspan = Number(rowspan) + 1;
												$(that)
														.attr("rowSpan",
																rowspan);
												$(this).hide();
											} else {
												that = this;
											}
										});
					});
		});
	}
	function loadStat(zsnd) {
		//每次加载统计前，将图表和图形两部分节点都重置为显示状态
		//$("#chartStat").show();
		//$("#listStat").show();
		myChart1.showLoading({
			text : '正在努力加载中...'
		}); //数据加载完之前先显示一段简单的loading动画
		myChart2.showLoading({
			text : '正在努力加载中...'
		}); //数据加载完之前先显示一段简单的loading动画
		var names = []; //类别数组（实际用来盛放X轴坐标值）
		var nums = [];//值数组（用来填充数据）
		var htmlAllJh = "";
		$.ajax({
			type : "post",
			async : false, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "${ctx}/statistics/statNDJZSRWWCQK", //请求发送 url
			data : {
				zsnd : zsnd
			},
			dataType : "json", //返回数据形式为json
			success : function(result) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (result) {
					for ( var i = 0; i < result.length; i++) {
						names.push(result[i].name); 
						nums.push({
							name : result[i].name,
							type : 'bar',
							data : [ 
									 result[i].num1,
									 result[i].num2,
									 result[i].num3 
									],
									 itemStyle: { /* 设置颜色 */
                							normal: {
                					 			 color: function(params) { /* 设置颜色 */
                       										 var colorList = ['#FA4E4E','#4476CA','#BDDB77' ];
                       									 return colorList[params.dataIndex];
                										}
                							}
                					}
						}); //挨个取出值并填入值数组
						htmlAllJh += "<tr id='allJhStat'><td colspan='3'>"
								+ result[i].name
								+ "年度招生计划</td><td colspan='3'>"
								+ result[i].num1 + "</td><td colspan='3'>"
								+ result[i].num2 + "</td><td colspan='2'>"
								+ result[i].num3 + "</td><td colspan='2'>"
								+ result[i].num4 + "</td></tr>";
					}
					var zsndString = zsnd.replace(new RegExp('\\|', 'gm'), '-');
					myChart1.hideLoading(); //隐藏加载动画//清空画布，防止缓存
					myChart1.clear();
					// 重新设置配置项和数据显示图表。
					myChart1.setOption(option1);
					myChart1.setOption({ //加载数据图表
						title : {
							text : zsndString + '年度间招生任务比对分析'
						},/* 
						legend : {
							data : names,
							top : 'bottom',//图例组件离容器上侧的距离
							left : 'center',//图例组件离容器左侧的距离
							itemWidth : 14
						//图例标记的图形宽度
						}, */
						series : nums
					});

					//填充列表统计数据 中 年度总任务情况统计
					$("tr").remove("#allJhStat");
					$("#allJhStatHead").after(htmlAllJh);

				}

			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
				myChart1.hideLoading();
			}
		});
		var namess = [];//类别数组（实际用来盛放X轴坐标值）
		var nums1 = [];//值数组（用来填充数据）
		var nums2 = [];//值数组（用来填充数据）
		var nums3 = [];//值数组（用来填充数据）
		var series = [];//填充数据
		var legend = [];
		$.ajax({
			type : "post",
			async : false, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "${ctx}/statistics/statNDJZSJGZSWCQK", //请求发送 url
			data : {
				zsnd : zsnd
			},
			dataType : "json", //返回数据形式为json
			success : function(result) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (result) {
					var legend1 = [];
					var legend2 = [];
					var legend3 = [];
					var data1 = [];
					var data2 = [];
					var data3 = [];
					var name1 = "";
					var name2 = "";
					var name3 = "";
					for ( var j = 0; j < result.length; j++) {
						name1 = result[j][0].id + "招生任务数";
						name2 = result[j][0].id + "招生登记数";
						name3 = result[j][0].id + "招生完成数";
						//取出多个年度对应的图例
						legend1.push(name1);
						legend2.push(name2);
						legend3.push(name3);
						var data11 = [];//用来存放每个年度对应的各部门的任务数
						var data22 = [];//用来存放每个年度对应的各部门的登记数
						var data33 = [];//用来存放每个年度对应的各部门的完成数
						namess = [];
						for ( var int = 0; int < result[j].length; int++) {
							data11.push(result[j][int].num1);
							data22.push(result[j][int].num2);
							data33.push(result[j][int].num3);
							namess.push(result[j][int].name);
						}
						data1.push({
							name : name1,
							type : 'bar',
							data : data11,
							 itemStyle: { /* 设置颜色 */
                							normal: {
                					 			 color: '#FA4E4E'
                							}
                					}
						});//各年度对应各部门的任务数
						data2.push({
							name : name2,
							type : 'bar',
							data : data22,
							 itemStyle: { /* 设置颜色 */
                							normal: {
                					 			 color: '#4476CA'
                							}
                					}
						});//各年度对应各部门的登记数
						data3.push({
							name : name3,
							type : 'bar',
							data : data33,
							 itemStyle: { /* 设置颜色 */
                							normal: {
                					 			 color:'#BDDB77'
                							}
                					}
						});//各年度对应各部门的完成数
					}

					legend = legend.concat(legend1).concat(legend2).concat(
							legend3);//合并图例
					series = series.concat(data1).concat(data2).concat(data3);//合并数组数据
					zsndString = zsnd.replace(new RegExp('\\|', 'gm'), '-');
					myChart2.hideLoading(); //隐藏加载动画
					//清空画布，防止缓存
					myChart2.clear();
					// 重新设置配置项和数据显示图表。
					myChart2.setOption(option2);
					myChart2.setOption({ //加载数据图表
						title : {
							text : zsndString + '年度间招生机构招生任务比对分析'
						},
						legend : {
							data : legend,
							top : 'bottom',//图例组件离容器上侧的距离
							left : 'center',//图例组件离容器左侧的距离
							itemWidth : 14
						//图例标记的图形宽度
						},
						xAxis : {
							data : namess
						},
						series : series

					});

					//加载统计表格 中 网上招生和学校招生
					//$("tr").remove("#otherStat");
					//$("#subtotal").after(htmlOther);
				}

			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
				myChart2.hideLoading();
			}
		})
		//加载统计表格
		loadTableStat(zsnd);
		//加载完数据后，显示到图表
		//changChart();
	}

	//查询并填充列表统计数据，年度总任务情况数据在图表填充时填充
	function loadTableStat(zsnd) {
		//加载表格前先移除之前的数据 
		$("tr").remove("#fjJhStat");
		$
				.ajax({
					type : "post",
					async : false, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "${ctx}/statistics/statNDJZSRWWCQKTable", //请求发送 url
					data : {
						zsnd : zsnd
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (result) {
							for ( var key in result) {
								var nd = key;
								var bmResult = result[nd][1];
								var ryResult = result[nd][0];
								var otherResult = result[nd][2];
								var sumJhNum = 0;
								var sumDjNum = 0;
								var sumWcNum = 0;
								var html = "";//表格展示分类统计
								var htmlOther = "";//表格展示网上招生和学校招生情况
								for ( var i = 0; i < otherResult.length; i++) {
									htmlOther += "<tr id='fjJhStat'><td id='"+nd+"'>"
											+ nd
											+ "年度招生计划</td>"
											+ "<td colspan='2'>"
											+ otherResult[i].name
											+ "</td>"
											+ "<td></td>"
											+ "<td></td>"
											+ "<td></td>"
											+ "<td></td>"
											+ "<td></td>"
											+ "<td></td>"
											+ "<td>"
											+ otherResult[i].num2
											+ "</td>"
											+ "<td>"
											+ otherResult[i].num3
											+ "</td>"
											+ "<td></td>"
											+ "<td>"
											+ otherResult[i].num8
											+ "</td>"
											+ "</tr>";
								}
								for ( var i = 0; i < bmResult.length; i++) {
									//填充列表统计数据 中 分类任务情况统计
									var bmId = bmResult[i].id;
									var bmName = bmResult[i].name;
									var bmJhNum = bmResult[i].num1;
									var bmDjNum = bmResult[i].num2;
									var bmWcNum = bmResult[i].num3;
									var bmWcPercent = bmResult[i].num4;
									var bmWcInAllPercent = bmResult[i].num8;
									var bmType = bmResult[i].num5;
									sumJhNum += bmJhNum;
									sumDjNum += bmDjNum;
									sumWcNum += bmWcNum;
									for ( var j = 0; j < ryResult.length; j++) {
										var ryId = ryResult[j].id;
										var ryName = ryResult[j].name;
										var ryJhNum = ryResult[j].num1;
										var ryDjNum = ryResult[j].num2;
										var ryWcNum = ryResult[j].num3;
										var ryWcPercent = ryResult[j].num4;
										var ryBmId = ryResult[j].id2;
										var ryBmName = ryResult[j].name2;
										if (bmId == ryBmId) {
											if (bmType == 2) {
												html += "<tr id='fjJhStat'><td id='"+nd+"'>"
														+ nd
														+ "年度招生计划</td>"
														+ "<td id='"+bmType+"'>学校招生部门</td>"
														+ "<td id='"+bmId+"'>"
														+ bmName
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmJhNum
														+ "</td>"
														+ "<td>"
														+ ryName
														+ "</td>"
														+ "<td>"
														+ ryJhNum
														+ "</td>"
														+ "<td>"
														+ ryDjNum
														+ "</td>"
														+ "<td>"
														+ ryWcNum
														+ "</td>"
														+ "<td>"
														+ ryWcPercent
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmDjNum
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmWcNum
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmWcPercent
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmWcInAllPercent
														+ "</td>" + "</tr>";
											} else {
												html += "<tr id='fjJhStat'><td id='"+nd+"'>"
														+ nd
														+ "年度招生计划</td>"
														+ "<td id='"+bmType+"'>代理机构</td>"
														+ "<td id='"+bmId+"'>"
														+ bmName
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmJhNum
														+ "</td>"
														+ "<td>"
														+ ryName
														+ "</td>"
														+ "<td>"
														+ ryJhNum
														+ "</td>"
														+ "<td>"
														+ ryDjNum
														+ "</td>"
														+ "<td>"
														+ ryWcNum
														+ "</td>"
														+ "<td>"
														+ ryWcPercent
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmDjNum
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmWcNum
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmWcPercent
														+ "</td>"
														+ "<td id='"+bmId+"'>"
														+ bmWcInAllPercent
														+ "</td>" + "</tr>";
											}
										}
									}
								}
								$("#hiddenTable").empty();
								//将数据添加到隐藏table中
								$("#hiddenTable").append(html);
								//合并隐藏table中相同id的单元格
								$("#hiddenTable").rowspan(0);
								$("#hiddenTable").rowspan(1);
								$("#hiddenTable").rowspan(2);
								$("#hiddenTable").rowspan(3);
								$("#hiddenTable").rowspan(9);
								$("#hiddenTable").rowspan(10);
								$("#hiddenTable").rowspan(11);
								$("#hiddenTable").rowspan(12);
								//加载小计行
								$("#hiddenTable").append(
										"<tr id='fjJhStat'><td id='"+nd+"'>"
												+ nd + "年度招生计划</td>"
												+ "<td colspan='2'>小计</td>"
												+ "<td>" + sumJhNum + "</td>"
												+ "<td></td>" + "<td></td>"
												+ "<td></td>" + "<td></td>"
												+ "<td></td>" + "<td>"
												+ sumDjNum + "</td>" + "<td>"
												+ sumWcNum + "</td>"
												+ "<td></td>" + "<td></td>"
												+ "</tr>");
								//加载其它统计项
								$("#hiddenTable").append(htmlOther);
								$("#hiddenTable").rowspan(0);
								//将合并后的单元格加到原表格相应位置
								$("#statTable").append($("#hiddenTable tr"));
							}

						}

					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
					}
				});
	}
	/* function changChart() {
		$("#chartStat").show();
		$("#listStat").hide();
		$("#chartButton").attr("disabled", "disabled");
		$("#tableButton").removeAttr("disabled");
	}
	function changTable() {
		$("#listStat").show();
		$("#chartStat").hide();
		$("#tableButton").attr("disabled", "disabled");
		$("#chartButton").removeAttr("disabled");
	} */
	//页面加载完后调用ajax加载图表
	$(function() {
		//设置多选下拉框中的属性
		/* $("#zsnd").multipleSelect({
			placeholder : "请选择",
			selectAllText : "全部选中",
			selectAll : false,
			minimumCountSelected : 3,
			countSelected : "#",
			width : "10%",
			filter : true
		}); */

		/* var zsnd = $("#zsnd").multipleSelect("getSelects") + ""; */
		/* zsnd = zsnd.replace(new RegExp(',', 'gm'), '|'); */
		var zsnds = $("#zsnd").val();
		var zsnd = "";
		for ( var int = 0; int < zsnds.length; int++) {
			zsnd += zsnds[int];
			if (int + 1 != zsnds.length) {
				zsnd += "|";
			}
		}
		loadStat(zsnd);
	});
	//查询按钮点击事件
	function statButton() {
		/* var zsnd = $("#zsnd").multipleSelect("getSelects") + "";
		zsnd = zsnd.replace(new RegExp(',', 'gm'), '|');
		console.log(zsnd); */
		var zsnds = $("#zsnd").val();
		var zsnd = "";
		if(zsnds==null ||zsnds.length<2){
			 alertx("招生年度至少选择2个年度！")
		}else{
		for ( var int = 0; int < zsnds.length; int++) {
			zsnd += zsnds[int];
			if (int + 1 != zsnds.length) {
				zsnd += "|";
			}
		}
		loadStat(zsnd);
		}
	}	
	/*统计结果导出excl*/
	function statExport(){
		var zsnds = $("#zsnd").val();
		var zsnd = "";
		if(zsnds==null||zsnds.length<2){
			 alertx("招生年度至少选择2个年度！")
		}else{
		for ( var int = 0; int < zsnds.length; int++) {
			zsnd += zsnds[int];
			if (int + 1 != zsnds.length) {
				zsnd += "|";
			}
		}
		window.location.href = "${ctx}/statistics/expStatNDZSJGZSWCQK?zsnd="+zsnd;
		}
	}
</script>
</head>
<body>
		<form action="#" class="breadcrumb form-search">
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				 <tr>
	       			<th style="width:50%;font-size: 14px;">招生年度</th>
	       			<td style="width:50%;text-align: left; " >
					<select id="zsnd" class="input-medium" multiple="multiple">
				<c:forEach items="${zsndList}" var="zsnd" varStatus="status">
					<option value="${zsnd.zsnd}"
						<c:if test="${status.index==0||status.index==1}">selected="selected"</c:if>>${zsnd.zsnd}</option>
				</c:forEach>
					</select>
				</td>
				</tr>
			<tr align="center">
				<td  class="btns" colspan="2">
					<input type="button" class="btn btn-primary"
				onclick="statButton()" value="查询" />
			<input type="button" class="btn btn-primary" onclick="statExport()" value="导出" /> 
				</td>
			</tr>
			</table>	 
		</form>
	<!-- <div class="txtb">
		<button id="chartButton" onclick="changChart()" disabled="disabled">图形</button>
		<button id="tableButton" onclick="changTable()">列表</button>
	</div> -->
	<div class="cxjg">查询结果</div>
	<div class="easyui-tabs" style="">
		<div title="图形" style="padding:20px;min-width:100px;">

			<div id="chartStat" style="margin-bottom: 30px;">
				<div>
					<div id="main1" style="width: 90%;height:300px;">
						<script type="text/javascript">
							// 基于准备好的dom，初始化echarts实例
							var myChart1 = echarts.init(document
									.getElementById('main1'));
							// 指定图表的配置项和数据
							var option1 = {
								title : {
									text : '2017年度招生任务完成情况',
									left : 'center'
								},
								tooltip : {
									trigger : 'axis',
									axisPointer : { // 坐标轴指示器，坐标轴触发有效
										type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
									}
								},
								legend : {
									data : [],
									top : 'bottom',//图例组件离容器上侧的距离
									left : 'center',//图例组件离容器左侧的距离
									itemWidth : 14
								//图例标记的图形宽度
								},
								xAxis : {
									data : [ "招生任务数", "招生登记数", "招生完成数" ]
								},
								yAxis : {},
								series : []
							};

							//清空画布，防止缓存
							myChart1.clear();
							// 使用刚指定的配置项和数据显示图表。
							myChart1.setOption(option1);
						</script>
					</div>
					<div id="main2" style="width: 90%;height:300px;">
						<script type="text/javascript">
							// 基于准备好的dom，初始化echarts实例
							var myChart2 = echarts.init(document
									.getElementById('main2'));
							// 指定图表的配置项和数据
							var option2 = {
								title : {
									text : '2017年招生机构招生完成情况',
									left : 'center'
								},
								tooltip : {
									trigger : 'axis',
									axisPointer : { // 坐标轴指示器，坐标轴触发有效
										type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
									}
								},
								legend : {
									data : [],
									top : 'bottom',//图例组件离容器上侧的距离
									left : 'center',//图例组件离容器左侧的距离
									itemWidth : 14
								//图例标记的图形宽度
								},
								grid : {
									bottom : '10%',
									containLabel : true
								},
								xAxis : [ {
									type : 'category',
									data : []
								} ],
								yAxis : [ {
									type : 'value'
								} ],
								series : []
							};

							//清空画布，防止缓存
							myChart2.clear();
							// 使用刚指定的配置项和数据显示图表。
							myChart2.setOption(option2);
						</script>
					</div>
				</div>
			</div>
		</div>
		<div title="列表" style="overflow:auto;padding:20px;min-width:100px;">
			<div id="listStat">
				<table id="statTable" cellspacing="0"
					style="width: 99.9%;height: 100%;margin-bottom: 30px; margin-left: 1.5px">
					<tr id="allJhStatHead">
						<td colspan="3">年度招生计划</td>
						<td colspan="3">招生总任务数</td>
						<td colspan="3">招生总登记数</td>
						<td colspan="2">招生总完成数</td>
						<td colspan="2">招生总完成率</td>
					</tr>
					<tr id="allJhStat"></tr>
					<tr id="fjJhStatHead">
						<td>年度招生计划</td>
						<td colspan="2">招生机构</td>
						<td>招生机构任务数</td>
						<td>招生人员姓名</td>
						<td>个人招生任务数</td>
						<td>个人招生登记数</td>
						<td>个人招生完成数</td>
						<td>个人招生完成率</td>
						<td>招生机构登记数</td>
						<td>招生机构完成数</td>
						<td>招生机构完成率</td>
						<td>占总招生任务数比率</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<table id="hiddenTable"></table>
</body>
</html>
