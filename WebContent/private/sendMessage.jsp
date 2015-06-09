<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="company.model.*,company.model.util.*,java.util.*,java.text.DateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="generator" content="Bootply" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/styles.css" rel="stylesheet">
<% 		  String path = "";
		  String name = "";
		  String title = "";
		  Date date = new Date();
		  DateFormat df = DateFormat.getDateInstance();
          if(session.getAttribute("type").equals("Admin")){
        	  Admin admin = ManagedAdminBean.getById(Integer.parseInt(session.getAttribute("user").toString()));
        	  if(admin != null){
        	  path = "./admin";
        	  name=admin.getName();
        	  title="Administriation";
        	  }
          } else { 
  			out.print("<script>alert('No permission!');window.location.href='"+request.getContextPath()+"/login.html';</script>");
          } %>
<title><%=title%></title>
</head>
<body>
<!-- Header -->
<div id="top-nav" class="navbar navbar-inverse navbar-static-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href=<%=path+".jsp"%>><%=title%></a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a class="dropdown-toggle" role="button" data-toggle="dropdown" href=<%=path+".jsp"%>><i class="glyphicon glyphicon-user"></i><%=name%></a>
				
        </li>
        <li><a href="../logout"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>
      </ul>
    </div>
  </div><!-- /container -->
</div>
<!-- /Header -->

<!-- Main -->
<div class="container-fluid">
<div class="row">
	<div class="col-sm-3">
      <!-- Left column -->
      <a href="#"><strong><i class="glyphicon glyphicon-wrench"></i> Tools</strong></a>  
      
      <hr>
      
      <ul class="list-unstyled">
        <li class="nav-header"> <a href="#" data-toggle="collapse" data-target="#userMenu">
          <h5>Settings</h5>
          </a>
            <ul class="list-unstyled collapse in" id="userMenu">
                <li class="active"> <a href=<%=path+".jsp"%>><i class="glyphicon glyphicon-home"></i> Home</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-envelope"></i> Messages <span class="badge badge-info">4</span></a></li>
                <li><a href=<%=path+"Profile.jsp"%>><i class="glyphicon glyphicon-user"></i> Profile</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-flag"></i> Reports</a></li>
                <li><a href="../logout"><i class="glyphicon glyphicon-off"></i> Logout</a></li>
            </ul>
        </li>
      </ul>
           
      <hr>
      
  	</div><!-- /col-3 -->
    <div class="col-sm-7">
      	
      <!-- column 2 -->	
      <a href=<%=path+".jsp"%>><strong><i class="glyphicon glyphicon-dashboard"></i> Add Message</strong></a>  
      
      	<hr>
      		<!-- 加载编辑器的容器 -->
      <div class="form-group">
		<form action="../addNotice" method="post" class="form-horizontal">  
			<div class="form-group">
		    	<label for="user" class="col-sm-2 control-label">Receiver Type </label>
		    		<div class="col-sm-6">
			      	<select id="accountType" name="accountType">
					  <option value="Employee">Employee</option>
					  <option value="Manager">Manager</option>
					  <option value="Admin">Admin</option>
				   </select>
				   </div>
			</div>
			
			<div class="form-group">
		    	<label for="user" class="col-sm-2 control-label">Receiver ID</label>
		    	<div class="col-sm-4">
		      	<input type="text" class="form-control" name="id" placeholder="ID" >
		      	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="user" class="col-sm-2 control-label">Title</label>
		    	<div class="col-sm-4">
		      	<input type="text" class="form-control" name="title" placeholder="ID" >
		      	</div>
		  	</div>
			
			<hr><br><br>
		 	<div class="form-group">
           		<script id="container" name="content" type="text/plain" style="width:100%;height:300px"></script>
           	</div>
           	<br>
           	<div class="form-group">
    			<a href="#"><button class="btn btn-primary" type="submit">Submit</button></a>
  			</div>
        </form> 
        <hr>
              
  	</div><!--/col-span-9-->
</div>
</div>
</div>
<!-- /Main -->


<!-- 配置文件 -->
<script type="text/javascript" src="../uEditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="../uEditor/ueditor.all.js"></script>
<!-- 实例化编辑器 -->
<script type="text/javascript">
    var ue = UE.getEditor('container');
</script>

</body>
</html>