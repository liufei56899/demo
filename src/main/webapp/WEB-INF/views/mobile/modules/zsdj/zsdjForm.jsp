<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%> 
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>${fns:getConfig('productName')}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.css">
    <script src="https://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script src="${ctxStatic}/validMes/MobilevalidMes.js" type="text/javascript" ></script>
    <!-- --------------消息提示插件    start----------------------------- -->
    <%-- <link rel="stylesheet" href="${ctxStatic}/mobile-js/example.css"> --%>
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="${ctxStatic}/mobile-js/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/mobile-js/sweetalert.css">
     <!-- ------------------------end------------------- -->
</head>
<section id="form_section" class="active">
<script type="text/javascript">
$(document).ready(function() {
  $("#back").on("click",function(){
		window.location="${ctx}/zsdj/zsdj/zslslist";
		});
   var sfid= "${zsdj.sf}";
   var csid= "${zsdj.cs}";
   var qxid= "${zsdj.qx}";
   var xzid= "${zsdj.jd}";
    byCS(sfid);
    byQX(csid);
    byXZ(qxid);
	var cs_title = document.getElementById("cs");
	var cs_title_value="";
   for ( var i = 0; i < cs_title.options.length; i++) {
					if (cs_title.options[i].value == csid) {
						cs_title_value=cs_title.options[i].value;
						$("#cs").find(
								"option[value='" + cs_title_value
										+ "']").attr("selected", true);
										$("#cs-button>span").text(cs_title.options[i].text);
						break;
					}
				}
				
	var qx_title = document.getElementById("qx");
						var qx_title_value = "";
						for ( var i = 0; i < qx_title.options.length; i++) {
							if (qx_title.options[i].value == qxid) {
								qx_title_value = qx_title.options[i].value;
								$("#qx").find(
										"option[value='" + qx_title_value
												+ "']").attr("selected", true);
												$("#qx-button>span").text(qx_title.options[i].text);
								break;
							}
						}
		var xz_title = document.getElementById("xz");
						var xz_title_value = "";
						for ( var i = 0; i < xz_title.options.length; i++) {
							if (xz_title.options[i].value == xzid) {
								xz_title_value = xz_title.options[i].value;
								$("#xz").find(
										"option[value='" + xz_title_value
												+ "']").attr("selected", true);
												$("#xz-button>span").text(xz_title.options[i].text);
								break;
							}
						}
		
		
		    var id = "${zsdj.zylx.id}";
		    var zyid =  "${zsdj.zy.id}";
		      if(id!=null && id!='')
			{
				var jh= "${zsdj.zsjh.id}";
				findZyLxByJhId(jh,'${ctx}','zylxId1','${zsdj.zylx.id}');
			}
		    var flag = "2";
		    if(id!=null&&id!=""){
		    	$("#zyid").empty();
		    	$.getJSON("${ctx}/zsdj/zsdj/findZyByJhLxIdm",
		             {jhid:"${zsdj.zsjh.id}",id:"${zsdj.zylx.id}",flag:flag},
		             function(result){
		                 if(result !=null && result!=""){
		                   $("#zyid").append(result.html);
		                   $("#zyid-button>span").text($("#zyid").find("option:selected").text());
		                   $("#zyid").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
		                   findXueZhiById($("#zyid"),'${ctx}','xzLab','xzId');
		                 }
		  	         }
		  	   );
		    }
			/* $("#inputForm").validate({
			alert(".........");
				submitHandler: function(form){
					var isTrue = validateLxdh();
					if(isTrue)
					{
						isTrue = validateSfzxx(null);
					}
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
			}); */
			
			if("${zsdj.id}" != "")
			{
				$("#btnSaveAndAdd").addClass(" hide");
			}
		});
		 //选择专业
		function lxChange(info){
			if(info!=null&&info!=""){
		     	var jhid = $("#jhId1").val();
		     	$("#zyid").empty();
		         $.getJSON("${ctx}/zsdj/zsdj/findZyByJhLxIdm",{jhid:jhid,id:info},function(result){
				   if(result!=null&&result!=""){
				      $("#zyid").append(result.html);
				      $("#xzLab").html("");
				     /*  $("#zyid").attr("style","width:220px;"); */
				      $("#zyid").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
					  $("#zyid-button>span").text($("#zyid").find("option:selected").text());
				      findXueZhiById($("#zyid"),'${ctx}','xzLab','xzId');
				      
				   }
			    });
	     }
		
		}
		//验证联系电话
	  function validateLxdh()
		{
			var value = $("#lxdh").val();
			if(value !=null && value!=""){
				var isTrue = /^1\d{10}$/i.test(value) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
				if(!isTrue){
				  /*  validTxt("lxdh","联系电话格式有问题"); */
				   swal("请输入正确的联系电话","","error");
				   return false;
				}
			return true;
			}else{
			 return false;
			}
		}
		//验证身份证信息是否重复
	 function validateSfzxx(num){
	     var sfzjhvalue = $("#sfzjh").val();
	     var id ="${zsdj.id}";
	     var sfzjlx = $("#sfzjlx").val();
	     var isTrue = true;
	     if(sfzjlx=='1'){
	         var isT = IdCardValidate(sfzjhvalue);
			if(!isT){
				/* validTxt("sfzjh","请输入正确的身份证件号码"); */
				swal("请输入正确的身份证件号码","","error");
				return false;
			}
	         //出生日期
	         if(num!=null)
	         {
	         	var csrqVal =findCsrqByCard(sfzjhvalue);
	       		$("#csrq").attr("onclick","");
	       		$("#csrq").attr("readonly","readonly");
	       		$("#csrq").val(csrqVal);
	         }
	     }
	     else{
	     	$("#csrq").attr("onclick","WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});");
			$("#csrq").removeAttr("readonly");
			if(num!=null)
			{
	       		$("#csrq").val("");
			}
		}
		
	     if(sfzjhvalue!=null&&sfzjhvalue!=""){
		    $.ajax({
			        type: "POST",
			        url: "${ctx}/zsdj/zsdj/validateSfzxx",
			        data: {sfzjh:sfzjhvalue,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						isTrue = result.isTrue;
						if(!isTrue)
						{
							/* validTxt("sfzjh","身份证件号码不能重复"); */
							swal("证件号码不能重复","","error");
							return false;
						}
				   }
			    });
	     }
	      return isTrue;
	  }
function setBcfs(fs){
	  		$("#bcfs").val(fs);
  } 
  //提交时验证表单是否为空
  function valid(){
        /*   i=3  是因为添加和修改是同一个页面，有3个隐藏域
          length-2 是因为备注信息可以为空 */
		 for(var i=3;i<document.inputForm.elements.length-2;i++){
				  if(document.inputForm.elements[i].value=="") {
					 swal("请保证数据完整","","error");
						return;
				  }
			   }
		
		
	  var a= validateLxdh();
	  var b=validateSfzxx();
	  if(a==true&&b==true){
	    $("#inputForm").submit();
	  }
	     
  }
  
function byCS(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs").empty();
			$("#qx").empty();
			$("#xz").empty();
			$("#cs").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ");
			$("#qx").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ");
			$("#xz").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ");
			$("#cs-button>span").text("请选择");
			$("#qx-button>span").text("请选择");
			$("#xz-button>span").text("请选择");
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
				
					$("#cs")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ");
				}
			}
		});
	}

	function byQX(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx").empty();
			$("#xz").empty();
			$("#qx").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ");
			$("#xz").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ");
			$("#qx-button>span").text("请选择");
			$("#xz-button>span").text("请选择");
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					
					$("#qx")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ");
				}
			}
		});
	}
	
	function byXZ(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#xz").empty();
			$("#xz").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ");
			$("#xz-button>span").text("请选择");
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					
					$("#xz")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ");
				}
			}
		});
	}
	
/**根据计划名称查询学年学期
 * obj 
 * http
 * labid
 * input 
 * */
function findXueNianXueQi(obj,http,labId,inputId)
{
	var id = $(obj).val();
	$.ajax({
        type: "POST",
        url: http+"/zsdj/zsdj/findXueNianXueQiById",
        data: {id:id},
        dataType:'json',
        async:false,
		success: function(result){
			$("#"+labId).val(result.nf.xnmc);
			$("#"+inputId).val(result.nf.id);
	   }
    });
}
/***
 * 根据计划id查询专业类型
 * @param id
 * @param http
 * @param selectId
 * @param zylxId
 */
function findZyLxByJhId(id,http,selectId,zylxId)
{
	/* var selHtml ="<select name='zylx.id' id='zylxId1' onchange='lxChange(this.value)' class='input-xlarge required'>"; */
	var selHtml = "<option value='' >请选择</option>";
	$("#"+selectId).empty();
	$.ajax({
        type: "POST",
        url: http+"/zsdj/zsdj/findZyLxByJhIdm",
        data: {id:id},
        dataType:'json',
        async:false,
		success: function(result){
			for(var i=0;i<result.length;i++)
			{
				selHtml +="<option value='"+result[i].zylxId.id+"' ";
				if(zylxId!=null && zylxId!="")
				{
					if(result[i].zylxId.id == zylxId)
					{
						selHtml += "selected ='selected'";
						$("#zylxId1-button>span").text(result[i].zylxId.lxmc);
					}
					
				}
				selHtml +=" > "+result[i].zylxId.lxmc+"</option>";
			}
	   }
    });
	/* selHtml +="</select>"; */
	$("#"+selectId).html(selHtml);
	$("#zyid").find("option").each(function(index)
	{
		if(index>0)
		{
			$(this).remove();
		}
	});
	$("#zyid").find("option[value='']").attr("selected",true);
	
	$("#xzLab").val('');
}
/**
 *  根据身份证取出生日期
 * */
function findCsrqByCard(idCard)
{
	var csrqVal = null;
	if (idCard.length == 15) 
	{
		var year =  idCard.substring(6,8);   
	    var month = idCard.substring(8,10);   
	    var day = idCard.substring(10,12); 
	    csrqVal = year +"-"+month+"-"+day;
	}else if(idCard.length == 18)
	{
		 var year =  idCard.substring(6,10);   
		 var month = idCard.substring(10,12);   
		 var day = idCard.substring(12,14); 
		 csrqVal = year +"-"+month+"-"+day;
	}
	return csrqVal;
	
}
/**根据专业id查询学制
 * obj 
 * http
 * labid
 * input 
 * */
function findXueZhiById(obj,http,labId,inputId)
{
	var id = $(obj).val();
	if(id!=null && id!="")
	{
		$.ajax({
	        type: "POST",
	        url: http+"/zsdj/zsdj/findZyXueZhiById",
	        data: {id:id},
	        dataType:'json',
	        async:false,
			success: function(result){
				$("#"+labId).val(result.xzmc);
				$("#"+inputId).val(result.xz);
		   }
	    });
		
	}else
	{
		$("#"+labId).val("");
		$("#"+inputId).val("");
	}
}
//==================================
	</script>
	<header  data-role="header" style="background-color: #40ED9F;">
            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-icon-back ui-btn-icon-left"  id="back" >返回</a>
        	<h1 class="title">${fns:getConfig('productName')}</h1>
    </header>
  <article class="active" id="form_article"  data-scroll="true">
  	<div class="indented">
<form:form id="inputForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/savezs" method="post" 
class="form-horizontal" name="inputForm">
		<form:hidden path="id"/>
		<form:hidden id="bcfs" path="bcfs"/>
		<input type="hidden" name="ly" value="1"> 
		   <div style="text-align: left">
			<label>计划名称：</label>
			<div >
				<form:select path="zsjh.id" id="jhId1"  class="input-xlarge required" 
					 onchange="findXueNianXueQi(this,'${ctx}','zsjj','xnxqId');findZyLxByJhId(this.value,'${ctx}','zylxId1','');" >
					<form:option value="" label="请选择..."/>
					<form:options items="${fns:findZsjhListByUserId()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
			</div>
			<div style="text-align: left">
                        <label>学生姓名：</label>
                        <div >
                             <form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-xlarge required" placeholder="请输入姓名..." />
                        </div>
                    </div>
		   <div  style="text-align: left">
			<label>性别：</label>
			<div >
				<form:select path="xbm"  id="xb" class="input-xlarge required" >
					<form:option value="" label="请选择..."/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			</div>
			<div style="text-align: left">
				<label>民族：</label>
				<div >
					<form:select path="nation" id="mz" class="input-xlarge  required" >
						<form:option value="" label="请选择..."/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div style="text-align: left">
			<label>专业类别：</label>
			<div  id="zylbDiv">
					<form:select path="zylx.id" id="zylxId1" onchange="lxChange(this.value)" class="input-xlarge required">
							<form:option value="" label="请选择..."/>
				</form:select>
			</div>
			</div>
			<div style="text-align: left">
				<label>专业名称：</label>
				<div  id="zyByLxzs">
					<form:select id="zyid" path="zy.id" class="input-xlarge required">
						<form:option value="" label="请选择..." />
					</form:select>
				</div>
			</div>
		 <div style="text-align: left">
			<label>招生季节：</label>
			<div >
					<input id="zsjj" readonly="readonly" value="${zsdj.xnxq.xnmc}"/>
					<input type="hidden" name="xnxq.id" id="xnxqId" value="${zsdj.xnxq.id}" />	
			</div>
			</div>
			<div style="text-align: left">
			   <label>学制：</label>
				<div >
					<input id="xzLab" readonly="readonly" value="${zsdj.xz}"/>
						<input type="hidden" name="xz" id="xzId" value="${zsdj.zy.xz}" />
				</div>
			 </div>
			<div style="text-align: left">
				<label>身份证件类型：</label>
				<div >
					<form:select path="sfzjlx" id="sfzjlx" class="input-xlarge  required">
						<form:option value="" label="请选择..."/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div style="text-align: left">
				 <label>证件号码：</label>
				<div >
					<form:input id="sfzjh" path="sfzjh" htmlEscape="false" maxlength="18" placeholder="请输入..."
					 onblur="validateSfzxx('1')"
						        class="input-xlarge required" />
				</div>
			 </div>
			<div style="text-align: left">
					<label>出生日期：</label>
					<div >
						<input name="csrq" type="date" id="csrq"  maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>"/>
					</div>
			</div>
			<div style="text-align: left">
				<labe>家庭住址：</label>
				<div >
					<form:input path="jtzz" id="address" htmlEscape="false" maxlength="255" class="input-xlarge " placeholder="请输入..."/>
				</div>
			</div>
		<div style="text-align: left">
			  <label>生源校：</label>
			<div >
				<form:input path="fromSchool"  id="syx" htmlEscape="false" maxlength="32" placeholder="请输入..."
					        class="input-xlarge required" />
			</div>
			</div>
		   <div style="text-align: left">
		     			<label>联系电话：</label>
			<div >
				<form:input path="lxdh"  id="lxdh" htmlEscape="false" maxlength="32" class="input-xlarge " placeholder="请输入..."
				           onblur="validateLxdh()"/>
			</div>
		   </div>
		<div style="text-align: left">
			<label>生源地区：</label>
			<div >
			<form:select path="sf" class="input-xlarge  required" onchange="byCS(this.value)" >
						<form:option value="" label="请选择"/>
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
					<br>
			<form:select path="cs" class="input-xlarge  required" id="cs" onchange="byQX(this.value)" >
						<form:option value="" label="请选择"/>
					</form:select>
					<br>
			<form:select path="qx" class="input-xlarge  required"  id="qx" onchange="byXZ(this.value)" >
						<form:option value="" label="请选择"/>
					</form:select>
					<br>
					<form:select path="jd" class="input-xlarge  required"  id="xz">
						<form:option value="" label="请选择"/>
					</form:select>
			</div>
		</div>
		<div style="text-align: left">
			<label>备注信息：</label>
			<div >
				<form:textarea path="remarks"  htmlEscape="false" rows="4" maxlength="255" 
					class="input-xxlarge "  />
			</div>
		</div>
		  <button class="ui-btn ui-corner-all ui-shadow ui-icon-check ui-btn-icon-left" 
		  style="background-color: #40ED9F;"
		  		onclick="setBcfs('save');valid();" type="button">保存</button>
		
	</form:form>
       </div>
    </article>
</section>
