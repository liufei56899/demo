<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>计划分解管理</title>
<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<style type="text/css">
.border-table {
	border-collapse: collapse;
	border: none;
}

.border-table td {
	border: solid #000 1px;
}
</style>
<link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />

</head>
<body>
<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						//$("#name").focus();
						$("#inputForm").validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
								
						//如果是点击修改进入页面，则加载信息
						if ("${jhFj.zsjh.id}" != "") {
							$("#btnSelectOffice").hide();
							info = "${oldAreaStr}";
							officeInfo = "${oldBmIdStr}";
							officeName = "${oldBmmcStr}";
							//绘制n行三列的表格
							var tableStr = "";
							tableStr += "<table class='table table-striped table-bordered table-condensed'>";
							tableStr += "<tr>";
							tableStr += "<td>部门</td>";
							tableStr += "<td>招生人数</td>";
							tableStr += "<td>划分区域</td>";
							tableStr += "<td>查看</td>";
							tableStr += "</tr>";
							tableStr += "<tr>";
							tableStr += "<td><input id=\"hidden${jhFj.office.id}\" type=\"hidden\" name=\"bmmc\" value=\"${jhFj.office.id}\"/>${jhFj.office.name}</td>";
							if("${jhFj.bcStatus}" == 1 || "${jhFj.fjFlag}" == 1)
							{
								tableStr += "<td>${jhFj.zsrs}</td>";
							}else{
								tableStr += "<td><input id=\"input${jhFj.office.id}\" type=\"text\" name=\"zsrsInput\" value=\"${jhFj.zsrs}\" class=\"input-xlarge\"/></td>";
							}
							tableStr += "<td>${innerTable}</td>";
							tableStr += "<td><a style=\"cursor:pointer;text-decoration: none;\" onclick=\"areaShow()\">查看</a></td>";
							tableStr += "</tr>";
							tableStr += "</table>";
							$("#officeTable").html(tableStr);
							/* $.getJSON("${ctx}/zsjh/zsjh/findSurplus", {
								id : "${jhFj.zsjh.id}"
							}, function(result) {
								$("#surplus").val(result.surplusValue);
							}); */
							$("#surplus").val("${surplusValue}");
							$("#hiddenbmfj").val(info);
							if("${jhFj.bcStatus}" == 1 || "${jhFj.fjFlag}" == 1){
						  		$("#btnSave").addClass(" hide"); 
						  		$("#divHistory").css("display","block");
								$("#approveDiv").css("display","block");
						  	}
							
							//显示历史记录信息
							$.getJSON("${ctx}/jhfj/jhFjRecord/getJhFjRecordList",{jhfjId : "${jhFj.id}"},function(result) {
							            var div = $("#selection_title");
										var option = "<select id=\"selectHistory\" style=\"width:217px;\" onchange=\"openHistoryRecord(this.value)\"><option value=''></option>";
										for ( var i = 0; i < result.length; i++) {
												option += "<option value=\""+result[i].id+"\">"
																	+ result[i].Record
																	+ "</option>";
										}
										option = option + "</select>";
										div.append(option);
										
										$("#selectHistory").select2();
							});
						}
						
						$("#zsjhbmfj").select2();
						//加载部门
						$
								.getJSON(
										"${ctx}/sys/office/treeData",
										{},
										function(data) {
											if (data.length > 0) {
												var strOffice = "<table>";
												$
														.each(
																data,
																function(index,
																		m) {
																	if (index > 0) {
																		var strBmChecked = "";
																		if (officeInfo
																				.indexOf(m.id) != -1) {
																			strBmChecked = "checked=\"checked\"";
																		}

																		strOffice += "<tr>";
																		strOffice += "<td><input type=\"checkbox\" id="
																				+ m.id
																				+ " "
																				+ strBmChecked
																				+ " name="
																				+ m.id
																				+ " value="
																				+ m.name
																				+ " onclick=\"selectOffice(this)\"/>";
																		strOffice += m.name;
																		strOffice += "</td>";
																		strOffice += "</tr>";
																	}
																});
												strOffice += "</table>";
												$("#officePanel").html(
														strOffice);
											}
										});
					});

	var officeInfo = "";
	var officeName = "";
	//选择部门
	function selectOffice(obj) {
		if (obj.checked) {
			officeInfo = officeInfo + obj.id + ",";
			officeName = officeName + obj.value + ",";
		} else {
			officeInfo = officeInfo.replace(obj.id + ",", "");
			officeName = officeName.replace(obj.value + ",", "");
		}
	}
	
	function openHistoryDialog(href, title, width, height) {
		var length = $("div#diaHistoryDiv").size();
		if (length == 0) {
			$("#inputForm").before(
					"<div id='diaHistoryDiv' style='width:820px;'></div>");
		}
		$('#diaHistoryDiv').dialog({
			title : title,
			width : width,
			height : height,
			closed : false,
			cache : false,
			href : href,
			modal : true
		});
	
		$(".panel").css("top", "0px");
		$(".window-shadow").css("top", "0px");
	}

	function openHistoryRecord(value) {
		openHistoryDialog("${ctx}/jhfj/jhFj/formJhFjhistory?id=" + value,"历史记录查看", 850, 450);
	}              

	//保存选择的部门
	function saveOffice() {
		//绘制n行三列的表格
		var tableStr = "";
		tableStr += "<table class='table table-striped table-bordered table-condensed'>";
		tableStr += "<tr>";
		tableStr += "<td>部门</td>";
		tableStr += "<td>招生人数</td>";
		tableStr += "<td>划分区域</td>";
		tableStr += "</tr>";
		var list = officeInfo.split(',');
		var listValue = officeName.split(',');
		
		for ( var i = 0; i < list.length - 1; i++) {
			tableStr += "<tr>";
			tableStr += "<td><input id=\"hidden"+list[i]+"\" type=\"hidden\" name=\"bmmc\" value=\""+list[i]+"\"/>"
					+ listValue[i] + "</td>";
			tableStr += "<td><input id=\"input"+list[i]+"\" type=\"text\" name=\"zsrsInput\" class=\"input-xlarge\"/></td>";
			tableStr += "<td><a id=\"openArea"
					+ list[i]
					+ "\" style=\"cursor:pointer;text-decoration: none;\" onclick=\"openArea('"
					+ list[i] + "')\">选择地区</a></td>";
			tableStr += "</tr>";
		}
		tableStr += "</table>";
		if (officeInfo != "") {
			$("#officeTable").html(tableStr);
		}
	}

	function closeModel()
	{
		$("#dqDiv").find(".modal").css("display","none");
	}

	var strDq = "";
	function openArea(officeId) {
		//$("#dqDiv").find(".modal").css("display","block");
	    var modelHeight = "330px;" 
	    var modeBodylHeight = "height:200px !important;"
        var bodyHeight = document.body.clientHeight;

        modelHeight = parseInt(bodyHeight * 0.6) + "px;";
        modeBodylHeight = "height:"+(parseInt(modelHeight) - 130)+"px !important;";
		strDq = strDq
				+ "<div class=\"modal fade\" style=\"width:880px;height:"+modelHeight+"\" id=\"selectArea"+officeId+"\">";
		strDq = strDq + "<div class=\"modal-dialog\">";
		strDq = strDq + "<div class=\"modal-content\">";
		strDq = strDq + "<div class=\"modal-header\">";
		strDq = strDq
				+ "<button type=\"button\" class=\"close\"  onclick=\"closeModel();\" data-dismiss=\"modal\" ><span>&times;</span></button>";//data-dismiss=\"modal\"
		strDq = strDq
				+ "<h4 class=\"modal-title\" id=\"myModalLabel"+officeId+"\">选择地区</h4>";
		strDq = strDq + "</div>";
		strDq = strDq + "<div class=\"modal-body\" style=\""+modeBodylHeight+"\">";
		strDq = strDq + "<div id=\"areaPanel"+officeId+"\">";
		strDq = strDq + "</div>";
		strDq = strDq + "</div>";
		strDq = strDq + "<div class=\"modal-footer\">";
		strDq = strDq
				+ "<button type=\"button\" class=\"btn btn-default\" onclick=\"closeModel();\"  data-dismiss=\"modal\" >关闭</button>"; //data-dismiss=\"modal\"
		strDq = strDq
				+ "<button type=\"button\" onclick=\"SaveSelectArea('"
				+ officeId
				+ "')\" class=\"btn btn-primary\" data-dismiss=\"modal\">确定</button>";//data-dismiss=\"modal\"
		strDq = strDq + "</div>";
		strDq = strDq + "</div>";
		strDq = strDq + "</div>";
		strDq = strDq + "</div>";
		//alert(strDq);
		$("#dqDiv").append(strDq);
		//var index = info.indexOf(","+officeId+",");
		var index = officeIds.indexOf("," + officeId + ",");
		if (index < 0) {
			//还没有选择地区
			//加载省份
			$.getJSON("${ctx}/sys/area/findallbychr", {
				parentId : 1
			}, function(data) {
				if (data.length > 0) {
					var strSheng = "<table>";
					$.each(data, function(index, m) {
						if (index == 0) {
							strSheng += "<tr>";
						}
						var strShengChecked = "";
						if (info.indexOf(officeId + "," + m.id) != -1) {
							strShengChecked = "checked=\"checked\"";
						}
						strSheng += "<td width=\"165\">";
						strSheng += "<input type=\"checkbox\" id=" + m.id
								+ officeId + " " + strShengChecked + " name="
								+ m.id + officeId + " value=" + m.name
								+ " onclick=\"openShi('" + officeId + "','"
								+ m.id + "',this)\"/>";
						strSheng += m.name;
						strSheng += "</td>";
						if ((index + 1) % 5 == 0 && index != 0) {
							strSheng += "</tr><tr>";
						}
					});
					strSheng += "</tr>";
					strSheng += "</table>";
					$("#areaPanel" + officeId).html(strSheng);
				}
			});
		}
		$("#dqDiv").find(".modal").css("display","none");
		$("#selectArea" + officeId).modal("show");
	}

	function areaShow() {
	    var bodyWidth = document.body.clientWidth;
        var bodyHeight = document.body.clientHeight;
            bodyWidth = parseInt(bodyWidth * 0.6);
            bodyHeight = parseInt(bodyHeight * 0.5);
	    $("#selectAreaShow").css({"width":bodyWidth+"px","height":bodyHeight+"px"});
		$("#selectAreaShow").modal("show");
		$(".modal-body").css("height","240");
	}

	//加载城市列表
	function openShi(officeId, shengId, obj) {
		if (obj.checked) {
			var strShi = "";
			$.getJSON("${ctx}/sys/area/findallbychr", {
				parentId : shengId
			}, function(data) {
				if (data.length > 0) {
					strShi += "<div id=\"div"+officeId+shengId+"\">";
					strShi += obj.value + "<br/>";
					strShi += "<table>";
					$.each(data,
							function(index, m) {
								if (index == 0) {
									strShi += "<tr>";
								}
								var strShiChecked = "";
								if (info.indexOf(officeId + "," + shengId + ","
										+ m.id) != -1) {
									strShiChecked = "checked=\"checked\"";
								}
								strShi += "<td width=\"165\">";
								strShi += "<input type=\"checkbox\" id=" + m.id
										+ officeId + " " + strShiChecked
										+ " name=" + m.id + officeId
										+ " value=" + m.name
										+ " onclick=\"openQu('" + officeId
										+ "','" + shengId + "','" + m.id
										+ "',this)\"/>";
								strShi += m.name;
								strShi += "</td>";
								if ((index + 1) % 5 == 0 && index != 0) {
									strShi += "</tr><tr>";
								}
							});
					strShi += "</tr>";
					strShi += "</table>";
					strShi += "<br/>";
					strShi += "</div>";
					$("#areaPanel" + officeId).append(strShi);
				}
			});
		} else {
			var list = info.split(',');
			for ( var i = 0; i < list.length - 1; i++) {
				if (list[i] == shengId) {
					var sStr = shengId + "," + list[i + 1] + "," + list[i + 2]
							+ "," + list[i + 3] + ",";
					info = info.replace(sStr, "");
				}
			}
			var my = document.getElementById("div" + officeId + shengId);
			if (my != null)
				my.parentNode.removeChild(my);
		}
	}

	//加载区县列表
	function openQu(officeId, shengId, shiId, obj) {
		if (obj.checked) {
			var strQu = "";
			$.getJSON("${ctx}/sys/area/findallbychr", {
				parentId : shiId
			}, function(data) {
				if (data.length > 0) {
					strQu += "<div id=\"div"+officeId+shiId+"\">";
					strQu += obj.value + "<br/>";
					strQu += "<table>";
					$.each(data, function(index, m) {
						if (index == 0) {
							strQu += "<tr>";
						}
						var strQuChecked = "";
						if (info.indexOf(officeId + "," + shengId + "," + shiId
								+ "," + m.id) != -1) {
							strQuChecked = "checked=\"checked\"";
						}
						strQu += "<td width=\"165\">";
						strQu += "<input type=\"checkbox\" id=" + m.id
								+ officeId + " " + strQuChecked + " name="
								+ m.id + officeId + " value=" + m.name
								+ " onclick=\"openZhen('" + officeId + "','"
								+ shengId + "','" + shiId + "','" + m.id
								+ "',this)\"/>";
						strQu += m.name;
						strQu += "</td>";
						if ((index + 1) % 5 == 0 && index != 0) {
							strQu += "</tr><tr>";
						}
					});
					strQu += "</tr>";
					strQu += "</table>";
					strQu += "<br/>";
					strQu += "</div>";
					$("#div" + officeId + shengId).append(strQu);
				}
			});
		} else//取消选择，将选择的城市移除
		{
			var list = info.split(',');
			for ( var i = 0; i < list.length - 1; i++) {
				if (list[i] == shiId) {
					var qStr = shengId + "," + shiId + "," + list[i + 1] + ","
							+ list[i + 2] + ",";
					info = info.replace(qStr, "");
				}
			}
			var my = document.getElementById("div" + officeId + shiId);
			if (my != null)
				my.parentNode.removeChild(my);
		}
	}

	var info = $("#hiddenbmfj").val();
	var officeIds = "";
	//选择区县，出现镇列表，同时将选择的区县数据保存
	function openZhen(officeId, shengId, shiId, quId, obj) {
		var quList = officeId + "," + shengId + "," + shiId + "," + quId + ","
				+ "" + ",";//选择区县列表
		var strZhen = "";
		//选中区县，将选择的区县数据相加
		if (obj.checked) {
			var quCount = countSubstr(info, quList);
			//如果次数等于0，则证明某区县没有被选过，添加区县
			if (quCount == 0) {
				info = info + quList;
				officeIds = "," + officeIds + officeId + ",";
			}
			$.getJSON("${ctx}/sys/area/findallbychr", {
				parentId : quId
			}, function(data) {
				if (data.length > 0) {
					strZhen += "<div id=\"div"+officeId+quId+"\">";
					strZhen += obj.value + "<br/>";
					strZhen += "<table>";
					$.each(data, function(index, m) {
						if (index == 0) {
							strZhen += "<tr>";
						}
						var strZhenChecked = "";
						if (info.indexOf(officeId + "," + shengId + "," + shiId
								+ "," + quId + "," + m.id) != -1) {
							strZhenChecked = "checked=\"checked\"";
						}
						strZhen += "<td width=\"165\">";
						strZhen += "<input type=\"checkbox\" id=" + m.id
								+ officeId + " " + strZhenChecked + " name="
								+ m.id + officeId + " value=" + m.name
								+ " onclick=\"SaveAreaResult('" + officeId
								+ "','" + shengId + "','" + shiId + "','"
								+ quId + "','" + m.id + "',this)\"/>";
						strZhen += m.name;
						strZhen += "</td>";
						if ((index + 1) % 5 == 0 && index != 0) {
							strZhen += "</tr><tr>";
						}
					});
					strZhen += "</tr>";
					strZhen += "</table>";
					strZhen += "<br/>";
					strZhen += "</div>";
					$("#div" + officeId + shiId).append(strZhen);
				}
			});
		} else//取消选择，将选择的区县移除
		{
			info = info.replace(quList, "");
			officeIds = officeIds.replace("," + officeId + ",", "");
			var list = info.split(',');
			for ( var i = 0; i < list.length - 1; i++) {
				if (list[i] == quId) {
					var zStr = shengId + "," + shiId + "," + quId + ","
							+ list[i + 1] + ",";
					info = info.replace(zStr, "");
				}
			}
			var my = document.getElementById("div" + officeId + quId);
			if (my != null)
				my.parentNode.removeChild(my);
		}
	}

	function SaveAreaResult(officeId, shengId, shiId, quId, zhenId, obj) {
		var quList = officeId + "," + shengId + "," + shiId + "," + quId + ","
				+ "" + ",";//选择区县列表
		var quStr = officeId + "," + shengId + "," + shiId + "," + quId + ",";//要判断此字符串出现的次数
		var zhenList = officeId + "," + shengId + "," + shiId + "," + quId
				+ "," + zhenId + ",";//选择镇列表
		//选中镇，将选择的镇数据相加
		if (obj.checked) {
			//判断某部门下是否选择了某镇
			var zhenCount = countSubstr(info, zhenList);
			//如果次数等于0，则证明某镇没有被选过，添加镇
			if (zhenCount == 0) {
				info = info + zhenList;
				officeIds = "," + officeIds + officeId + ",";
			}
		} else//取消选择，将选择的镇移除
		{
			info = info.replace(zhenList, "");
			officeIds = officeIds.replace("," + officeId + ",", "");
		}
		var quCount = countSubstr(info, quStr);
		//如果次数大于1，则证明某一个区县下面的镇被选择了，则移除区县选择的记录
		if (quCount > 1) {
			info = info.replace(quList, "");
			officeIds = officeIds.replace("," + officeId + ",", "");
		} else if (quCount == 0) {
			info = info + quList;
			officeIds = "," + officeIds + officeId + ",";
		}
	}

	//判断一个字符串在另一字符串中出现的次数
	function countSubstr(str, substr) {
		var count;
		var reg = "/" + substr + "/gi"; //查找时忽略大小写
		reg = eval(reg);
		if (str.match(reg) == null) {
			count = 0;
		} else {
			count = str.match(reg).length;
		}
		return count;
	}

	function SaveSelectArea(officeId) {
		$("#dqDiv").find(".modal").css("display","none");
		$("#openArea" + officeId).text("点击查看");
	}

	function saveJhfj() {
		var strZsjh = "";
		var strOfficeId = "";
		var strZsrs = "";
		var zsrsTotal = 0;
		var bmmc = document.getElementsByName("bmmc");
		var zsrs = document.getElementsByName("zsrsInput");
		var syrs = document.getElementById("surplus").value;
		
		for (i = 0; i < bmmc.length; i++) {
			strOfficeId += bmmc[i].value + ",";
		}

		for (i = 0; i < zsrs.length; i++) {
			if (zsrs[i].value == "" || zsrs[i].value == null) {
				alert("招生人数请填写完整！");
				strZsrs = "";
				return false;
			}
			if (isNaN(zsrs[i].value)) {
				alert("招生人数只能填写数字！");
				return false;
			}
			var rs = parseInt(zsrs[i].value);
			if(rs<=0){
				alert("必须填写大于0正整数！");
				return false;
			}
			zsrsTotal = zsrsTotal + rs;
			strZsrs += zsrs[i].value + ",";
		}
		strZsjh = $("#zsjhbmfj").val();
		if (strZsjh == "") {
			alert("请选择招生计划！");
			return false;
		}
		if (syrs < zsrsTotal) {
			alert("该计划剩余人数小于分解人数，请重新设置分解人数！");
			return false;
		}
		
		$.ajax({
			type : 'post',
			url : "${ctx}/jhfj/jhFj/SaveSelectArea",
			dataType : 'text',
			data : {
				jhfjId : "${jhFj.id}",
				zsjhId : strZsjh,
				officeIds : strOfficeId,
				zsrses : strZsrs,
				ids : info,
				fjrs : zsrsTotal
			},
			success : function(data) {
				location.href = "${ctx}/jhfj/jhFj/list/";
			}
		});
		return true;
	}

	function getSurplus(obj) {
		$.ajaxSetup({ cache: false });
		$.getJSON("${ctx}/zsjh/zsjh/findSurplus", {
			id : obj.value
		}, function(result) {
			$("#surplus").val(result.surplusValue);
		});
	}
	
	
	
	
</script>
	${selectAreaStr}
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/jhfj/jhFj/list/">计划分解列表</a></li>
		<li class="active"><a href="${ctx}/jhfj/jhFj/form?id=${jhFj.id}">计划分解<shiro:hasPermission
					name="jhfj:jhFj:edit">${not empty jhFj.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="jhfj:jhFj:edit">查看</shiro:lacksPermission>
		</a></li>
	</ul> --%>
	<br />
	<form:form id="inputForm" modelAttribute="jhFj"
		action="${ctx}/jhfj/jhFj/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<input id="hiddenbmfj" type="hidden"/>
		<sys:message content="${message}" />
		<div class="control-group" id="divHistory" style="display: none;">
			<label class="control-label">部门任务分解历史记录:</label> 
				<label class="control-label" style="margin-left: 20px;">
					<div id="selection_title" ></div> 
				</label>
		</div>
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">
				<form:select id="zsjhbmfj" path="zsjh.id" class="input-medium required"
					style="width:215px;" onchange="getSurplus(this)">
					<form:option value="" label="" />
					<form:options items="${fns:findListZsjh()}" itemLabel="jhmc"
						itemValue="id" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余人数：</label>
			<div class="controls">
				<input type="text" id="surplus" name="surplus" readonly="true"
					class="input-xlarge" />
			</div>
		</div>

		<button type="button" id="btnSelectOffice"
			class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#selectOffice">选择部门</button>

		<div id="officeTable"></div>

		<!-- 地区 -->
		<div id="dqDiv"></div>

		<!-- 部门 -->
		<div class="modal fade" style="width:200px;" id="selectOffice"
			tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">选择部门</h4>
					</div>
					<div class="modal-body">
						<div id="officePanel"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" onclick="saveOffice()"
							class="btn btn-primary" data-dismiss="modal">确定</button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="approveDiv" style="display: none;">
		<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					<c:if test="${jhFj.bcStatus eq '1' || jhFj.fjFlag eq '1' }">
						<c:if test="${jhFj.bcStatus eq '1' }">
							通过 
						</c:if>
						<c:if test="${jhFj.bcStatus eq '2' }">
							不通过
						</c:if>
					</c:if>
					<c:if test="${jhFj.bcStatus ne '1' && jhFj.fjFlag ne '1' }">
						<form:radiobutton path="bcStatus"  value="1"/>通过  
                     	<form:radiobutton path="bcStatus"  value="2"/>不通过
					</c:if>
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<c:if test="${jhFj.bcStatus eq '1' || jhFj.fjFlag eq '1' }">
					${jhFj.spnr }
				</c:if>
				<c:if test="${jhFj.bcStatus ne '1' && jhFj.fjFlag ne '1' }">
					<form:textarea path="spnr" htmlEscape="false" rows="4"  maxlength="255" class="input-xxlarge " style="width:772px;"/>
				</c:if>
			
			</div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<c:if test="${jhFj.bcStatus eq '1' || jhFj.fjFlag eq '1' }">
				 ${jhFj.approveBy.name }
				</c:if>
				
				<c:if test="${jhFj.bcStatus ne '1' && jhFj.fjFlag ne '1' }">
				<form:input path="approveBy.name" id="approveBy.name"  htmlEscape="false" maxlength="11"  class="input-xlarge"/>
				</c:if>
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
			     	<c:if test="${jhFj.bcStatus eq '1' || jhFj.fjFlag eq '1' }">
					 	<fmt:formatDate value="${jhFj.approveDate}" pattern="yyyy-MM-dd"/>
					</c:if>
				
					<c:if test="${jhFj.bcStatus ne '1' && jhFj.fjFlag ne '1' }">
						 <input name="approveDate" type="text"  maxlength="64" class="input-xlarge Wdate required"
						value="<fmt:formatDate value="${jhFj.approveDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					
					</c:if>
			     </div>
		   </div>
		</div>
		</div>
		
		<div class="form-actions">
			<input id="btnSave" class="btn btn-primary" type="button"
				onclick="return saveJhfj();" value="保 存" />&nbsp; 
				
				<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>