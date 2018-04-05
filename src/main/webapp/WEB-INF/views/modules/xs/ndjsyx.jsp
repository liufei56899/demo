<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
<title>年度间招生生源校分布情况</title>
<meta name="decorator" content="default" />
<script type="text/javascript"
	src="${ctxStatic}/js/jquery-ui-jqLoding.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctxMap_static}/css/main.css">
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<%-- <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script> --%>
<style type="text/css">
table,tr,td {
	border: 1px solid;
}

.zt {
	font-weight: bold;
}

.tbtr>th {
	text-align: center;
}

.tbtr2>td {
	border: none;
	border-top: 1px solid #ddd;
	border-right: 1px solid #ddd;
	text-align: center;
}

.select2-search-choice {
	border: none !important;
	background: none !important;
	padding: 0 !important;
	line-height: 26px !important;
	padding-left: 15px !important;
}

.select2-choices {
	border-radius: 4px;
}

.select2-choices>li {
	height: 26px !important;
}
</style>
</head>
<body>
	<form action="#" id="formSelect" method="post"
		class="breadcrumb form-search">
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
				<th style="width:200px;font-size:14px; ">招生年度</th>
				<td style="width:300px; "><select id="zsnd"
					class="input-medium" multiple="multiple" name="zsnd"
					class="selectpicker show-tick form-control"
					style="margin-top: -4px; margin-bottom: 0;width: 220px"
					onchange="getSyx()">
						<!-- <select name="zs" id="newYearId" class="selectpicker show-tick form-control"  style="width:185px;" multiple="multiple"> -->
						<c:forEach var="jh" items="${jh }">
							<option value="${jh.zsnd}"
								<c:if test="${fn:contains(zsnd, jh.zsnd)}">
							selected="selected"</c:if>>${jh.zsnd}</option>
						</c:forEach>
				</select>
				</td>
				<th style="width:200px;font-size:14px; ">生源校</th>
				<td style="width:300px;font-size:14px; ">
				<select name="syx" id="syx"
					style="margin-top: -4px; margin-bottom: 0; margin-right: 20px;width: 220px">
						<option value="0" id="ss" selected>请选择</option>
				</select> <input id="hiddenSyx" type="hidden" value="${syxHidden }" /></td>
			</tr>



			<tr>
				<td colspan="4" style="text-align: center;"><input
					type="button" class="btn btn-primary" onclick="seach()" value="查询">
					<input type="button" class="btn btn-primary" onclick="exportMx()"
					value="导出"></td>
			</tr>

		</table>
	</form>
	<div class="cxjg">查询结果</div>

	<div class="easyui-tabs" style="">
		<!-- 表格 -->
		<!-- 图表 -->
		
			<table id="tab" cellspacing="0"
				style="width: 100%;margin-bottom: 30px"
				class="table table-striped table-bordered table-condensed">
				<thead>
					<tr class="tbtr" style="height: 50px;font-size: 16px;color:#444;">
						<th>学生生源校</th>
						<th>招生专业</th>
						<th>年度</th>
						<!-- <th>招生专业任务数</th> -->
						<th>招生专业登记数</th>
						<th>招生专业完成数</th>
					</tr>
				<thead>
				<tbody>
					<c:set var="tempCount" value="0"></c:set>
					<%--临时变量 --%>
					<c:set var="rowspanCount" value="0"></c:set>
					<%--记录合并列数 --%>
					<c:set var="tempFrist" value="0"></c:set>
					<%--记录合并开始位置 --%>
					<c:set var="tempEnd" value="-1"></c:set>
					<%--记录合并结束位置 --%>
					<c:set var="tempCount2" value="0"></c:set>
					<%--临时变量 --%>
					<c:set var="rowspanCount2" value="0"></c:set>
					<%--记录合并列数 --%>
					<c:set var="tempFrist2" value="0"></c:set>
					<%--记录合并开始位置 --%>
					<c:set var="tempEnd2" value="-1"></c:set>
					<%--记录合并结束位置 --%>
					<c:forEach items="${ndjsyx}" var="map" varStatus="status">
						<tr style="height:40px;font-size: 16px" class="tbtr2">
							<%--利用一个结果集List<Bean>来生成，数据过多会加重客户断负担 --%>
							<c:if test="${status.index>=tempEnd}">
								<c:set var="rowspanCount" value="0"></c:set>
								<%--清除历史数据 --%>
								<c:forEach var="map2" items="${ndjsyx}" varStatus="status2">
									<%-- fromSchool指要合并的属性 --%>
									<c:if test="${map.fromSchool==map2.fromSchool}">
										<c:set var="tempFrist" value="${status.index }"></c:set>
										<c:set var="rowspanCount" value="${rowspanCount+1 }"></c:set>
										<c:set var="tempEnd" value="${tempFrist+rowspanCount }"></c:set>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test="${status.index>=tempEnd2}">
								<c:set var="rowspanCount2" value="0"></c:set>
								<%--清除历史数据 --%>
								<c:set var="fromSchoolAndZymc" value=""></c:set>
								<%--清除历史数据 --%>
								<c:set var="fromSchoolAndZymc2" value=""></c:set>
								<%--清除历史数据 --%>
								<c:forEach var="map3" items="${ndjsyx}" varStatus="status3">
									<%-- fromSchool指要合并的属性 --%>
									<c:set var="fromSchoolAndZymc"
										value="${map.fromSchool}${map.zymc}"></c:set>
									<c:set var="fromSchoolAndZymc2"
										value="${map3.fromSchool}${map3.zymc}"></c:set>
									<c:if test="${fromSchoolAndZymc==fromSchoolAndZymc2}">
										<c:set var="tempFrist2" value="${status.index }"></c:set>
										<c:set var="rowspanCount2" value="${rowspanCount2+1 }"></c:set>
										<c:set var="tempEnd2" value="${tempFrist2+rowspanCount2 }"></c:set>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test="${status.index==tempFrist}">
								<td rowspan="${rowspanCount}">
									<%-- fromSchool指要合并的属性 --%> ${map.fromSchool}</td>
							</c:if>
							<c:if test="${status.index==tempFrist2}">
								<td rowspan="${rowspanCount2}">
									<%-- zymc指要合并的属性 --%> ${map.zymc}</td>
							</c:if>
							<td>${map.zsnd }</td>
							<%--  <td>${map.rws }</td> --%>
							<td>${map.djs }</td>
							<td>${map.wcs }</td>
						</tr>
					</c:forEach>
					<%-- <c:forEach var="map" items="${ ndjsyx}">
	         <tr style="height:40px;font-size: 16px" class="tbtr2">
						<td id="${map.fromSchool }">${map.fromSchool }</td>
						<td id="${map.fromSchool }+${map.zymc}">${map.zymc}</td>
						<td>${map.zsnd }</td>
						 <td>${map.rws }</td>
						<td>${map.djs }</td>
						<td>${map.wcs }</td>
			 </tr>
	         </c:forEach> --%>
				</tbody>
			</table>
		</div>

	<script type="text/javascript">
		function getSyx() {
			var str = $("#zsnd").val();
			var syx = $("#hiddenSyx").val();
			$
					.ajax({
						type : "POST",
						url : "${ctx}/statistics/sResources?zsnd=" + str,
						dataType : 'json',
						async : true,
						success : function(result) {
							$("#syx").empty();
							$("#syx").append(
									'<option selected="selected" value="">' + '请选择' + '</option>');
							for ( var i = 0; i < result.length; i++) {
								var r = result[i];
								if (r.str == syx) {
									$("#syx").append(
											'<option value="'+r.str+'" selected="selected">'
													+ r.str + '</option>');
								} else {
									$("#syx").append(
											'<option value="'+r.str+'">'
													+ r.str + '</option>');
								}
								$("#syx").find("option[value='']").attr("selected",false);
								$("#syx").select2();
							}
						}
					});
			$("#hiddenSyx").val("");
		}

		function seach() {
			var str = $("#zsnd").val();
			if (str == null || str.length < 2) {
				alertx("招生年度至少选择2个年度！")
			} else {
				$("#formSelect").attr("action", "${ctx}/xs/xsJbxx/ndjsyx").submit();
			}
		}

		/* 导出 */
		function exportMx() {
		   $.fn.jqLoading({backgroundImage: "${ctxStatic}/js/loading.gif",
                			height: 100, width: 240, text: "正在加载中，请耐心等待...." });
			var zsnd = $("#zsnd").val();
			var syx = $("#syx").val();
			jQuery
					.ajax({
						type : "POST",
						url : "${ctx}/statistics/exportMx?zsnd=" + zsnd
								+ "&syx=" +encodeURI(encodeURI(syx)),
						dataType : 'json',
						async : true,
						success : function(data) {
							updateFile(data);
						}
					});
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
		//下载
		function updateFile(filePath) {
			window.location.href = '${ctx}/statistics/updateFile?filePath='
					+ encodeURI(encodeURI(filePath));
		}
	</script>
	<script type="text/javascript">
		jQuery.fn.rowspan = function(colIdx) { //封装的一个JQuery小插件，合并相同id的td行
			return this
					.each(function() {
						var that;
						$('tr', this)
								.each(
										function(row) {
											$('td:eq(' + colIdx + ')', this)
													.filter(':visible')
													.each(
															function(col) {
																if (that != null
																		&& $(
																				this)
																				.attr(
																						"id") == $(
																				that)
																				.attr(
																						"id")) {
																	rowspan = $(
																			that)
																			.attr(
																					"rowSpan");
																	if (rowspan == undefined) {
																		$(that)
																				.attr(
																						"rowSpan",
																						1);
																		rowspan = $(
																				that)
																				.attr(
																						"rowSpan");
																	}
																	rowspan = Number(rowspan) + 1;
																	$(that)
																			.attr(
																					"rowSpan",
																					rowspan);
																	$(this)
																			.hide();
																} else {
																	that = this;
																}
															});
										});
					});
		}

		$(document).ready(function() {
			getSyx();
			$("#zsnd").select2({
				allowClear : true,
				newYearId : true,
				maximumSelectionSize : 3
			});
		});
	</script>
</body>
</html>