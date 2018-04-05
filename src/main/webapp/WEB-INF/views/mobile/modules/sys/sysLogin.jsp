<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.css">
    <script src="https://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <title>${fns:getConfig('productName')}</title>
       <!-- --------------消息提示插件    start----------------------------- -->
    <%-- <link rel="stylesheet" href="${ctxStatic}/mobile-js/example.css"> --%>
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="${ctxStatic}/mobile-js/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/mobile-js/sweetalert.css">
     <!-- ------------------------end------------------- -->
</head>
<body>
<section id="login_section">
    <header  data-role="header" style="background-color: #40ED9F;">
        <h1>${fns:getConfig('productName')}</h1>
    </header>
    <article data-scroll="true" id="login_article">
        <div data-role="main" class="ui-content">
            <form id="loginForm" action="${ctx}/login" method="post">
                <div class="ui-field-contain">
                        <label for="username">账号</label>
                        <input type="text" name="username" id="username" placeholder="请填写登录账号">
                </div>
                  <div class="ui-field-contain">
                  		<label for="password">密码</label>
                        <input type="password" name="password" id="password" placeholder="请填写登录密码">
                </div>
                <div  class="ui-field-contain" id="validateCodeDiv" style="display:none;">
                        <label class="input-label mid" for="validateCode">验证码</label>
                        <sys:validateCode name="validateCode" 
                        inputCssStyle="margin-bottom:0;" imageCssStyle="padding-top:7px;"/>
                </div>
                <input type="hidden" name="mobileLogin" value="true">
               <div class="ui-field-contain">
               			<!-- <input type="submit"  onclick="return check();"  value="登录" style="background-color: #40ED9F;"/> -->
                        <button type="submit"  onclick="return check();" style="background-color: #40ED9F;">登录</button>
                </div>
                
            </form>
        </div>
    </article>
</section>
<script type="text/javascript">
	$(document).ready(function(){
				$('#validateCodeDiv').show();
				$('#validateCodeDiv a').click();
				$("#validateCode").css("width","100%");
			});
               var sessionid = '${not empty fns:getPrincipal() ? fns:getPrincipal().sessionid : ""}';
               function check(){
	               var name=$("#username").val();
	               var pwd=$("#password").val();
	               if(name==""){
		               swal("请输入用户名","","error");
		               return false;
	               }else if(pwd==""){
						swal("请输入密码","","error");
						return false;
	               }else if ($('#validateCodeDiv').is(':visible') && $('#validateCode').val() == ''){
						swal("请填写验证码","", "error");
						return false;
					}else{
	               	var loginForm = $("#loginForm");
					$.post(loginForm.attr('action'), loginForm.serializeArray(), function(data){
						if (data && data.sessionid){
							sessionid = data.sessionid;
							//return true;
						}else{
							//swal(data.message);
							if(data.message!=null&&data.message!=""){
								swal({   
								title: "错误",  
								 text:data.message,   
								 type: "error",   
								 showCancelButton: false,   
								 confirmButtonColor: "#DD6B55",  
								  confirmButtonText: "确定",  
								   closeOnConfirm: false }, 
								   function(){   
								   		sessionid="";
								   		window.location.href="${ctx}/login";
								});
							}else{
								sessionid = data.sessionid;
							}
							//return false;
						}
						//console.log(data);
					});
							
	                	
	               }
             
               }
               </script>
</body>
</html>