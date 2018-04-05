<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>新生报到管理</title>
<meta name="decorator" content="default" />
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="/em/static/js/reset.css">
<link rel="stylesheet" href="/em/static/js/editstyle.css">
<style type="text/css">
 .cxtj{
 background: none;
 border-bottom: 1px solid #bbb;
 height: 42px;
 color:#317eac;
 text-align: center;
 font-size: 18px;
 font-weight:bold;
 }
 .select2-result-label{
  font-size: 14px;
 }
 
  .f-information>div,.s-information>div,.t-information>div,.o-information>div{
    float:none !important;
    width: 100%;
} 
.r-group label.gr-mc{
	width: 40%;
}
..left-information .group, .right-information .group{
	width: 60%;
}
.group{
		width: 60% !important;
}
</style>	

<script>
$.extend($.validator.messages, {
required: "&nbsp;"
});
	var index = 0;
	$(document).ready(
			function() {
				f();
				CamSDKOCX2.InitCameraLib();
				StartVideo2();

				var $div_btn = $(".s-btn");
				$div_btn
						.click(function() {

							cleanXSDJXX();
                           CamSDKOCX2.CloseDev();
                           CamSDKOCX2.UnInitCameraLib();
							$(this).addClass("active").siblings().removeClass(
									"active");
							index = $div_btn.index(this);
							$("div.content-box>.o-information>.photo")
									.eq(index).show().siblings().hide();
							if (index == 1) {
							  	$("#btnSerach").attr("disabled",false);
								f1();
								//$("#cxb").select2();
								
							}
							;
							if (index == 2) {
							  	$("#btnSerach").attr("disabled",false);
								f2();
								
							}
							;
							if (index == 3) {
							  	$("#btnSerach").attr("disabled",false);
								f3();
								
							}
							;
							if (index == 0) {
								
								$("#btnSerach").attr("disabled",true);
								f();

							}
							;
							$("div.body-box>.photo-body").eq(index).show()
									.siblings().hide();
							
							CamSDKOCX2.InitCameraLib();
							StartVideo();
							StartVideo2();
						});
			});

	function f() {

		$("#c3").empty();
		$("#c4").empty();
		$("#c5").empty();
		$("#c6").empty();
		$("#c2").empty();
		$("#c1").empty();

		$("#cc")
				.html(
						"<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%' classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		//CamSDKOCX2.InitCameraLib();
		//StartVideo();
		//StartVideo2();
	}

	function f1() {
		$("#c3").empty();
		$("#c4").empty();
		$("#c5").empty();
		$("#c6").empty();
		$("#cc").empty();
		$("#c1")
				.html(
						"<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%' classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		$("#c2")
				.html(
						"<OBJECT id='CamSDKOCX1' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%' classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		//CamSDKOCX1.InitCameraLib();
		//StartVideo();
		//StartVideo2();
	}

	function f2() {
		$("#c1").empty();
		$("#c2").empty();
		$("#c5").empty();
		$("#c6").empty();
		$("#cc").empty();
		$("#c3")
				.html(
						"<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		$("#c4")
				.html(
						"<OBJECT id='CamSDKOCX1' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		//CamSDKOCX1.InitCameraLib();
		//StartVideo();
		//StartVideo2();
	}
	function f3() {
		$("#c1").empty();
		$("#c2").empty();
		$("#c3").empty();
		$("#c4").empty();
		$("#cc").empty();
		$("#c5")
				.html(
						"<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		$("#c6")
				.html(
						"<OBJECT id='CamSDKOCX1' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>")

		//CamSDKOCX1.InitCameraLib();
		//StartVideo();
		//StartVideo2();
	}
</script>

<script type="text/javascript">
	$(window).load(function() {
		var s = $("#xxx").val();
		if (s == "1") {
			$("#xxx").val("男");
		} else {
			$("#xxx").val("女");
		}
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>

<script type="text/javascript">
	$(document).ready(
			function() {
				//$("#name").focus();

				$("#inputForm1")
						.validate(
								{
									submitHandler : function(form) {
									     var isTrue = onchange();
	                                     if (isTrue) {
											loading('正在提交，请稍等...');
											form.submit();
										}
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
											$(".group").find("label[class='error']").each(function(){
												$(this).html("0");
											});
											
											 //element.html("必填项！");
										}
									}
								});
				$("#inputForm2")
						.validate(
								{
									submitHandler : function(form) {
										 var isTrue = onchange1();
	                                     if (isTrue) {
											loading('正在提交，请稍等...');
											form.submit();
										}
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
				$("#inputForm3")
						.validate(
								{
									submitHandler : function(form) {
										 var isTrue = onchange2();
	                                     if (isTrue) {
											loading('正在提交，请稍等...');
											form.submit();
										}
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
				$("#inputForm4")
						.validate(
								{
									submitHandler : function(form) {
										 var isTrue = onchange3();
	                                     if (isTrue) {
											loading('正在提交，请稍等...');
											form.submit();
										}
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
				/* zhuanYeInit();
				//initSex(); */
			});

                 //===========================表单验证==============================
                function byIDD(){
                  $("#rsfzjh").attr("readonly",true);
                  $("#rcsrq").attr("readonly",true);
                  $("#rjtzz").attr("readonly",true);
				  $("#rqfjg").attr("readonly",true);
                 }
                 function onchange() {
		         var isTrue1 = byName();
		         var isTrue2 = byID();
		         var isTrue3 =byYears();
		         return isTrue1&&isTrue2&&isTrue3;
	             }
	             
		//验证联系电话
	  function validateLxdh()
		{
			var value = $("#lxdh").val();
			if(value !=null && value!="")
			{
				var isTrue = /^1\d{10}$/i.test(value) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
				if(!isTrue)
				{
				   validTxt("lxdh","联系电话格式有问题");
				   return false;
				}
			}
			return true;
		}
                 //验证姓名
                   function byName(){
                   var xxx = $("#rxm").val();
		           var re = /^[\u4E00-\u9FA5]{2,8}$/;
		            if(xxx!=null&&xxx!=""){
		            if (!re.test(xxx)) {
			         alertx("您的真实姓名必须是2~8位的中文！");
			         //$("#xmfont").insertAfter("src","/em/static/js/unchecked.gif");
			       return false;
		               }
		            return true;
		               }
                   }
                   function onblurid(sfzjhVal){
		         	
                   }
                   //验证身份证号
                    function byID(){
                   	 var sfzjhVal = $("#rsfzjh").val();
		             if (sfzjhVal != null && sfzjhVal != "") {
			         	 var isT = IdCardValidate(sfzjhVal);
			     		 if (!isT) {
				          		validTxt("rsfzjh", "&nbsp;");
				       		 return false
			          	 }
		             }
		     var flag=    loadXSDJXX(sfzjhVal);
		      if(flag==1){
				      validTxt("rsfzjh", "&nbsp;");
				      return false;
		      }
		            	 //getCSRQ(sfzjhVal);
		                 return true;
                   }
                   //验证生日
           function byYears(){
                      
	                var sfzjhVal = $("#rsfzjh").val();
		             var birthday = $("#rcsrq").val();
		            var a = sfzjhVal.substring(6, 14);
		            if (birthday != null && birthday != "") {
		                var y=birthday.substring(0,4);
		                var m=birthday.substring(5,7);
		                var d=birthday.substring(8,10);
		                var rq=y+m+d;
			             if (a != rq) {
				         alertx("出生日期与身份证件号码对应日期不符！");
				return false;
			}
		}

		return true;
                   }
                   
                   
       function onchange1() {
		         var isTrue1 = byName1();
		         var isTrue2 = byID1();
		         var isTrue3 =byYears1();
		         return isTrue1&&isTrue2&&isTrue3;
	             }
                   
                   //=======
                    function byName1(){
                     var xxx = $("#cxm").val();
		           var re = /^[\u4E00-\u9FA5]{2,8}$/;
		            if(xxx!=null&&xxx!=""){
		            if (!re.test(xxx)) {
			         alertx("您的真实姓名必须是2~8位的中文！");
			       return false;
		               }
		            return true;
		               }
                   }
                    //=======
                    function byID1(){
                    var sfzjhVal = $("#csfzjh").val();
		             if (sfzjhVal != null && sfzjhVal != "") {
			          var isT = IdCardValidate(sfzjhVal);
			          if (!isT) {
				          validTxt("csfzjh", "&nbsp;");
				        return false
			              }
		                 }
		  var flag=    loadXSDJXX(sfzjhVal);
		      if(flag==1){
				      validTxt("csfzjh", "&nbsp;");
				      return false;
		      }
		               getCSRQ1(sfzjhVal);
		                 return true;
                      }
                    //=======
                    function byYears1(){
                      
	                var sfzjhVal = $("#csfzjh").val();
		             var birthday = $("#ccsrq").val();
		            var a = sfzjhVal.substring(6, 14);
		            if (birthday != null && birthday != "") {
		                var y=birthday.substring(0,4);
		                var m=birthday.substring(5,7);
		                var d=birthday.substring(8,10);
		                var rq=y+m+d;
			             if (a != rq) {
				         alertx("出生日期与身份证件号码对应日期不符！");
				          return false;
			            }
		                      }

		                return true;
                   }
                   
                   
                    function onchange2() {
		         var isTrue1 = byName2();
		         var isTrue2 = byID2();
		         var isTrue3 =byYears2();
		         return isTrue1&&isTrue2&&isTrue3;
	             }
                    //=======
                    function byName2(){
                     var xxx = $("#bxm").val();
		           var re = /^[\u4E00-\u9FA5]{2,8}$/;
		            if(xxx!=null&&xxx!=""){
		            if (!re.test(xxx)) {
			         alertx("您的真实姓名必须是2~8位的中文！");
			       return false;
		               }
		            return true;
		               }
                   }
                    //=======
                    function byID2(){
                    var sfzjhVal = $("#bsfzjh").val();
		             if (sfzjhVal != null && sfzjhVal != "") {
			          var isT = IdCardValidate(sfzjhVal);
			      if (!isT) {
				          validTxt("bsfzjh", "&nbsp;");
				        return false
			           }
		             }
		     var flag=    loadXSDJXX(sfzjhVal);
		      if(flag==1){
				      validTxt("bsfzjh", "&nbsp;");
				      return false;
		      }
		       getCSRQ2(sfzjhVal);
		                 return true;
                   }
                    //=======
                    function byYears2(){
                      
	                var sfzjhVal = $("#bsfzjh").val();
		             var birthday = $("#bcsrq").val();
		            var a = sfzjhVal.substring(6, 14);
		            if (birthday != null && birthday != "") {
		                var y=birthday.substring(0,4);
		                var m=birthday.substring(5,7);
		                var d=birthday.substring(8,10);
		                var rq=y+m+d;
			             if (a != rq) {
				        alertx("出生日期与身份证件号码对应日期不符！");
				return false;
			}
		}

		return true;
                   }
                   
                   
                    function onchange3() {
		         var isTrue1 = byName3();
		         var isTrue2 = byID3();
		         var isTrue3 =byYears3();
		         return isTrue1&&isTrue2&&isTrue3;
	             }
                    //=======
                    function byName3(){
                     var xxx = $("#qxm").val();
		           var re = /^[\u4E00-\u9FA5]{2,8}$/;
		            if(xxx!=null&&xxx!=""){
		            if (!re.test(xxx)) {
			         alertx("您的真实姓名必须是2~8位的中文！");
			       return false;
		               }
		            return true;
		               }
                   }
                    //=======
                    function byID3(){
                    var sfzjhVal = $("#qsfzjh").val();
		             if (sfzjhVal != null && sfzjhVal != "") {
			          var isT = IdCardValidate(sfzjhVal);
			      if (!isT) {
				          validTxt("qsfzjh", "&nbsp;");
				        return false
			           }
		             }
		      var flag=    loadXSDJXX(sfzjhVal);
		      if(flag==1){
				      validTxt("qsfzjh", "&nbsp;");
				      return false;
		      }
		         getCSRQ3(sfzjhVal);
		                 return true;
                   }
                    //=======
                    function byYears3(){
                      
	                var sfzjhVal = $("#qsfzjh").val();
		             var birthday = $("#qcsrq").val();
		            var a = sfzjhVal.substring(6, 14);
		            if (birthday != null && birthday != "") {
		                var y=birthday.substring(0,4);
		                var m=birthday.substring(5,7);
		                var d=birthday.substring(8,10);
		                var rq=y+m+d;
			             if (a != rq) {
				        alertx("出生日期与身份证件号码对应日期不符！");
				return false;
			}
		}

		return true;
                   }
	//选择专业
	function lxChange(info) {
		$("#zyid1").empty();
		$("#zyid1").select2("destroy");
	}
	//选择专业1
	function lxChange1(info) {
		if (info != null && info != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
			data : {
				id : info
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					ht = ht.replace("zy.id", "zylxId");
					$("#zyByLx1").html(ht);
					$("#zyid").attr("style", "width:215px;");
					$("#zyid").attr("class", "input-medium required");
					$("#zyid").attr("onchange",
							"findXueZhiById(this,'${ctx}','xzLab','xzId')");
					$("#zyid").attr("onchange","zyChange1(this.value);");
					$("#zyid").select2();
				}
			}
		});
			

		}
	}
	
		//显示学制
	function zyChange1(ida) {
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					$("#xza").val(ht);
					
				}
			}
		});
		}
	}
		//选择专业5
	function lxChange5(info) {
		if (info != null && info != "") {
		    jQuery.ajax({
					type : "POST",
					url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
					data : {
						id : info
					},
					dataType : 'json',
					async : false,
					success : function(result) {
					     if (result != null && result != "") {
							var ht = result.html;
							alertx(ht);
							ht = ht.replace("zyid", "zyid5");
							ht = ht.replace("zy.id", "zylxId");
							$("#zyByLx5").html(ht);
							$("#zyid5").attr("style", "width:228px;");
							$("#zyid5").attr("class", "input-medium");
							$("#zyid5").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid5").attr("onchange","zyChange5(this.value);");
							$("#zyid5").select2();
									}
						 }
					  });
					}
				}
		//显示专业简称
	function zyChange5(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzf").val(ht);
					
				}
			}
		});
			

		}
	}
		//选择专业6
	function lxChange6(info) {
		if (info != null && info != "") {
		    jQuery.ajax({
					type : "POST",
					url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
					data : {
						id : info
					},
					dataType : 'json',
					async : false,
					success : function(result) {
					     if (result != null && result != "") {
							var ht = result.html;
							alertx(ht);
							ht = ht.replace("zyid", "zyid6");
							ht = ht.replace("zy.id", "zylxId");
							$("#zyByLx6").html(ht);
							$("#zyid6").attr("style", "width:228px;");
							$("#zyid6").attr("class", "input-medium");
							$("#zyid6").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid6").attr("onchange","zyChange5(this.value);");
							$("#zyid6").select2();
									}
						 }
					  });
					}
				}
		//显示专业简称
	function zyChange6(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzf6").val(ht);
					
				}
			}
		});
			

		}
	}
		//选择专业7
	function lxChange7(info) {
		if (info != null && info != "") {
		    jQuery.ajax({
					type : "POST",
					url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
					data : {
						id : info
					},
					dataType : 'json',
					async : false,
					success : function(result) {
					     if (result != null && result != "") {
							var ht = result.html;
							alertx(ht);
							ht = ht.replace("zyid", "zyid7");
							ht = ht.replace("zy.id", "zylxId");
							$("#zyByLx7").html(ht);
							$("#zyid7").attr("style", "width:228px;");
							$("#zyid7").attr("class", "input-medium");
							$("#zyid7").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid7").attr("onchange","zyChange5(this.value);");
							$("#zyid7").select2();
									}
						 }
					  });
					}
				}
		//显示专业简称
	function zyChange7(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzf7").val(ht);
					
				}
			}
		});
			

		}
	}
		//选择专业5
	function lxChange8(info) {
		if (info != null && info != "") {
		    jQuery.ajax({
					type : "POST",
					url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
					data : {
						id : info
					},
					dataType : 'json',
					async : false,
					success : function(result) {
					     if (result != null && result != "") {
							var ht = result.html;
							alertx(ht);
							ht = ht.replace("zyid", "zyid8");
							ht = ht.replace("zy.id", "zylxId");
							$("#zyByLx8").html(ht);
							$("#zyid8").attr("style", "width:228px;");
							$("#zyid8").attr("class", "input-medium");
							$("#zyid8").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid8").attr("onchange","zyChange5(this.value);");
							$("#zyid8").select2();
									}
						 }
					  });
					}
				}
		//显示专业简称
	function zyChange8(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzf8").val(ht);
					
				}
			}
		});
			

		}
	}
	//选择专业2
	function lxChange2(info) {
		if (info != null && info != "") {
			jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
			data : {
				id : info
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					ht = ht.replace("zyid", "zyid2");
					ht = ht.replace("zy.id", "zylxId");
					$("#zyByLx2").html(ht);
					$("#zyid2").attr("style", "width:215px;");
					$("#zyid2").attr("class", "input-medium required");
					$("#zyid2").attr("onchange",
							"findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid2").attr("onchange","zyChange2(this.value);");
					$("#zyid2").select2();
				}
			}
		});
			

		}
	}
	
		//显示专业简称
	function zyChange2(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzb").val(ht);
					
				}
			}
		});
			

		}
	}
	//选择专业3
	function lxChange3(info) {
		if (info != null && info != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
			data : {
				id : info
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					ht = ht.replace("zyid", "zyid3");
					ht = ht.replace("zy.id", "zylxId");
					$("#zyByLx3").html(ht);
					$("#zyid3").attr("style", "width:228px;");
					$("#zyid3").attr("class", "input-medium required");
					$("#zyid3").attr("onchange",
							"findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid3").attr("onchange","zyChange3(this.value);");
					$("#zyid3").select2();
				}
			}
		});

		}
	}
		//显示专业简称
	function zyChange3(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzc").val(ht);
					
				}
			}
		});
			

		}
	}
	//选择专业4
	function lxChange4(info) {
		if (info != null && info != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByLxIdList",
			data : {
				id : info
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					ht = ht.replace("zyid", "zyid4");
					ht = ht.replace("zy.id", "zylxId");
					$("#zyByLx4").html(ht);
					$("#zyid4").attr("style", "width:228px;");
					$("#zyid4").attr("class", "input-medium required");
					$("#zyid4").attr("onchange",
							"findXueZhiById(this,'${ctx}','xzLab','xzId')");
							$("#zyid4").attr("onchange","zyChange4(this.value);");
					$("#zyid4").select2();
				}
			}
		});
		}
	}
		//显示专业简称
	function zyChange4(ida) {
	    
		if (ida != null && ida != "") {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/findZysByzyIdList",
			data : {
				id : ida
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result != null && result != "") {
					var ht = result.html;
					
					$("#xzd").val(ht);
					
				}
			}
		});
			

		}
	}
</script>

<!-- ------------------------------身份证读卡器功能------------------------------- -->
<script type="text/javascript">
	function readcard() {
		if(connect()==-1){
			return;
		};//连接
		
		getStatus();//获取状态
		readCert1();//读取信息
		disconnect();//断开连接

	}
	//测试连接是否成功
	function connect() {
		//clearForm();
		var ret = CertCtl.connect();
		//alertx(ret);
		//document.all['ret'].innerHTML = ret;
		ret = JStrToObj(ret);
		DisplayInfo(ret);
		return ret.resultFlag;
	}

	function JStrToObj(str) {
		return eval("(" + str + ")");
	}
	function DisplayInfo(ret) {
       if(ret.resultFlag!=0){
         alertx(ret.errorMsg);
       }
	}
	//获取状态
	function getStatus() {
		//clearForm();
		var ret = CertCtl.getStatus();
		//alertx(ret);
		//document.all['ret'].innerHTML = ret;
		ret = JStrToObj(ret);
		DisplayInfo(ret);
		return;
	}

	function disconnect() {
		//clearForm();
		var ret = CertCtl.disconnect();
		//document.all['ret'].innerHTML = ret;
		ret = JStrToObj(ret);
		DisplayInfo(ret);
		return;
	}

	//读取信息
	function readCert1() {
		//clearForm();
		var ret = CertCtl.readCert();
		//alertx(ret+"                          ....");
		//document.all['ret'].innerHTML = ret;
		ret = JStrToObj(ret);
		if (ret.resultFlag == -1) {
			DisplayInfo(ret);
		} else {
			fillForm(ret);
		}
	}

	function ReadIDCard() {
		var ret = JStrToObj(CertCtl.connect());

		if (ret.resultFlag == -1) {
			clearForm();
			DisplayInfo(ret);
			return;
		}

		ret = JStrToObj(CertCtl.readCert());
		if (ret.resultFlag == -1) {
			clearForm();
			DisplayInfo(ret);
		} else {
			fillForm(ret);
		}

		ret = JStrToObj(CertCtl.disconnect());
		if (ret.resultFlag == -1) {
			DisplayInfo(ret);
			return;
		}
	}

	//清楚form
	function clearForm() {
		document.all['rxm'].value = '';
		document.all['xbm'].value = '';
		document.all['rcsrq'].value = '';
		document.all['rsfzjh'].value = '';
		document.all['rjtzz'].value = '';

	}
function loadXSDJXX(personID) {
		var flagA;
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/getZsdjBySfzh",
			data : {
				sfzjh : personID
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				if(data.zsdj!=''&&data.zsdj!=null){
				alertx("该生已报名，请进行其他操作！");
				flagA=1;
			}else{
				flagA=0;
			}
			}
		});
		return flagA;
	}
	//填充数据
	function fillForm(ret) {
		DisplayInfo(ret);
		var pName = ret.resultContent.partyName;//姓名
		var pSex = ret.resultContent.gender;//性别
		var pNation = ret.resultContent.nation; //民族
		var pBorn = ret.resultContent.bornDay;//生日
		var pAddress = ret.resultContent.certAddress;//地址
		var pCardNo = ret.resultContent.certNumber;//身份证号码
		var pPolice = ret.resultContent.certOrg;//签发机关
		var pActivityLFrom = ret.resultContent.effDate; //起始时间
		var pActivityLTo = ret.resultContent.expDate; //结束时间

		//根据身份证号加载学生信息
		var flagb=loadXSDJXX(pCardNo);
		if(flagb==0){
		byIDD();//设置信息不可改
		
		$("#rxm").val(pName);
		$("#rsfzjh").val(pCardNo);
		var year = pBorn.substring(0, 4);
		var mm = pBorn.substring(4, 6);
		var dd = pBorn.substring(6, 8);
		var births = year + "-" + mm + "-" + dd;
		$("#rcsrq").val(births);
		$("#rjtzz").val(pAddress);
		$("#rqfjg").val(pPolice);
		$("#rstarttime").val(pActivityLFrom);
		$("#rovertime").val(pActivityLTo);
		var p = pNation + "族";
		var title = document.getElementById("rnation");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#rnation").select2("destroy");
				$("#rnation").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#rnation").select2();
				break;
			}
		}
		var sexHtml = "<select id='xbm2' name='xbm' style='width:215px;'>";
		if (pSex == "1" || pSex == 1) {
			sexHtml += "<option value='1' selected='selected'>男</option>";
			sexHtml += "<option value='2' >女</option>";
		} else {
			sexHtml += "<option value='2' selected='selected'>女</option>";
			sexHtml += "<option value='1' >男</option>";
		}
		sexHtml += "</select><span class='help-inline'><font color='red'>*</font> </span>";
		$("#rxbmP").html(sexHtml);
		$("#xbm2").select2("destroy");
		$("#xbm2").attr("style","width:215px;");
		$("#xbm2").select2();
		
	
		
				//=====默认选中身份证件类型
				$("#sfzID").select2("destroy");
				$("#sfzID").find(
						"option[value='1']").attr(
						"selected", true);
				$("#sfzID").select2();
				//设置不可改属性
				$("#rnation").select2("destroy");
				$("#rnation").attr("readonly",true);
				$("#rnation").select2();
				$("#sfzID").select2("destroy");
				$("#sfzID").attr("readonly",true);
				$("#sfzID").select2();
				$("#xbm2").select2("destroy");
				$("#xbm2").attr("readonly",true);
				$("#xbm2").select2();
				$("#rxm").select2("destroy");
				$("#rxm").attr("readonly",true);
				$("#rxm").select2();
				
				
				
				
				
				
		//身份证照片
		document.all['pic2'].src = "data:image/jpg;base64,"
				+ ret.resultContent.cardHimg;

		}
	}
</script>
<!-- -------------------------------------------身份证OCR识别---------------------------------------------- -->
<script type="text/javascript">
	var mainDevCount = -1;
	var subDevCount = -1;
	var mainIndex = 0;
	var subindex = 1;
	var strFile;
	var nFileCount = 0;
	var strFolder = "D:\\CameraTest";
	var newFile;
	var nFileCount = 0;
	function AddDevice1() {
		mainDevCount = 0;
		var total = CamSDKOCX1.GetDevCount();
		//alertx(total);
		for ( var i = 0; i < total; i++) {
			var devtype = CamSDKOCX1.GetDevType(i);
			if (devtype == 0) {
				var DevEle = CamSDKOCX1.GetDevName(i);

				Reso.DeviceName.options[mainDevCount].text = DevEle;
				mainDevCount++;
			}
		}
		mainIndex = 0;
		subindex = mainDevCount;
		Reso.DeviceName.options[0].selected = true;

	}
	function AddDevice2() {
		mainDevCount = 0;
		var total = CamSDKOCX2.GetDevCount();
		//alertx(total);
		for ( var i = 0; i < total; i++) {
			var devtype = CamSDKOCX2.GetDevType(i);
			if (devtype == 0) {
				var DevEle = CamSDKOCX2.GetDevName(i);

				Reso.DeviceName.options[mainDevCount].text = DevEle;
				mainDevCount++;
			}
		}
		mainIndex = 0;
		subindex = mainDevCount;
		Reso.DeviceName.options[0].selected = true;

	}
	/* function ChangeDevice()
	 {	var obj=document.getElementById("DeviceName");
	 index=obj.selectedIndex;
	 CamSDKOCX1.openDev(index,0,Width,Height);
	 AddResolution2Comb(Reso);
	 SetResolution();
	 } */
	function ChangeDevice2() {
		var obj = document.getElementById("DeviceName2");
		var index = obj.selectedIndex;
		index = index + mainDevCount;
		CamSDKOCX2.OpenDev(index, 0, Width, Height);
	}
	function SetResolution() { //2016年8月29日10:16:08
		var obj = document.getElementById("Resolution");
		var index = obj.selectedIndex;
		var width = CamSDKOCX1.GetResolutionWidth(index);
		var height = CamSDKOCX1.GetResolutionHeight(index);
		CamSDKOCX1.SetResolution(width, height);
	}
	function SetResolutionsub() {
		var obj = document.getElementById("Resolutionsub");
		var index = obj.selectedIndex;
		var width = CamSDKOCX2.GetResolutionWidth(index);
		var height = CamSDKOCX2.GetResolutionHeight(index);
		CamSDKOCX2.SetResolution(width, height);
	}
	function StartVideo() {
		// CamSDKOCX1.CloseDev();

		// AddDevice1();
		if(index==1||index==2||index==3){
			CamSDKOCX1.OpenDev(0, 0, 0, 0);
		}

		//AddResolution2Comb(Reso);
	}
	function StartVideo2() {
		// CamSDKOCX2.InitCameraLib();
		//alertx(b);
		// AddDevice2();

		CamSDKOCX2.OpenDev(1, 0, 0, 0);
		//alertx (a);
		//alertx(subindex);
		//AddResolution2Combsub(Resosub);
	}
	function SetState() {
		var obj = document.getElementById("autocrop");
		var index = obj.selectedIndex;
		if (index < 3) {
			CamSDKOCX1.SetAutoCrop(index);
		} else {
			CamSDKOCX1.SetCusCrop(1);
		}
	}
	function AddResolution2Comb(f) {
		var total = CamSDKOCX1.GetResolutionCount();
		for ( var i = 0; i < total; i++) {
			var width = CamSDKOCX1.GetResolutionWidth(i);
			var height = CamSDKOCX1.GetResolutionHeight(i);
			var resolution = width + "X" + height;
			f.Resolution.options[i].text = resolution;
		}
		f.Resolution.options[0].selected = true;
	}
	function AddResolution2Combsub(f) {
		var total = CamSDKOCX2.GetResolutionCount();
		for ( var i = 0; i < total; i++) {
			var width = CamSDKOCX2.GetResolutionWidth(i);
			var height = CamSDKOCX2.GetResolutionHeight(i);
			var resolutionsub = width + "X" + height;
			f.Resolutionsub.options[i].text = resolutionsub;
		}
		f.Resolutionsub.options[0].selected = true;
	}
	function Denoise() {
		var obj = document.getElementById("denoise");
		var statcuscrop = obj.checked;
		CamSDKOCX1.SetDenoise(statcuscrop);
	}
	function watermark() {
	}

	//-----------------------------------------副摄像头采集照片--------------------

	function AutoCapture() {
		var s = "";
		if (index == 0) {

			s = $("#rsfzjh").val();

			//$("#sss").attr("src",files);
		}
		;
		if (index == 1) {
			s = $("#csfzjh").val();
			//$("#imgface").attr("src",files);
		}
		;
		if (index == 2) {
			s = $("#bsfzjh").val();
			//$("#ss1").attr("src",files);
		}
		;
		if (index == 3) {
			s = $("#qsfzjh").val();
			//$("#ss2").attr("src",files);
		}
		;

		if (s == null || s == "") {
			alertx("请先输入信息！");
			return;
		}
		;

		//创建路径
		var objFSO = new ActiveXObject("Scripting.FileSystemObject");
		if (!objFSO.FolderExists(strFolder)) {
			var strFolderName = objFSO.CreateFolder(strFolder);
		}
		newFile = strFolder + "\\" + s + ".jpg";
		var files = CamSDKOCX2.CaptureImage(newFile);

		var p = CamSDKOCX2.EncodeBase64(newFile);
         	 $("#sss").attr("src", "/em/static/js/xszp.png");
         	 $("#pic").attr("src", "/em/static/js/xszp.png");
             $("#imgface").attr("src", "/em/static/js/xszp.png");
             $("#pic1").attr("src", "/em/static/js/xszp.png");
			 $("#picc").attr("src", "/em/static/js/xszp.png");
			 $("#pic4").attr("src", "/em/static/js/xszp.png");
	 		 $("#mm").attr("src", "/em/static/js/xszp.png");
	 		 $("#pic3").attr("src", "/em/static/js/xszp.png");
		if (index == 0) {
		    
			$("#sss").attr("src", "data:image/jpg;base64,"+p);
			$("#pic").attr("src", "data:image/jpg;base64,"+p);
			$("#pic").css({
				"width" : "120px",
				"height" : "160px"
			});
             
		}
		if (index == 1) {

			$("#imgface").attr("src", "data:image/jpg;base64,"+p);
			$("#pic1").attr("src", "data:image/jpg;base64,"+p);
			$("#pic1").css({
				"width" : "120px",
				"height" : "160px"
			});

		}
		if (index == 2) {
			$("#picc").attr("src", "data:image/jpg;base64,"+p);
			$("#pic4").attr("src", "data:image/jpg;base64,"+p);
			$("#pic4").css({
				"width" : "120px",
				"height" : "160px"
			});
		}
		if (index == 3) {
			$("#mm").attr("src", "data:image/jpg;base64,"+p);
			$("#pic3").attr("src", "data:image/jpg;base64,"+p);
			$("#pic3").css({
				"width" : "120px",
				"height" : "160px"
			});
		}

		//上传图片==============================
		getImg(p, s);

	}

	function ColorStyle() {
		var obj = document.getElementById("colorstyle");
		var index = obj.selectedIndex;
		CamSDKOCX1.SetColorStyle(index);
	}
	function SetEffect() {
		var obj = document.getElementById("adjust");
		var index = obj.selectedIndex;
		CamSDKOCX1.SetAdjust(index);
	}
	function Combineimage() {
		CamSDKOCX1.CombineImage();
	}
	function EncodeBase64() {
		alertx(CamSDKOCX1.EncodeBase64(newFile));
	}

	function ocrreconize() {
	
	           //默认身份证
                $("#csfzjlx").select2("destroy");
				$("#csfzjlx").find(
						"option[value='1']").attr(
						"selected", true);
				$("#csfzjlx").select2();
				//默认户口簿
				$("#ccsfzjlx").select2("destroy");
				$("#ccsfzjlx").find(
						"option[value='11']").attr(
						"selected", true);
				$("#ccsfzjlx").select2();
				//默认其他证件
				$("#qsfzjlx").select2("destroy");
				$("#qsfzjlx").find(
						"option[value='12']").attr(
						"selected", true);
				$("#qsfzjlx").select2();
	       
	
	            //默认其他证件=======================================
				
	         
	
	
		clearForms();
		CamSDKOCX1.UnInitIDCardOCR();
		var initocr = CamSDKOCX1.InitIDCardOCR();
		// alertx(initocr+"a...");
		if (initocr != 0) {
			alertx("ocr初始化失败！");
			return;
		} else {
            var fso = new ActiveXObject("Scripting.FileSystemObject");//获取对象
	        var pathfile="D:\\FilePhoto";//文件路径
		    if (!fso.FolderExists(pathfile)) {//如果目录不存在，则创建一个目录
			var strFolderName = fso.CreateFolder(pathfile);//文件夹名称
		     }
		    var date=new Date();
		    var y=date.getFullYear();
		   
		    var mm=date.getMonth()+1;
		    
		    var d=date.getDate();
		    var h=date.getHours();
		    var m=date.getMinutes();
		    var s=date.getSeconds();
		    var time=y+"年"+mm+"月"+d+"日"+h+"时"+m+"分"+s+"秒";
		   // alertx(time+"      ........");
			var ocrtestpath = pathfile+"\\"+time+".jpg";
			
			CamSDKOCX1.SetAutoCrop(1);
			CamSDKOCX1.CaptureImage(ocrtestpath);
			var ocrresult = CamSDKOCX1.RecongnizeIDCardOCR(ocrtestpath,
					pathfile+"\\"+time+"Head.jpg");
			

			if (ocrresult.length < 1) {
				alertx("未识别到信息，请手动输入！");
			     $("#smpic").attr("src","/em/static/js/xszp.png");
			     
			} else {
				if(index==1){
				
				var str = ocrresult.split("|");//定义一个 字符串
					if(loadXSDJXX(str[5])==0){
				$("#cxm").val(str[0]);
				var xb = str[1];
				var sexHtml = "<select id='xbm1' name='xbm' style='width:215px;'>";
				if (xb == "男") {
					sexHtml += "<option value='1' selected='selected'>男</option>";
					sexHtml += "<option value='2' >女</option>";
				} else {
					sexHtml += "<option value='2' selected='selected'>女</option>";
					sexHtml += "<option value='1' >男</option>";
				}
				sexHtml += "</select><span class='help-inline'><font color='red'>*</font> </span>";
				$("#cxb").html(sexHtml);
				$("#xbm1").select2("destroy");
				$("#xbm1").attr("style","width:215px;");
				$("#xbm1").select2();
				var n = str[2] + "族";
				var title = document.getElementById("cmz");
				for ( var i = 0; i < title.options.length; i++) {
					if (title.options[i].innerHTML == n) {
						
						$("#cmz").select2("destroy");
						$("#cmz").find(
								"option[value='" + title.options[i].value
										+ "']").attr("selected", true);
						$("#cmz").select2();
						break;
					}
				}

				$("#ccsrq").val(str[3]);
				$("#cjtzz").val(str[4]);
				$("#csfzjh").val(str[5]);
			
				$("#smpic").css({"width":"120px","height":"160px"});
				var headImg=pathfile+"\\"+time+"Head.jpg";
				document.all['smpic'].src = "data:image/jpg;base64,"+CamSDKOCX1.EncodeBase64(headImg);
				
				//alertx(pathfile+"\\"+time+"Head.jpg");
				}
				}
				
                if(index==2){
                
				var str = ocrresult.split("|");//定义一个 字符串
				if(loadXSDJXX(str[5])==0){
				$("#bxm").val(str[0]);
				var xb = str[1];
				
				var sexHtml = "<select id='xbm3' name='xbm' style='width:228px;'>";
				if (xb == "男") {
					sexHtml += "<option value='1' selected='selected'>男</option>";
					sexHtml += "<option value='2' >女</option>";
				} else {
					sexHtml += "<option value='2' selected='selected'>女</option>";
					sexHtml += "<option value='1' >男</option>";
				}
				sexHtml += "</select><span class='help-inline'><font color='red'>*</font> </span>";
				$("#bxbm").html(sexHtml);
				//alertx(xb);
				$("#xbm3").select2("destroy");
				$("#xbm3").attr("style","width:228px;");
				$("#xbm3").select2();
				
				
				var n = str[2] + "族";
				var title = document.getElementById("ccmz");
				for ( var i = 0; i < title.options.length; i++) {
					if (title.options[i].innerHTML == n) {
						
						$("#ccmz").select2("destroy");
						$("#ccmz").find(
								"option[value='" + title.options[i].value
										+ "']").attr("selected", true);
						$("#ccmz").select2();
						break;
					}
				}

				$("#bcsrq").val(str[3]);
				$("#bjtzz").val(str[4]);
				$("#bsfzjh").val(str[5]);
				
				//$("#spic").css({"width":"120px","height":"160px"});
				//document.all['spic'].src = pathfile+"\\"+time+"Head.jpg";
                }
                }
                
                if(index==3){
				var str = ocrresult.split("|");//定义一个 字符串
				if(loadXSDJXX(str[5])==0){
				$("#qxm").val(str[0]);
				var xb = str[1];
				var sexHtml = "<select id='xbmc' name='xbm' style='width:228px;'>";
				if (xb == "男") {
					sexHtml += "<option value='1' selected='selected'>男</option>";
					sexHtml += "<option value='2' >女</option>";
				} else {
					sexHtml += "<option value='2' selected='selected'>女</option>";
					sexHtml += "<option value='1' >男</option>";
				}
				sexHtml += "</select><span class='help-inline'><font color='red'>*</font> </span>";
				$("#qxbm").html(sexHtml);
				$("#xbmc").select2("destroy");
				$("#xbmc").attr("style","width:228px;");
				$("#xbmc").select2();
				var n = str[2] + "族";
				var title = document.getElementById("crnation");
				for ( var i = 0; i < title.options.length; i++) {
					if (title.options[i].innerHTML == n) {
						
						$("#crnation").select2("destroy");
						$("#crnation").find(
								"option[value='" + title.options[i].value
										+ "']").attr("selected", true);
						$("#crnation").select2();
						break;
					}
				}


				$("#qcsrq").val(str[3]);
				$("#qjtzz").val(str[4]);
				$("#qsfzjh").val(str[5]);
				
				//$("#spic").css({"width":"120px","height":"160px"});
				//document.all['spic'].src = pathfile+"\\"+time+"Head.jpg";
                }
                }
                
                
                
			}
		}
	}

   
      


	//清楚form
	function clearForms() {
		document.all['cxm'].value = '';
		document.all['xbm'].value = '';
		document.all['ccsrq'].value = '';
		document.all['cjtzz'].value = '';
		document.all['csfzjh'].value = '';
		

	}
	/* setTimeout("StartVideo()", 100);
	setTimeout("StartVideo2()", 100); */
	SetState.checked = true;

	//-----------------------------------------------身份证OCR识别结束--------------------------------------------
</script>

<!-- -----------------------------------根据身份证号码查询数据，加载到左侧新生登记信息页面------------------------------------- -->
<script type="text/javascript">
	
	function loadXSDJXXBySerachZsdj(id) {
		//隐藏查询列表
		$("#serachList").hide();
		$.post("${ctx}/zsdj/zsdj/listByXsbdSerachZsdj", {
			id : id
		}, function(result) {
			data=result[0];
			if (data.sfzjh == null || data.sfzjh == "") {
				alertx("该生未登记，请先去登记！");
				return;
			}
			$("#saveZsdj").val(data.id);
			$("#name1").val(data.xm);
			$("#sex1").val(data.xbname);
			$("#nation1").val(data.nationNmae);
			$("#idType1").val(data.zjlxName);
			$("#ID1").val(data.sfzjh);
			$("#birthday1").val(data.csrq.substring(0, 10));
			$("#djqy").val(data.sfName+""+data.csName+data.qxName+data.jdName);
			$("#syx").val(data.fromSchool);
			$("#addr1").val(data.jtzz);
			$("#zsjh1").val(data.zsjh.jhmc);
			$("#term1").val(data.xnxq.xnmc);
			/* $("#entryYear1").val(data.nj.nf); */
			$("#xdzy1").val(data.zy.zymc+"("+data.xz+")");
			$("#xdzylx1").val(data.zylx.lxmc);
			$("#xz1").val(data.xz);
			$("#tel1").val(data.lxdh);
			$("#remark1").val(data.remark);
			
		
		
			

		if(index==0){
						
		  var title = document.getElementById("zylxId1");
	
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == data.zylx.lxmc) {
				//alertx(title.options[i].value);
				$("#zylxId1").select2("destroy");
				$("#zylxId1").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zylxId1").select2();
				break;
			}
		}  
			lxChange1(data.zylx.id);
		 var title = document.getElementById("zyid");
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].value == data.zy.id) {
				//alertx(title.options[i].value);
				$("#zyid").select2("destroy");
				$("#zyid").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				//$("#zyid").attr("onchange","zyChange1(this.value)");
				$("#zyid").select2();
				zyChange1(title.options[i].value);
				break;
			}
			}
			$("#fromSchool1").val(data.fromSchool);
		var p = data.sfName;
		var title = document.getElementById("sf1");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#sf1").select2("destroy");
				$("#sf1").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#sf1").select2();
				break;
			}
		}
		var sfid=$("#sf1").val();
		byCS1(sfid);
		var p = data.csName;
		var title = document.getElementById("cs1");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#cs1").select2("destroy");
				$("#cs1").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#cs1").select2();
				break;
			}
		}
		var sfid=$("#cs1").val();
		byQX1(sfid);
		var p = data.qxName;
		var title = document.getElementById("qx1");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#qx1").select2("destroy");
				$("#qx1").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#qx1").select2();
				break;
			}
		}
		var sfid=$("#qx1").val();
		byXZ1(sfid);
		var p = data.jdName;
		var title = document.getElementById("jd1");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#jd1").select2("destroy");
				$("#jd1").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#jd1").select2();
				break;
			}
		}
		  
		}  
		if(index==1){
								
		  var title = document.getElementById("zylxId2");
	
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == data.zylx.lxmc) {
				//alertx(title.options[i].value);
				$("#zylxId2").select2("destroy");
				$("#zylxId2").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zylxId2").select2();
				break;
			}
		}  
			lxChange2(data.zylx.id);
		 var title = document.getElementById("zyid2");
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].value == data.zy.id) {
				//alertx(title.options[i].value);
				$("#zyid2").select2("destroy");
				$("#zyid2").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zyid2").select2();
				zyChange2(title.options[i].value);
				break;
			}
			}  
			
						//===========================================
			$("#fromSchool2").val(data.fromSchool);
			
		var p = data.sfName;
		var title = document.getElementById("sf2");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#sf2").select2("destroy");
				$("#sf2").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#sf2").select2();
				break;
			}
		}
		var sfid=$("#sf2").val();
		byCS2(sfid);
		var p = data.csName;
		var title = document.getElementById("cs2");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#cs2").select2("destroy");
				$("#cs2").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#cs2").select2();
				break;
			}
		}
		var sfid=$("#cs2").val();
		byQX2(sfid);
		var p = data.qxName;
		var title = document.getElementById("qx2");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#qx2").select2("destroy");
				$("#qx2").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#qx2").select2();
				break;
			}
		}
		var sfid=$("#qx2").val();
		byXZ2(sfid);
		var p = data.jdName;
		var title = document.getElementById("xz2");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#xz2").select2("destroy");
				$("#xz2").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#xz2").select2();
				break;
			}
		}
			
		}  
		if(index==2){
								
		  var title = document.getElementById("zylxId3");
	
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == data.zylx.lxmc) {
				//alertx(title.options[i].value);
				$("#zylxId3").select2("destroy");
				$("#zylxId3").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zylxId3").select2();
				break;
			}
		}  
			lxChange3(data.zylx.id);
		 var title = document.getElementById("zyid3");
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].value == data.zy.id) {
				//alertx(title.options[i].value);
				$("#zyid3").select2("destroy");
				$("#zyid3").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zyid3").select2();
				zyChange3(title.options[i].value);
				break;
			}
			}  
				//================================================//===========================================
			$("#fromSchool3").val(data.fromSchool);
			
		var p = data.sfName;
		var title = document.getElementById("sf3");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#sf3").select2("destroy");
				$("#sf3").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#sf3").select2();
				break;
			}
		}
		var sfid=$("#sf3").val();
		byCS3(sfid);
		var p = data.csName;
		var title = document.getElementById("cs3");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#cs3").select2("destroy");
				$("#cs3").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#cs3").select2();
				break;
			}
		}
		var sfid=$("#cs3").val();
		byQX3(sfid);
		var p = data.qxName;
		var title = document.getElementById("qx3");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#qx3").select2("destroy");
				$("#qx3").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#qx3").select2();
				break;
			}
		}
		var sfid=$("#qx3").val();
		byXZ3(sfid);
		var p = data.jdName;
		var title = document.getElementById("xz3");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#xz3").select2("destroy");
				$("#xz3").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#xz3").select2();
				break;
			}
		}
			
		}  
		if(index==3){
								
		  var title = document.getElementById("zylxId4");
	
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == data.zylx.lxmc) {
				//alertx(title.options[i].value);
				$("#zylxId4").select2("destroy");
				$("#zylxId4").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zylxId4").select2();
				break;
			}
		}  
			lxChange4(data.zylx.id);
		 var title = document.getElementById("zyid4");
		  for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].value == data.zy.id) {
				//alertx(title.options[i].value);
				$("#zyid4").select2("destroy");
				$("#zyid4").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#zyid4").select2();
				zyChange4(title.options[i].value);
				break;
			}
			}  
				//================================================//===========================================
			$("#fromSchool4").val(data.fromSchool);
			
		var p = data.sfName;
		var title = document.getElementById("sf4");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#sf4").select2("destroy");
				$("#sf4").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#sf4").select2();
				break;
			}
		}
		var sfid=$("#sf4").val();
		byCS4(sfid);
		var p = data.csName;
		var title = document.getElementById("cs4");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#cs4").select2("destroy");
				$("#cs4").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#cs4").select2();
				break;
			}
		}
		var sfid=$("#cs4").val();
		byQX4(sfid);
		var p = data.qxName;
		var title = document.getElementById("qx4");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#qx4").select2("destroy");
				$("#qx4").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#qx4").select2();
				break;
			}
		}
		var sfid=$("#qx4").val();
		byXZ4(sfid);
		var p = data.jdName;
		var title = document.getElementById("xz4");
		for ( var i = 0; i < title.options.length; i++) {
			if (title.options[i].innerHTML == p) {
				$("#xz4").select2("destroy");
				$("#xz4").find(
						"option[value='" + title.options[i].value + "']").attr(
						"selected", true);
				$("#xz4").select2();
				break;
			}
		}
			
			//================================================
		}
		 
			
			
		}, "json");
	}
	function cleanXSDJXX() {
		$("#name1").val("");
		$("#sex1").val("");
		$("#nation1").val("");
		$("#idType1").val("");
		$("#ID1").val("");
		$("#birthday1").val("");
		$("#djqy").val("");
		$("#syx").val("");
		$("#addr1").val("");
		$("#zsjh1").val("");
		/* $("#grade1").val(""); */
		$("#term1").val("");
		/* $("#entryYear1").val(""); */
		$("#xdzy1").val("");
		$("#xdzylx1").val("");
		$("#xz1").val("");
		$("#tel1").val("");
		$("#remark1").val("");
	}
</script>


<!-- --------------------------提交不同的表单---------------------------- -->
<script type="text/javascript">
	function savesubmit() {
		if(confirm("请确认表单信息准确无误！\n点击“确定”确认保存，点击“取消”返回页面")){
			if (index == 1) {
				$("#inputForm2").attr("action",
						"${ctx}/xsbd/bdJbxx/save2");
				$("#inputForm2").submit();
			} else if (index == 2) {
				$("#inputForm3").attr("action",
						"${ctx}/xsbd/bdJbxx/save2");
				$("#inputForm3").submit();
			} else if (index == 3) {
				$("#inputForm4").attr("action",
						"${ctx}/xsbd/bdJbxx/save2");
				$("#inputForm4").submit();
			} else {
	
				$("#inputForm1").attr("action",
						"${ctx}/xsbd/bdJbxx/save2");
				$("#inputForm1").submit();
			}
		}

	}
</script>


<script type="text/javascript">
	//上传图片====================================
	function getImg(imgStr, sfzjh) {
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/xsbd/bdJbxx/generateImage",
			data : {
				imgStr : imgStr,
				sfzjh : sfzjh
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				console.log(result);
			}
		});
	}
	
			//重置
		function resetClick()
        {   
	        //隐藏查询列表
			$("#serachList").hide();
        	$("#zsdj_xm").attr("value",'');
        	$("#zsdj_xbm").select2("destroy");
        	$("#zsdj_xbm").find("option:selected").attr("selected",false);
        	$("#zsdj_xbm").select2();  
        }

	function serachZsdj(){
		var name=$("#zsdj_xm").val();
		var sex=$("#zsdj_xbm").val();
		$.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/listByXsbdSerachZsdj",
			data : {
				xm : name,
				xbm:sex,
				zsdjzt:"0"
			},
			dataType : 'json',
			async : true,
			success : function(result) {
				if (result != null && result != "") {
					$("#serachBody").empty();
					for(var i=0;i<result.length;i++){
						var r=result[i];
						$("#serachBody").append(
							"<tr>"
								+"<td>"
									+r.xm
								+"</td>"
								+"<td>"
									+r.sfzjh
								+"</td>"
								+"<td>"
									+r.zy.zymc
								+"</td>"
								+"<td>"
									+r.lxdh
								+"</td>"
								+"<td><input class='btn btn-primary cxjg_td' type='button' value='确定' onClick=\"loadXSDJXXBySerachZsdj('"+r.id+"')\"/></td>"
							+"</tr>"
						);
						//显示查询列表
						 $("#serachList").show();
						
					}
				}else{
					alertx("没有找到人员信息，请先去登记！");
				}
			}
		});
	}
	
	
	  function byCS1(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs1").empty();
			$("#qx1").empty();
			$("#jd1").empty();
			$("#cs1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#qx1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#jd1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#cs1").select2("destroy");
					$("#cs1")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
 function byCS2(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs2").empty();
			$("#qx2").empty();
			$("#xz2").empty();
			$("#cs2").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#qx2").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz2").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#cs2").select2("destroy");
					$("#cs2")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	} function byCS3(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs3").empty();
			$("#qx3").empty();
			$("#xz3").empty();
			$("#cs3").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#qx3").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz3").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#cs3").select2("destroy");
					$("#cs3")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	} function byCS4(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs4").empty();
			$("#qx4").empty();
			$("#xz4").empty();
			$("#cs4").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#qx4").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz4").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#cs4").select2("destroy");
					$("#cs4")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	function byQX1(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx1").empty();
			$("#jd1").empty();
			$("#qx1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#jd1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#qx1").select2("destroy");
					$("#qx1")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	function byQX2(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx2").empty();
			$("#xz2").empty();
			$("#qx2").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz2").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#qx2").select2("destroy");
					$("#qx2")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	function byQX3(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx3").empty();
			$("#xz3").empty();
			$("#qx3").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz3").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#qx3").select2("destroy");
					$("#qx3")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	function byQX4(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx4").empty();
			$("#xz4").empty();
			$("#qx4").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz4").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#qx4").select2("destroy");
					$("#qx4")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
		function byXZ1(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				$("#jd1").empty();
					$("#jd1")
							.append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#jd1").select2("destroy");
					$("#jd1")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
		function byXZ2(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				$("#xz2").empty();
					$("#xz2")
							.append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#xz2").select2("destroy");
					$("#xz2")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
		function byXZ3(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				$("#xz3").empty();
					$("#xz3")
							.append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#xz3").select2("destroy");
					$("#xz3")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
		function byXZ4(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				$("#xz4").empty();
					$("#xz4")
							.append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#xz4").select2("destroy");
					$("#xz4")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	
	function getCSRQ1(num){
			var x=$("#csfzjlx").val();
			var yy=num.substring(6,10);
			var mm=num.substring(10,12);
			var dd=num.substring(12,14);
			if(num!=0){
			if(x==1||x.eq("1")){
					 $("#ccsrq").val(yy+"-"+mm+"-"+dd);
					 $("#ccsrq").attr("readonly",true);
			}
			}
	}
	function getCSRQ2(num){
			var y=$("#ccsfzjlx").val();
			var yy=num.substring(6,10);
			var mm=num.substring(10,12);
			var dd=num.substring(12,14);
			if(num!=0){
			if(y==1||y.eq("1")){
					 $("#bcsrq").val(yy+"-"+mm+"-"+dd);
					 $("#bcsrq").attr("readonly",true);
			}
			}
	}
	function getCSRQ3(num){
			var z=$("#qsfzjlx").val();
			var yy=num.substring(6,10);
			var mm=num.substring(10,12);
			var dd=num.substring(12,14);
			if(num!=0){
			if(z==1||z.eq("1")){
					 $("#qcsrq").val(yy+"-"+mm+"-"+dd);
					 $("#qcsrq").attr("readonly",true);
			}
			}
	}
</script>
</head>
<body onload="StartVideo();StartVideo2();"
	onunload="CamSDKOCX1.UnInitCameraLib();">

	<object type="application/cert-reader" id="CertCtl" width=0 height=0>
	</object>

	<div class="body-box">
		<div class="o-photo_body photo-body">
			<div class="photo-frame">
				<div class="photo">
					<p class="photo-font">拍照照片</p>
					<span class="pic"> <img src="/em/static/js/xszp.png" alt=""
						id="sss"> </span>
					<!-- <a href="#" class="pic-btn">采集照片</a> -->
					<input class="pic-btn" type="button" value="采集照片 "
						onClick="AutoCapture();" name="subCapture">
				</div>
				<div class="camera" id="cc"></div>
				<div class="ID-card">
					<p class="card-font">身份证照片</p>
					<span class="card-pic"> <img src="/em/static/js/xszp.png"
						id="pic2" alt="" width="120" height="160"> </span>
				</div>
				<div class="id-card-camera"></div>
			</div>
			<div class="clearfix"></div>
		</div>




		<div class="s-photo_body photo-body">
			<div class="photo-frame">
				<div class="photo">
					<p class="photo-font">拍照照片</p>
					<span class="pic"> <img id="imgface"
						src="/em/static/js/xszp.png" alt=""> </span>
					<!-- <a href="#" class="pic-btn">采集照片</a> -->
					<input class="pic-btn" type="button" value="采集照片 "
						onClick="AutoCapture();" name="subCapture">
				</div>
				<!-- <div>
				<input type = "button" value = " 刷新副头" onClick = "StartVideo2();" name = "start">
				</div> -->
				<div class="camera" id="c1">
					<!-- <OBJECT id="CamSDKOCX2"
						style="MARGIN-LEFT:5px; WIDTH: 42.4%; HEIGHT:100%" 
						classid="clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41"> 
				 </OBJECT> -->
				</div>
				<div class="ID-card" style="line-height: 80px;">
					<p class="card-font">身份证照片</p>
					<span class="card-pic"> <img src="/em/static/js/xszp.png"
						id="smpic" alt="" width="120px" height="160px"> </span>
					<button class="pic-btn" style="width: 85%" onClick="ocrreconize();">扫描</button>

				</div>
				<div class="id-card-camera" id="c2">



				</div>

			</div>
			<div class="clearfix"></div>
		</div>




		<div class="t-photo_body photo-body">
			<div class="photo-frame">
				<div class="photo">
					<p class="photo-font">拍照照片</p>
					<span class="pic"> <img src="/em/static/js/xszp.png" alt=""
						id="picc"> </span>
					<!-- <a href="#" class="pic-btn">采集照片</a> -->
					<input class="pic-btn" type="button" value="采集照片 "
						onClick="AutoCapture();" name="subCapture">
				</div>

				<div class="camera" id="c3">
			
				</div>
	
				<div class="hukobo">
					<div class="id-card-camera huko" id="c4">
					
					</div>
				
					<button class="huko-btn" onClick="ocrreconize();">扫描</button>
				</div>

			</div>
			<div class="clearfix"></div>
		</div>




		<div class="f-photo_body photo-body">
			<div class="photo-frame">
				<div class="photo">
					<p class="photo-font">拍照照片</p>
					<span class="pic"> <img src="/em/static/js/xszp.png" alt=""
						id="mm"> </span>
			
					<input class="pic-btn" type="button" value="采集照片 "
						onClick="AutoCapture();" name="subCapture">
				</div>
			
				<div class="camera" id="c5">
					
				</div>
				
				<div class="qita">
					<div class="id-card-camera qitaj" id="c6">
						
					</div>
				
					<button class="qita-btn" onClick="ocrreconize();">扫描</button>
				</div>
			
			</div>
			<div class="clearfix"></div>
		</div>
	</div>

	<div style="display: none">
		<form name="Reso">
			<select style="display: none;" name="DeviceName" id="DeviceName"
				onchange="ChangeDevice()">
				<option value="0"></option>
				<option value="1"></option>
				<option value="2"></option>
				<option value="3"></option>
				<option value="4"></option>
			</select> 分辨率: <select name="Resolutionsub" id="Resolutionsub"
				onchange="SetResolutionsub()">
				<option value="0">开启视频后获取分辨率</option>
				<option value="1"></option>
				<option value="2"></option>
				<option value="3"></option>
				<option value="4"></option>
				<option value="5"></option>
				<option value="6"></option>
				<option value="7"></option>
				<option value="8"></option>
				<option value="9"></option>
			</select> 图片格式: <select name="FileType" id="FileType" onchange="SetFileType()">
				<option value="0">bmp</option>
				<option value="1">jpg</option>
				<option value="2">tif</option>
				<option value="3">png</option>
			</select> 图片颜色: <select name="colorstyle" id="colorstyle"
				onchange="ColorStyle()">
				<option value="0">彩色</option>
				<option value="1">灰度</option>
				<option value="2">黑白</option>
			</select> <select style="display: none;" name="DeviceName2" id="DeviceName2"
				onchange="ChangeDevice2()">
				<option value="0"></option>
				<option value="1"></option>
				<option value="2"></option>
				<option value="3"></option>
				<option value="4"></option>
			</select>
		</form>
		<select name="autocrop" id="autocrop" onchange="SetState()">
			<option value="0">不裁切</option>
			<option value="1">单图裁切</option>
			<option value="2">多图裁切</option>
			<option value="3">手动裁切</option>
		</select> <input type="hidden" id="PhotoSavePath" value="d:\\studentPhoto" /> <input
			type="button" value=" 刷新主头" onClick="StartVideo();" name="start">
		<input type="button" value=" 刷新副头" onClick="StartVideo2();"
			name="start"> <input type="button" value="OCR识别身份证"
			onClick="ocrreconize();" name="ocrreconize">
	</div>



	<div class="btn btn_">
		<input type="button" class="s-btn active" value="身份证识别"
			onclick="readcard();"> <input type="button" class="s-btn"
			value="身份证/身份证复印件扫描"> <input type="button" class="s-btn"
			value="户口簿/户口簿复印件扫描"> <input type="button" class="s-btn"
			value="其他证件扫描">
	</div>
	<div class="clearfix"></div>

	<div class="content-box">
		
		<!-- -------------------------------------身份证读卡器识别数据-------------------------------- -->
		<div class="o-information " style="height: 900px">
			<div class="right-information photo">
				<h1 class="title">身份证读卡器识别数据</h1>
				<form:form id="inputForm1" modelAttribute="bdJbxx"
					action="${ctx}/xsbd/bdJbxx/save" method="post"
					class="form-horizontal" enctype="multipart/form-data">
					<form:hidden path="id" />
					<sys:message content="${message}" />
					<input type="hidden" id="saveZsdj" />
					<div class="r-group">
		     			<label class="gr-mc">准考证号：</label>
						<div class="controls">
						<form:input path="zkzh" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">报考层次：</label>
						<div class="controls">
						<form:input path="bkcc" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					</div>
					<div class="r-group">
						<label class="gr-mc">计划名称：</label>
						<div class="group">
					<form:select path="zsjh.id" id="zsjhid" maxlength="64" class="input-xlarge  required" style="width:215px;">
							<form:option value="" label="请选择招生计划" />
							<form:options items="${fns:findListZsjh()}" itemLabel="jhmc"
								itemValue="id" htmlEscape="false" />
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
							</div>
					</div>
					
					<div class="r-group">
						<label class="gr-mc"><font color="red">姓名：</font></label>
						<div class="group">
							<form:input path="xm" id="rxm" htmlEscape="false" maxlength="64" onblur="byName()"
								class="input-xlarge required gr-r-mc" style="width:215px" />
							<span class="help-inline"><font color="red" id="xmfont">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label  class="gr-mc"><font color="red">性别：</font></label>
						<div class="group" id="rxbmP" style="padding-top:8px">
							<form:select path="xbm" id="xbm" class="input-xlarge required gr-r-mc" style="width:215px" >
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sex')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc"><font color="red">民族：</font></label>
						<div class="group">
							<form:select path="nation" id="rnation"
								class="input-xlarge  required" style="width:215px">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('nation')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>


					<div class="r-group">
						<label class="gr-mc"><font color="red">身份证件类型：</font></label>
						<div class="group">

							<form:select path="sfzjlx" class="input-xlarge  required" style="width:215px;" id="sfzID" onchange="getCSRQ('0')">

								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sfzjlx')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>

					<div class="r-group">
						<label class="gr-mc"><font color="red">身份证件号码：</font></label>
						<div class="mc-input">
							<form:input path="sfzjh" id="rsfzjh" htmlEscape="false" onblur="byID();"
								maxlength="18" class="input-xlarge required requ" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc"><font color="red">出生年月：</font></label>
						<div class="mc-input">
							<input name="csrq" type="text" id="rcsrq" readonly="readonly"
								maxlength="20" class="input-xlarge required requ" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					
						
		  <div class="r-group" style="width:60%;">
			<label class="gr-mc"style="width:27%;">生源地区：</label>
			<div  class="mc-input">
			<form:select path="sf" id="sf1" class="input-xlarge  required" style="width:10%;" onchange="byCS1(this.value)" >
						<form:option value="" label="请选择省"/>
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
			<form:select path="cs" class="input-xlarge  required"  style="width:10%;" id="cs1" onchange="byQX1(this.value)" >
						<form:option value="" label="请选择市"/>
					</form:select>
			<form:select path="qx" class="input-xlarge  required"  style="width:10%;" id="qx1"  onchange="byXZ1(this.value)" >
						<form:option value="" label="请选择县"/>
					</form:select>
					<form:select path="jd" class="input-xlarge  required"   style="width:10%;"  id="jd1">
						<form:option value="" label="请选择乡"/>
					</form:select>
					</div>
					</div>
					<%--
					 <div class="r-group">
					<label class="gr-mc"></label>
			<div  class="mc-input"> 
		<form:select path="jd" class="input-xlarge  required"   style="width:61%;"  id="jd1">
						<form:option value="" label="请选择乡"/>
					</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			
			--%>
			<div class="r-group">
			  <label class="gr-mc">生源校：</label>
			<div class="mc-input">
				<form:input path="fromSchool" htmlEscape="false" maxlength="32" id="fromSchool1"
					        class="input-xlarge required" style="width:200px;"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
	
					
					
					<%-- <div class="group">
						<label>出生年月：</label>
						<div class="group">
							<form:input path="csrq" id="rcsrq" htmlEscape="false" maxlength="64" onblur="byYears()"
								class="input-xlarge required" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div> --%>
					<div class="r-group">
						<label class="gr-mc"><font color="red">家庭住址：</font></label>
						<div class="mc-input">
							<form:input path="jtzz" id="rjtzz" htmlEscape="false"
								maxlength="255" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc"><font color="red">签发机关：</font></label>
						<div class="mc-input">
							<form:input path="qfjg" id="rqfjg" htmlEscape="false"
								maxlength="50" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc"><font color="red">身份证件起始时间：</font></label>
						<div class="mc-input">
							<input name="starttime" id="rstarttime" type="text"
								readonly="readonly" maxlength="20" class="input-xlarge requ"/>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc"><font color="red">身份证件结束时间：</font></label>
						<div class="mc-input">
							<input name="overtime" id="rovertime" type="text"
								readonly="readonly" maxlength="20" class="input-xlarge requ" />
						</div>
					</div>


					<div class="r-group">
						<label class="gr-mc">专业类别：</label>
						<div class="mc-input">
							<form:select path="zyId.id" id="zylxId1" style="width:215px"
								onchange="lxChange1(this.value)" class="input-medium required">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>

					

                         <input type="hidden" value="1" name="datafrom"/>
                         
						
					</div>
					<div class="r-group">
						<label class="gr-mc">专业名称：</label>
						<div class="mc-input" id="zyByLx1">
							<select name="zylxId" class="input-medium required" id="zyid" style="width:215px">
								<option value="" label="请选择" />
							</select>
							<span class="help-inline"><font color="red" >*</font> </span>
						</div>
						</div>
						<div class="r-group">
						    <label class="gr-mc">学制：</label>
							<div class="mc-input" id="zyinfo">
							    <form:input path="xz" class="input-xlarge requ"  id="xza" type="text" readonly="true"/>
						    </div>
						</div>
						
							<div class="r-group">
						<label class="gr-mc">招生老师：</label>
						<div class="group">
							<form:select path="js.id" 
								class="input-xlarge  required gr-r-mc" style="width:215px;">
								<form:option value="" label="" />
								<form:options items="${fns:getAllUserList()}"
									itemLabel="name" itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
						
						<div class="r-group">
		     			<label class="gr-mc">联系电话：</label>
						<div class="mc-input">
	         <form:input path="lxdh" htmlEscape="false" maxlength="32"
				      onblur="validateLxdh()" /><label></label>
			</div>
		   </div>
		   
		   <div class="r-group">
				<label class="gr-mc">学生来源：</label>
				<div class="controls">
					<form:select path="xslym" class="input-xlarge required" style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xs_ly')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		    <div class="r-group">
				<label class="gr-mc">学生类型：</label>
				<div class="controls">
					<form:select path="xslx" class="input-xlarge required" style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xslx')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="r-group">
		     			<label class="gr-mc">西安音乐学院考级证书等级：</label>
						<div class="controls">
						<form:input path="yyxykszsdj" htmlEscape="false" maxlength="32" 
						class="input-xlarge" style="width:205px;"/>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">成绩：</label>
						<div class="controls">
						<form:select path="yyxukszscj" class="input-xlarge" style="width:215px;">
						<form:option value="" label=""/>
						<form:option value="1" label="优秀"/>
						<form:option value="2" label="良好"/>
						<form:option value="2" label="合格"/>
					   </form:select>
						
					    </div>
					</div>
					<div class="r-group">
		     			<label class="gr-mc">是否愿意兼报：</label>
						<div class="controls">
						<form:select path="isyyjb" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
						
					    </div>
					    </div>
							<div class="r-group">
						<label class="gr-mc">兼报专业类别：</label>
						<div class="mc-input">
							<form:select path="jbzylxid" id="zylxId5" style="width:215px"
								onchange="lxChange5(this.value)" class="input-medium">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
						</div>
                         <input type="hidden" value="1" name="datafrom"/>
					</div>
					<div class="r-group">
						<label class="gr-mc">兼报专业名称：</label>
						<div class="mc-input" id="zyByLx5">
							<select name="jbzyid" class="input-medium" id="zyid5" style="width:215px">
								<option value="" label="请选择" />
							</select>
						</div>
						</div>
						<div class="r-group">
						    <label class="gr-mc">兼报学制：</label>
							<div class="mc-input" id="zyinfo5">
							    <form:input path="jbxz" class="input-xlarge"  id="xzf" type="text" readonly="true"/>
						    </div>
						</div>
						<div class="r-group">
		     			<label class="gr-mc">是否特殊政策考生：</label>
						<div class="controls">
						<form:select path="isdszcks" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
					    </div>
					    </div>
					    <div class="r-group">
						    <label class="gr-mc">奖惩状况：</label>
							<div class="mc-input" >
							    <form:input path="jcqk" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							 <input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy1" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							   <input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy2" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy3" class="input-xlarge"  type="text" />
						    </div>
						</div>
						
				</form:form>
			</div>

			<!-- ------------------------------------身份证/复印件扫描---------------------------------- -->
			<div class="clearfix"></div>
			<div class="right-information photo" style=" display:none;">
				<h1 class="title">身份证/复印件扫描</h1>
				<form:form id="inputForm2" modelAttribute="bdJbxx"
					action="${ctx}/xsbd/bdJbxx/save" method="post"
					class="form-horizontal mc-form">
					<form:hidden path="id" />
					<sys:message content="${message}" />
					<div class="r-group">
		     			<label class="gr-mc">准考证号：</label>
						<div class="controls">
						<form:input path="zkzh" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">报考层次：</label>
						<div class="controls">
						<form:input path="bkcc" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					</div>
					<div class="r-group">
						<label class="gr-mc">计划名称：</label>
						<div class="group">
					<form:select path="zsjh.id" id="zsjhid" maxlength="64" class="input-xlarge  required" style="width:215px;">
							<form:option value="" label="请选择招生计划" />
							<form:options items="${fns:findListZsjh()}" itemLabel="jhmc"
								itemValue="id" htmlEscape="false" />
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
							</div>
					</div>
					
					<div class="r-group">
						<label class="gr-mc">姓名：</label>
						<div class="group">
							<form:input path="xm" htmlEscape="false" maxlength="64" id="cxm" onblur="byName1()" style="width:215px"
								class="input-xlarge required gr-r-mc" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">性别：</label>
						<div class="group" id="cxb" style="padding-top: 6px;">
							<form:select path="xbm" class="input-xlarge required gr-r-mc" style="width:215px;" >
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sex')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">民族：</label>
						<div class="group">
							<%-- <form:input path="nation" htmlEscape="false" maxlength="64" id="cmz"
					class="input-xlarge required" /> --%>
							<form:select path="nation" id="cmz"
								class="input-xlarge  required" style="width:215px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('nation')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件类型：</label>
						<div class="group" style="padding-top: 6px;">
							<form:select path="sfzjlx" class="input-xlarge required gr-r-mc" style="width:215px;"
								id="csfzjlx" onchange="getCSRQ1('0')">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sfzjlx')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件号码：</label>
						<div class="mc-input">
							<form:input path="sfzjh" htmlEscape="false" maxlength="18" onblur="byID1()"
								id="csfzjh" class="input-xlarge required requ" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">出生年月：</label>
						<div class="mc-input">
							<input name="csrq" type="text" readonly="readonly" maxlength="20" style="width: 200px;"
								id="ccsrq" class="input-medium Wdate required requ"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div> 
					  <div class="r-group" style="width:60%">
			<label class="gr-mc" style="width: 27%">生源地区：</label>
			<div  class="mc-input">
			<form:select path="sf"  id="sf2" class="input-xlarge  required" style="width:10%;" onchange="byCS2(this.value)" >
						<form:option value="" label="请选择省"/>
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
			<form:select path="cs" class="input-xlarge  required" style="width:10%;" id="cs2" onchange="byQX2(this.value)" >
						<form:option value="" label="请选择市"/>
					</form:select>
			<form:select path="qx" class="input-xlarge  required" style="width:10%;" id="qx2"  onchange="byXZ2(this.value)" >
						<form:option value="" label="请选择县"/>
					</form:select>
							<form:select path="jd" class="input-xlarge  required" style="width:10%"  id="xz2">
						<form:option value="" label="请选择乡"/>
					</form:select>
					</div>
					</div>
			<div class="r-group">
			  <label class="gr-mc">生源校：</label>
			<div class="mc-input">
				<form:input path="fromSchool" htmlEscape="false" maxlength="32" id="fromSchool2"
					        class="input-xlarge required" style="width:200px;"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
					<div class="r-group">
						<label class="gr-mc">家庭住址：</label>
						<div class="mc-input">
							<form:input path="jtzz" htmlEscape="false" maxlength="255"
								id="cjtzz" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group ">
						<label class="gr-mc">签发机关：</label>
						<div class="mc-input">
							<form:input path="qfjg" htmlEscape="false" maxlength="50"
								id="cqfjg" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件起始时间：</label>
						<div class="mc-input">
							<input name="starttime" type="text" readonly="readonly"
								id="cstarttime" maxlength="20" class="input-medium Wdate requ" style="width:200px;"
								value="<fmt:formatDate value="${bdJbxx.starttime}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件结束时间：</label>
						<div class="mc-input">
							<input name="overtime" type="text" readonly="readonly" style="width:200px;"
								id="covertime" maxlength="20" class="input-medium Wdate requ"
								value="<fmt:formatDate value="${bdJbxx.overtime}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">专业类别：</label>
						<div class="mc-input">
							<form:select path="zyId.id" id="zylxId2"
								onchange="lxChange2(this.value)" class="input-medium required requ" style="width: 215px;">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
						    <input type="hidden" value="2" name="datafrom"/>
					</div>
					<div class="r-group">
						<label class="gr-mc">专业名称：</label>
						<div class="mc-input" id="zyByLx2">
							<select name="zylxId" class="input-medium requ required" id="zyid1" style="width: 215px;">
								<option value="" label="请选择" />
							</select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
						</div>
					<div class="r-group">
						    <label class="gr-mc">学制：</label>
							<div class="mc-input" id="zyinfo1">
							    <form:input path="xz" class="input-xlarge requ"  id="xzb" type="text" readonly="true"/>
						    </div>
						</div>
						
							<div class="r-group">
						<label class="gr-mc">招生老师：</label>
						<div class="group">
							<form:select path="js.id" 
								class="input-xlarge  required gr-r-mc"  style="width: 215px;">
								<form:option value="" label="" />
								<form:options items="${fns:getAllUserList()}"
									itemLabel="name" itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
						
						<div class="r-group">
		     			<label class="gr-mc">联系电话：</label>
						<div class="mc-input">
	<form:input path="lxdh" htmlEscape="false" maxlength="32" style="width:200px;"
				      onblur="validateLxdh()" /><label></label>
			</div>
		   </div>
		   
		 <div class="r-group">
				<label class="gr-mc">学生来源：</label>
				<div class="controls">
					<form:select path="xslym" class="input-xlarge required" style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xs_ly')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		       <div class="r-group">
				<label class="gr-mc">学生类型：</label>
				<div class="controls">
					<form:select path="xslx" class="input-xlarge required" style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xslx')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
				<div class="r-group">
		     			<label class="gr-mc">西安音乐学院考级证书等级：</label>
						<div class="controls">
						<form:input path="yyxykszsdj" htmlEscape="false" maxlength="32" 
						class="input-xlarge" style="width:205px;"/>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">成绩：</label>
						<div class="controls">
						<form:select path="yyxukszscj" class="input-xlarge" style="width:215px;">
						<form:option value="" label=""/>
						<form:option value="1" label="优秀"/>
						<form:option value="2" label="良好"/>
						<form:option value="2" label="合格"/>
					   </form:select>
						
					    </div>
					</div>
					<div class="r-group">
		     			<label class="gr-mc">是否愿意兼报：</label>
						<div class="controls">
						<form:select path="isyyjb" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
						
					    </div>
					    </div>
							<div class="r-group">
						<label class="gr-mc">兼报专业类别：</label>
						<div class="mc-input">
							<form:select path="jbzylxid" id="zylxId6" style="width:215px"
								onchange="lxChange6(this.value)" class="input-medium">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
						</div>
                         <input type="hidden" value="1" name="datafrom"/>
					</div>
					<div class="r-group">
						<label class="gr-mc">兼报专业名称：</label>
						<div class="mc-input" id="zyByLx6">
							<select name="jbzyid" class="input-medium" id="zyid6" style="width:215px">
								<option value="" label="请选择" />
							</select>
						</div>
						</div>
						<div class="r-group">
						    <label class="gr-mc">兼报学制：</label>
							<div class="mc-input" id="zyinfo5">
							    <form:input path="jbxz" class="input-xlarge"  id="xzf6" type="text" readonly="true"/>
						    </div>
						</div>
						<div class="r-group">
		     			<label class="gr-mc">是否特殊政策考生：</label>
						<div class="controls">
						<form:select path="isdszcks" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
					    </div>
					    </div>
					    <div class="r-group">
						    <label class="gr-mc">奖惩状况：</label>
							<div class="mc-input" >
							    <form:input path="jcqk" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							 <input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy1" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							   <input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy2" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy3" class="input-xlarge"  type="text" />
						    </div>
						</div>
				</form:form>
			</div>


			<!-- --------------------------------------户口簿/复印件扫描------------------------------------------------ -->
			<div class="right-information photo" style="display:none;">
				<h1 class="title">户口簿/复印件扫描</h1>

				<form:form id="inputForm3" modelAttribute="bdJbxx"
					action="${ctx}/xsbd/bdJbxx/save" method="post"
					class="form-horizontal">
					<form:hidden path="id" />
					<sys:message content="${message}" />
					<div class="r-group">
		     			<label class="gr-mc">准考证号：</label>
						<div class="controls">
						<form:input path="zkzh" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">报考层次：</label>
						<div class="controls">
						<form:input path="bkcc" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					</div>
					<div class="r-group">
						<label class="gr-mc">计划名称：</label>
						<div class="group">
					<form:select path="zsjh.id" id="zsjhid" maxlength="64" class="input-xlarge  required" style="width:228px;">
							<form:option value="" label="请选择招生计划" />
							<form:options items="${fns:findListZsjh()}" itemLabel="jhmc"
								itemValue="id" htmlEscape="false" />
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
							</div>
					</div>
					
					<div class="r-group">
						<label class="gr-mc">姓名：</label>
						<div class="group">
							<form:input path="xm" htmlEscape="false" maxlength="64" id="bxm" onblur="byName2()" style="width:215px;"
								class="input-xlarge required gr-r-mc" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">曾用名：</label>
						<div class="group" style="padding-top: 6px;">
							<form:input path="cname" htmlEscape="false" maxlength="64" style="width:228px;"
								id="bcname" class="input-xlarge gr-r-mc" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">户主或与户主关系：</label>
						<div class="group">
							<form:input path="relation" htmlEscape="false" maxlength="64" style="width:215px;"
								id="crelation" class="input-xlarge gr-r-mc" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">性别：</label>
						<div class="group"  id="bxbm" style="padding-top: 6px;">
							<form:select path="xbm" class="input-xlarge required gr-r-mc" style="width:228px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sex')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">民族：</label>
						<div class="group">
							<form:select path="nation" id="ccmz"
								class="input-xlarge  required gr-r-mc" style="width:215px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('nation')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">出生地：</label>
						<div class="group" style="padding-top: 6px;">
							<form:input path="jtzz" htmlEscape="false" maxlength="255" style="width:228px;"
								id="bjtzz" class="input-xlarge gr-r-mc" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">籍贯：</label>
						<div class="group">
							<form:input path="jg" htmlEscape="false" maxlength="64" id="bjg" style="width:215px;"
								class="input-xlarge gr-r-mc" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">出生日期：</label>
						<div class="group">
							<input name="csrq" type="text" readonly="readonly" maxlength="20"style="width:228px;"
								id="bcsrq" class="input-medium Wdate required gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					
					  <div class="r-group" style="width: 60%">
			<label class="gr-mc" style="width: 27%">生源地区：</label>
			<div  class="mc-input">
			<form:select path="sf"  id="sf3" class="input-xlarge  required" style="width:10%;" onchange="byCS3(this.value)" >
						<form:option value="" label="请选择省"/>
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
			<form:select path="cs" class="input-xlarge  required" style="width:10%;" id="cs3" onchange="byQX3(this.value)" >
						<form:option value="" label="请选择市"/>
					</form:select>
			<form:select path="qx" class="input-xlarge  required" style="width:10%;" id="qx3"  onchange="byXZ3(this.value)" >
						<form:option value="" label="请选择县"/>
					</form:select>
							<form:select path="jd" class="input-xlarge  required" style="width:10%;" id="xz3">
						<form:option value="" label="请选择乡"/>
					</form:select>
					</div>
					</div>
			<div class="r-group">
			  <label class="gr-mc">生源校：</label>
			<div class="mc-input">
				<form:input path="fromSchool" htmlEscape="false" maxlength="32" id="fromSchool3"
					        class="input-xlarge required" style="width:215px;"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
	
	
					<div class="r-group">
						<label class="gr-mc">本市（县）其他住址：</label>
						<div class="mc-input">
							<form:input path="otheraddress" htmlEscape="false"
								maxlength="200" id="botheraddress" class="input-xlarge requ" style="width:215px;" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">宗教信仰：</label>
						<div class="mc-input">
							<form:input path="religion" htmlEscape="false" maxlength="200" style="width:215px;"
								id="breligion" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">公民身份证件编号：</label>
						<div class="mc-input">
							<form:input path="sfzjh" htmlEscape="false" maxlength="18" onblur="byID2()" style="width:215px;"
								id="bsfzjh" class="input-xlarge required requ" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件类型：</label>
						<div class="mc-input">
							<form:select path="sfzjlx" class="input-xlarge required requ" style="width:230px;"
								id="ccsfzjlx" onchange="getCSRQ2('0')">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sfzjlx')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身高：</label>
						<div class="mc-input">
							<form:input path="sg" htmlEscape="false" maxlength="20" id="bsg" style="width:215px;"
								class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">血型：</label>
						<div class="mc-input">
							<form:input path="xx" htmlEscape="false" maxlength="20" id="bxx" style="width:215px;"
								class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">文化程度：</label>
						<div class="mc-input">
							<form:input path="whcd" htmlEscape="false" maxlength="20" style="width:215px;"
								id="bwhcd" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">兵役状况：</label>
						<div class="mc-input">
							<form:input path="byzk" htmlEscape="false" maxlength="20" style="width:215px;"
								id="bbyzk" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">服务处所：</label>
						<div class="mc-input">
							<form:input path="fwcs" htmlEscape="false" maxlength="100" style="width:215px;"
								id="bfwcs" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">职业：</label>
						<div class="mc-input">
							<form:input path="zy" htmlEscape="false" maxlength="50" id="bzy" style="width:215px;"
								class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">何时由何地迁来本市（县）：</label>
						<div class="mc-input">
							<form:input path="bsx" htmlEscape="false" maxlength="200" style="width:215px;"
								id="bbsx" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">何时由何地迁来本址：</label>
						<div class="mc-input">
							<form:input path="bzz" htmlEscape="false" maxlength="200" style="width:215px;"
								id="bbzz" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">专业类别：</label>
						<div class="mc-input">
							<form:select path="zyId.id" id="zylxId3" style="width:230px;"
								onchange="lxChange3(this.value)" class="input-medium required requ">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
						    <input type="hidden" value="3" name="datafrom"/>
					</div>
					
					<div class="r-group">
					   <label class="gr-mc">专业名称：</label>
						<div class="mc-input" id="zyByLx3">
							<select name="zylxId" class="input-medium requ required" id="zyid1" style="width:230px;">
								<option value="" label="请选择" />
							</select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>	
							<div class="r-group">
						    <label class="gr-mc">学制：</label>
							<div class="mc-input" id="zyinfo2">
							    <form:input path="xz" class="input-xlarge requ"  id="xzc" type="text" readonly="true" style="width:215px;"/>
						    </div>
						</div>
						
							<div class="r-group">
						<label class="gr-mc">招生老师：</label>
						<div class="group">
							<form:select path="js.id"  style="width:230px;"
								class="input-xlarge  required gr-r-mc" >
								<form:option value="" label="" />
								<form:options items="${fns:getAllUserList()}"
									itemLabel="name" itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
						
						<div class="r-group">
		     			<label class="gr-mc">联系电话：</label>
						<div class="mc-input">
	<form:input path="lxdh" htmlEscape="false" maxlength="32" style="width:215px;"
				      onblur="validateLxdh()" /><label></label>
			</div>
		   </div>
		   
		    <div class="r-group">
				<label class="gr-mc">学生来源：</label>
				<div class="controls">
					<form:select path="xslym" class="input-xlarge required" style="width:228px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xs_ly')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		  
		       <div class="r-group">
				<label class="gr-mc">学生类型：</label>
				<div class="controls">
					<form:select path="xslx" class="input-xlarge required" style="width:228px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xslx')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
				<div class="r-group">
		     			<label class="gr-mc">西安音乐学院考级证书等级：</label>
						<div class="controls">
						<form:input path="yyxykszsdj" htmlEscape="false" maxlength="32" 
						class="input-xlarge" style="width:205px;"/>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">成绩：</label>
						<div class="controls">
						<form:select path="yyxukszscj" class="input-xlarge" style="width:215px;">
						<form:option value="" label=""/>
						<form:option value="1" label="优秀"/>
						<form:option value="2" label="良好"/>
						<form:option value="2" label="合格"/>
					   </form:select>
						
					    </div>
					</div>
					<div class="r-group">
		     			<label class="gr-mc">是否愿意兼报：</label>
						<div class="controls">
						<form:select path="isyyjb" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
						
					    </div>
					    </div>
							<div class="r-group">
						<label class="gr-mc">兼报专业类别：</label>
						<div class="mc-input">
							<form:select path="jbzylxid" id="zylxId7" style="width:215px"
								onchange="lxChange7(this.value)" class="input-medium">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
						</div>
                         <input type="hidden" value="1" name="datafrom"/>
					</div>
					<div class="r-group">
						<label class="gr-mc">兼报专业名称：</label>
						<div class="mc-input" id="zyByLx7">
							<select name="jbzyid" class="input-medium" id="zyid7" style="width:215px">
								<option value="" label="请选择" />
							</select>
						</div>
						</div>
						<div class="r-group">
						    <label class="gr-mc">兼报学制：</label>
							<div class="mc-input" id="zyinfo7">
							    <form:input path="jbxz" class="input-xlarge"  id="xzf7" type="text" readonly="true"/>
						    </div>
						</div>
						<div class="r-group">
		     			<label class="gr-mc">是否特殊政策考生：</label>
						<div class="controls">
						<form:select path="isdszcks" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
					    </div>
					    </div>
					    <div class="r-group">
						    <label class="gr-mc">奖惩状况：</label>
							<div class="mc-input" >
							    <form:input path="jcqk" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							 <input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy1" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							   <input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy2" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy3" class="input-xlarge"  type="text" />
						    </div>
						</div>
				</form:form>
			</div>
			<!-- ---------------------------------其他证件扫描-------------------------------------- -->
			<div class="right-information photo" style="display:none;">
				<h1 class="title">其他证件扫描</h1>

				<form:form id="inputForm4" modelAttribute="bdJbxx"
					action="${ctx}/xsbd/bdJbxx/save" method="post"
					class="form-horizontal">
					<form:hidden path="id" />
					<sys:message content="${message}" />
					<div class="r-group">
		     			<label class="gr-mc">准考证号：</label>
						<div class="controls">
						<form:input path="zkzh" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">报考层次：</label>
						<div class="controls">
						<form:input path="bkcc" htmlEscape="false" maxlength="32" 
						class="input-xlarge requ required" style="width:205px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					    </div>
					</div>
					<div class="r-group">
						<label class="gr-mc">计划名称：</label>
						<div class="group">
					<form:select path="zsjh.id" id="zsjhid" maxlength="64" class="input-xlarge  required" style="width:228px;">
							<form:option value="" label="请选择招生计划" />
							<form:options items="${fns:findListZsjh()}" itemLabel="jhmc"
								itemValue="id" htmlEscape="false" />
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
							</div>
					</div>
		

					<div class="r-group">
						<label class="gr-mc">姓名：</label>
						<div class="group">
							<form:input path="xm" htmlEscape="false" maxlength="64" id="qxm" onblur="byName3()" style="width:228px;"
								class="input-xlarge required gr-r-mc" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					
					<div class="r-group">
						<label class="gr-mc">性别：</label>
						<div class="group" id="qxbm" style="padding-top: 6px;">
							<form:select path="xbm" class="input-xlarge required gr-r-mc" style="width:228px;" id="cc">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sex')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>


					<div class="r-group">
						<label class="gr-mc">民族：</label>
						<div class="group">
							<form:select path="nation" id="crnation"
								class="input-xlarge  required gr-r-mc" style="width:228px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('nation')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件类型：</label>
						<div class="group" style="padding-top: 6px;">
							<form:select path="sfzjlx" class="input-xlarge required gr-r-mc" style="width:228px;"
								id="qsfzjlx" onchange="getCSRQ3('0')">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('sfzjlx')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件号码：</label>
						<div class="mc-input">
							<form:input path="sfzjh" htmlEscape="false" maxlength="18" onblur="byID3();" style="width:215px;"
								id="qsfzjh" class="input-xlarge required requ" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">出生年月：</label>
						<div class="mc-input">
							<input name="csrq" type="text" readonly="readonly" maxlength="20" style="width:215px;"
								id="qcsrq" class="input-medium Wdate required requ"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					  <div class="r-group" style="width:60%">
			<label class="gr-mc" style="width: 27%">生源地区：</label>
			<div  class="mc-input">
			<form:select path="sf" id="sf4" class="input-xlarge  required" style="width:10%;" onchange="byCS4(this.value)" >
						<form:option value="" label="请选择省"/>
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
			<form:select path="cs" class="input-xlarge  required" style="width:10%;" id="cs4" onchange="byQX4(this.value)" >
						<form:option value="" label="请选择市"/>
					</form:select>
					<form:select path="qx" class="input-xlarge  required" style="width:10%;" id="qx4"  onchange="byXZ4(this.value)" >
						<form:option value="" label="请选择县"/>
					</form:select>
							<form:select path="jd" class="input-xlarge  required" style="width:10%;" id="xz4">
						<form:option value="" label="请选择乡"/>
					</form:select>
					</div>
					</div>
			<div class="r-group">
			  <label class="gr-mc">生源校：</label>
			<div class="mc-input">
				<form:input path="fromSchool" htmlEscape="false" maxlength="32" id="fromSchool4" 
					        class="input-xlarge required" style="width:215px;"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
					<div class="r-group">
						<label class="gr-mc">家庭住址：</label>
						<div class="mc-input">
							<form:input path="jtzz" htmlEscape="false" maxlength="255" style="width:215px;"
								id="qjtzz" class="input-xlarge requ" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">签发机关：</label>
						<div class="mc-input">
							<form:input path="qfjg" htmlEscape="false" maxlength="50" style="width:215px;"
								id="qqfjg" class="input-xlarge requ" />
						</div>
					</div> 
					<div class="r-group">
						<label class="gr-mc">身份证件起始时间：</label>
						<div class="mc-input">
							<input name="starttime" type="text" readonly="readonly" style="width:215px;"
								id="qstarttime" maxlength="20" class="input-medium Wdate requ"
								value="<fmt:formatDate value="${bdJbxx.starttime}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">身份证件结束时间：</label>
						<div class="mc-input">
							<input name="overtime" type="text" readonly="readonly" style="width:215px;"
								id="qovertime" maxlength="20" class="input-medium Wdate requ"
								value="<fmt:formatDate value="${bdJbxx.overtime}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">专业类别：</label>
						<div class="mc-input">
							<form:select path="zyId.id" id="zylxId4" style="width:228px;"
								onchange="lxChange4(this.value)" class="input-medium required requ">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>

						
                           <input type="hidden" value="4" name="datafrom"/>
						
					</div>
					
					<div class="r-group">
					 <label class="gr-mc">专业名称：</label>
						<div class="mc-input" id="zyByLx4">
							<select name="zylxId" class="input-medium requ required" id="zyid1" style="width:228px;">
								<option value="" label="请选择" />
							</select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
							<div class="r-group">
						    <label class="gr-mc">学制：</label>
							<div class="mc-input" id="zyinfo3">
							    <form:input path="xz" class="input-xlarge requ"  id="xzd" type="text" readonly="true" style="width:215px;"/>
						    </div>
						</div>
						
						
						<div class="r-group">
						<label class="gr-mc">招生老师：</label>
						<div class="group">
							<form:select path="js.id"  style="width:228px;"
								class="input-xlarge  required gr-r-mc" >
								<form:option value="" label="" />
								<form:options items="${fns:getAllUserList()}"
									itemLabel="name" itemValue="id" htmlEscape="false" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
					
				
			<div class="r-group">
		     			<label class="gr-mc">联系电话：</label>
						<div class="controls">
	<form:input path="lxdh" htmlEscape="false" maxlength="32" style="width:215px;"
				      onblur="validateLxdh()" /><label></label>
			</div>
		   </div>
		   
		   <div class="r-group">
				<label class="gr-mc">学生来源：</label>
				<div class="controls">
					<form:select path="xslym" class="input-xlarge required" style="width:228px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xs_ly')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		  
		       <div class="r-group">
				<label class="gr-mc">学生类型：</label>
				<div class="controls">
					<form:select path="xslx" class="input-xlarge required" style="width:228px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xslx')}" itemLabel="label" 
						itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="r-group">
		     			<label class="gr-mc">西安音乐学院考级证书等级：</label>
						<div class="controls">
						<form:input path="yyxykszsdj" htmlEscape="false" maxlength="32" 
						class="input-xlarge" style="width:205px;"/>
					    </div>
					    </div>
						<div class="r-group">
						<label class="gr-mc">成绩：</label>
						<div class="controls">
						<form:select path="yyxukszscj" class="input-xlarge" style="width:215px;">
						<form:option value="" label=""/>
						<form:option value="1" label="优秀"/>
						<form:option value="2" label="良好"/>
						<form:option value="2" label="合格"/>
					   </form:select>
						
					    </div>
					</div>
					<div class="r-group">
		     			<label class="gr-mc">是否愿意兼报：</label>
						<div class="controls">
						<form:select path="isyyjb" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
						
					    </div>
					    </div>
							<div class="r-group">
						<label class="gr-mc">兼报专业类别：</label>
						<div class="mc-input">
							<form:select path="jbzylxid" id="zylxId8" style="width:215px"
								onchange="lxChange8(this.value)" class="input-medium">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
						</div>
                         <input type="hidden" value="1" name="datafrom"/>
					</div>
					<div class="r-group">
						<label class="gr-mc">兼报专业名称：</label>
						<div class="mc-input" id="zyByLx8">
							<select name="jbzyid" class="input-medium" id="zyid8" style="width:215px">
								<option value="" label="请选择" />
							</select>
						</div>
						</div>
						<div class="r-group">
						    <label class="gr-mc">兼报学制：</label>
							<div class="mc-input" id="zyinfo8">
							    <form:input path="jbxz" class="input-xlarge"  id="xzf8" type="text" readonly="true"/>
						    </div>
						</div>
						<div class="r-group">
		     			<label class="gr-mc">是否特殊政策考生：</label>
						<div class="controls">
						<form:select path="isdszcks" class="input-xlarge required" style="width:215px;">
						<form:option value="0" label="否"/>
						<form:option value="1" label="是"/>
					   </form:select>
					    </div>
					    </div>
					    <div class="r-group">
						    <label class="gr-mc">奖惩状况：</label>
							<div class="mc-input" >
							    <form:input path="jcqk" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							 <input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate1" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy1" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							   <input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input" >
							    <form:input path="jdxy2" class="input-xlarge"  type="text" />
						    </div>
						</div>
						 <div class="r-group">
						    <label class="gr-mc">就读时间：</label>
							<div class="mc-input" >
							<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" /> 
							  	<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:90px;"
								id="bcsrq" class="input-medium Wdate gr-r-mc"
								value="<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />
						    </div>
						</div>
							 <div class="r-group">
						    <label class="gr-mc">就 读 学 校：</label>
							<div class="mc-input">
							    <form:input path="jdxy3" class="input-xlarge"  type="text" />
						    </div>
						</div>
				</form:form>
			</div>
		</div>

		<div class="clearfix"></div>
		<div class="information-btn">
			<shiro:hasPermission name="xsbd:bdJbxx:edit">
				<input id="btnSubmit" class="btn btn-primary"
					style=" width:20% !important;" type="button" value="保 存"
					onclick="savesubmit();" />&nbsp;</shiro:hasPermission>
					
		</div>

	</div>
  
</body>
</html>