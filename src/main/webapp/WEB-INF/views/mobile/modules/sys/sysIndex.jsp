<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<section id="index_section">
	<header>
        <h1 class="title">${fns:getConfig('productName')}</h1>
        <nav class="right">
            <a data-icon="plus" href="#" id="toAdd"></a>
        </nav>
    </header>
  <article class="active" id="list_article"  data-scroll="true">
         <br>
   		<form>
   			  <input id="myFilter"  type="search" placeholder="请输入姓名" >
	 	</form>
	 <!-- <ul class="list"	data-filter="true" data-input="#myFilter" 
					 data-autodividers="true" data-inset="true"> -->
        <ul class="list" >
            <!-- <li class="divider">学生姓名</li> -->
            <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
              <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
              <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
             <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
              <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
              <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
              <li data-icon="next">
            	<a href="#" data-target="section">
            	<span data-icon="user"></span>张三</a>
            </li>
        </ul>
    <a href="#" class="button block alizarin" id="btnLogout">退出</a>
    </article>
    <script type="text/javascript">
   		$('#btnLogout').tap(function(){
   			J.confirm('确认提示','确认要退出吗？',function(){
   				$.get("${ctx}/logout", function(){
   					sessionid = '';
   					J.showToast('退出成功！', 'success');
   					J.Router.goTo('#login_section');
   				});
   			});
   		});
   		
   		$('#toAdd').tap(function(){
   					J.Router.goTo('#toAdd_section');
   			});
    </script>
</section>