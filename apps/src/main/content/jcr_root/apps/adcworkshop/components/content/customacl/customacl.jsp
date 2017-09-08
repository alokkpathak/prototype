<%--
    * Copyright (c)  Vorwerk POC
    * Program Name :  subMenus.jsp
        * Application  :  Vorwerk POC
            * Purpose      :  See description
                * Description  :  Lists childpages of topmenu.
                    * Modification History:
* ---------------------
    *    Date                                Modified by                                       Modification Description
    *-----------                            ----------------                                    -------------------------
    * 04-Jan-2017                  Cognizant Technology solutions            					Initial Creation
    *-----------                           -----------------                                    -------------------------
    --%>

    
<%@include file="/apps/adcworkshop/components/shared/global.jsp" %>
<%@page import="java.util.*, 
    			javax.jcr.*, 
				javax.jcr.query.*,
			    javax.jcr.security.AccessControlManager,
				javax.jcr.security.AccessControlPolicy,
				org.apache.jackrabbit.api.security.JackrabbitAccessControlPolicy,
				org.apache.jackrabbit.api.security.JackrabbitAccessControlList,com.day.cq.wcm.api.WCMMode"

%>
<%
    final String pagePath = properties.get("pagePath", String.class);
	String[] groups = {"groupNameText","groupNameLabelText"};

	pageContext.setAttribute("groups", groups);

boolean isEdit = WCMMode.fromRequest(request) == WCMMode.EDIT;
boolean isDesign = WCMMode.fromRequest(request) == WCMMode.DESIGN;

    %>
	<adc:multicompositefield var="groupsList" fieldNodeName="groups" fieldPropertyNames="${groups}" returnType="List" />
	<%
    Session session = resourceResolver.adaptTo(Session.class);
    session = resourceResolver.adaptTo(Session.class);
	QueryManager queryManager = session.getWorkspace().getQueryManager();
    String sqlStatement="";
    sqlStatement = "SELECT * FROM [nt:base] AS s WHERE ISDESCENDANTNODE(["+pagePath+"/jcr:content]) and CONTAINS(s.*, 'adcworkshop/components')";
    
    Query query = queryManager.createQuery(sqlStatement,"JCR-SQL2");

    //Execute the query and get the results ...
    QueryResult result = query.execute();

    //Iterate over the nodes in the results ...
    NodeIterator nodeIter = result.getNodes();
		if (((isEdit) || (isDesign))) { 
	%>

	<form class="form-horizontal" action=".fslwebshop.accessControl.json" id="customAclForm" role="form" method="POST">

    <%
    int count = 1;
    while ( nodeIter.hasNext() ) {
         
     Node node = nodeIter.nextNode();
     String nodeName = node.getName().toString();
        String resPath = node.getPath().toString();
        %>
		
  <h5> Component Name: </h5><h2><%=nodeName%></h2>
       <h5> Component Path: </h5> <p><%=resPath%></p>
		
        <%
			 if(node.hasNode("rep:policy")){
			Node repPolicyNode = node.getNode("rep:policy");
                if(repPolicyNode.hasNodes()){
                NodeIterator repNodeIter = repPolicyNode.getNodes();

                    while ( repNodeIter.hasNext() ) {
						String privileges = "";
                        Node repNode = repNodeIter.nextNode();
                String principalName = repNode.getProperty("rep:principalName").getValue().toString();
				 Property references = repNode.getProperty("rep:privileges");     
  						Value[] values = references.getValues();
						for(Value val: values){
                            privileges = privileges +" "+ val.getString();
                        }

                   %>
        <h5>Node:</h5>   <p><%= repNode.getName().toString() %></p>
        <h5>Denied Group</h5><p><%= principalName %></p>
        <h5>Denied Permission</h5> <p><%=privileges  %></p><%
					}
                  
    }
} 
        %>

        			<input type="hidden" id="respath_<%=count%>" value="<%=resPath%>">

                    <div class="form-group">
                        <label class="col-md-12 padding-zero">Group</label>
                        <select class="valid col-md-12 form-control" id="groupname_select_<%=count%>">
                            <option value="select">Select</option>
                            <c:forEach items="${groupsList}" var="grpList">
								<option value="${grpList.groupNameText}">${grpList.groupNameLabelText}</option>
                            </c:forEach>
                        </select>
                    </div>

					<div class="form-group">
                        <label class="col-md-12 padding-zero">Permission</label>
                        <select class="valid col-md-12 form-control" id="permission_select_<%=count%>">

								<option value="select">Select</option>
								<option value="denyEdit">${properties.denyEditPermissionLabelText}</option>
                                <option value="denyDelete">${properties.denyDeletePermissionLabelText}</option>
                                <option value="denyEditDelete">${properties.denyEditDeletePermissionLabelText}</option>
                               	<option value="none">${properties.removeaccess}</option>
                        </select>
                    </div>


   <%
	count++;
    }
   %>
     				<div class="form-group col-md-12 text-center" id="customAclForm_submit" data-count="<%=count%>"> 
                        <button type="submit" class="btn  btn-lg button-orange">${properties.formButtonLabelText}</button>
                    </div>

    </form>
<%
	    }
   %>

