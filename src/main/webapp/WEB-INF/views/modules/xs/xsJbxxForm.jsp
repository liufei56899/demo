<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:226px;
	  }
	  .labWidth 
	  {
	  	 width:230px;
	  }
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var isTrue = validateSub();
					if(isTrue)
					{
						loading('正在提交，请稍等...');
						form.submit();
					}
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
			
			if("${xsJbxx.id}" != ""){
				$("#divHistory").css("display","block");
			}
			
			//显示历史记录信息
							$.getJSON("${ctx}/xs/xsJbxxRecord/getXsJbxxRecordList",{xsId : "${xsJbxx.id}"},function(result) {
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
			
			if("${xsJbxx.shzt}" == 1){
				$("#btnSubmitSave").addClass(" hide");
			}
			
			initBanJi();
			zhuanYeInit();
			
			zhaoShengFangShi();
			lianZhaoHeZuoLeiXing();
			chengYuanYiOnBlur();
			chengYuanErOnBlur();
			
			
		});
		
		function openNewDialog(href, title, width, height) {
		var length = $("div#dialogDiv").size();
		if (length == 0) {
			$("#inputForm").before(
					"<div id='dialogDiv' style='width:820px;'></div>");
		}
		$('#dialogDiv').dialog({
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

	function openHistoryRecord(value) {//formXsJbxxHistory
		openNewDialog("${ctx}/xs/xsJbxx/formXsJbxxHistory?id=" + value,"历史记录查看", 1200, 650);
	}
		
		
			//初始化专业
		function zhuanYeInit()

		{
			var zhuanYeId  = "${xsJbxx.zyId.id}";//专业id
			var zhuanYeLxId = "${xsJbxx.zylxId.id}";//专业类别ID
			if(zhuanYeLxId!="" && zhuanYeLxId !=null)
			{
				$.getJSON("${ctx}/zy/zyJbxx/findInitZysByLxId",{id:zhuanYeLxId,zyId:zhuanYeId},function(result){
		        $("#zhuaYeId").html(result.html);
		        $("#zyid").attr("style","width:284px;");
		        $("#zyid").select2({
				 	formatResult: format,
				    formatSelection: format,
				    escapeMarkup: function(m) { return m; }
				 });
		  	});
			}
		}
		
		function format(state) 
		{
			return state.text;
		}
		
		//验证身份证号
		function validateSfz()
		{
			var sfzjhVal = $("#sfzjh").val();
			if(sfzjhVal!=null && sfzjhVal!="")
			{
				var isT = IdCardValidate(sfzjhVal);
				if(!isT)
				{
					validTxt("sfzjh","请输入正确的身份证件号码");
					return false
				}
			}
			return true;
		}
		
		//
		function validateSub()
		{
			var isTrue = validateDh("jhrlxdh");
			if(isTrue)
			{
				isTrue = validateSfz();
			}
			if(isTrue)
			{
				isTrue = validateDh("lxdh");
			}
			//jtdh
			if(isTrue)
			{
				isTrue = validateDh("jtdh");
			}
			if(isTrue)
			{
				isTrue = validateDh("cyylxdh");
			}
			if(isTrue)
			{
				isTrue = validateDh("cyelxdh");
			}
			/* if(isTrue)
			{
			   var banJiId = $("#banJiId").val();//分班id
			   if(banJiId == null || banJiId == "")
			   {
			   		isTrue = false;
			   }
			   if(!isTrue)
			   {
			   		alertx('请选择班级');
			   }
			} */
			return isTrue;
		}
		
		
		//验证电话格式
		function validateDh(id)
		{
			var value = $("#"+id).val();
			if(value!=null && value!="")
			{
				var isTrue = /^1\d{10}$/i.test(value) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
				if(!isTrue)
				{
				   validTxt(id,"联系电话格式有问题");
				   return false;
				}
			}
			return true;
		}
		
		//初始化班级
		function initBanJi()
		{
			var zhuanYeId  = "${xsJbxx.zyId.id}";//专业id
			 $.getJSON("${ctx}/xs/xsJbxx/getBanJiList",{zyId:zhuanYeId},function(data)
			 {
				if(data.length >0)
				{
					var strSheng = "<table>";
					$.each(data,function(index,m){
						if(index==0){
							strSheng += "<tr>";
						}
						strSheng += "<td width=\"130\">";
						strSheng += "<input type=\"checkbox\" id="+m.id+" rnrs="+m.rnrs+" name="+m.id+" value="+m.bjmc+" />";
						strSheng +=m.bjmc;
						strSheng += "</td>";
						if((index+1)%5==0 && index!=0){
							strSheng += "</tr><tr>";
						}
					});
					strSheng += "</tr>";
					strSheng += "</table>";
					
					$("#banJiPanel").html(strSheng);
				}
				
			 });
		}
		
		
		//选择班级
		function selectBanJi(obj)
		{
			/* console.log(obj); */
		}
		
		//确定班级事件
		function saveBanJi()
		{
			 var num =0;//
            var bjId = "";//班级id
            var rnrs = parseInt(0);//容纳人数
            var xueShengId = "${xsJbxx.id}";//学生id
            var bjmc ="";
        	$("#selectBanJi").find("input[type='checkbox']").each(function()
        	{
        		if($(this).attr("checked"))
				{
					num ++;
					bjId = $(this).attr("id");
					rnrs = parseInt($(this).attr("rnrs"));
					bjmc = $(this).val();
				}
        	});
        	if(num == 0)
        	{
        		alertx('请选择班级');
        	}
        	else if(num >1)
        	{
        		alertx('只能选择一个班级');
        	}
        	else 
        	{
        		//验证该班级人数已达容纳人数
        		 $.getJSON("${ctx}/xs/xsJbxx/getBanJiNum",{id:xueSengI别d,bjmc:bjId},function(data)
			 	{
			 		if(rnrs < parseInt(data.bjNum))
			 		{
			 			alertx('此班级人数已达数，请重新选择班级');
			 		}else
			 		{
			 		   $("#banJiId").val(bjId);
			 		   $("#banJiMc").html(bjmc);
			 		}
			 		
			    });
        	}
		}
		
		
		//根据专业类别获取专业
		function zhuanYeOnClick(zylxVal)
		{
			 $.getJSON("${ctx}/zy/zyJbxx/findZysByLxId",{id:zylxVal},function(result){
		        $("#zhuaYeId").html(result.html);
			  	$("#zyid").attr("style","width:284px;");
			  	$("#zyid").select2({
				 	formatResult: format,
				    formatSelection: format,
				    escapeMarkup: function(m) { return m; }
				 });
		  	});
		}
		
		
		//招生方式
		/**
		  招生方式 为统一招生时 则 准考证号 、 考生号、考试总分则为必填项
		*/
		function zhaoShengFangShi()
		{
			var zsfs = $("#zsfs").val();
			if(zsfs =="1")
			{
				addValidate("zkzh");
				addValidate("ksh");
				addValidate("kszf");
			}
			else
			{
				emptyValidate("zkzh");
				emptyValidate("ksh");
				emptyValidate("kszf");
			}
		}
		
		//连招合作类型
		function lianZhaoHeZuoLeiXing()
		{
			var lzhzlx = $("#lzhzlx").val();
			if(lzhzlx !="1" && lzhzlx!=null && lzhzlx!="")
			{
				addValidate("lzhzbxfs");
				addValidate("lzhzxxdm");
			}
			else
			{
				emptyValidate("lzhzbxfs");
				emptyValidate("lzhzxxdm");
			}
		}
		
		//成员1信息
		/**
		   （成员1和成员2信息可以都不填写）。若填写成员1或成员2信息时蓝色字体的4项信息同时为必填项，黑色字体为选填项
		**/
		function chengYuanYiOnBlur()
		{
			var cyyxm =$("#cyyxm").val();//姓名
			var cyygx = $("#cyygx").val();//关系
			var cyysfjhr = $("#cyysfjhr").val();//是否监护人
			var cyylxdh = $("#cyylxdh").val();//联系电话
			
			if((cyyxm !=null && cyyxm!="") || (cyygx !=null && cyygx!="") || (cyysfjhr !=null && cyysfjhr!="") || 
			 (cyylxdh !=null && cyylxdh!="") )
			 {
			 	addValidate("cyyxm");
				addValidate("cyygx");
				addValidate("cyysfjhr");
				addValidate("cyylxdh");
			 }else
			 {
			 	emptyValidate("cyyxm");
				emptyValidate("cyygx");
				emptyValidate("cyysfjhr");
				emptyValidate("cyylxdh");
			 	
			 }
		}
		
		//验证成员2信息
		function chengYuanErOnBlur()
		{
			var cyexm =$("#cyexm").val();//姓名
			var cyegx = $("#cyegx").val();//关系
			var cyesfjhr = $("#cyesfjhr").val();//是否监护人
			var cyelxdh = $("#cyelxdh").val();//联系电话
			if((cyexm !=null && cyexm!="") || (cyegx !=null && cyegx!="") || (cyesfjhr !=null && cyesfjhr!="") || 
			 (cyelxdh !=null && cyelxdh!="") )
			 {
			 	addValidate("cyexm");
				addValidate("cyegx");
				addValidate("cyesfjhr");
				addValidate("cyelxdh");
			 }else
			 {
			 	emptyValidate("cyexm");
				emptyValidate("cyegx");
				emptyValidate("cyesfjhr");
				emptyValidate("cyelxdh");
			 	
			 }
		}
		
		
		//添加验证
		function addValidate(id)
		{
		    if($("#"+id).next().attr("class") =="error")
			{
				$("#"+id).next().next().html("<font color='red'>*</font>");
			}else
			{
				$("#"+id).next().html("<font color='red'>*</font>");
			}
		    //$("#"+id).next().html("<font color='red'>*</font>");
			$("#"+id).addClass("required");
		}
		
		
		//清空验证
		function emptyValidate(id)
		{
			if($("#"+id).next().attr("class") =="error")
			{
			   	$("#"+id).next().remove();
			   	$("#"+id).next().empty();
			}
			else
			{
				$("#"+id).next().empty();
			}
			$("#"+id).removeClass("required");
			$("#"+id).removeClass("error");
		}
		
		function saveBefferCheck(){
			var shzt = "${xsJbxx.shzt}";
			if(shzt == 1){
				alert("该信息已经审核，不能修改！");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/xs/xsJbxx/list/">学生信息列表</a></li>
		<li class="active"><a href="${ctx}/xs/xsJbxx/form?id=${xsJbxx.id}">学生信息<shiro:hasPermission name="xs:xsJbxx:edit">${not empty xsJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xs:xsJbxx:edit">查看</shiro:lacksPermission></a></li>
		
		<li><a href="${ctx}/xs/xsJbxx/chengYuanInfo?id=${xsJbxx.id}">成员信息修改
		<shiro:hasPermission name="xs:xsJbxx:edit">
		</shiro:hasPermission></a></li>
		
	</ul><br/>
	<form:form id="inputForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="control-group" id="divHistory" style="display: none;">
			<label class="control-label">学生历史记录:</label> 
				<label class="control-label" style="margin-left: 20px;">
					<div id="selection_title" ></div> 
				</label>
		</div>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="xm" htmlEscape="false" maxlength="15" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style ="width:230px;" >性别：</label>
				<div class="controls">
					<form:select path="xbm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生日期：</label>
				<div class="controls">
					<input name="csrq" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="${fns:getDate(xsJbxx.csrq)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style ="width:230px;">身份证件类型：</label>
				<div class="controls">
					<form:select path="sfzjlxm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input path="sfzjh" id="sfzjh" htmlEscape="false" maxlength="18" 
						class="input-xlarge required" onblur="validateSfz();"  style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style ="width:230px;">姓名拼音：</label>
				<div class="controls">
					<form:input path="xmpy" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">英文姓名：</label>
				<div class="controls">
					<form:input path="ywxm" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<%-- <div class="lg-form">
				<label class="control-label" style ="width:230px;">班级名称：</label>
				<div class="controls">
					<form:input path="bjmc" htmlEscape="false" readonly="readonly" maxlength="32" class="input-xlarge "/>
					<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" 
						data-target="#selectBanJi">选择班级</button>
					<c:if test="${not empty xsJbxx.bjmc.bjmc }">
						<span id="banJiMc">${xsJbxx.bjmc.bjmc }</span> 
					</c:if>
					<c:if test="${empty xsJbxx.bjmc.bjmc }">
						<span id="banJiMc">未分班</span> 
					</c:if>
					<input type="hidden" name="bjmc.id" value="${xsJbxx.bjmc.id }" id="banJiId" />
				</div>
			</div> --%>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学号：</label>
				<div class="controls">
					<form:input path="xh" htmlEscape="false" maxlength="18" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">学生类别：</label>
				<div class="controls">
					<form:select path="xslbm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xslb')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学习形式：</label>
				<div class="controls">
					<form:select path="xxxsm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xxxs')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">入学方式：</label>
				<div class="controls">
					<form:select path="rxfsm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('rxfs')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">就读方式：</label>
				<div class="controls">
					<form:select path="jdfsm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('jdfs')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">国籍/地区：</label>
				<div class="controls">
					<form:select path="gjdqm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('gjdqm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">港澳台侨外：</label>
				<div class="controls">
					<form:select path="gatqwm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('gatqwm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">婚姻状况：</label>
				<div class="controls">
					<form:select path="hyzkm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('hyzk')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">乘火车区间：</label>
				<div class="controls">
					<form:input path="chcqj" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">是否随迁子女：</label>
				<div class="controls">
					<form:select path="sfsqzn" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">生源地行政区划码：</label>
				<div class="controls">
					<form:input path="sydxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">出生地行政区划码：</label>
				<div class="controls">
					<form:input path="csdxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">籍贯地行政区划码：</label>
				<div class="controls">
					<form:input path="jgdxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">户口所在详细地址：</label>
				<div class="controls">
					<form:input path="hkszdqxyxxxdz" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">所属派出所：</label>
				<div class="controls">
					<form:input path="scpcs" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">户口所在地行政区划码：</label>
				<div class="controls">
					<form:input path="hkszdxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">户口性质：</label>
				<div class="controls">
					<form:select path="hkxz" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('hkxz')}" itemLabel="label" itemValue="value" htmlEscape="alse别"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">学生居住地类型：</label>
				<div class="controls">
					<form:select path="xsjzdlx" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xsjzdlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业类别：</label>
				<div class="controls">
					<form:select path="zylxId.id" class="input-xlarge required" style="width:284px;" onchange="zhuanYeOnClick(this.value);">
						<form:option value="" label=""/>
						<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">专业名称：</label>
				<div class="controls" id="zhuaYeId">
					<select name="zyId.id" class="input-xlarge required"  style="width:284px;" >
						<option value=""></option>
					</select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业简称：</label>
				<div class="controls">
					<form:input path="zyjc" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">专业方向：</label>
				<div class="controls">
					<form:input path="zyfx" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学制：</label>
				<div class="controls">
					<form:select path="xz" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xzdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">民族：</label>
				<div class="controls">
					<form:select path="mzm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">
					<form:select path="zzmmm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">健康状况：</label>
				<div class="controls">
					<form:select path="jkzkm" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学生来源：</label>
				<div class="controls">
					<form:select path="xslym" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xs_ly')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">招生对象：</label>
				<div class="controls">
					<form:select path="zsdx" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zsdx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">监护人联系电话：</label>
				<div class="controls">
					<form:input path="jhrlxdh" id="jhrlxdh" onblur="validateDh('jhrlxdh');" htmlEscape="false" maxlength="32" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">毕业学校：</label>
				<div class="controls">
					<form:input path="byxx" htmlEscape="false" maxlength="50" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="lxdh" id="lxdh" onblur="validateDh('lxdh');" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">招生方式：</label>
				<div class="controls">
					<%-- <form:input path="zsfs" htmlEscape="false" maxlength="64" class="input-xlarge "/> --%>
					<form:select path="zsfs" id="zsfs" class="input-xlarge required" style="width:284px;" onchange="zhaoShengFangShi();">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zsfs')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">准考证号：</label>
				<div class="controls">
					<form:input path="zkzh" id="zkzh" onblur="zhaoShengFangShi();" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">考生号：</label>
				<div class="controls">
					<form:input path="ksh" id="ksh" onblur="zhaoShengFangShi();" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">考生总分：</label>
				<div class="controls">
					<form:input path="kszf" id="kszf" onblur="zhaoShengFangShi();" htmlEscape="false" maxlength="10" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">考生特长：</label>
				<div class="controls">
					<form:input path="kstc" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">考生既往病史：</label>
				<div class="controls">
					<form:input path="ksjwbs" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">体检结论：</label>
				<div class="controls">
					<form:input path="tjjl" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联招合作类型：</label>
				<div class="controls">
					<%-- <form:input path="lzhzlx" htmlEscape="false" maxlength="64" class="input-xlarge "/> --%>
					<form:select path="lzhzlx" id="lzhzlx" class="input-xlarge required" style="width:284px;" onchange="lianZhaoHeZuoLeiXing();">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('lzhzlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">联招合作办学形式：</label>
				<div class="controls"> 
					<%-- <form:input path="lzhzbxfs" htmlEscape="false" maxlength="64" class="input-xlarge "/> --%>
					<form:select path="lzhzbxfs" id="lzhzbxfs" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('lzhzbxxs')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"> </span>
					
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联招合作学校代码：</label>
				<div class="controls">
					<form:input path="lzhzxxdm" id="lzhzxxdm" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">校外教学点：</label>
				<div class="controls">
					<form:input path="xwjxd" htmlEscape="false" maxlength="32" class="input-xlarge required" style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">分段培养方式：</label>
				<div class="controls">
					<%-- <form:input path="fdpyfs" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:268px;"/> --%>
					<form:select path="fdpyfs" id="fdpyfs" class="input-xlarge required" style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('fdpyfs')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">电子信箱/其他联系方式：</label>
				<div class="controls">
					<form:input path="dzxx" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">家庭现地址：</label>
				<div class="controls">
					<form:input path="jtxdz" htmlEscape="false" maxlength="128" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">家庭邮政编码：</label>
				<div class="controls">
					<form:input path="jtyzbm" htmlEscape="false" maxlength="6" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">家庭电话：</label>
				<div class="controls">
					<form:input path="jtdh" id="jtdh" onblur="validateDh('jtdh');" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style="width:230px;">入学年月：</label>
				<div class="controls">
					<input name="rxny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="${fns:getDate(xsJbxx.rxny)}" pattern="yyyy-MM" 
						onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" style="width:268px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<%-- <div class="lg-form">
				<label class="control-label">成员1姓名：</label>
				<div class="controls">
					<form:input path="cyyxm" id="cyyxm" onblur="chengYuanYiOnBlur();" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div> --%>
		</div>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员1关系：</label>
				<div class="controls">
					<form:input path="cyygx" id="cyygx" onblur="chengYuanYiOnBlur();" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员1是否监护人：</label>
				<div class="controls">
					<form:select path="cyysfjhr" id="cyysfjhr" onblur="chengYuanYiOnBlur();" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员1联系电话：</label>
				<div class="controls">
					<form:input path="cyylxdh" id="cyylxdh" onblur="chengYuanYiOnBlur();validateDh('cyylxdh');" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员1出生年月：</label>
				<div class="controls">
					<input name="cyycsny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(xsJbxx.cyycsny)}" pattern="yyyy-MM-dd" 
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员1身份证件类型：</label>
				<div class="controls">
					<form:select path="cyysfzjlx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员1身份证件号：</label>
				<div class="controls">
					<form:input path="cyysfzjh" htmlEscape="false" maxlength="18" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员1民族：</label>
				<div class="controls">
					<form:select path="cyymzm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员1政治面貌：</label>
				<div class="controls">
					<form:select path="cyyzzmmm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员1健康状况：</label>
				<div class="controls">
					<form:select path="cyyjkzkm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员1工作或学习单位：</label>
				<div class="controls">
					<form:input path="cyygzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员1职务：</label>
				<div class="controls">
					<form:input path="cyyzw" htmlEscape="false" maxlength="20" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员2姓名：</label>
				<div class="controls">
					<form:input path="cyexm" id="cyexm" onblur="chengYuanErOnBlur();" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员2关系：</label>
				<div class="controls">
					<form:input path="cyegx" id="cyegx" onblur="chengYuanErOnBlur();" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员2是否监护人：</label>
				<div class="controls">
					<form:select path="cyesfjhr" id="cyesfjhr" onblur="chengYuanErOnBlur();" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员2联系电话：</label>
				<div class="controls">
					<form:input path="cyelxdh" id="cyelxdh" onblur="chengYuanErOnBlur();validateDh('cyelxdh');" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员2出生年月：</label>
				<div class="controls">
					<input name="cyecsny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(xsJbxx.cyecsny)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员2身份证件类型：</label>
				<div class="controls">
					<form:select path="cyesfzjlx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员2身份证件号：</label>
				<div class="controls">
					<form:input path="cyesfzjh" htmlEscape="false" maxlength="18" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员2民族：</label>
				<div class="controls">
					<form:select path="cyemzm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员2政治面貌：</label>
				<div class="controls">
					<form:select path="cyezzmmm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">成员2健康状况：</label>
				<div class="controls">
					<form:select path="cyejkzkm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">成员2工作或学习单位：</label>
				<div class="controls">
					<form:input path="cyegzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div> --%>
		<div class="control-group">
			<%-- <div class="lg-form">
				<label class="control-label">成员2职务：</label>
				<div class="controls">
					<form:input path="cyezw" htmlEscape="false" maxlength="20" class="input-xlarge " style="width:268px;"/>
				</div>
			</div> --%>
			<%-- <div class="lg-form">
				<label class="control-label">备注信息：</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:284px;"/>
				</div>
			</div> --%>
		</div>
		<%-- <div class="control-group">
			<table id="bmTable" class="table table-striped table-bordered table-condensed">
				<tr>
					<td colspan="12">成员1信息</td>
				</tr>
			 	<tr>
			 		<th style="width:95px;">姓名</th>
			 		<th style="width:95px;">关系</th>
			 		<th style="width:80px;">是否监护人</th>
			 		<th style="width:120px;">联系电话</th>
			 		<th style="width:95px;">出生年月</th>
			 		<th style="width:80px;">身份证件类型</th>
			 		<th style="width:120px;">身份证件号</th>
			 		<th style="width:70px;">民族</th>
			 		<th style="width:80px;">政治面貌</th>
			 		<th style="width:80px;">健康状况</th>
			 		<th style="width:120px;">工作或学习单位</th>
			 		<th>职务</th>
			 	</tr>
			 	<tr>
			 		<td>
			 			<form:input path="cyyxm" id="cyyxm" onblur="chengYuanYiOnBlur();" htmlEscape="false" maxlength="64" class="input-xlarge " 
			 				style="width:60px;"/>
						<span class="help-inline"></span>
			 		</td>
			 		<td>
			 			<form:input path="cyygx" id="cyygx" onblur="chengYuanYiOnBlur();" htmlEscape="false" maxlength="32" 
			 				class="input-xlarge " style="width:60px;"/>
						<span class="help-inline"></span>
			 		</td>
			 		<td>
			 			<form:select path="cyysfjhr" id="cyysfjhr" onblur="chengYuanYiOnBlur();" 
			 				class="input-xlarge " style="width:70px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"></span>
			 		</td>
			 		<td>
			 			<form:input path="cyylxdh" id="cyylxdh" onblur="chengYuanYiOnBlur();validateDh('cyylxdh');" 
			 				htmlEscape="false" maxlength="32" class="input-xlarge " style="width:90px;"/>
						<span class="help-inline"></span>
			 		</td>
			 		<td>
			 			<input name="cyycsny" type="text" readonly="readonly" maxlength="20" 
			 				class="input-medium Wdate "
						value="${fns:getDate(xsJbxx.cyycsny)}" pattern="yyyy-MM-dd" 
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:90px;"/>
			 		</td>
			 		<td>
			 			<form:select path="cyysfzjlx" class="input-xlarge " style="width:80px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
			 		</td>
			 		<td>
			 			<form:input path="cyysfzjh" htmlEscape="false" maxlength="18" class="input-xlarge " 
			 				style="width:100px;"/>
			 		</td>
			 		<td>
			 			<form:select path="cyymzm" class="input-xlarge " style="width:60px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
			 		</td>
			 		<td>
			 			<form:select path="cyyzzmmm" class="input-xlarge " style="width:80px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
			 		</td>
			 		<td>
			 			<form:select path="cyyjkzkm" class="input-xlarge " style="width:80px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
			 		</td>
			 		<td>
						<form:input path="cyygzhxxdw" htmlEscape="false" maxlength="255" 
							class="input-xlarge " style="width:90px;"/>
			 		</td>
			 		<td>
						<form:input path="cyyzw" htmlEscape="false" maxlength="20" 
							class="input-xlarge " style="width:80px;"/>
			 		</td>
			 	</tr>
			
			</table>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
		<c:if test="${not empty xsJbxx.id}">
			<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<%-- <form:input path="userName1" id="approveBy.name" htmlEscape="true" disabled="disabled" 
					maxlength="32" class="input-xlarge "  value="${xsJbxx.approveBy.name }"
					style="width:268px;"/> --%>
			  <input type="text" name="userName1" id="approveBy.name" disabled="disabled" class="input-xlarge "
			  	  style="width:268px;" value="${xsJbxx.approveBy.name }"  />
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
				     <input type="text" disabled="disabled" maxlength="64" class="input-xlarge Wdate required"
					value="<fmt:formatDate value="${xsJbxx.approveDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			     </div>
		   </div>
		</div>
			
		</c:if>
		
		<!-- 部门 -->
		<div class="modal fade" style="width:680px;" id="selectBanJi" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		       <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">选择班级</h4>
		      </div>
		      <div class="modal-body">
		      <div id="banJiPanel">
				</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" onclick="saveBanJi()" class="btn btn-primary" data-dismiss="modal">确定</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<div class="form-actions">
			<shiro:hasPermission name="xs:xsJbxx:edit"><input id="btnSubmitSave" onclick="return saveBefferCheck()" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>