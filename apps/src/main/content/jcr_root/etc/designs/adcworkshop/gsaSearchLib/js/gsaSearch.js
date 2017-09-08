var searchString;
var searchStartTime;
var searchStopTime;
var totalPages;
var searchResults;
var currentPage;
//IE 8 fix
Date.now = Date.now || function() { return +new Date; };

function gsaCallback (obj){


    //jQuery("#searchTerm").text(searchString);
    //var maxPageCount = function(){if(obj.length < 10){return obj.length;}else{return 10;}};
    var maxResultCount;

    searchResults = initPagination(obj.result);
    
    totalPages = searchResults.length / 10;

    if(searchResults.length < 10){
        maxResultCount = obj.length;
    }else{
        maxResultCount = 10;
    }

    renderResultPage(1,searchResults);
}

var searchFailed = function (response, opts){

    var entry = "<div>" + response.responseText + "</div> <br>";
    entry = entry + "<div> Response Status: " + response.status + ": " + response.statusText + "</div> <br>";


    jQuery("#searchResults").append(entry);
}

function submitSearch(searchTerm, gsaURL, searchCol){

    var fullURL = gsaURL + "?col=" + searchCol + "&q=" + searchTerm;
    searchString = searchTerm;
    searchStartTime = Date.now();



    jQuery.ajax({
        url: fullURL,
        type: 'GET',
        dataType: 'json',

        success: function (data, textStatus, xhr) {


            gsaCallback(data);

        },
        error: function (xhr, textStatus, errorThrown) {

        }
    });    
}

function initPagination(obj){

    var searchResult = new Array();
    var searchResultCount=0;


    for(i=0;i<obj.length;i++){
        var url;
    	var title;
    	var description;

        if (obj[i].hasOwnProperty("title")){
            title = obj[i].title;
        }
        else
        {
            if(obj[i].hasOwnProperty("Title")){
                title = obj[i].Title;
            }
            else{
           		title="";
            }
        }
        if (obj[i].hasOwnProperty("url")){
            url = obj[i].url;
        }
        else{
            url = "";
        }
        if (obj[i].hasOwnProperty("description")){
            description = obj[i].description;
        }
        else{            
            description = "";
        }

        if(title !="" || description != ""){
            searchResult[searchResultCount] = new Object();
			searchResult[searchResultCount].title = title;
            searchResult[searchResultCount].url = url;
            searchResult[searchResultCount].description = description;
            searchResultCount++;
        }

    }
    return searchResult;
}

function nextPage(){

    renderResultPage(currentPage+1,searchResults);

}

function prevPage(){

    renderResultPage(currentPage-1,searchResults);
}

function renderResultPage(pageNumber,searchResults){

    var resultsLength = pageNumber * 10;
    searchStopTime = Date.now();

    if(resultsLength > searchResults.length){
        resultsLength = searchResults.length;
    }

    var pageResultCounter = (pageNumber - 1) *10;
    currentPage = pageNumber;

    jQuery("#resultContainer").remove();
    jQuery("#searchResults").append("<div id='resultContainer'/>");

    var searchStats = "<p> "+txtResults+" <b>" + (pageResultCounter+1) + "</b> - <b>" + resultsLength + "</b> "+txtOfAbout+" <b>" + searchResults.length + "</b> "+txtFor+" <b>"+searchString+"</b>. "+
        txtSearchTook+": <b>" + ((searchStopTime-searchStartTime)/1000) + "</b> "+txtSeconds+".</p>";
    jQuery("#searchStats").empty();
    jQuery("#searchStats").append(searchStats);


    for(i=pageResultCounter;i<resultsLength;i++){

        if(searchResults[i].title !="" || searchResults[i].description != ""){
			var entry = "<div class='searchItem'> <div class='searchTitle'> <a href=" + searchResults[i].url + " style='text-decoration:underline'>" + searchResults[i].title + "</a></div>";
            entry = entry + "<div class='searchDesc'>" + searchResults[i].description + "</div>";
			entry = entry + "<div class='searchHref'><a href=" + searchResults[i].url + " style='text-decoration:underline'>" + searchResults[i].url + "</a></div></div>";
            jQuery("#resultContainer").append(entry);
        }

    }
    var pages = "<div class='searchPaging'><br><b>Page:</b> ";

    if(currentPage > 1){
        pages = pages + "<a href='#someUrl' class='navigation' page='prev' >Previous</a> ";
    }
    for(i=0;i<totalPages;i++){
        if(i == pageNumber-1){
            pages = pages + "<b>" + (Number(i)+1)+ "</b> ";
        }else{
            pages = pages + "<a href='#someUrl' class='navigation' page='"+ (Number(i)+1) + "' >" + (Number(i)+1) + "</a> ";
        }
    }
    if(currentPage < totalPages){
        pages = pages + "<a href='#someUrl' class='navigation' page='next' >Next</a>";
    }
    pages = pages + "</div>";


    jQuery("#resultContainer").append(pages);

        $('a.navigation').click(function(){
            searchStartTime = Date.now();
            var pageNum = $(this).attr("page");

            if(pageNum == "next"){
            	nextPage();
        	}else if (pageNum == "prev"){
            	prevPage();
        	}else{
            	renderResultPage(pageNum,searchResults);
        	}
    	});


}
