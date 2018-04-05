<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解个人管理</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			//如果是点击修改进入页面，则加载信息
			if("${jhFjGr.zsjh.id}" != ""){
				$("#btnSelectUser").hide();
				info = "${oldAreaStr}";
				oldJsInfo = "${oldBmStr}";
				oldBmInfo = "${oldJsStr}";
				//绘制n行三列的表格
				var tableStr = "";
				tableStr += "<table class='table table-striped table-bordered table-condensed'>";
				tableStr += "<tr>";
				tableStr += "<td>教师姓名</td>";
				tableStr += "<td>招生人数</td>";
				tableStr += "<td>划分区域</td>";
				tableStr += "<td>查看</td>";
				tableStr += "</tr>";
				tableStr += "<tr>";
				tableStr += "<td><input id=\"hidden${jhFjGr.jsId}\" type=\"hidden\" name=\"jsmcgrfj\" value=\"${jhFjGr.jsId}\"/>${jhFjGr.jsmc}</td>";
				if("${jhFjGr.bcStatus}" == 1){
				tableStr += "<td>${jhFjGr.zsrs}</td>";
				
				}else{
				tableStr += "<td><input id=\"input${jhFjGr.jsId}\" type=\"text\" name=\"zsrsInput\" value=\"${jhFjGr.zsrs}\" class=\"input-xlarge\"/></td>";
				}
				
				tableStr += "<td>${innerTable}</td>";
				tableStr += "<td><a style=\"cursor:pointer;text-decoration: none;\" onclick=\"areaShow()\">查看</a></td>";
				tableStr += "</tr>";
				tableStr += "</table>";
				$("#officeTable").html(tableStr);
				/* $.getJSON("${ctx}/zsjh/zsjh/findSurplus",{id:"${jhFjGr.zsjh.id}"},function(result)
				 {
				 	$("#surplus").val(result.surplusValue);
			  	 }); */
			  	 $("#surplus").val("${surplusValue}");
			  	 
			  	 $("#hiddengrfj").val(info);
			  	 
			  	 if("${jhFjGr.bcStatus}" == 1){
						  		$("#btnSave").addClass(" hide");
						  		$("#divHistory").css("display","block");
			  	 				$("#approveDiv").css("display","block"); 
						  	}
			  	 //显示历史记录信息
							$.getJSON("${ctx}/jhfjgr/jhFjGrRecord/getJhFjGrRecordList",{jhfjId : "${jhFjGr.id}"},function(result) {
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
			
			$("#zsjhgrfj").select2();
			//加载部门
			$.getJSON("${ctx}/sys/office/treeData",{},function(data){
					if(data.length >0){
							var strOffice = "<table>";
							$.each(data,function(index,m){
								if(index>0){
									if(index==0){
										strOffice += "<tr>";
									}
									var strBmChecked = "";
									if(oldBmInfo.indexOf(m.id)!=-1){
										strBmChecked = "checked=\"checked\"";
									}
										strOffice += "<td width=\"125\"><input type=\"checkbox\" id="+m.id+" "+strBmChecked+" name="+m.id+" value="+m.name+" onclick=\"showJsList(this)\"/>";
									strOffice +=m.name;
									strOffice += "</td>";
									if((index+1)%6==0 && index!=0){
										strOffice += "</tr><tr>";
									}
								}
							});
							strOffice += "</tr>";
							strOffice += "</table>";
							$("#officePanel").html(strOffice);
						}
			});
		});
		
		//全选 反选
		function quanXuan(divId)
		{
			//
			$("#div"+divId +" table").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					$(this).attr("checked",false);
					jsInfo = jsInfo.replace($(this).attr("id")+",", "");
					jsName = jsName.replace($(this).val()+",","");
					console.log(jsInfo);
					console.log(jsName);
				}
				else
				{
					$(this).attr("checked",true);
					jsInfo = jsInfo + $(this).attr("id") + ",";
					jsName = jsName + $(this).val() + ",";
					console.log(jsInfo);
					console.log(jsName);
				}
			});
		}
		
		var oldBmInfo = "";
		var oldJsInfo = "";
		var bmInfo="";
		function showJsList(obj){
			if(obj.checked){
			bmInfo += obj.id+",";
			var strJsList = "";
			$.getJSON("${ctx}/sys/user/findUserByOfficeId",{officeId:obj.id},function(data){
					if(data.length >0){
							strJsList += "<div id=\"div"+obj.id+"\">";
							strJsList += obj.value+"&nbsp;&nbsp;&nbsp;<input  class='btn' type='button' value='全选' onclick=\"quanXuan('"+obj.id+"');\" />"+"<br/>";
							strJsList += "<table>";
							$.each(data,function(index,m){
								if(index==0){
									strJsList += "<tr>";
								}
								var strJsChecked = "";
								if(oldJsInfo.indexOf(m.id)!=-1){
									strJsChecked = "checked=\"checked\"";
								}
								strJsList += "<td width=\"125\">";
								strJsList += "<input type=\"checkbox\" id="+m.id+" "+strJsChecked+" name="+m.id+" value="+m.name+" onclick=\"selectOffice(this)\"/>";
								strJsList +=m.name;
								strJsList += "</td>";
								if((index+1)%4==0 && index!=0){
									strJsList += "</tr><tr>";
								}
							});
							strJsList += "</tr>";
							strJsList += "</table>";
							strJsList += "<br/>";
							strJsList += "</div>";
							$("#officePanel").append(strJsList);
						}
				});
			}
			else
			{
				var list = bmInfo.split(',');
				for(var i=0;i<list.length-1;i++){
					if(list[i]==obj.id){
						var bStr = obj.id+",";
						bmInfo = bmInfo.replace(bStr, "");
					}
				}
				var my = document.getElementById("div"+obj.id);
			    if (my != null)
				my.parentNode.removeChild(my);
			}
		}
		
		var jsInfo = "";
		var jsName = "";
		//选择人员
		function selectOffice(obj)
		{
			if(obj.checked){
				jsInfo = jsInfo + obj.id + ",";
				jsName = jsName + obj.value + ",";
				console.log(jsInfo);console.log(jsName);
			}
			else
			{
				jsInfo = jsInfo.replace(obj.id+",", "");
				jsName = jsName.replace(obj.value+",","");
			}
		}
		
		function openHistoryDialog(href, title, width, height) {
		var length = $("div#HistorydialogDiv").size();
		if (length == 0) {
			$("#inputForm").before(
					"<div id='HistorydialogDiv' style='width:820px;'></div>");
		}
		$('#HistorydialogDiv').dialog({
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
			openHistoryDialog("${ctx}/jhfjgr/jhFjGr/formJhFjhistory?id=" + value,"历史记录查看", 850, 450);
		}
		
		
		//关闭
		function closeModel()
		{
			$("#dqDiv").find(".modal").css("display","none");
		}
		
		//保存选择的部门人员
		function saveOffice(){
			//绘制n行三列的表格
			var tableStr = "";
			tableStr += "<table class='table table-striped table-bordered table-condensed'>";
			tableStr += "<tr>";
			tableStr += "<td>教师名称</td>";
			tableStr += "<td>招生人数</td>";
			tableStr += "<td>划分区域</td>";
			tableStr += "</tr>";
			var list = jsInfo.split(',');
			var listValue = jsName.split(',');
			for(var i=0;i<list.length-1;i++){
				tableStr += "<tr>";
				tableStr += "<td><input id=\"hidden"+list[i]+"\" type=\"hidden\" name=\"jsmcgrfj\" value=\""+list[i]+"\"/>"+listValue[i]+"</td>";
				tableStr += "<td><input id=\"input"+list[i]+"\" type=\"text\" name=\"zsrsInput\" class=\"input-xlarge\"/></td>";
				tableStr += "<td><a id=\"openArea"+list[i]+"\" style=\"cursor:pointer;text-decoration: none;\" onclick=\"openArea('"+list[i]+"')\">选择地区</a></td>";
				tableStr += "</tr>";
			}
			tableStr += "</table>";
			if(jsInfo != ""){
				$("#officeTable").html(tableStr);
			}
			
			//$("#selectOffice").css({"width":"0","height":"0","display":"none"});
			//$("#selectOffice").css("display","none");
		}
		
		var strDq = "";
		function openArea(jsId){
		$("#dqDiv").find(".modal").css("display","block");
		//alert("jsId:::::"+jsId);
		
		var modelHeight = "330px;"; 
	    var modeBodylHeight = "height:200px !important;";
        var bodyHeight = document.body.clientHeight;

        modelHeight = parseInt(bodyHeight * 0.5) + "px;";
        modeBodylHeight = "height:"+(parseInt(modelHeight) - 80)+"px !important;";
		    strDq = "";
			strDq = strDq +"<div class=\"modal fade\" style=\"width:880px;height:"+modelHeight+"\" id=\"selectArea"+jsId+"\">";
  			strDq = strDq +"<div class=\"modal-dialog\">";
    		strDq = strDq +"<div class=\"modal-content\">";
      		strDq = strDq +"<div class=\"modal-header\">";
       		strDq = strDq +"<button type=\"button\" class=\"close\" data-dismiss=\"modal\" ><span>&times;</span></button>";
        	strDq = strDq +"<h4 class=\"modal-title\" id=\"myModalLabel"+jsId+"\">选择地区</h4>";
      		strDq = strDq +"</div>";
      		strDq = strDq +"<div class=\"modal-body\" style=\""+modeBodylHeight+"\">";
      		strDq = strDq +"<div id=\"areaPanel"+jsId+"\">";
			strDq = strDq +"</div>";
      		strDq = strDq +"</div>";
      		strDq = strDq +"<div class=\"modal-footer\">";
        	strDq = strDq +"<button type=\"button\" class=\"btn btn-default\"  data-dismiss=\"modal\" >关闭</button>";//data-dismiss=\"modal\"
        	strDq = strDq +"<button type=\"button\" onclick=\"SaveSelectArea('"+jsId+"')\" class=\"btn btn-primary\" data-dismiss=\"modal\" >确定</button>";
      		strDq = strDq +"</div>";
    		strDq = strDq +"</div>";
  			strDq = strDq +"</div>";
			strDq = strDq +"</div>";
			//alert(strDq);
			//$("#dqDiv").empty();
			$("#dqDiv").append(strDq);
			//console.log($("#dqDiv").val());
			//var index = info.indexOf(jsId+",");
			var index = jsIds.indexOf(","+jsId+",");
			if(index < 0){
			//还没有选择地区
				//加载省份
				$.getJSON("${ctx}/sys/area/findallbychr",{parentId:1},function(data){
						if(data.length >0){
								var strSheng = "<table>";
								$.each(data,function(index,m){
									if(index==0){
										strSheng += "<tr>";
									}
									var strShengChecked = "";
									if(info.indexOf(","+jsId+","+m.id)!=-1){
										strShengChecked = "checked=\"checked\"";
									}
									strSheng += "<td width=\"165\">";
									strSheng += "<input type=\"checkbox\" id="+m.id+jsId+" "+strShengChecked+" name="+m.id+jsId+" value="+m.name+" onclick=\"openShi('"+jsId+"','"+m.id+"',this)\"/>";
									strSheng +=m.name;
									strSheng += "</td>";
									if((index+1)%5==0 && index!=0){
										strSheng += "</tr><tr>";
									}
								});
								strSheng += "</tr>";
								strSheng += "</table>";
								$("#areaPanel"+jsId).html(strSheng);
							}
				});
			}
			$("#dqDiv").find(".modal").css("display","none");
			$("#selectArea"+jsId).modal("show");
		}
		
		function areaShow(){
		    var bodyWidth = document.body.clientWidth;
            var bodyHeight = document.body.clientHeight;
            bodyWidth = parseInt(bodyWidth * 0.6);
            bodyHeight = parseInt(bodyHeight * 0.5);
	        $("#selectAreaShow").css({"width":bodyWidth+"px","height":"392"+"px"});
		    $("#selectAreaShow").modal("show");
		    $(".modal-body").css("height","260");
		    $("#modal_body").css("height","0");
		}
		
		//加载城市列表
		function openShi(jsId,shengId,obj){
			if(obj.checked){
			var strShi = "";
			$.getJSON("${ctx}/sys/area/findallbychr",{parentId:shengId},function(data){
					if(data.length >0){
							strShi += "<div id=\"div"+jsId+shengId+"\">";
							strShi += obj.value+"<br/>";
							strShi += "<table>";
							$.each(data,function(index,m){
								if(index==0){
									strShi += "<tr>";
								}
								var strShiChecked = "";
								if (info.indexOf(","+jsId + "," + shengId + ","
										+ m.id) != -1) {
									strShiChecked = "checked=\"checked\"";
								}
								strShi += "<td width=\"165\">";
								strShi += "<input type=\"checkbox\" id="+m.id+jsId+" "+strShiChecked+" name="+m.id+jsId+" value="+m.name+" onclick=\"openQu('"+jsId+"','"+shengId+"','"+m.id+"',this)\"/>";
								strShi +=m.name;
								strShi += "</td>";
								if((index+1)%5==0 && index!=0){
									strShi += "</tr><tr>";
								}
							});
							strShi += "</tr>";
							strShi += "</table>";
							strShi += "<br/>";
							strShi += "</div>";
							$("#areaPanel"+jsId).append(strShi);
						}
				});
			}
			else
			{
				var list = info.split(',');
				for(var i=0;i<list.length-1;i++){
					if(list[i]==shengId){
						var sStr = shengId+","+list[i+1]+","+list[i+2]+","+list[i+3]+",";
						info = info.replace(sStr, "");
					}
				}
				var my = document.getElementById("div"+jsId+shengId);
			    if (my != null)
				my.parentNode.removeChild(my);
			}
		}
		
		//加载区县列表
		function openQu(jsId,shengId,shiId,obj){
			if(obj.checked){
			var strQu = "";
			$.getJSON("${ctx}/sys/area/findallbychr",{parentId:shiId},function(data){
					if(data.length >0){
							strQu += "<div id=\"div"+jsId+shiId+"\">";
							strQu += obj.value+"<br/>";
							strQu += "<table>";
							$.each(data,function(index,m){
								if(index==0){
									strQu += "<tr>";
								}
								var strQuChecked = "";
								if (info.indexOf(","+jsId + "," + shengId + "," + shiId
								+ "," + m.id) != -1) {
							strQuChecked = "checked=\"checked\"";
						}
								strQu += "<td width=\"165\">";
								strQu += "<input type=\"checkbox\" id="+m.id+jsId+" "+strQuChecked+" name="+m.id+jsId+" value="+m.name+" onclick=\"openZhen('"+jsId+"','"+shengId+"','"+shiId+"','"+m.id+"',this)\"/>";
								strQu +=m.name;
								strQu += "</td>";
								if((index+1)%5==0 && index!=0){
									strQu += "</tr><tr>";
								}
							});
							strQu += "</tr>";
							strQu += "</table>";
							strQu += "<br/>";
							strQu += "</div>";
							$("#div"+jsId+shengId).append(strQu);
						}
				});
			}
			else//取消选择，将选择的城市移除
			{
				var list = info.split(',');
				for(var i=0;i<list.length-1;i++){
					if(list[i]==shiId){
						var qStr = shengId+","+shiId+","+list[i+1]+","+list[i+2]+",";
						info = info.replace(qStr, "");
					}
				}
				var my = document.getElementById("div"+jsId+shiId);
			    if (my != null)
				my.parentNode.removeChild(my);
			}
		}
		
		var info = $("#hiddengrfj").val();
		var jsIds = "";
		//选择区县，出现镇列表，同时将选择的区县数据保存
		function openZhen(jsId,shengId,shiId,quId,obj){
			var quList = jsId+","+shengId+","+shiId+","+quId+","+""+",";//选择区县列表
			var strZhen = "";
			//选中区县，将选择的区县数据相加
			if(obj.checked){
			var quCount = countSubstr(info,quList);
				//如果次数等于0，则证明某区县没有被选过，添加区县
				if(quCount == 0)
				{
					info = info+quList;
					jsIds = ","+jsIds+jsId+",";
				}
			$.getJSON("${ctx}/sys/area/findallbychr",{parentId:quId},function(data){
					if(data.length >0){
							strZhen += "<div id=\"div"+jsId+quId+"\">";
							strZhen += obj.value+"<br/>";
							strZhen += "<table>";
							$.each(data,function(index,m){
								if(index==0){
									strZhen += "<tr>";
								}
								var strZhenChecked = "";
								if (info.indexOf(","+jsId + "," + shengId + "," + shiId
								+ "," + quId + "," + m.id) != -1) {
							strZhenChecked = "checked=\"checked\"";
						}
								strZhen += "<td width=\"165\">";
								strZhen += "<input type=\"checkbox\" id="+m.id+jsId+" "+strZhenChecked+" name="+m.id+jsId+" value="+m.name+" onclick=\"SaveAreaResult('"+jsId+"','"+shengId+"','"+shiId+"','"+quId+"','"+m.id+"',this)\"/>";
								strZhen +=m.name;
								strZhen += "</td>";
								if((index+1)%5==0 && index!=0){
									strZhen += "</tr><tr>";
								}
							});
							strZhen += "</tr>";
							strZhen += "</table>";
							strZhen += "<br/>";
							strZhen += "</div>";
							$("#div"+jsId+shiId).append(strZhen);
						}
				});
			}
			else//取消选择，将选择的区县移除
			{
				info = info.replace(quList, "");
				jsIds = jsIds.replace(","+jsId+",", "");
				var list = info.split(',');
				for(var i=0;i<list.length-1;i++){
					if(list[i]==quId){
						var zStr = shengId+","+shiId+","+quId+","+list[i+1]+",";
						info = info.replace(zStr, "");
					}
				}
				var my = document.getElementById("div"+jsId+quId);
			    if (my != null)
				my.parentNode.removeChild(my);
			}
		}
		
		function SaveAreaResult(jsId,shengId,shiId,quId,zhenId,obj){
			var quList = jsId+","+shengId+","+shiId+","+quId+","+""+",";//选择区县列表
			var quStr = jsId+","+shengId+","+shiId+","+quId+",";//要判断此字符串出现的次数
			var zhenList = jsId+","+shengId+","+shiId+","+quId+","+zhenId+",";//选择镇列表
			//选中镇，将选择的镇数据相加
			if(obj.checked){
				//判断某部门下是否选择了某镇
				var zhenCount = countSubstr(info,zhenList);
				//如果次数等于0，则证明某镇没有被选过，添加镇
				if(zhenCount == 0)
				{
					info = info+zhenList;
					jsIds = ","+jsIds+jsId+",";
				}
			}
			else//取消选择，将选择的镇移除
			{
				info = info.replace(zhenList, "");
				jsIds = jsIds.replace(","+jsId+",", "");
			}
			var quCount = countSubstr(info,quStr);
			//如果次数大于1，则证明某一个区县下面的镇被选择了，则移除区县选择的记录
			if(quCount>1){
				info = info.replace(quList, "");
				jsIds = jsIds.replace(","+jsId+",", "");
			}
			else if(quCount == 0)
			{
				info = info+quList;
				jsIds = ","+jsIds+jsId+",";
			}
		}
		
		//判断一个字符串在另一字符串中出现的次数
		function countSubstr(str,substr){
           var count;
           var reg="/"+substr+"/gi";    //查找时忽略大小写
           reg=eval(reg);
           if(str.match(reg)==null){
                   count=0;
           }else{
                   count=str.match(reg).length;
           }
           return count;
		}
		
		function SaveSelectArea(jsId){
			closeModel();
			$("#openArea"+jsId).text("点击查看");
		}
		
		function saveJhfj(){
			var strZsjh = "";
			var strJsId = "";
			var strZsrs = "";
			var zsrsTotal=0;
			var jsmc = document.getElementsByName("jsmcgrfj");
			var zsrs = document.getElementsByName("zsrsInput");
			var syrs = document.getElementById("surplus").value;
			
			for(i = 0; i < jsmc.length; i++) {
				strJsId += jsmc[i].value + ",";
			}
			
			 for(i = 0; i < zsrs.length; i++) {
			 	if(zsrs[i].value == "" || zsrs[i].value == null){
			 		alert("招生人数请填写完整！");
			 		strZsrs = "";
			 		return false;
			 	}
			 	if(isNaN(zsrs[i].value)){
			 		alert("招生人数只能填写数字！");
			 		return false;
			 	}
			 	var rs = parseInt(zsrs[i].value);
			 	if(rs<=0){
					alert("必须填写大于0的正整数！");
					return false;
				}
			 	zsrsTotal = zsrsTotal+rs;
			 	strZsrs += zsrs[i].value + ",";
			 }
			 
			 strZsjh = $("#zsjhgrfj").val();
			 if(strZsjh == ""){
			 	alert("请选择招生计划！");
			 	return false;
			 }
			 if(syrs < zsrsTotal){
			 	alert("该计划剩余人数小于分解人数，请重新设置分解人数！");
			 	return false;
			 }
			 $.ajax({
			   type : 'post',
			   url: "${ctx}/jhfjgr/jhFjGr/SaveSelectArea",
			   dataType:'text',
			   data : {jhfjId:"${jhFjGr.id}",zsjhId:strZsjh,jsIds:strJsId,zsrses:strZsrs,ids:info,fjrs:zsrsTotal},
			   success: function(data){
			   		location.href = "${ctx}/jhfjgr/jhFjGr/list/";
			   }
			});
			 return true;
		}
		
		function getSurplus(obj){
			 $.ajaxSetup({ cache: false });
			 $.getJSON("${ctx}/zsjh/zsjh/findSurplus",{id:obj.value},function(result)
			 {
			 	$("#surplus").val(result.surplusValue);
		  	 });
		}
		
		function updateWindows(){
		   //$("#selectOffice").css("dispaly","none");
		   $("#selectOffice").css({"width":"0","height":"0"});
		}
		
		function aa(){alert('11');}
		
		function updateWindows2(){//style="height: 176px !important;"
			/* deleteCss(); */
		  var bodyWidth = document.body.clientWidth;
              bodyWidth = parseInt(bodyWidth * 0.6);
		  $("#selectOffice").css({"width":""+bodyWidth+"px","height":"230px","margin-top":"50px"});
		  $("#modal_body").css("max-height","289px !important");
		}
		
	</script>
   ${selectAreaStr}
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/jhfjgr/jhFjGr/list/">计划分解个人列表</a></li>
		<li class="active"><a href="${ctx}/jhfjgr/jhFjGr/form?id=${jhFjGr.id}">计划分解个人<shiro:hasPermission name="jhfjgr:jhFjGr:edit">${not empty jhFjGr.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="jhfjgr:jhFjGr:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="jhFjGr" action="${ctx}/jhfjgr/jhFjGr/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="hiddengrfj" type="hidden"/>
		<sys:message content="${message}"/>
		<div class="control-group" id="divHistory" style="display: none;">
			<label class="control-label">个人任务分解历史记录:</label> 
				<label class="control-label" style="margin-left: 20px;">
					<div id="selection_title" ></div> 
				</label>
		</div>		
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">
				<form:select id="zsjhgrfj" path="zsjh.id" class="input-medium required" onchange="getSurplus(this)" style="width:215px;">
					<form:option value="" label=""/>
					<form:options items="${fns:findListZsjh()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余人数：</label>
			<div class="controls">
				<input type="text" id="surplus" name="surplus" readonly="true" class="input-xlarge"/>
			</div>
		</div>
		
		<button type="button" id="btnSelectUser" class="btn btn-primary btn-lg" data-toggle="modal" 
			data-target="#selectOffice" 
		onclick="updateWindows2()">选择人员</button>
		
		<!-- <a href="#selectOffice" role="button" class="btn" data-toggle="modal">查看演示案例</a> -->
		<div id="officeTable"></div>
		
		<!-- 地区 -->
<div id="dqDiv"></div>


<div class="modal fade" style="width:200px;"  id="selectOffice" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
       <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">选择人员</h4>
      </div>
      <div class="modal-body" id="modal_body" style="height: 100px;">
      <div id="officePanel">
		</div>
      </div>
      <div class="modal-footer"><!-- data-dismiss="modal"  -->
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" onclick="saveOffice()" class="btn btn-primary"  data-dismiss="modal">确定</button>
      </div>
    </div>
  </div>
</div>


<div id="approveDiv" style="display: none;">
		<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					 <form:radiobutton path="bcStatus" disabled="true" value="1"/>通过  
                     <form:radiobutton path="bcStatus" disabled="true" value="2"/>不通过
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<form:textarea path="spnr" htmlEscape="false" rows="4" disabled="true" maxlength="255" class="input-xxlarge " style="width:772px;"/>
			</div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<form:input path="approveBy.name" id="approveBy.name"  htmlEscape="false" maxlength="11" readonly="true" class="input-xlarge"/>
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
				     <input name="approveDate" type="text" disabled="disabled" maxlength="64" class="input-xlarge Wdate required"
					value="<fmt:formatDate value="${jhFjGr.approveDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			     </div>
		   </div>
		</div>
		</div>
		
		
		<div class="form-actions">
			<input id="btnSave" class="btn btn-primary" type="button" onclick="return saveJhfj();" value="保 存"/>&nbsp;
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>