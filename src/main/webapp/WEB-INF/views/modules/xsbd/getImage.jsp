<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>照片采集</title>  
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<link rel="stylesheet" href="/em/static/js/reset.css">
<link rel="stylesheet" href="/em/static/js/editstyle.css">


</head>  
<body onload="StartVideo();"onunload="CamSDKOCX.UnInitCameraLib();">

<style type="text/css"> 
#top{height:400px;
margin:0;
}
#left{
width: 100%;
height: 100%;
}
.camera{
	float:left;
	width: 49%;
}
.camera>span{
	padding:10px  20px;
	font-size:14px;
}
.photo{
	float:right;
		width: 49%;
}
.pic{
	display:block;
	width: 21%;
	margin: 0 auto;
}
.butn{
	width: 42%;
	margin: 0 auto;
}
.butn>input{
	width:100px;
	height:30px;
	margin-bottom: 20px;
}
.photo-body{
 	width: 90%;
 	margin: 0 auto;
}
.butn select{
	width:100px;

}
.butn  label{
	line-height: 30px;
}
</style>  
<div class="body-box">
		<div class="o-photo_body photo-body">
			<div class="photo-frame">
				<div class="camera" id="cc">
							<OBJECT id="CamSDKOCX" style="MARGIN-LEFT:5px; WIDTH: 100%; HEIGHT:250px;" 
				classid="clsid:556DBC8A-FE4A-4DA7-A82E-3926C8D4AC41" > 		
				<SPAN STYLE='color: red'>ActiveX 控件装入失败! -- 请检查浏览器的安全设置。CamSDKOCX</SPAN>
							</OBJECT>
							<br>
					<span>姓名：${zsdj.xm }</span>
 					<span>身份证号码：${zsdj.sfzjh }</span>
 					<input type="hidden" id="number" value="${zsdj.sfzjh }"/>
				</div>
				<div class="photo">			
					<span class="pic">
					 	<img src="/em/static/js/xszp.png" alt="" id="sss"> 
					</span>
					<div class="butn">	
					
					<div style='margin-top: 20px;'>
					<label>请选择拍摄类型：</label>
					<select onchange="getTYPE(this.value)">
 									<option value="0">学籍照片</option>
 									<option value="1" selected="selected">普通照片</option>
 						</select>
					</div>
 						<input type = "button" value = "拍摄" onClick = "Capture();" name = "Capture" >
 						<input type = "button" value = "保存"  onclick="uploadImage();">
 						<span>注：当不选择拍摄类型时，默认为选择普通拍照</span>
 					</div>
				</div>

				<div class="id-card-camera"></div>
			</div>
			<div class="clearfix"></div>
		</div>
		</div>

<div style= "display:none">
<select name="adjust" id="adjust" style = "margin-left:180px" onchange = "SetEffect()">
    <option value="0">不优化</option>
	<option value="1">文档优化</option>
	<option value="2">彩页优化</option>
 </select>
 <select name="autocrop" id="autocrop" style = "margin-left:180px" onchange = "SetState()">
    <option value="0">不裁切</option>
	<option value="1">单图裁切</option>
	<option value="2">多图裁切</option>
 </select>
	<input id="SetCusState" type="checkbox" value="" onClick="SetCusState(this)" style = "margin-left:180px" />手动裁切
	<input type = "button" value = "拍摄" onClick = "Capture();" name = "Capture" style = "margin-left:180px">
	<input type = "button" value = "文件上传" onClick = "Uploadfile();" name = "Uploadfile" style = "margin-left:20px">
	<input type = "button" value = "关闭视频" onClick = "Close();" name = "Close" style = "margin-left:20px">
	<input type = "button" value = "切换主头" onClick = "qiehuan0();" name = "qiehuan0" style = "margin-left:20px">
	<input type = "button" value = "切换副头" onClick = "qiehuan1();" name = "qiehuan1" style = "margin-left:20px">
 </div>
 
 <script type="text/javascript">
var strFile;
var Width = 0;
var Height = 0;
var mainIndex = 0;
var index = 0;
var strFile = "D:\\test.jpg";
var newFile;
var s="";
var p="";
function StartVideo()
{
	CamSDKOCX.InitCameraLib();
	CamSDKOCX.OpenDev(1,0,0,0);	
	CamSDKOCX.bSetImageArea(2300,0,7700,10000);
	// SubTest();
}
function SetEffect()
{
	var obj=document.getElementById("adjust") ;
	var index=obj.selectedIndex;
	CamSDKOCX.SetAdjust(index);
}
function SetState()
{	var obj=document.getElementById("autocrop") ;
	var index=obj.selectedIndex;
	CamSDKOCX.SetAutoCrop(index);
}
function SetCusState(obj)
{
	var statcuscrop = obj.checked;
	CamSDKOCX.SetCusCrop(statcuscrop);
}

function Capture()
{
	 		var fso = new ActiveXObject("Scripting.FileSystemObject");//获取对象
	        var pathfile="D:\\FilePhoto";//文件路径
		    if (!fso.FolderExists(pathfile)) {//如果目录不存在，则创建一个目录
			var strFolderName = fso.CreateFolder(pathfile);//文件夹名称
		     }
		     s=$("#number").val();//获取身份证号码
		     newFile = pathfile + "\\" + s + ".jpg";
			CamSDKOCX.CaptureImage(newFile);//保存图片到本地（本机）
			 p = CamSDKOCX.EncodeBase64(newFile);
				$("#sss").attr("src", "data:image/jpg;base64,"+p);
				$("#sss").css({
										"width" : "108px",
										"height" : "143px"
										});
						
	nFileCount ++;

}
function uploadImage(){
	if(p==""||s==""){
		alert("请先拍摄照片！");
		return;
	}
		getImg(p, s);//上传图片到服务器				
}
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
function Close()
{
	CamSDKOCX.CloseDev();
	CamSDKOCX.UnInitCameraLib();
}
function qiehuan0()
{
	CamSDKOCX.CloseDev();
	CamSDKOCX.OpenDev(0,0,0,0);	
}

function qiehuan1()
{
	CamSDKOCX.CloseDev();
	secondStep();
	CamSDKOCX.bSetImageArea(2187,0,7813,10000);
}
function SubTest()
{
	CamSDKOCX.CloseDev();
	CamSDKOCX.OpenDev(1,0,320,240);
	//此处为新加接口bSetImageArea();
	//注：bSetImageArea(LONG iX1, LONG iY1, LONG iX2, LONG iY2)，设置裁切区域，参数分别为（X1，Y1为裁切框左上坐标，X2,Y2为裁切框右下坐标）
	CamSDKOCX.bSetImageArea(15000,7500,35000,42500);
}
function secondStep()
{
//do something
setTimeout("CamSDKOCX.OpenDev(1,0,1600,1200)", 200);
}


function getTYPE(num){
	if(num==0){
		SubTest();
	}
	if(num==1){
		qiehuan1();
	}
}
</script>
<SCRIPT>
setTimeout("StartVideo()",10);
SetState.checked = true;
</SCRIPT>
</body>  
</html> 

