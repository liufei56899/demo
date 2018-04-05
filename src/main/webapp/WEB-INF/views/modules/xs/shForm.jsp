<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:226px;
	  }
	  .labWidth 
	  {
	  	 width:230px;
	  }
	  .left-control-group,.right-control-group{
	   width: 49.9%;
	   float: left;
	  
	  }
	  .left-control-group{
	   border-right: 1px dotted #ddd;
	  }
	  .left-form{
	   border-bottom: 1px dotted #ddd;
	  }
	  .control-label{
	   float: none !important;
	  }
	</style>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
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
			if("${xsJbxx.shzt}" == "2"){
				$("#btnSubmitOk").addClass(" hide");
			}
			
			/* zhaoShengFangShi();
			lianZhaoHeZuoLeiXing();
			chengYuanYiOnBlur();
			chengYuanErOnBlur(); */
			
			
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
			
			for(var i=0;i<selects.length;i++){ 
	            if(selects[i].checked==true) 
	            { 
	                if(selects[i].value==1){
	                	shzt = 1;
						spnr = "";
	                }
	                if(selects[i].value==2){
	                	shzt = 2;
						spnr = $("#spnr").val();
						if(spnr==null||spnr==""||spnr.length<1){
						    alertx('请填写不通过意见！');
						    return;
						}
	                }
	            } 
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
	<form:form id="inputForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/updateShzt" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<fieldset>
			<legend>学生基本信息:</legend>
		</fieldset>	
		<div class="cont-group" style="height: 216px;">
		<div class="left-control-group">
			<div class="left-form">
				<label class="control-label"><font color="red">姓名：</font></label> 
				<div class="controls1">
					${xsJbxx.xm }
				</div>
			</div>
			<div class="left-form">
				<label class="control-label labWidth" ><font color="red">姓名拼音：</font></label>
				<div class="controls1">
					${xsJbxx.xmpy }
				</div>
			</div>
			<div class="left-form">
				<label class="control-label labWidth" >英文姓名：</label>
				<div class="controls1">
					${xsJbxx.ywxm }
				</div>
			</div>
			<div class="left-form">
				<label class="control-label labWidth" ><font color="red">性别：</font></label>
				<div class="controls1">
					${fns:getDictLabel(xsJbxx.xbm, 'sex', '')}
				</div>
			</div>
		</div>
		<div class="right-control-group">
		<div class="right-form">
				<label class="control-label"  style="padding:0;">照片：</label>
				<c:if test="${xsJbxx.photo==null}">
				<img src="${ctxStatic }/js/xszp.png" id="imgShow0" style='width:120px; height:160px;'/>			
					</c:if>
				<c:if test="${xsJbxx.photo!=null}">
				<img src="${xsJbxx.photo}" id="imgShow0" style='width:120px; height:160px;'/>			
					</c:if>	
			</div>
		
		</div>
		
	</div>
	<div class="control-group">
			<div class="lg-form">
				<label class="control-label"><font color="red">身份证件类型：</font></label>
				<div class="controls1">
					${fns:getDictLabel(xsJbxx.sfzjlxm, 'sfzjlx', '')}
				</div>
			</div>
			<div class="lg-form" style="border-top: 1px dotted #ddd;">
				<label class="control-label"><font color="red">身份证件号码：</font></label>
				<div class="controls1">
					${xsJbxx.sfzjh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label"><font color="red">出生日期：</font></label>
				<div class="controls1">
					${fns:getDate(xsJbxx.csrq)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >民族：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.mzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls1">${xsJbxx.lxdh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >健康状况：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.jkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">婚姻状况：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.hyzkm, 'hyzk', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >国籍/地区：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
					<label class="control-label">户口性质：</label>
					<div class="controls1">${fns:getDictLabel(xsJbxx.hkxz, 'hkxz', '')}
					</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >学生居住地类型：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.xsjzdlx, 'xsjzdlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">港澳台侨外：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.gatqwm, 'gatqwm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.zzmmm, 'zzmm', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">电子信箱/其他联系方式：</label>
				<div class="controls1">${xsJbxx.dzxx }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">生源地行政区划码：</label>
				<div class="controls1">${xsJbxx.sydxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生地：</label>
				<div class="controls1">${xsJbxx.csd}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">出生地行政区划码：</label>
				<div class="controls1">${xsJbxx.csdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">籍贯：</label>
				<div class="controls1">${xsJbxx.jg}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">籍贯地行政区划码：</label>
				<div class="controls1">${xsJbxx.jgdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">户口所在地：</label>
				<div class="controls1">${xsJbxx.hkszd}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">户口所在地行政区划码：</label>
				<div class="controls1">${xsJbxx.hkszdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >户口所在地区县以下详细地址：</label>
				<div class="controls1">${xsJbxx.hkszdqxyxxxdz }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">家庭现地址：</label>
				<div class="controls1">${xsJbxx.jtxdz }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >家庭邮政编码：</label>
				<div class="controls1">${xsJbxx.jtyzbm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">家庭电话：</label>
				<div class="controls1">${xsJbxx.jtdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">所属派出所：</label>
				<div class="controls1">${xsJbxx.scpcs }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">乘火车区间：</label>
				<div class="controls1">${xsJbxx.chcqj }
				</div>
			</div>
		</div>
		
			<%-- <div class="lg-form">
				<label class="control-label" style ="width:230px;">班级名称：</label>
				<div class="controls1">
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
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">学号：</label>
				<div class="controls1">
					${xsJbxx.xh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >学生类别：</label>
				<div class="controls1">
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">学习形式：</label>
				<div class="controls1">
					${fns:getDictLabel(xsJbxx.xxxsm, 'xxxs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">入学方式：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label" >国籍/地区：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div> --%>
	<%-- 	<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls1">${xsJbxx.lxdh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >国籍/地区：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">港澳台侨外：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.gatqwm, 'gatqwm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">婚姻状况：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.hyzkm, 'hyzk', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">乘火车区间：</label>
				<div class="controls1">${xsJbxx.chcqj }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">是否随迁子女：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.sfsqzn, 'sfdm', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">生源地行政区划码：</label>
				<div class="controls1">${xsJbxx.sydxzqhm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">出生地：</label>
				<div class="controls1">${xsJbxx.csdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">籍贯：</label>
				<div class="controls1">${xsJbxx.jgdxzqhm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >户口所在地区县以下详细地址：</label>
				<div class="controls1">${xsJbxx.hkszdqxyxxxdz }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">所属派出所：</label>
				<div class="controls1">${xsJbxx.scpcs }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">户口所在地：</label>
				<div class="controls1">${xsJbxx.hkszdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">户口性质：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.hkxz, 'hkxz', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >学生居住地类型：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.xsjzdlx, 'xsjzdlx', '')}
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.zzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >健康状况：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.jkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学生来源：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >招生对象：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">监护人联系电话：</label>
				<div class="controls1">${xsJbxx.jhrlxdh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >毕业学校：</label>
				<div class="controls1">${xsJbxx.byxx }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">电子信箱/其他联系方式：</label>
				<div class="controls1">${xsJbxx.dzxx }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">备注：</label>
				<div class="controls1">${xsJbxx.remarks}
				</div>
			</div>
		</div>
		 --%>
		
		
		
		<fieldset>
			<legend>学生来源信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学生来源：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >招生对象：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">入学方式：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >是否随迁子女：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.sfsqzn, 'sfdm', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">招生生源地：</label>
				<div class="controls1">
					<div class="controls1">${xsJbxx.zssyd}
				</div>
				</div>
			</div>		
		</div>
		
		
		<fieldset>
			<legend>学生入学信息:</legend>
		</fieldset>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" ><font color="red">入学年月：</font></label>
				<div class="controls1">${fns:getDate(xsJbxx.rxny)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">学号：</label>
				<div class="controls1">
					${xsJbxx.xh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >学生类别：</label>
				<div class="controls1">
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" ><font color="red">招生季节：</font></label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.zsjj, 'term_type', '')}</div>
				<%-- <div class="controls1">${xsJbxx.zsjj}</div> --%>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业简称：</label>
				<div class="controls1">${xsJbxx.zyjc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">学习形式：</label>
				<div class="controls1">
					${fns:getDictLabel(xsJbxx.xxxsm, 'xxxs', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">年级：</label>
				<div class="controls1">
					${xsJbxx.nj.nf }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label"><font color="red">学制：</font></label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.xz, 'xzdm', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">分段培养方式：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.fdpyfs, 'fdpyfs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">班级名称：</label>
				<div class="controls1">${xsJbxx.bjmc.bjmc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否校外教学点学生：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.sfxwjxdxs, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">就读方式：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.jdfsm, 'jdfs', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >招生方式：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.zsfs, 'zsfs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">准考证号：</label>
				<div class="controls1">${xsJbxx.zkzh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >考生号：</label>
				<div class="controls1">${xsJbxx.ksh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">考试总分：</label>
				<div class="controls1">${xsJbxx.kszf }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联招合作类型：</label>
				<div class="controls1">${fns:getDictLabel(xsJbxx.lzhzlx, 'lzhzlx', '')}
				</div>
			</div>
				<div class="lg-form">
				<label class="control-label">联招合作学校名称：</label>
				<div class="controls1">${xsJbxx.lzhzxxmc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >联招合作办学形式：</label>
				<div class="controls1"> ${fns:getDictLabel(xsJbxx.lzhzbxfs, 'lzhzbxxs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联招合作学校代码：</label>
				<div class="controls1">${xsJbxx.lzhzxxdm}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >校外教学点：</label>
				<div class="controls1">${xsJbxx.xwjxd }
				</div>
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
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">学号：</label>
				<div class="controls">
					${xsJbxx.xh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >学生类别：</label>
				<div class="controls">
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">学习形式：</label>
				<div class="controls">
					${fns:getDictLabel(xsJbxx.xxxsm, 'xxxs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">入学方式：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label" >国籍/地区：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">港澳台侨外：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.gatqwm, 'gatqwm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">婚姻状况：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.hyzkm, 'hyzk', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">乘火车区间：</label>
				<div class="controls">${xsJbxx.chcqj }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" style ="width:230px;">是否随迁子女：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.sfsqzn, 'sfdm', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">生源地行政区划码：</label>
				<div class="controls">${xsJbxx.sydxzqhm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">出生地行政区划码：</label>
				<div class="controls">${xsJbxx.csdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">籍贯地行政区划码：</label>
				<div class="controls">${xsJbxx.jgdxzqhm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >户口所在详细地址：</label>
				<div class="controls">${xsJbxx.hkszdqxyxxxdz }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">所属派出所：</label>
				<div class="controls">${xsJbxx.scpcs }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">户口所在地行政区划码：</label>
				<div class="controls">${xsJbxx.hkszdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">户口性质：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.hkxz, 'hkxz', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >学生居住地类型：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.xsjzdlx, 'xsjzdlx', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学制：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.xz, 'xzdm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >民族：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.mzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.zzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >健康状况：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.jkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学生来源：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >招生对象：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">监护人联系电话：</label>
				<div class="controls">${xsJbxx.jhrlxdh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >毕业学校：</label>
				<div class="controls">${xsJbxx.byxx }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">${xsJbxx.lxdh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >国籍/地区：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >招生方式：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.zsfs, 'zsfs', '')}
				</div>
			</div>
		</div>
		
		
		
		
		<fieldset>
			<legend>学生来源信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学生来源：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >招生对象：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">入学方式：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >是否随迁子女：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.sfsqzn, 'sfdm', '')}
				</div>
			</div>
		</div>
		
		
		<fieldset>
			<legend>学生入学信息:</legend>
		</fieldset>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">准考证号：</label>
				<div class="controls">${xsJbxx.zkzh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >考生号：</label>
				<div class="controls">${xsJbxx.ksh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学号：</label>
				<div class="controls">
					${xsJbxx.xh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >招生方式：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.zsfs, 'zsfs', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">考生总分：</label>
				<div class="controls">${xsJbxx.kszf }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >考生特长：</label>
				<div class="controls">${xsJbxx.kstc }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">考生既往病史：</label>
				<div class="controls">${xsJbxx.ksjwbs }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >体检结论：</label>
				<div class="controls">${xsJbxx.tjjl }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联招合作类型：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.lzhzlx, 'lzhzlx', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >联招合作办学形式：</label>
				<div class="controls"> ${fns:getDictLabel(xsJbxx.lzhzbxfs, 'lzhzbxxs', '')}
					
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联招合作学校代码：</label>
				<div class="controls">${xsJbxx.lzhzxxdm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >校外教学点：</label>
				<div class="controls">${xsJbxx.xwjxd }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">分段培养方式：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.fdpyfs, 'fdpyfs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">电子信箱/其他联系方式：</label>
				<div class="controls">${xsJbxx.dzxx }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">家庭现地址：</label>
				<div class="controls">${xsJbxx.jtxdz }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >家庭邮政编码：</label>
				<div class="controls">${xsJbxx.jtyzbm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">家庭电话：</label>
				<div class="controls">${xsJbxx.jtdh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >入学年月：</label>
				<div class="controls">${fns:getDate(xsJbxx.rxny)}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" >学生类别：</label>
				<div class="controls">
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">乘火车区间：</label>
				<div class="controls">${xsJbxx.chcqj }
				</div>
			</div>
		</div>
		
		<div  class="control-group">
			<div class="lg-form">
				<label class="control-label">学习形式：</label>
				<div class="controls">
					${fns:getDictLabel(xsJbxx.xxxsm, 'xxxs', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">就读方式：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.jdfsm, 'jdfs', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业类别：</label>
				<div class="controls">${xsJbxx.zylxId.lxmc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >专业名称：</label>
				<div class="controls" id="zhuaYeId">
					${xsJbxx.zyId.zymc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">班级：</label>
				<div class="controls">${xsJbxx.bjmc.bjmc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业简称：</label>
				<div class="controls">${xsJbxx.zyjc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label" >专业方向：</label>
				<div class="controls">${xsJbxx.zyfx}
				</div>
			</div>
		</div>
		 --%>
		
		
		
		
		<fieldset>
			<legend>成员1信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">${xsJbxx.cyyxm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyygx, 'cygx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyysfjhr, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">${xsJbxx.cyylxdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class="controls">${fns:getDate(xsJbxx.cyycsny)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyysfzjlx, 'sfzjlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">${xsJbxx.cyysfzjh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyymzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyyzzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyyjkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class="controls">${xsJbxx.cyygzhxxdw }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class="controls">${xsJbxx.cyyzw }
				</div>
			</div>
		</div>
		<fieldset>
			<legend>成员2信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">${xsJbxx.cyexm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyegx, 'cygx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyesfjhr, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">${xsJbxx.cyelxdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class="controls">${fns:getDate(xsJbxx.cyecsny)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyesfzjlx, 'sfzjlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">${xsJbxx.cyesfzjh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyemzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyezzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">${fns:getDictLabel(xsJbxx.cyejkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class="controls">${xsJbxx.cyegzhxxdw }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class="controls">${xsJbxx.cyezw }
				</div>
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
					 <form:radiobutton id="shzt" name="shzt" path="shzt" value="1" checked="true"/>通过  
                     <form:radiobutton id="shzt" name="shzt" path="shzt" value="2"/>不通过
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<form:textarea id="spnr" path="spnr" htmlEscape="false" rows="4" 
					maxlength="255" class="input-xxlarge " style="width:677px;"/>
			</div>
		</div>
		
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<form:input path="approveBy.name" id="approveBy.name"  
					htmlEscape="false" maxlength="11" readonly="true" value="${userName }" class="input-xlarge"/>
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
				     <input name="approveDate" type="text" disabled="disabled" maxlength="64" class="input-xlarge Wdate required"
					value="<fmt:formatDate value="${approveDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			     </div>
		   </div>
		</div>
		
		<div class="form-actions" align="center">
			<%-- <shiro:hasPermission name="xs:xsJbxx:edit">
			<input id="btnSubmit" onclick="return saveBefferCheck()" class="btn btn-primary" type="button" value="审 核"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> --%>
			<input id="btnSubmitOk" onclick="return ShenHeCheck()" class="btn btn-primary" type="button" value="确定"/>&nbsp;
			<input id="btnCancel" class="btn btn-primary"  type="button" value="取消" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>