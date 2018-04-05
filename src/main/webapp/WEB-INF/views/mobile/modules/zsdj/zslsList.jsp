<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="https://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script
	src="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<title>${fns:getConfig('productName')}</title>
 <!-- --------------消息提示插件    start----------------------------- -->
    <%-- <link rel="stylesheet" href="${ctxStatic}/mobile-js/example.css"> --%>
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="${ctxStatic}/mobile-js/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/mobile-js/sweetalert.css">
     <!-- ------------------------end------------------- -->
</head>
<body>

	<div data-role="page">
		<section id="list_section">
			<script type="text/javascript">
	$(document).ready(function() {
	  $("#tian").on("click",function(){
		window.location="${ctx}/zsdj/zsdj/formMobile";
	});
	  $("#user").on("click",function(){
   					  swal({   
								title: "",  
								 text:'确定退出吗',   
								 type: "warning",   
								 showCancelButton: true,   
								 confirmButtonColor: "#DD6B55",  
								  confirmButtonText: "确定", 
								   cancelButtonText: "取消", 
								   closeOnConfirm: false }, 
								   function(){   
								   		$.get("${ctx}/logout", function(){
						   					sessionid = '';
						   					window.location.href="${ctx}/login";
						   				});
								   		
   				});
		});
	});
function toEdit(id){
	   window.location="${ctx}/zsdj/zsdj/formMobile?id="+id;
	}
	</script>
			<header data-role="header" style="background-color: #40ED9F;">
				<a href="#" 
				class="ui-btn ui-corner-all ui-shadow ui-icon-user ui-btn-icon-left" id="user">我</a>
				<h1>${fns:getConfig('productName')}</h1>
				
					<a href="#"
						class="ui-btn ui-corner-all ui-shadow ui-icon-plus ui-btn-icon-left ui-btn-right"
						id="tian">添加</a>
			
			</header>
			<div data-role="main" class="ui-content">
				<form class="ui-filterable">
					<input id="myFilter" data-type="search" placeholder="根据名称搜索..">
				</form>
				<ul data-role="listview" data-filter="true" data-input="#myFilter"
					data-autodividers="true" data-inset="true">
					<c:forEach items="${page.list}" var="zsdj">
						<li><a href="javascript:void(0);"
							onclick="toEdit('${zsdj.id}')"> ${zsdj.xm} </a></li>
					</c:forEach>
				</ul>
			</div>
		</section>
	</div>

</body>
</html>