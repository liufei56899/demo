/*
	EasyUI 自带验证框使用方法: 
		missingMessage：未填写时显示的信息 
		validType：验证类型见下示例 
		invalidMessage：无效的数据类型时显示的信息 
		required="true" 必填项 
		class="easyui-validatebox" 文本验证 
		class="easyui-numberbox" 数字验证 、
	
	以下扩展验证
	作者：强子
	时间：2014-5-29
*/
$.extend($.fn.validatebox.defaults.rules, {
   idcard : {// 验证身份证 
        validator : function(value) { 
            return IdCardValidate(value); 
        }, 
        message : '身份证号码格式不正确' 
    },
    minLength:{
        validator: function(value, param){
            return value.length >= param[0];
        },
        message: '请输入至少{0}个字符.'
    },
    maxLength:{
        validator: function(value, param){
            return value.length <= param[0];
        },
        message: '请输入至多{0}个字符.'
    },
    length:{
    	validator:function(value,param){ 
        	var len=$.trim(value).length; 
            return len>=param[0]&&len<=param[1]; 
        }, 
        message:"输入内容长度必须介于{0}和{1}之间." 
    },
    phone : {// 验证电话号码 
        validator : function(value) { 
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value); 
        }, 
        message : '格式不正确,请使用下面格式:020-88888888' 
    }, 
    mobile : {// 验证手机号码 
        validator : function(value) { 
    		return /^1\d{10}$/i.test(value);
        }, 
        message : '手机号码格式不正确' 
    }, 
    mobileAndPhone : { //验收手机号码或固定电话
    	validator : function(value) { 
    		return /^1\d{10}$/i.test(value) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
        }, 
        message : '请输入正确的手机号码或固定电话' 
    },
    intOrFloat : {// 验证整数或小数 
        validator : function(value) { 
            return /^\d+(\.\d+)?$/i.test(value); 
        }, 
        message : '请输入数字，并确保格式正确' 
    }, 
    numberFw:{
    	validator:function(value,param){ 
        	var num=parseFloat(value); 
            return num>=param[0] && num<=param[1]; 
        }, 
        message:"输入数值必须介于{0}和{1}之间." 
    },
    min:{
    	validator:function(value,param){ 
	    	var num=parseFloat(value); 
	    	return num>=param[0]; 
	    }, 
	    message:"请输入最小是{0}的数值." 
    },
    max:{
    	validator:function(value,param){ 
	    	var num=parseFloat(value); 
	    	return num<=param[0]; 
	    }, 
	    message:"请输入最大是{0}的数值." 
    },
    currency : {// 验证货币 
        validator : function(value) { 
            return /^\d+(\.\d+)?$/i.test(value); 
        }, 
        message : '货币格式不正确' 
    }, 
    qq : {// 验证QQ,从10000开始 
        validator : function(value) { 
            return /^[1-9]\d{4,9}$/i.test(value); 
        }, 
        message : 'QQ号码格式不正确' 
    }, 
    integer : {// 验证整数 
        validator : function(value) { 
            return /^[+]?[1-9]+\d*$/i.test(value); 
        }, 
        message : '请输入整数' 
    }, 
    age : {// 验证年龄
        validator : function(value) { 
            return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value); 
        }, 
        message : '年龄必须是0到120之间的整数' 
    }, 
    
    chinese : {// 验证中文 
        validator : function(value) { 
            return /^[\Α-\￥]+$/i.test(value); 
        }, 
        message : '请输入中文' 
    }, 
    english : {// 验证英语 
        validator : function(value) { 
            return /^[A-Za-z]+$/i.test(value); 
        }, 
        message : '请输入英文' 
    }, 
    unnormal : {// 验证是否包含空格和非法字符 
        validator : function(value) { 
            return /.+/i.test(value); 
        }, 
        message : '输入值不能为空和包含其他非法字符' 
    }, 
    username : {// 验证用户名 
        validator : function(value) { 
            return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value); 
        }, 
        message : '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）' 
    }, 
    faxno : {// 验证传真 
        validator : function(value) { 
//            return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value); 
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value); 
        }, 
        message : '传真号码不正确' 
    }, 
    zip : {// 验证邮政编码 
        validator : function(value) { 
            return /^[1-9]\d{5}$/i.test(value); 
        }, 
        message : '邮政编码格式不正确' 
    }, 
    ip : {// 验证IP地址 
        validator : function(value) { 
            return /d+.d+.d+.d+/i.test(value); 
        }, 
        message : 'IP地址格式不正确' 
    }, 
    name : {// 验证姓名，可以是中文或英文 
        validator : function(value) { 
            return /^[\Α-\￥]+$/i.test(value)|/^\w+[\w\s]+\w+$/i.test(value); 
        }, 
        message : '请输入姓名' 
    },
    date : {// 验证日期
        validator : function(value) { 
         //格式yyyy-MM-dd或yyyy-M-d
            return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value); 
        },
        message : '清输入合适的日期格式'
    },
    msn:{ 
        validator : function(value){ 
        return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value); 
    }, 
    message : '请输入有效的msn账号(例：abc@hotnail(msn/live).com)' 
    },
    same:{ 
        validator : function(value, param){ 
            if($("#"+param[0]).val() != "" && value != ""){ 
                return $("#"+param[0]).val() == value; 
            }else{ 
                return true; 
            } 
        }, 
        message : '两次输入的密码不一致！'    
    },
    pdfFileType:{ // 验证文件格式PDF
        validator : function(value){
        	var result=true;
        	if(value!=''){
	        	var fileType=value.substring(value.lastIndexOf("."),value.length);
				fileType=fileType.toUpperCase();
				if(fileType!='.PDF'){
					result=false;
				}
           	}
           	return result;
        }, 
        message : '请选择格式为PDF的文件.'    
    },
    double:{ //两位小数
        validator : function(value){ 
        	return /^([1-9]\d*(\.\d{1,2})?$)|^(0\.\d{1,2}$)|^0$/.test(value);
        },
        message : '请输入最多2位小数的数字.'
    },
    floatSix:{ //6位小数
        validator : function(value){ 
        	return /^([1-9]\d*(\.\d{1,6})?$)|^(0\.\d{1,6}$)|^0$/.test(value);
        },
        message : '请输入最多6位小数的数字.'
    },
    buChongFu:{ //重复值验证
        validator : function(value,param){ 
	        var name=param[0];
			var ret=true;
			if(jQuery(this).is('select')){
				ret=checkSelectShiFouChongFu(name);
			}else{
				ret=checkInputShiFouChongFu(name);
			}
			return ret;
		},
        message : '不能出现重复的值.'
    },
    remote: { //异步验证
        validator: function(value,param){
            var result=true;
            var mch= Math.round(Math.random() * 10000); 
            var datastr="validateparam1="+value;
            if(param.length==3){
            	datastr+="&validateparam2="+$("#"+param[2]).val();
            }
            datastr+="&mch="+mch;
            datastr=encodeURI(datastr);
            jQuery.ajax({
		        type: "POST",
		        url: param[0],
		        data: datastr,
		        dataType:'json',
		        async:false,
				success: function(retjson){
					if(retjson){
						result=true;
					}else{
						result=false;
					}
			   }
		    });
		    return result;
            
        },
        message: '{1}已存在'
    }
});


//验证input textarea重复
function checkInputShiFouChongFu(validatename){
	var ret=true;
	var evs=jQuery("[validatename='"+validatename+"']");
	var evsClone=evs.clone();
	evs.each(function(){
		var nowSfzh= jQuery(this);
		var count=0;
		evsClone.each(function(){
			if(jQuery(this).val()==nowSfzh.val() && nowSfzh.val()!=''){
				count++;
				if(count>1){
					ret=false;
				}
			}
		});
		
		
	});
	return ret;
	
}
//验证select重复
function checkSelectShiFouChongFu(validatename){
	var ret=true;
	var evs=jQuery("[validatename='"+validatename+"'] option:selected");
	var evsClone=evs.clone();
	evs.each(function(){
		var nowSfzh= jQuery(this);
		var count=0;
		evsClone.each(function(){
			if(jQuery(this).val()==nowSfzh.val() && nowSfzh.val()!=''){
				count++;
				if(count>1){
					ret=false;
				}
			}
		});
		
	});
	return ret;
}

/**  
 * 创建人 : 强当安
 * 身份证号验证入口方法 : IdCardValidate(idCard) idCard :18或15位身份证号
 * 
 * 身份证15位编码规则：dddddd yymmdd xx p   
 * dddddd：地区码   
 * yymmdd: 出生年月日   
 * xx: 顺序类编码，无法确定   
 * p: 性别，奇数为男，偶数为女  
 * <p />  
 * 身份证18位编码规则：dddddd yyyymmdd xxx y   
 * dddddd：地区码   
 * yyyymmdd: 出生年月日   
 * xxx:顺序类编码，无法确定，奇数为男，偶数为女   
 * y: 校验码，该位数值可通过前17位计算获得  
 * <p />  
 * 18位号码加权因子为(从右到左) Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2,1 ]  
 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]   
 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )   
 * i为身份证号码从右往左数的 2...18 位; Y_P为脚丫校验码所在校验码数组位置  
 *   
 */  
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
//  可对传入字符直接当作数组来处理   
// if(idCard.length==15){   
// alert(idCard[13]);   
// if(idCard[13]%2==0){   
// return 'female';   
// }else{   
// return 'male';   
// }   
// }else if(idCard.length==18){   
// alert(idCard[16]);   
// if(idCard[16]%2==0){   
// return 'female';   
// }else{   
// return 'male';   
// }   
// }else{   
// return null;   
// }   
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
 * 删除tr
 * @param ev:img对象（this）
 */
function deleteTr(ev){
	var tbody=jQuery(ev).parent().parent().parent();
	var thisTr=jQuery(ev).parent().parent();
	thisTr.remove();
	var index=0;
	tbody.find("tr").each(function(){
	   if(index>0){
	   		var tr=jQuery(this);
	   		var inputs=tr.find("input");
	   		var selects=tr.find("select");
	   		var textAreas=tr.find("textArea");
	   		setNameIndex(inputs,index-1);
	   		setNameIndex(selects,index-1);
	   		setNameIndex(textAreas,index-1);
	   }
	   index++;
	});
}
/*	
添加TR 
tbody    要添加在的tbody对象 
tr       要添加的tr对象 
trsize   最多允许添加的tr数量
addname  添加的名称
*/
function addTr(tbody,tr,trsize,addname){
	if(trsize>0){
		var trs=tbody.children("tr");
		if(trs.size()>trsize){
			alert(addname);
			return false;
	    }
	    
	}
	var trhtml="<tr>"+tr.html()+"</tr>";
	tbody.append(trhtml);
	var index=0;
	tbody.find("tr").each(function(){
	   if(index>0){
	   		var tr=jQuery(this);
	   		var inputs=tr.find("input");
	   		var selects=tr.find("select");
	   		var textAreas=tr.find("textArea");
	   		setNameIndex(inputs,index-1);
	   		setNameIndex(selects,index-1);
	   		setNameIndex(textAreas,index-1);
	   }
	   index++;
	});
	return true;
}
function setNameIndex(evs,index){
	evs.each(function(){
		var name=jQuery(this).attr("name");
		if(typeof(name) == "undefined"){
			name="";
		}
		if(name.indexOf(".")>-1){
			var strs1=name.split(".");
			//alert(name);
			var strs2=name.split("[")
			var newname = strs2[0]+"["+index+"]."+[strs1[1]];
			//alert(newname);
			jQuery(this).attr("name",newname);
		}
	});
	
}
