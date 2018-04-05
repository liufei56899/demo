<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>招生登记</title>
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
						$div_btn.click(function() {
						   clearForm();
                           CamSDKOCX2.CloseDev();
                           CamSDKOCX2.UnInitCameraLib();
							$(this).addClass("active").siblings().removeClass(
									"active");
							index = $div_btn.index(this);
							$("div.content-box>.o-information>.photo").eq(index).show().siblings().hide();
							f();
							$("div.body-box>.photo-body").eq(index).show()
									.siblings().hide();
							CamSDKOCX2.InitCameraLib();
							StartVideo();
							StartVideo2();
						});
			});
	

	function f() {
	 if(index==0){
	           //=====默认选中身份证件类型
	            $("#title").html("身份证读卡器识别数据");
				$("#sfzID").select2("destroy");
				$("#sfzID").find("option[value='1']").attr("selected", true);
				$("#sfzID").select2();
			    $("#c3").empty();
				$("#c4").empty();
				$("#c5").empty();
				$("#c6").empty();
				$("#c2").empty();
				$("#c1").empty();
				$("#cc").html("<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%' classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
		      }else if(index==1){
		       $("#title").html("身份证/身份证复印件扫描识别数据");
                $("#sfzID").select2("destroy");
				$("#sfzID").find("option[value='1']").attr("selected", true);
				$("#sfzID").select2();
             		$("#c3").empty();
					$("#c4").empty();
					$("#c5").empty();
					$("#c6").empty();
					$("#cc").empty();
					$("#c1").html("<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%' classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
			
					$("#c2").html("<OBJECT id='CamSDKOCX1' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%' classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
				
             
             }else if(index==2){
                     //默认户口簿
                $("#title").html("户口簿/户口簿复印件扫描识别数据");
				$("#sfzID").select2("destroy");
				$("#sfzID").find("option[value='11']").attr("selected", true);
				$("#sfzID").select2();
                    $("#c1").empty();
					$("#c2").empty();
					$("#c5").empty();
					$("#c6").empty();
					$("#cc").empty();
					$("#c3")
							.html("<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
			
					$("#c4")
							.html("<OBJECT id='CamSDKOCX1' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
				
             }else if(index==3){
             //默认其他证件
                $("#title").html("其他证件扫描识别数据");
				$("#sfzID").select2("destroy");
				$("#sfzID").find("option[value='12']").attr("selected", true);
				$("#sfzID").select2();
                    $("#c1").empty();
					$("#c2").empty();
					$("#c3").empty();
					$("#c4").empty();
					$("#cc").empty();
					$("#c5")
							.html("<OBJECT id='CamSDKOCX2' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
			
					$("#c6").html("<OBJECT id='CamSDKOCX1' style='MARGIN-LEFT:5px;MARGIN-RIGHT:5px; WIDTH: 96%; HEIGHT:100%'  classid='clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41'><SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN></OBJECT>");
				
             }
	}
</script>
<script type="text/javascript">
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
										}
									}
								});
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
			       return false;
		               }
		            return true;
		               }
                   }
  
                   //验证身份证号
      function byID(){
                   	 var sfzjhVal = $("#rsfzjh").val();
		             if (sfzjhVal != null && sfzjhVal != "") {
			         	 var isT = IdCardValidate(sfzjhVal);
			     		 if (!isT) {
				          		validTxt("rsfzjh", "&nbsp;");
				       		 return false;
			          	 }
		             }
		     var flag=    loadXSDJXX(sfzjhVal);
		      if(flag==1){
				      validTxt("rsfzjh", "&nbsp;");
				      return false;
		      }
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
		var ret = CertCtl.connect();
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
		var ret = CertCtl.getStatus();
		ret = JStrToObj(ret);
		DisplayInfo(ret);
		return;
	}

	function disconnect() {
		var ret = CertCtl.disconnect();
		ret = JStrToObj(ret);
		DisplayInfo(ret);
		return;
	}

	//读取信息
	function readCert1() {
		var ret = CertCtl.readCert();
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
		document.all['rqfjg'].value = '';
		document.all['rstarttime'].value = '';
		document.all['rovertime'].value = '';
		document.all['rnation'].value = '';
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
		if(index==1||index==2||index==3){
			CamSDKOCX1.OpenDev(0, 0, 0, 0);
		}
	}
	function StartVideo2() {
		CamSDKOCX2.OpenDev(1, 0, 0, 0);
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
			s = $("#rsfzjh").val();
		if (s == null || s == "") {
			alertx("请先输入信息！");
			return;
		};
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
		CamSDKOCX1.UnInitIDCardOCR();
		var initocr = CamSDKOCX1.InitIDCardOCR();
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
			var ocrtestpath = pathfile+"\\"+time+".jpg";
			CamSDKOCX1.SetAutoCrop(1);
			CamSDKOCX1.CaptureImage(ocrtestpath);
			var ocrresult = CamSDKOCX1.RecongnizeIDCardOCR(ocrtestpath,
					pathfile+"\\"+time+"Head.jpg");
			if (ocrresult.length < 1) {
				alertx("未识别到信息，请手动输入！");
			     $("#smpic").attr("src","/em/static/js/xszp.png");
			} else {
				    var str = ocrresult.split("|");//定义一个 字符串
						if(loadXSDJXX(str[5])==0){
					$("#rxm").val(str[0]);
					var xb = str[1];
				    var sexHtml = "<select id='xbm2' name='xbm' style='width:215px;'>";
					if (xb == "男") {
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
				    var n = str[2] + "族";
					var title = document.getElementById("rnation");
					for ( var i = 0; i < title.options.length; i++) {
					if (title.options[i].innerHTML == n) {
						$("#rnation").select2("destroy");
						$("#rnation").find("option[value='" + title.options[i].value + "']").attr("selected", true);
						$("#rnation").select2();
						break;
					}
				}
			    $("#rcsrq").val(str[3]);
				$("#rjtzz").val(str[4]);
				$("#rsfzjh").val(str[5]);
				if(index==1){
				$("#smpic").css({"width":"120px","height":"160px"});
				var headImg=pathfile+"\\"+time+"Head.jpg";
				document.all['smpic'].src = "data:image/jpg;base64,"+CamSDKOCX1.EncodeBase64(headImg);
				}	
			}
			}
		}
	}
	SetState.checked = true;

	//-----------------------------------------------身份证OCR识别结束--------------------------------------------
</script>

<!-- --------------------------提交不同的表单---------------------------- -->
<script type="text/javascript">
	function savesubmit() {
		if(confirm("请确认表单信息准确无误！\n点击“确定”确认保存，点击“取消”返回页面")){
		$("#inputForm1").submit();
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
</script>
<script type="text/javascript">
     function findZyLxByJhId(zsjhid){
     var selHtml ="<select name='zylx.id' id='zylxId1' onchange='lxChange(this.value)' class='input-xlarge required' style='width:215px;'>";
	 selHtml += "<option value='' >请选择</option>";
	 var selHtml1 ="<select name='jbzylxid' id='zylxId2' onchange='lxChange1(this.value)' class='input-xlarge' style='width:215px;'>";
	 selHtml1 += "<option value='' >请选择</option>";
	 $("#zylbDiv").empty();
	 $("#zylbDiv1").empty();
	jQuery.ajax({
        type: "POST",
        url: "${ctx}/zsdj/zsdj/findZyLxByJhId",
        data: {id:zsjhid},
        dataType:'json',
        async:false,
		success: function(result){
			for(var i=0;i<result.length;i++)
			{
				selHtml +="<option value='"+result[i].zylxId.id+"'  > "+result[i].zylxId.lxmc+"</option>";
				selHtml1 +="<option value='"+result[i].zylxId.id+"' > "+result[i].zylxId.lxmc+"</option>";
			}
	   }
    });
    selHtml +="</select><span class='help-inline'><font color='red'>*</font> </span>";
	$("#zylbDiv").html(selHtml);
	$("#zylbDiv1").html(selHtml1);
	$("#zylxId1").select2();
    }
  function lxChange(zylxid){
     var zhjhid = $("#zsjhid").val();
     var selHtml ="<select name='zy.id' id='zyId1' onchange='zyChange(this.value)' class='input-xlarge required' style='width:215px;'>";
	 selHtml += "<option value='' >请选择</option>";
	 $("#zyByLx1").empty();
	jQuery.ajax({
        type: "POST",
        url: "${ctx}/zsdj/zsdj/findZyByjhzyLxId",
        data: {id:zylxid,jhid:zhjhid},
        dataType:'json',
        async:false,
		success: function(result){
			for(var i=0;i<result.length;i++)
			{
				selHtml +="<option value='"+result[i].zyId.id+"'  > "+result[i].zyId.zymc+"</option>";
			}
	   }
    });
    selHtml +="</select><span class='help-inline'><font color='red'>*</font> </span>";
	$("#zyByLx1").html(selHtml);
	$("#zyId1").select2();
    }
  
  	function zyChange(ida) {
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
   function lxChange1(zylxid){
     var zhjhid = $("#zsjhid").val();
     var selHtml ="<select name='jbzyid' id='zyId2' onchange='zyChange1(this.value)' class='input-xlarge required' style='width:215px;'>";
	 selHtml += "<option value='' >请选择</option>";
	 $("#zyByLx2").empty();
	jQuery.ajax({
        type: "POST",
        url: "${ctx}/zsdj/zsdj/findZyByjhzyLxId",
        data: {id:zylxid,jhid:zhjhid},
        dataType:'json',
        async:false,
		success: function(result){
			for(var i=0;i<result.length;i++)
			{
				selHtml +="<option value='"+result[i].zyId.id+"'  > "+result[i].zyId.zymc+"</option>";
			}
	   }
    });
    selHtml +="</select><span class='help-inline'><font color='red'>*</font> </span>";
	$("#zyByLx2").html(selHtml);
	$("#zyId2").select2();
    }
  
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
					$("#xzb").val(ht);
				}
			}
		});

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
					<input class="pic-btn" type="button" value="采集照片 "
						onClick="AutoCapture();" name="subCapture">
				</div>
				<div class="camera" id="cc"></div>
				<div class="ID-card">
					<p class="card-font">身份证照片</p>
					<span class="card-pic"> <img src="/em/static/js/xszp.png"
						id="pic2" alt="" width="120" height="160"> </span>
				<button class="pic-btn" style="width: 85%" onclick="readcard();">扫描</button>
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
				<div class="camera" id="c1">
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
		<input type="button" class="s-btn active" value="身份证识别"> 
		<input type="button" class="s-btn" value="身份证/身份证复印件扫描"> 
		<input type="button" class="s-btn" value="户口簿/户口簿复印件扫描"> 
		<input type="button" class="s-btn" value="其他证件扫描">
	</div>
	<div class="clearfix"></div>
		<div class="o-information " style="height: 900px">
			<div class="right-information photo">
				<h1 class="title"  id="title">身份证读卡器识别数据</h1>
				<form:form id="inputForm1" modelAttribute="zsdj"
					action="${ctx}/zsdj/zsdj/bmdjAdd" method="post"
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
					<form:select path="zsjh.id" id="zsjhid" maxlength="64" onchange="findZyLxByJhId(this.value)"    class="input-xlarge  required" style="width:215px;">
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
							<input name="csrq" type="text" id="rcsrq" 
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
			<div class="r-group">
			  <label class="gr-mc">生源校：</label>
			<div class="mc-input">
				<form:input path="fromSchool" htmlEscape="false" maxlength="32" id="fromSchool1"
					        class="input-xlarge required" style="width:200px;"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
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
								 maxlength="20" class="input-xlarge requ"/>
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc"><font color="red">身份证件结束时间：</font></label>
						<div class="mc-input">
							<input name="overtime" id="rovertime" type="text"
								 maxlength="20" class="input-xlarge requ" />
						</div>
					</div>
	                   <div class="r-group">
						<label class="gr-mc">专业类别：</label>
						<div class="mc-input"  id="zylbDiv">
							<form:select path="zylx.id" id="zylxId1" style="width:215px"
								class="input-medium required">
								<form:option value="" label="请选择" />
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
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
						 <input type="hidden" value="1" name="datafrom"/>
						<!-- <div class="r-group">
						    <label class="gr-mc">学制：</label>
							<div class="mc-input" id="zyinfo">
							    <form:input path="xz" class="input-xlarge requ"  id="xza" type="text" readonly="true"/>
						    </div>
						</div> -->
						
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
					<form:select path="ly" class="input-xlarge required" style="width:215px;">
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
						<label class="gr-mc">兼报专业类别:</label>
						<div class="mc-input"  id="zylbDiv1">
							<form:select path="jbzylxid" id="zylxId1" style="width:215px"
								class="input-medium required">
								<form:option value="" label="请选择" />
							</form:select>
							
						</div>
					</div>
					<div class="r-group">
						<label class="gr-mc">兼报专业名称:</label>
						<div class="mc-input" id="zyByLx2">
							<select name="jbzyid" class="input-medium" id="zyid2" style="width:215px">
								<option value="" label="请选择" />
							</select>
						</div>
						</div>
						<div class="r-group">
						    <label class="gr-mc">兼报学制:</label>
							<div class="mc-input" id="zyinfo1">
							    <form:input path="jbxz" class="input-xlarge"  id="xzb" type="text" readonly="true"/>
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
						    <label class="gr-mc" style="width:40%;">就读时间：</label>
							<div class="mc-input">
							 <input name="xxdate1" type="text" readonly="readonly" style="width:13%"; maxlength="20"class="input-medium Wdate"
								id="bcsrq"
								value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />至 
							  	<input name="xxdate1" type="text" readonly="readonly" maxlength="20"
								id="bcsrq" class="input-medium Wdate" style="width:13%";
								value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM"/>"
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
						    <label class="gr-mc" style="width:40%;">就读时间：</label>
							<div class="mc-input" >
							   <input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:13%;"
								id="bcsrq" class="input-medium Wdate"
								value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />至 
							  	<input name="xxdate2" type="text" readonly="readonly" maxlength="20"style="width:13%;"
								id="bcsrq" class="input-medium Wdate"
								value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM"/>"
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
						    <label class="gr-mc" style="width:40%;">就读时间：</label>
							<div class="mc-input" >
							<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:13%;"
								id="bcsrq" class="input-medium Wdate"
								value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" />至 
							  	<input name="xxdate3" type="text" readonly="readonly" maxlength="20"style="width:13%;"
								id="bcsrq" class="input-medium Wdate"
								value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM"/>"
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
		<div class="clearfix"></div>
		<div class="information-btn">
			<shiro:hasPermission name="zsdj:zsdj:edit">
				<input id="btnSubmit" class="btn btn-primary"
					style=" width:20% !important;" type="button" value="保 存"
					onclick="savesubmit();" />&nbsp;</shiro:hasPermission>
					
		</div>
		</div>
		
</body>
</html>