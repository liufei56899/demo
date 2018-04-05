<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>西安音乐学院附属中等音乐学校智慧校园管理系统</title>
	<meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '1' : cookie.tabmode.value}"/>
    <c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
    <script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script></c:if>
	<link rel="icon" type="image/png" href="${ctxStatic}/img/favicon.png">
	<style type="text/css">
		#main {padding:0;margin:0;} #main .container-fluid{padding:0 4px 0 6px;}
		#header {margin:0 0 8px;position:static;} #header li {font-size:18px;_font-size:12px;}
		#header .brand {font-family:'Microsoft Yahei';font-size:26px;padding-left:33px;}
		#footer {margin:40px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
		#footer, #footer a {color:#999;} #left{overflow-x:hidden;overflow-y:auto;} #left .collapse{position:static;}
		#userControl>li>a{/*color:#fff;*/text-shadow:none;} #userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}
		#current_path{margin-top:5px;height: 30px;font-size:14px; border-bottom: 1px solid  #cfd4d8; text-indent: 20px;}
		.tabs>ul>li{
		  margin-top: 5px !important;
		}
		.jericho_tabs tab_selected{
		  margin-top: 5px !important;
		}
		#openClose{
		/*  box-shadow: 2px 5px 10px #555; */
		 position: relative;
		 z-index: 100;
		 margin-top: 66px;
		
		}
		#right{
		 position: relative;
		}
	    .accordion-heading>a{
	     color: #555;
	    }
	    #content_top_tzgg .title>p{
	     font-size: 14px;
	     font-weight: bold;
	    }
	    
	    
	</style>
	<script type="text/javascript" src="${ctxStatic}/main/main.js"></script>
	<script type="text/javascript">
	    var boo = false;
		$(document).ready(function() {
		    //显示时间:
		    //viewNyr("nyr"); 
		    //显示当前登录用户
		    $.ajaxSetup({ cache: false });
		    $.getJSON("${ctx}/sys/user/getUserDefault",function(result) {
			    //$("#login_name").text(result.username);
			    //$("#login_role").text(result.roleName);
			    //部门 + 姓名 + 职位
			    var html = result.officename+result.username+result.gwzym;
			    $("#user_officename").text(html);
			   /*  $("#user_name").text(result.username);
			    $("#user_zw").text(result.gwzym); */
		    });
			// <c:if test="${tabmode eq '1'}"> 初始化页签
			$.fn.initJerichoTab({
                renderTo: '#right',
                uniqueId: 'jerichotab',
                contentCss: { 'height': $('#right').height() - tabTitleHeight - 35 },
                loadOnce: true, 
                tabWidth: 110,
                titleHeight: tabTitleHeight,
                tabs: []
            });//</c:if>
			// 绑定菜单单击事件
			var boo3 = false;
			$("#menu a.menu").click(function(){
				// 一级菜单焦点
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				// 左侧区域隐藏
				if ($(this).attr("target") == "mainFrame"){
					$("#left,#openClose").hide();
					wSizeWidth();
					// <c:if test="${tabmode eq '1'}"> 隐藏页签
					$(".jericho_tab").hide();
					$("#mainFrame").show();//</c:if>
					return true;
				}
				// 左侧区域显示
				$("#left,#openClose").show();
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
				// 显示二级菜单
				var menuId = "#menu-" + $(this).attr("data-id");
				if ($(menuId).length > 0){
					$("#left .accordion").hide();
					$(menuId).show();
					// 初始化点击第一个二级菜单
					if (!$(menuId + " .accordion-body:first").hasClass('in')){
						$(menuId + " .accordion-heading:first a").click();
					}
					if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
						$(menuId + " .accordion-body a:first i").click();
					}
					// 初始化点击第一个三级菜单
					$(menuId + " .accordion-body li:first li:first a:first i").click();
				}else{
					// 获取二级菜单数据
					$.get($(this).attr("data-href"), function(data){
						if (data.indexOf("id=\"loginForm\"") != -1){
							/* alert('未登录或登录超时。请重新登录，谢谢！'); */
							top.location = "${ctx}";
							return false;
						}
						$("#left .accordion").hide();
						$("#left").append(data);
						// 链接去掉虚框
						$(menuId + " a").bind("focus",function() {
							if(this.blur) {this.blur()};
						});
						// 二级标题
						$(menuId + " .accordion-heading a").click(function(){
							$(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
							if(!$($(this).attr('data-href')).hasClass('in')){
								$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
							}
						});
						// 二级内容
						$(menuId + " .accordion-body a").click(function(){
							$(menuId + " li").removeClass("active");
							$(menuId + " li i").removeClass("icon-white");
							$(this).parent().addClass("active");
							$(this).children("i").addClass("icon-white");
						});
						// 展现三级
						$(menuId + " .accordion-inner a").click(function(){
							var href = $(this).attr("data-href");
							if($(href).length > 0){
								$(href).toggle().parent().toggle();
								return false;
							}
							// <c:if test="${tabmode eq '1'}"> 打开显示页签
							return addTab($(this)); // </c:if>
						});
						// 默认选中第一个菜单
						if(!boo){
						  mainPage();
						  boo = true;
						}
						if(boo3==false){
						  boo3==true;
						  $("#openClose").removeClass().addClass("open");
						}
					    if(boo3==true){
						   $(menuId + " .accordion-body a:first i").click(); 
						   $("#openClose").removeClass().addClass("close");
						}
						$(menuId + " .accordion-body li:first li:first a:first i").click();
						//设置实体颜色
						$("#menu li a").css("color","black");
						
					});
				}
				// 大小宽度调整
				wSizeWidth();
				return false;
			});
			function mainPage(){
			     $("#current_path").text("");
			  	 $(".jericho_tab").show();
			     $("#mainFrame").hide();
			     $.fn.jerichoTab.addTab({
                      title: "主页",
                      name: "当前位置:主页",
                      closeable: false,
                      data: {
                        dataType: "iframe",
                        dataLink: "${ctx}/sys/user/mainpage"
                      }
                }).loadData(true);
                $("#current_path").text("当前位置:主页".trim());
             	$("div[title='主页']").bind("click",function(){
             		if(!$("#openClose").hasClass("open")){
						$("#openClose").click();
					}else{
						$("#openClose").attr("class","close");
						$("#openClose").click();
					}
				});
			}
			// 初始化点击第一个一级菜单
			$("#menu a.menu:first span").click();
			// <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
			$("#userInfo .dropdown-menu a").mouseup(function(){
			    $("#userInfo .dropdown-menu").css("display","none");
				return addTab($(this), true);
			});// </c:if>
			$(".dropdown-menu").mouseleave(function(){
			   $("#userInfo .dropdown-menu").css("display","none");
			   return false;
			});
			/* // 鼠标移动到边界自动弹出左侧菜单
			$("#openClose").mouseover(function(){
				if($(this).hasClass("open")){
					$(this).click();
				}
			}); */
			// 获取通知数目  <c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
			function getNotifyNum(){
				$.get("${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
					var num = parseFloat(data);
					if (num > 0){
						$("#notifyNum,#notifyNum2").show().html("("+num+")");
					}else{
						$("#notifyNum,#notifyNum2").hide()
					}
				});
			}
			getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
			setInterval(getNotifyNum, "${oaNotifyRemindInterval}"); //</c:if>
		});
		// <c:if test="${tabmode eq '1'}"> 添加一个页签
		function addTab($this, refresh){
		   //设置当前位置
           var tt  = $this.parent().parent().parent().parent().parent().children(".accordion-heading").children().text().trim();           
           var t2  = $("#menu").children("li.active").text().trim();
          
			$(".jericho_tab").show();
			$("#mainFrame").hide();
			$.fn.jerichoTab.addTab({
                tabFirer: $this,
                title: $this.text(),
                name: (t2+">"+tt).trim(),
                closeable: true,
                data: {
                    dataType: 'iframe',
                    dataLink: $this.attr('href')
                }
            }).loadData(refresh);

            $("#current_path").text("当前位置:".trim());
            var location = (t2 + ">"+tt+">"+$this.text()).trim()
            $("#current_path").append(location);
            
			return false;
		}// </c:if>
		
		$(function () {
			$("#menu li a").click(function(){
			    $(this).addClass("lg-active").parent("li").siblings("li").children("a").removeClass("lg-active"); 
			});
		
            $(".dropdown-toggle").click(function () {
                $(".nav-bar_").stop().slideToggle(500);
            });
		})
		
		/**
		  快捷菜单的tab
		*/
		function tabKjcd(title,name,link)
		{	
			 $.fn.jerichoTab.addTab({
                      title: title,
                      name: name,
                      closeable: true,
                      data: {
                        dataType: "iframe",
                        dataLink: link
                      }
              }).loadData(true);
              $("#current_path").text("当前位置:"+name+"".trim());
		}
		
		
		function menuSheZhi()
		{
			 $.fn.jerichoTab.addTab({
                      title: "快捷菜单",
                      name: "快捷菜单",
                      closeable: true,
                      data: {
                        dataType: "iframe",
                        dataLink: "${ctx}/kjcdsz/sysMenu/"
                      }
              }).loadData(true);
              $("#current_path").text("当前位置:快捷菜单".trim());
		}
		
	    //修改密码
		function modifyPwd(){
		   var flag = $("#hPassword").val();
		   var lastTabL = $.fn.jerichoTab.tabpage.children("li").filter(".jericho_tabs").length;
		   if(flag.length==0){
		       $.fn.jerichoTab.addTab({
                      title: "修改密码",
                      name: "修改密码",
                      closeable: true,
                      data: {
                        dataType: "iframe",
                        dataLink: "${ctx}/sys/user/modifyPwd"
                      }
              }).loadData(true);
              $("#current_path").text("当前位置:修改密码".trim());
              $("#hPassword").val("jerichotab_"+lastTabL);
		   }else if(flag.length > 0){
		      var f = panduancolse(flag);
		      if(f==false){
		          $.fn.jerichoTab.addTab({
                      title: "修改密码",
                      name: "修改密码",
                      closeable: true,
                      data: {
                        dataType: "iframe",
                        dataLink: "${ctx}/sys/user/modifyPwd"
                      }
                  }).loadData(true);
                  $("#current_path").text("当前位置:修改密码".trim());
                  $("#hPassword").val("jerichotab_"+lastTabL);
		      }else{
		          var t  =  chuliAddTab(flag);
		          setTabActiveLoad(t);
		      }
		   }
		 }
		 
		 function setTabActiveLoad(t){
		   t = t.substr(t.indexOf("_")+1,t.length);
           $.fn.setTabActive(t).loadData(false);
           
           /***************功能为完成,后续修改****************************/
           /*  var lastTab2 = $.fn.jerichoTab.tabpage.children("li").filter(".jericho_tabs")
            for(var i=0;i<lastTab2.length;i++){
                if(t==lastTab2[i].id){
                alert("90909"+JSON.stringify(lastTab2[i]));
                   if (lastTab2[i].hasClass('tab_selected'))
                       lastTab2[i].swapClass('tab_selected', 'tab_unselect');
                   else if (lastTab2[i].hasClass('tab_unselect'))
                       lastTab2[i].swapClass('tab_unselect', 'tab_selected');
                }
            } */
           
		 }
		 
		 function panduancolse(flag){
		   var lastTab2 = $.fn.jerichoTab.tabpage.children("li").filter(".jericho_tabs")
           for(var i=0;i<lastTab2.length;i++){
                if(flag==lastTab2[i].id){
                   return true;
                }
           }
		  return false;
		 }
		 
		 function chuliAddTab(flag){
           var lastTab2 = $.fn.jerichoTab.tabpage.children("li").filter(".jericho_tabs");
           for(var i=0;i<lastTab2.length;i++){
                var id = lastTab2[i].id;
                if(flag==id){
                  return lastTab2[i].id;
                }
           }
		 }
	</script>
</head>
<body>
<div id="main">
    <!-- 显示顶部信息 -->
	<div id="main_top">
	   <div class="top-left"></div>
       <div class="top-right">
        <div class="right-top">
            <!-- <span id="login_name" style="margin-right: 15px;">招生办主任 </span>
            <span id="nyr">2016年7月22日</span> -->
            <!-- <span id="login_role" style="margin-right: 15px;"></span>
            <span id="login_zw"></span> -->
            <div style="text-align: center;">
            <span id="user_officename" style="margin-right: 15px;"></span>
            <!-- <span id="user_name" ></span>
            <span id="user_zw" style="margin-right: 15px;"></span> -->
            </div>
            <!-- <span id="nyr">2016年7月22日</span> -->
        </div>
        <div class="right-down">
            <ul>
                <li><i class="icon1"></i><a href="${ctx}/sys/role/zxbzpage" target="_blank">帮助</a></li>
                <li><i class="icon2"></i><a href="#" onclick="modifyPwd();">修改密码</a><p id="hPassword" style="visibility: hidden;"></p></li>
                <li style="border-right: none;"><i class="icon3"></i><a href="${ctx}/logout" title="退出登录">退出</a></li>
            </ul>
        </div>
       </div>
	</div>
	<!-- 导航树信息 显示 -->
	<div class="nav-lg-list">
		     	<ul id="menu" >
						<c:set var="firstMenu" value="true"/>
						<c:set value="0" var="indexMenu"/>
						<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus" >
							<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
								<c:if test="${indexMenu eq '0' }">
									<li class="menu ${not empty firstMenu && firstMenu ? 'active' : ''}">
										<c:if test="${empty menu.href}">
											<a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
										</c:if>
										<c:if test="${not empty menu.href}">
											<a class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
										</c:if>
									</li>
									<c:set value="${idxStatus.index}" var="indexMenu"/>
								</c:if>
								
								<c:if test="${indexMenu ne idxStatus.index }">
									<li class="menu ${not empty firstMenu && firstMenu ? 'active' : ''}">
										<c:if test="${empty menu.href}">
											<a class="menu " href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
										</c:if>
										<c:if test="${not empty menu.href}">
											<a class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
										</c:if>
									</li>
								</c:if>
								
									<c:if test="${firstMenu}">
										<c:set var="firstMenuId" value="${menu.id}"/>
									</c:if>
									<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:forEach>
					</ul>
	    </div>
	<!-- 显示内容 -->
	<style>
	   .gncd_{
	      height: 50px;
	    }
	    .gncd_>span{
	     display: block;
	     line-height: 50px;
	    }
	    .gncd_>span.gncd{
	     float: left;
	    font-size: 16px;
	    font-weight: bold;
	    margin-left: 15px;
	    }
	    .gncd_>span.nav_ico{
	     float: right;
	     width: 70px;
	    }
	    .gncd_>span.nav_ico>a:hover{
	     text-decoration: none;
	    }
	    .gncd_>span.gncd>a>img,.gncd_>span.nav_ico>a>img{
	     margin: 0;
	    }
	</style>
	<div class="container-fluid">
			<div id="content" class="row-fluid">
				<div id="left">
				   <div>
				      <div class="gncd_">
				        <span class="gncd">功能菜单</span>
				        <span class="nav_ico" style="width: 35px;">
				          <%-- <a href="#" style="margin-right: 12px;">
				          <img alt="log1" src="${ctxStatic}/lg-images/icon-1.png">
				          </a>  --%>
				         <%--  <a href="javaScript:void(0);" style="margin-right: 12px;" onclick="menuSheZhi();">
				          	<img alt="log2" src="${ctxStatic}/lg-images/icon-2.png">
				          </a> --%>
				        </span>
				      </div>
				   </div>
				    <%-- 
					<iframe id="menuFrame" name="menuFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="650"></iframe> --%>
				</div>
				<div id="openClose" class="close">&nbsp;</div>
				
				<div id="right">
				    <div id="current_path">当前位置</div>
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
				</div>
				
			</div>
		    <div id="footer" >
	            Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')}
			</div>
		</div>
</div>
	<script type="text/javascript"> 
	    var boo2 = false;
		var leftWidth = 200; // 左侧窗口大小
		var tabTitleHeight = 33; // 页签的高度
		var htmlObj = $("html"), mainObj = $("#main");
		var headerObj = $("#main_top"), footerObj = $("#footer");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var minHeight = 600, minWidth = 980;
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
			mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
			frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height() - footerObj.height() - (strs[1] < minWidth ? 42 : 28));
			$("#openClose").height($("#openClose").height() - 5);// <c:if test="${tabmode eq '1'}"> 
			$(".jericho_tab iframe").height($("#right").height() - tabTitleHeight); // </c:if>
			wSizeWidth();
		}
		function wSizeWidth(){
			if (!$("#openClose").is(":hidden")){
				if(boo2==false){
			       $("#left").width(0);
			       boo2 = true;
			    }
				var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
				$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			}else{
	            var ttt = $("#current_path").text();
			    if(ttt.match("当前位置:")){
			       $("#left").width(200);
			    }
				$("#right").width("90%");
			}
		}// <c:if test="${tabmode eq '1'}"> 
		function openCloseClickCallBack(b){
			$.fn.jerichoTab.resize();
		} // </c:if>
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>


</body>
</html>