<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
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
</head>
<body>
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
			
			zhaoShengFangShi();
			lianZhaoHeZuoLeiXing();
			chengYuanYiOnBlur();
			chengYuanErOnBlur();
			
			
		});
		
		
		
		//
		function validateSub()
		{
			var isTrue = validateDh("jhrlxdh");
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
			if(isTrue)
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
			}
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
        		 $.getJSON("${ctx}/xs/xsJbxx/getBanJiNum",{id:xueShengId,bjmc:bjId},function(data)
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
			var ids = "${xsJbxx.id}";
			if(shzt == 1){
				alert("该信息已经审核，不能重复审核！");
				return false;
			}
			$.ajax({
			type : 'post',
			url : "${ctx}/xs/xsJbxx/updateShzt",
			dataType : 'text',
			data : {
				ids : ids
			},
			success : function(data) {
				location.href = "${ctx}/xs/xsJbxx/xjList/";
			}
		});
			return true;
		}
		
		function ShenHeCheck(){
			var shzt = "${xsJbxx.shzt}";
			var id = "${xsJbxx.id}";
			if(shzt == 1){
				alert("该信息已经审核通过，不能再次审核！");
				return false;
			}
			var spnr = "";
			var selects = document.getElementsByName("shzt");
			if(selects[0].checked){
				shzt = 1;
				spnr = "";
			}
			else if(selects[1].checked){
				shzt = 2;
				spnr = $("#spnr").val();
			}
			$.ajax({
			type : 'post',
			url : "${ctx}/xs/xsJbxx/saveSh",
			dataType : 'text',
			data : {
				id: id,
				shzt:shzt,
				spnr:spnr
			},
			success : function(data) {
				location.href = "${ctx}/xs/xsJbxx/xjList/";
			}
		});
			return true;
		}
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/xs/xsJbxx/xjList/">学生信息列表</a></li>
		<li class="active"><a href="${ctx}/xs/xsJbxx/shForm?id=${xsJbxx.id}">学籍信息<shiro:hasPermission name="xs:xsJbxx:edit">${not empty xsJbxx.id?'审核':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xs:xsJbxx:edit">查看</shiro:lacksPermission></a></li>
		
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="xsJbxxRecord" action="${ctx}/xs/xsJbxx/updateShzt" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:268px;"/>
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
						value="${fns:getDate(xsJbxxRecord.csrq)}" pattern="yyyy-MM-dd"
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
					<form:input path="sfzjh" htmlEscape="false" maxlength="18" class="input-xlarge required" style="width:268px;"/>
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
						<form:options items="${fns:getDictList('hkxz')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<label class="control-label">专业名称：</label>
				<div class="controls" id="zhuaYeId">
					<!-- <select name="zyId.id" class="input-xlarge required"  style="width:284px;" >
						<option value=""></option>
					</select> -->
					<form:input path="zyId.zymc" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<%-- <div class="lg-form">
				<label class="control-label" style="width:230px;">专业类别：</label>
				<div class="controls">
					<form:select path="zylxId.id" class="input-xlarge required" style="width:284px;" onchange="zhuanYeOnClick(this.value);">
						<form:option value="" label=""/>
						<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div> --%>
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
						value="${fns:getDate(xsJbxxRecord.rxny)}" pattern="yyyy-MM" 
						onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" style="width:268px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			
		</div>
		
		<fieldset>
			<legend>成员1信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="cyyxm" id="cyyxm" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class="controls">
					<form:select path="cyygx" id="cyygx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('cygx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class="controls">
					<form:select path="cyysfjhr" id="cyysfjhr" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="cyylxdh" id="cyylxdh" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class="controls">
					<input name="cyycsny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(xsJbxxRecord.cyycsny)}" pattern="yyyy-MM-dd" 
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					<form:select path="cyysfzjlx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input path="cyysfzjh" htmlEscape="false" maxlength="18" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="cyymzm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">
					<form:select path="cyyzzmmm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">
					<form:select path="cyyjkzkm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class="controls">
					<form:input path="cyygzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class="controls">
					<form:input path="cyyzw" htmlEscape="false" maxlength="20" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<fieldset>
			<legend>成员2信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="cyexm" id="cyexm" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class="controls">
					<form:select path="cyegx" id="cyegx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('cygx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class="controls">
					<form:select path="cyesfjhr" id="cyesfjhr" class="input-xlarge " style="width:284px;">
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="cyelxdh" id="cyelxdh" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class="controls">
					<input name="cyecsny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(xsJbxxRecord.cyecsny)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					<form:select path="cyesfzjlx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input path="cyesfzjh" htmlEscape="false" maxlength="18" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="cyemzm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">
					<form:select path="cyezzmmm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">
					<form:select path="cyejkzkm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class="controls">
					<form:input path="cyegzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class="controls">
					<form:input path="cyezw" htmlEscape="false" maxlength="20" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
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
		<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					 <form:radiobutton id="shzt" path="shzt" value="1" checked="true"/>通过  
                     <form:radiobutton id="shzt" path="shzt" value="2"/>不通过
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<form:textarea id="spnr" path="spnr" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
		<div class="form-actions" align="center">
			<%-- <shiro:hasPermission name="xs:xsJbxx:edit">
			<input id="btnSubmit" onclick="return saveBefferCheck()" class="btn btn-primary" type="button" value="审 核"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> --%>
			<!-- <input id="btnSubmitOk" onclick="return ShenHeCheck()" class="btn btn-primary" type="button" value="确定"/>&nbsp; -->
			<input id="btnCancel" class="btn btn-primary"  type="button" value="取消" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>