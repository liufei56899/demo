$(document).ready(function() {
	// 绑定select2 change事件
	$("select").bind("change", function() {
		$("#searchForm").submit();
	});
});

function tiaoJianCx() {
	$("#searchForm").submit();
}

/*
 * id:标签id
 * mes：提示消息
 */
function validTxt(id, mes) {
	if ($("#" + id).next().attr("class") == "error") {
		$("#" + id).next().remove();
	}
	var errHtml = "<label for='" + id + "' class='error'>" + mes + "</label>";
	$("#" + id).next().before(errHtml);

}

function format(state) {
	return state.text;
}
/**
 * 下拉选择添加样式
 * 
 * @param id
 */
function selectAddStyle(id) {
	$("#" + id).select2({
		formatResult : format,
		formatSelection : format,
		escapeMarkup : function(m) {
			return m;
		}
	});
}

function openDialog(href, title, width, height) {
	var length = $("div#dialogDiv").size();
	if (length == 0) {
		$("#searchForm").before(
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
	/*$(".panel").css("top", "0px");
	$(".window-shadow").css("top", "0px");*/
	$("#dialogDiv").panel("move",{top:$(document).scrollTop() + ($(window).height()-height) * 0.5});
}
function closeDialog() {
	$(".panel").css("display", "none");
	$(".window-shadow").css("display", "none");
	$(".window-mask").css("display", "none");
}

/** ************list中 设置checkbox是否选中**************** */
function selAll(obj) {
	var o = document.getElementsByName("choose");
	for ( var i = 0; i < o.length; i++) {
		if (obj.checked == true)
			o[i].checked = true;
		else
			o[i].checked = false;
	}
}
// 判断是否全部被选中，如果选中全选复选框被选中，反之未被选中
function selFirst() {
	var o = document.getElementsByName("choose");
	var count = 0;
	var num = 0;
	for ( var i = 0; i < o.length - 1; i++) {
		if (o[i + 1].checked == true) {
			count++;
		}
		if (o[i + 1].checked == false) {
			num++;
		}
	}
	if (count == o.length - 1) {
		o[0].checked = true;
	}
	if (num > 0) {
		if (o[0].checked == true) {
			o[0].checked = false;
		}
	}
}

/*

 * href : title : tab title width: height:
 
function openDialog(href, title, width, height) {
	// content
	var dialogDiv = $("#content").find("#dialogDiv");
	if (dialogDiv.size() == 0) {
		$("#searchForm").before(
				"<div id='dialogDiv' style='width:820px;'></div>");
	}
	var mch = Math.round(Math.random() * 10000);
	if (href.indexOf('?') > -1) {
		href += "&mch=" + mch;
	} else {
		href += "?mch=" + mch;
	}

	if ($(".pagination").next().find("div").size() > 0) {

		$(".panel").eq(0).remove();
		$(".window-shadow").eq(0).remove();
		$(".window-mask").eq(0).remove();
		$(".pagination").next().find("div").each(function() {
			$(this).remove();
		});

		$(".pagination").find("div").each(function() {
			$(this).remove();
		});

		$(".panel").eq(0).remove();
		$(".window-shadow").eq(0).remove();
		$(".window-mask").eq(0).remove();
	}

	$('#dialogDiv').dialog({
		title : title,
		width : width,
		height : height,
		closed : false,
		cache : false,
		href : href,
		modal : true,
		onClose : function() {
			$("#content").find("#dialogDiv").remove();
			$(".pagination").next().remove();
			$(".pagination").next().remove();

		}
	});
	$(".panel").css("top", "0px");
	$(".window-shadow").css("top", "0px");
	//$(".panel-tool").css("display", "none");
}

// 关闭Dialog
function closeDialog() {
	$('#dialogDiv').dialog('close', true);
	$("#content").find("#dialogDiv").remove();
	$(".pagination").next().remove();
	$(".pagination").next().remove();
	$(".window-shadow").css("display", "none");
	$(".window-mask").css("display", "none");
	closeAllDiv();
}

function closeAllDiv() {
	$(".pagination").find("div").each(function() {
		$(this).remove();
	});
}*/

/*******验证身份证件号**********/
var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];// 加权因子   
var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];// 身份证验证位值.10代表X   
function IdCardValidate(idCard) {   
    idCard = trim(idCard.replace(/ /g, ""));   
    if (idCard.length == 15) {   
        return isValidityBrithBy15IdCard(idCard);   
    } else if (idCard.length == 18) {   
        var a_idCard = idCard.split("");// 得到身份证数组   
        if(isValidityBrithBy18IdCard(idCard)&&isTrueValidateCodeBy18IdCard(a_idCard)){   
            return true;   
        }else {   
            return false;   
        }   
    } else {   
        return false;   
    }   
}   
/**  
 * 判断身份证号码为18位时最后的验证位是否正确  
 * @param a_idCard 身份证号码数组  
 * @return  
 */  
function isTrueValidateCodeBy18IdCard(a_idCard) {   
    var sum = 0; // 声明加权求和变量   
    if (a_idCard[17].toLowerCase() == 'x') {   
        a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
    }   
    for ( var i = 0; i < 17; i++) {   
        sum += Wi[i] * a_idCard[i];// 加权求和   
    }   
    valCodePosition = sum % 11;// 得到验证码所位置   
    if (a_idCard[17] == ValideCode[valCodePosition]) {   
        return true;   
    } else {   
        return false;   
    }   
}   
/**  
 * 通过身份证判断是男是女  
 * @param idCard 15/18位身份证号码   
 * @return 'female'-女、'male'-男  
 */  
function maleOrFemalByIdCard(idCard){   
    idCard = trim(idCard.replace(/ /g, ""));// 对身份证号码做处理。包括字符间有空格。   
    if(idCard.length==15){   
        if(idCard.substring(14,15)%2==0){   
            return 'female';   
        }else{   
            return 'male';   
        }   
    }else if(idCard.length ==18){   
        if(idCard.substring(14,17)%2==0){   
            return 'female';   
        }else{   
            return 'male';   
        }   
    }else{   
        return null;   
    }   
}   
 /**  
  * 验证18位数身份证号码中的生日是否是有效生日  
  * @param idCard 18位书身份证字符串  
  * @return  
  */  
function isValidityBrithBy18IdCard(idCard18){   
    var year =  idCard18.substring(6,10);   
    var month = idCard18.substring(10,12);   
    var day = idCard18.substring(12,14);   
    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
    // 这里用getFullYear()获取年份，避免千年虫问题   
    if(temp_date.getFullYear()!=parseFloat(year)   
          ||temp_date.getMonth()!=parseFloat(month)-1   
          ||temp_date.getDate()!=parseFloat(day)){   
            return false;   
    }else{   
        return true;   
    }   
}   
  /**  
   * 验证15位数身份证号码中的生日是否是有效生日  
   * @param idCard15 15位书身份证字符串  
   * @return  
   */  
  function isValidityBrithBy15IdCard(idCard15){   
      var year =  idCard15.substring(6,8);   
      var month = idCard15.substring(8,10);   
      var day = idCard15.substring(10,12);   
      var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
      // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
      if(temp_date.getYear()!=parseFloat(year)   
              ||temp_date.getMonth()!=parseFloat(month)-1   
              ||temp_date.getDate()!=parseFloat(day)){   
                return false;   
        }else{   
            return true;   
        }   
  }   
//去掉字符串头尾空格   
function trim(str) {   
    return str.replace(/(^\s*)|(\s*$)/g, "");   
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

/***
 * 根据计划id查询专业类型
 * @param id
 * @param http
 * @param selectId
 * @param zylxId
 */
function findZyLxByJhId(id,http,selectId,zylxId)
{
	var selHtml ="<select name='zylx.id' id='zylxId1' onchange='lxChange(this.value)' class='input-xlarge required' style='width:220px;'>";
	selHtml += "<option value='' >请选择</option>";
	$("#"+selectId).empty();
	jQuery.ajax({
        type: "POST",
        url: http+"/zsdj/zsdj/findZyLxByJhId",
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
					}
					
				}
				selHtml +=" > "+result[i].zylxId.lxmc+"</option>";
			}
	   }
    });
	selHtml +="</select><span class='help-inline'><font color='red'>*</font> </span>";
	$("#"+selectId).html(selHtml);
	$("#zylxId1").select2();
	
	$("#zyid").select2("destroy");
	$("#zyid").find("option").each(function(index)
	{
		if(index>0)
		{
			$(this).remove();
		}
	});
	$("#zyid").find("option[value='']").attr("selected",true);
	$("#zyid").select2();
	
	$("#xzLab").html('');
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
	jQuery.ajax({
        type: "POST",
        url: http+"/zsdj/zsdj/findXueNianXueQiById",
        data: {id:id},
        dataType:'json',
        async:false,
		success: function(result){
			$("#"+labId).html(result.nf.xnmc);
			$("#"+inputId).val(result.nf.id);
	   }
    });
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
		jQuery.ajax({
	        type: "POST",
	        url: http+"/zsdj/zsdj/findZyXueZhiById",
	        data: {id:id},
	        dataType:'json',
	        async:false,
			success: function(result){
				$("#"+labId).html(result.xzmc);
				$("#"+inputId).val(result.xz);
		   }
	    });
		
	}else
	{
		$("#"+labId).html("");
		$("#"+inputId).val("");
	}
}

/**
 * 获取学生信息
 * @param http
 * @param njId
 * @param bjId
 * @param zyId
 * @returns {Boolean}
 */
function getXsJbxx(http,njId,bjId,zyId)
{
	var istrue = true;
	jQuery.ajax({
	        type: "POST",
	        url: http+"/xs/xsJbxx/getXsJbssList",
	        data: {njId:njId,bjId:bjId,zyId:zyId},
	        dataType:'json',
	        async:false,
			success: function(result){
				istrue = result.isTrue;
		   }
	    });
	return istrue;
}

function getZsjhList(http,id)
{
	var istrue = true;
	jQuery.ajax({
	        type: "POST",
	        url: http+"/zsjh/zsjh/getZsjhList",
	        data: {id:id},
	        dataType:'json',
	        async:false,
			success: function(result){
				istrue = result.isTrue;
		   }
	    });
	return istrue;
}




















