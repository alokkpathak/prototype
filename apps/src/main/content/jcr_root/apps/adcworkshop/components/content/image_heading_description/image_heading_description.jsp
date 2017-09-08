<%--
* Copyright (c)  Vorwerk POC
* Program Name :  image_heading_description.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  Display header with image component.
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 11-Jul-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>

<%@include file="/apps/adcworkshop/components/shared/global.jsp"%>
<%@page session="false" %>
<%@page  import="java.util.*" %>

<cq:includeClientLib js="apps.adc.workshop.authorlibs"/> 

<%

    Session session = resourceResolver.adaptTo(Session.class);
    
    Node valuesNode = null;
	Node valuesNode2 = null;

	int i=0;

	if(currentNode!=null)
	{
    	if(session.itemExists(currentNode.getPath() + "/leftmulti")){
        valuesNode = session.getNode(currentNode.getPath()+"/leftmulti");
    	}
    
   		 if(session.itemExists(currentNode.getPath() + "/rightmulti")){
        valuesNode2 = session.getNode(currentNode.getPath()+"/rightmulti");
    	}
    
    List<Map<String, String>> leftradiobuttonList = new ArrayList<Map<String, String>>();
    List<Map<String, String>> rightradiobuttonList = new ArrayList<Map<String, String>>();

    if(valuesNode != null){
        
        NodeIterator itemIterator1 = valuesNode.getNodes();
        Node multifieldDetailsNode = null;
        String lefttitlename = null;
        String lefttitledescription=null;
        String leftimagename=null;
        
        Map<String, String> leftradiobuttonMap = null;


        while(itemIterator1.hasNext()){
            multifieldDetailsNode = itemIterator1.nextNode();
            lefttitlename= multifieldDetailsNode.hasProperty("lefttitlename")?multifieldDetailsNode.getProperty("lefttitlename").getString():"";
            lefttitledescription= multifieldDetailsNode.hasProperty("lefttitledescription")?multifieldDetailsNode.getProperty("lefttitledescription").getString():"";
            leftimagename= multifieldDetailsNode.hasProperty("leftimagename")?multifieldDetailsNode.getProperty("leftimagename").getString():"";

            leftradiobuttonMap = new HashMap<String, String>();
            leftradiobuttonMap.put("lefttitlename",lefttitlename);
            leftradiobuttonMap.put("lefttitledescription",lefttitledescription);
            leftradiobuttonMap.put("leftimagename",leftimagename);


            
            leftradiobuttonList.add(leftradiobuttonMap);
        }
        request.setAttribute("leftradiobuttonList", leftradiobuttonList);

    }

    if(valuesNode2 != null){

        NodeIterator itemIterator2 = valuesNode2.getNodes();
        Node multifieldDetailsNode2 = null;
        String righttitlename = null;
        String righttitledescription=null;
        String rightimagename=null;

        Map<String, String> rightradiobuttonMap = null;


        while(itemIterator2.hasNext()){
            multifieldDetailsNode2 = itemIterator2.nextNode();
            righttitlename= multifieldDetailsNode2.hasProperty("righttitlename")?multifieldDetailsNode2.getProperty("righttitlename").getString():"";
            righttitledescription= multifieldDetailsNode2.hasProperty("righttitledescription")?multifieldDetailsNode2.getProperty("righttitledescription").getString():"";
            rightimagename= multifieldDetailsNode2.hasProperty("rightimagename")?multifieldDetailsNode2.getProperty("rightimagename").getString():"";

            rightradiobuttonMap = new HashMap<String, String>();
            rightradiobuttonMap.put("righttitlename",righttitlename);
            rightradiobuttonMap.put("righttitledescription",righttitledescription);
            rightradiobuttonMap.put("rightimagename",rightimagename);



            rightradiobuttonList.add(rightradiobuttonMap);
        }
        request.setAttribute("rightradiobuttonList", rightradiobuttonList);
        
    }

    }


%>  
<section class="container-fluid">
    <div class="container-fluid">
        <div class=" row gs-row3 text-left">
            <h3 class="text-center"><strong>${properties.title}</strong></h3>
            <div class="col-md-12">
                <div class="col-md-5 col-md-offset-1 col-sm-6">
                    <c:forEach items="${leftradiobuttonList}" var="leftlist" >
                        <div class="media">
                            <div class="media-left">
                                <img src=${leftlist.leftimagename} alt="${properties.eftimagealt}" />
                            </div>
                            <div class="media-body">
                                <h4><strong> ${leftlist.lefttitlename} </strong></h4>
                                <p> ${leftlist.lefttitledescription} </p>								
                            </div>
                        </div>		
                    </c:forEach>
                </div>

                <div class="col-md-5 sensor-column-2 col-sm-6">
                    <c:forEach items="${rightradiobuttonList}" var="rightlist" >
                        <div class="media">
                            <div class="media-left">
                                <img src=${rightlist.rightimagename} alt="${properties.rightimagealt}"/>
                            </div>
                            <div class="media-body">
                                <h4><strong> ${rightlist.righttitlename} </strong></h4>
                                <p> ${rightlist.righttitledescription} </p>

                            </div>
                        </div>	
                    </c:forEach>
                </div>
            </div>
            
        </div>
    </div>
</section>

