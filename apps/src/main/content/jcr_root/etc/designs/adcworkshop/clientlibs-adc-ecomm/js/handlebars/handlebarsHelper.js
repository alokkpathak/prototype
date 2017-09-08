
Handlebars.registerHelper('compare', function(lvalue, rvalue, options) {
    
    if (arguments.length < 3)
        throw new Error("Handlerbars Helper 'compare' needs 2 parameters");
    
    var operator = options.hash.operator || "==";
    
    var operators = {
        '==':       function(l,r) { return l == r; },
        '===':      function(l,r) { return l === r; },
        '!=':       function(l,r) { return l != r; },
        '<':        function(l,r) { return l < r; },
        '>':        function(l,r) { return l > r; },
        '<=':       function(l,r) { return l <= r; },
        '>=':       function(l,r) { return l >= r; },
        'typeof':   function(l,r) { return typeof l == r; }
    }
    
    if (!operators[operator])
        throw new Error("Handlerbars Helper 'compare' doesn't know the operator "+operator);
    
    var result = operators[operator](lvalue,rvalue);
    
    if( result ) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});

/***************************************/
Handlebars.registerHelper('if_eq', function(a, b, opts) {
    if (a === b) {
        return true;
    } else {
        return false;
    }
});
/****************************************/
Handlebars.registerHelper('pickImgForSku', function(skuid, imgSkuArr) 
                          {
                              var imgPath = "";
                              if( skuid != 'undefined' && imgSkuArr != 'undefined' )
                              {
                                  for(var i = 0; i < imgSkuArr.length; i++) 
                                  {
                                      var skuVal = imgSkuArr[i].sku
                                      if( skuVal === skuid )
                                      {
                                          imgPath = imgSkuArr[i].imagePath;
                                      }
                                  }
                              }		
                              return imgPath;
                          });

Handlebars.registerHelper('pickUrlForSku', function(skuid, viewUrlArray) 
		{
			var urlpath = "";
			if( skuid != 'undefined' && viewUrlArray != 'undefined' )
			{
				for(var i = 0; i < viewUrlArray.length; i++) 
				{
					var skuVal = viewUrlArray[i].sku
					if( skuVal === skuid )
					{
						urlpath = viewUrlArray[i].viewUrl;
					}
				}
			}		
			return urlpath;
		});

Handlebars.registerHelper('fetchDateFromDateTime', function(datetime) {
        if(datetime!=null && datetime!="" && typeof(datetime)!="undefined"){

        if(datetime.indexOf(":")>-1)
        {
            var t = datetime.split(" ");
            return t[0];
        }
        else{
          return datetime;
        }
    }

});

Handlebars.registerHelper('vatFormCheck', function(name) {
	var taxText = "";	
    if(name == "1"){
        taxText = $("#taxexclusivelabel").val();
    }else{
		taxText = $("#inclusivetaxlabel").val();
    }
    
    return taxText;
});


Handlebars.registerHelper('trimProductName', function(name) {
    var trimmedProdName = name.replace(/\s/g, '');
    return trimmedProdName;
});


Handlebars.registerHelper('times', function(n, qty, block) {
    var accum = '';
    selectedqty = qty;
    if(qty>n){
		for(var i = 1; i < parseInt(qty)+1;++i)
        	accum += block.fn(i);
    }else{
        for(var i = 1; i < n+1;++i)
        	accum += block.fn(i);
    }
    return accum;
});


Handlebars.registerHelper('qtyselect', function(a, block) {
    		if (a == selectedqty) {
                return block.fn(this);
            } else {
                return block.inverse(this);
            }
});
