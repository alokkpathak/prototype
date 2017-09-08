<%--
* Copyright (c)  Vorwerk POC
* Program Name :  gsaSearchResults.jsp
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  GSA Search Results component
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
*-----------                            ----------------                                    -------------------------
* 23-Oct-2016                  Cognizant Technology solutions            					Initial Creation
*-----------                           -----------------                                    -------------------------
--%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%
%><%@page import="java.lang.StringBuffer"%>
<%
	String gsaURL = properties.get("gsaURL","empty");
    String searchTerm = "";
    if (null != slingRequest.getRequestParameter("q")) {
	    searchTerm = slingRequest.getRequestParameter("q").toString().replace("'","\\\'");
    }

	String txtSearchTitle = properties.get("searchTitle","Search");
	String txtResults = properties.get("results","Results").replace("'","\\\'");
	String txtOfAbout = properties.get("ofAbout","of about").replace("'","\\\'");
	String txtFor = properties.get("for","for").replace("'","\\\'");;
	String txtSearchTook = properties.get("searchTook","Search took").replace("'","\\\'");
	String txtSeconds = properties.get("seconds","seconds").replace("'","\\\'");

 	String searchCol = properties.get("searchCol","empty").replace("'","\\\'");
	StringBuffer requestUrl = slingRequest.getRequestURL();
	int start = requestUrl.indexOf("//");
	int end = requestUrl.indexOf("/",start+2);
	String hostname = requestUrl.substring(0,end);
	gsaURL = hostname + gsaURL;
%>

<cq:includeClientLib categories="vorwerk.commons.search"/>
<script type="text/javascript" src="/etc/designs/vorwerk-common/vorwerkCommon/gsaSearchLib/js/gsaSearch.js"></script>
<sling:defineObjects/>

<script type="text/javascript">

    var searchTerm = '<%= searchTerm%>';
    var gsaURL = '<%= gsaURL%>';
    var searchCol = '<%= searchCol%>';

    var txtResults = '<%= txtResults%>';
    var txtOfAbout = '<%= txtOfAbout%>';
    var txtFor = '<%= txtFor%>';
    var txtSearchTook = '<%= txtSearchTook%>';
    var txtSeconds = '<%= txtSeconds%>';


	submitSearch(searchTerm, gsaURL, searchCol);

</script>
<div class="search-content">

	<div id="searchStats"> </div>

	<div class="searchTermContainer">
        <span class="seach-term-desc"><%=txtSearchTitle%></span>
		<strong id="searchTerm"></strong>
	</div>
    <hr id="search-top-divider" class="search-top-divider">
	<br class="clear-all">


	<div id='searchResults'> </div>


</div>