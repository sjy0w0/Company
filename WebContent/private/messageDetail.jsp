<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="company.model.*,company.model.util.*,java.util.*,java.text.*"%>
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
		  String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		  if(session.getAttribute("type").equals("Admin")){
        	  Admin admin = ManagedAdminBean.getById(Integer.parseInt(session.getAttribute("user").toString()));
        	  if(admin != null){
        	  path = "./admin";
        	  name=admin.getName();
        	  title="Administriation";
        	  }
          } else if(session.getAttribute("type").equals("Manager")){
        	  Manager manager = ManagedManagerBean.getById(Integer.parseInt(session.getAttribute("user").toString()));
              if(manager != null){
            	path = "./manager";
            	name = manager.getName();
            	title = "Manager";
              }
            }else if(session.getAttribute("type").equals("Employee")){
              Employee employee = ManagedEmployeeBean.getById(Integer.parseInt(session.getAttribute("user").toString()));
            	  if(employee != null){
            	  path = "./employee";
            	  name=employee.getName();
            	  title="Employee";
            	  }
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
                <li><a href="./messageIndex.jsp"><i class="glyphicon glyphicon-envelope"></i> Messages <span class="badge badge-info">
				<% 
				List<Message> messages=null;
				Message message=null; 
				try{
			  		messages = ManagedMessageBean.getByToTypeIdStatus(session.getAttribute("type").toString(),
			  				Integer.parseInt(session.getAttribute("user").toString()),"YES");
					String messageId =request.getParameter("messageId");
					message = ManagedMessageBean.getMessageById(Integer.parseInt(messageId));
				}catch(Exception e){}
			  	%>
			  	<%=messages.size()%>
			  	</span></a></li>
                <li><a href=<%=path+"Profile.jsp"%>><i class="glyphicon glyphicon-user"></i> Profile</a></li>
                <li><a href="./management.jsp"><i class="glyphicon glyphicon-cog"></i> Management</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-flag"></i> Reports</a></li>
                <li><a href="../logout"><i class="glyphicon glyphicon-off"></i> Logout</a></li>
            </ul>
        </li>
      </ul>
           
      <hr>
      
  	</div><!-- /col-3 -->
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
    <div class="col-sm-9">
      	
      <!-- column 2 -->	
      <a href=<%=path+".jsp"%>><strong><i class="glyphicon glyphicon-dashboard"></i> Message</strong></a>  
      
      	<hr>
      
		<div class="row">
            <!-- center left-->	
            <div class="col-md-7">
            	<a href="./messageIndex.jsp"><strong> Message(Message Id:<%=message.getMessageId() %>)</strong></a>  
			  <br><br>
              <div class="panel panel-default">
                    
                  <div class="panel-heading"><h5>Title: <%=message.getTitle() %> 
                  <h5>From:<%=message.getFtype() %> <%=message.getFid() %>
                  &nbsp&nbsp&nbsp&nbsp Date: <%=message.getDate() %></h5>
                  </div>
                  <div class="panel-body">
                  	<%=message.getContent()%>
                  <br><br>
                  </div>
              	</div>     
            </div>
         	<div class="col-md-7">
			  <div class="form-group">
    			<a href="./sendMessage.jsp?rType=<%=message.getFtype()%>&rId=<%=message.getFid()%>"><button class="btn btn-primary" type="button">Reply</button></a>
  			  </div>  
          	</div><!--/col-->
        	
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