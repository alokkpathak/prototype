(function() {
  var Validator = function(){   
    //this.init();
  }
 Validator.prototype.validateEmptyField = function(field_text){
     if($(field_text).val()){
           return true;
      }
      else{
          return false;
      }
  }
 Validator.prototype.validatePhoneNumber = function(field_val){
    var val=$(field_val).val();
     var filter;

     if(readCookie('countryCookie')=='GB'){
        //filter = /^((\d{4}|\(?0\d{4}\)?)\s?\d{3}\s?\d{3})$/;
		 //filter= /^[0-9]{7,10}$/;
		 filter = /^[1-9]([0-9]{6,9}$)$/;//as per defect numbers WUD-61 and WD-1527
     }
     else if(readCookie('countryCookie')=='IT'){
        //filter = /^((38[{8,9}|0])|(34[{7-9}|0])|(36[6|8|0])|(33[{3-9}|0])|(32[{8,9}]))([\d]{7})$/;
		//filter = /^((\d{4}|\(?0\d{4}\)?)\s?\d{3}\s?\d{3})$/;
		//filter= /^[0-9]{8,12}$/;
		filter = /^[1-9]([0-9]{7,11}$)$/;//as per defect numbers WUD-61 and WD-1527
     }
	 else if(readCookie('countryCookie')=='LU'){
       
		filter = /^[+]{1}[0-9]*$/;//as per defect numbers WUD-61 and WD-1527
     }
     else {
        filter = /^(?:[1-9]\d*)$/;
     }

      if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }
 Validator.prototype.validateAlbhaNumericFifty = function(field_val){
    var val=$(field_val).val();
    var filter = /^[a-zA-Z0-9]{1,50}$/;
       if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }

  Validator.prototype.validateSixteenDigit = function(field_code){
    var val=$(field_code).val();
	var isValid = CodiceFiscale.check(val);
      if(isValid){
           return true;
      }
      else{
          return false;
      }
  }  
  Validator.prototype.validateEmail = function(field_email){
	var filter = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,4}))$/;  
    var val=$(field_email).val(); 
      if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }

  /*Checks for only alphabetic*/
  Validator.prototype.validateAlbhabetic = function(field_name){
    var val=$(field_name).val(); 
    var filter = /^[a-zA-ZÀ-ÿ\-\s]*$/;
      if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }
    /*Checks for only alphanumeric - only for postal code*/
  Validator.prototype.validateAlbhaNumeric = function(field_name){
	var val=$(field_name).val(); 
	var filter="";
    var fetchedCountryCookie = readCookie('countryCookie');
	if (fetchedCountryCookie == "GB") {
		filter=/(^(?![QVXqvx])[A-Za-z])([0-9]|[0-9][0-9]|((?![IJZijz])[A-Za-z][0-9][0-9]?)|([0-9][A-HJKSTUWa-hjkstuw])|((?![IJZijz])[A-Za-z][1-9][ABEHMNPRVWXYabehmnprvwxy]))( ?)[0-9][ABD-HJLNP-UW-Zabd-hjlnp-uw-z]{2}$/;
	}else if(fetchedCountryCookie == "LU"){
		filter = /^[0-9]{4}$/;
	}
	else{
		filter = /^[0-9a-zA-Z\-\s]{4,10}$/;
	}
      if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }
    Validator.prototype.validateAlbhaNumerictext = function(field_name){
    var val=$(field_name).val(); 
    var filter = /^[0-9a-zA-Z\-\s*$!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/$]/;
      if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }

  Validator.prototype.validatePassword = function(field_password){
    var val=$(field_password).val();
    var filter =  (/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/);
      if(filter.test(val)){
           return true;
      }
      else{
          return false;
      }
  }
  Validator.prototype.confirmPassword = function(field_password,field_confirmPassword){
    var val=$(field_password).val();
    if($(field_password).val() === $(field_confirmPassword).val())   
      return true;
    else
      return false;

  }
  Validator.prototype.validateDay = function(field_day){   
    var value=$(field_day).val();
    var dayValidate = "^(3[01]|[12][0-9]|0?[1-9])$";           

    if (value.match(dayValidate))
      return true;
    else
      return false;   
  }
  //mm/dd/yyyy
  //^(1[0-2]|0?[1-9])/(3[01]|[12][0-9]|0?[1-9])/(?:[0-9]{2})?[0-9]{2}$

  Validator.prototype.validateMonth = function(field_month){ 
    var value=$(field_month).val();     
    var monthValidate = "^(1[0-2]|0?[1-9])$";
    if (value.match(monthValidate))
       return true;
    else
      return false;     
  }
  Validator.prototype.validateYear = function(field_year){ 
  var value=$(field_year).val();
  var yearValidate = "^(?:[0-9]{2})?[0-9]{4}$";  
     if (value.match(yearValidate) && value >= 1800)
       return true;
    else
      return false;   
  }
  Validator.prototype.confirmEmail = function(field_email, field_confirm_email){ 
    var email=$(field_email).val();
    var confirmMail = $(field_confirm_email).val();
     if(email.toLowerCase()  === confirmMail.toLowerCase())   
        return true;
    else
        return false;
  }
  Validator.prototype.getErrorMessage= function(isEmpty,wrongFormat,format,fieldName,input){
      var form=$(input).closest('form');



       var $_errorMsg= fieldName+ $(form).find('#mandatory-message').text();
      if(isEmpty)
        return $_errorMsg;
      else(wrongFormat)
      {
        switch(format){
          case 'alpha':$_errorMsg= $(form).find('#invalidChar-message').text();

                 break;
          case 'email':$_errorMsg=$(form).find('#email-message').text();

                 break;
          case 'numeric':$_errorMsg=$(form).find('#onlyNumber-message').text();

                 break; 
          case 'password':$_errorMsg=$(form).find('#password-message').text();

                 break;
          case 'confirm_password':$_errorMsg=$(form).find('#passwordNotMatching-message').text();

                 break; 
          case 'day':$_errorMsg=$(form).find('#number-of-days-message').text();

                 break; 
          case 'month': $_errorMsg=$(form).find('#number-of-months-message').text();

                 break; 
          case 'year':$_errorMsg=$(form).find('#invalid-format-message').text();

                 break;   
          case 'agree_terms':$_errorMsg=$(form).find('#terms-agree-message').text();

            break;   
          case 'dropdown':if(fieldName!=null) 
                $_errorMsg=$(form).find('#select-valid-option-message').text()+ fieldName;
					else
                $_errorMsg=$(form).find('#select-valid-option-message').text();


           break; 
          case 'confirm_email': $_errorMsg=$(form).find('#email-do-not-match-message').text();

           break; 
          case 'postal_code': $_errorMsg=$(form).find('#valid-postcode-message').text(); 

            break;
		case 'contact_clientcode':  $_errorMsg=$(form).find('#invalid-tax-code-message').text(); 
            break; 
		   case 'serial_number': $_errorMsg=$(form).find('#invalid-serial-number-message').text(); 

            break;
           case 'alphanumerictext': $_errorMsg=$(form).find('#invalid-contact-us-message').text();    
            break;  
            case 'futureDate': $_errorMsg=  $(form).find('#invalid-future-date-message').text(); 
                break;
			case 'phone_Invalid_LU': $_errorMsg=  $(form).find('#phone_invalid').text(); 
                break;

        }
        return $_errorMsg;
      }
  }

  Validator.prototype.toggleErrorMsg = function(input,isFormat,format){
    var self= this;  

     if(format=="futureDate"){
		var spErrorMsg=$('.vatDateOfBirth').find('.tax_day_error');
         var val = $('#tax_day').val()+"/"+$('#tax_month').val()+"/"+$('#tax_year').val();
        var errorMsg = self.getErrorMessage(!(val),isFormat,format,"",$('.vatDateOfBirth'));
        $(spErrorMsg).text(errorMsg);
       // input.removeClass("valid").addClass("invalid");
        spErrorMsg.removeClass("error").addClass("error_show");
      } 
      else{
	var val=input.val();
    var spErrorMsg = input.next();

    if(format=="day" || format=="month" || format=="year")
         spErrorMsg=$('.vatDateOfBirth').find('span.'+$(input).attr('id')+'_error');

    if(format=="agree_terms")
      spErrorMsg = $(input).parent().find('span.error, span.error_show');

    var field= input.attr('data-lbl');      
      if(val && isFormat){
        input.removeClass("invalid").addClass("valid");
        spErrorMsg.removeClass("error_show").addClass("error");
      }
      else{
        var errorMsg = self.getErrorMessage(!(val),isFormat,format,field,input);
        $(spErrorMsg).text(errorMsg);
        input.removeClass("valid").addClass("invalid");
        spErrorMsg.removeClass("error").addClass("error_show");


        }
      }
  }


  //Pass parent section if page has nested forms, else pass form itself as parent
  Validator.prototype.submitForm = function(form,parent){

    var self=this;
    var form_data=$(form).find(":input:not(:hidden)").serializeArray(); 

    var error_free= true;

    var isClaimChecked='';
    var isBillingDiffers='';
    if($(parent).attr('id')=="shipping-address"){
      isClaimChecked= $('#chkClaimData').prop('checked');
      isBillingDiffers = $('#billingDiffers').prop('checked');
      //If claim is unchecked, remove tax form fields from form-data.
      //Do not validate tax form field.
      if(isClaimChecked == false){
          form_data= $.grep(form_data, function (item) {
            return item.name.indexOf("tax_") !== 0;
          });
      } 
      //Do not validate billing address, if "billing address differs" is not checked
       if(isBillingDiffers == false){
          form_data= $.grep(form_data, function (item) {
              return item.name.indexOf("billing_") !== 0;
          });
      } 
    } 
      for(var input=0;input<form_data.length;input++){


          var element=$(parent).find("input[id*="+form_data[input]['name']+"]:visible");   

        if(element!="undefined" && element.length>1){
			var arrElement = element;
              for(var index=0;index<arrElement.length;index++){
				 element = arrElement[index];
                 var error_element=$("span", $(element).parent());
                 var result = self.checkField($(element),form,form_data[input]['name'],form_data[input].value);

				 if(!result[1]){
                    error_free=result[1];
                 }
              }

          }
      else{
			 var result = self.checkField(element,form,form_data[input]['name'],form_data[input].value);
      }
		$_mandatoryErrorMsg = result[0];
		   if(!result[1]){
			error_free=result[1];
          }

      }



var requiredRadioButton = $(form).find('input:radio[data-mandatory=true]:visible');
	$.each(requiredRadioButton, function(){
		if($('input[name='+this.name+']:checked').length<=0)
			{
				$(this).parent().find('span.error').removeClass("error").addClass("error_show");        
				self.toggleErrorMsg($(this),false,"agree_terms");        
				chk_error_free= false;
			}

	});


    /*Validation for mandatory checkbox*/    
    var requiredCheckbox = $(form).find('input[data-mandatory=true]:visible');
    var chk_error_free= true;
    $.each(requiredCheckbox, function(){
      if($(this).prop('checked')== false){
        $(this).parent().find('span.error').removeClass("error").addClass("error_show");        
        self.toggleErrorMsg($(this),false,"agree_terms");        
        chk_error_free= false;
      }
      else
      {
         $(this).parent().find('span').removeClass("error_show").addClass("error");
      } 

    });

	/*Validation for mandatory dropdown*/
    var mandatoryDropdown =  $(form).find('select[data-mandatory]:visible');
    var drp_error_free= true;
    $.each(mandatoryDropdown, function(){
      if($(this).val() == "select"){
        $(this).parent().find('span.error').removeClass("error").addClass("error_show");        
        self.toggleErrorMsg($(this),false,"dropdown");        
        drp_error_free= false;
      }
      else
      {

         $(this).parent().find('span.error_show').removeClass("error_show").addClass("error");
      } 

    });

     if(!error_free || !chk_error_free || !drp_error_free){
		var focusId = $('.error_show:visible').prev()[0].id;
		if(!focusId && $('.error_show:visible').hasClass('dateFields')){
			var focusId = $('.error_show:visible').attr('id');
        }
        $(location).attr('href', '#'+focusId+'');
    }
	//Validate dob for future date
      if($('.vatDateOfBirth').is(':visible')){
    	  var today=new Date();
			 var getYear=today.getFullYear()-4;
            var getMonth=today.getMonth()+1;
             var getDate=today.getDate();
          var dateField = $('#tax_day');
          var monthField = $('#tax_month');
          var yearField = $('#tax_year');
          if(self.validateDay(dateField) && self.validateMonth(monthField) && self.validateYear(yearField)){
				var dateOfBirth = monthField.val()+'/'+ dateField.val() + '/'+yearField.val();
              	var presentDay= getMonth+'/'+ getDate + '/'+getYear;
              	if(!(self.validateDob(dateOfBirth,presentDay))){
              	error_free= false;
				self.toggleErrorMsg($(this),'false',"futureDate");
              }

          }


      }

    return error_free && chk_error_free && drp_error_free;
  }
  Validator.prototype.validateDob = function(dateOfBirth,presentDay){
      //dateOfBirth - mm/dd/yyyy
		var isValid= true;
      //To chek if it is a valid date
 		var bits = dateOfBirth.split('/');
  		var d = new Date(dateOfBirth);
  		var validatedate= new Date(presentDay);
  		var validDate = !!(d && (d.getMonth() + 1) == bits[0] && d.getDate() == Number(bits[1]));
        if(new Date(dateOfBirth) > validatedate || validDate == false){
				isValid = false;

         }
      return isValid;
  } 
  
  Validator.prototype.checkField= function(element,form,name,form_data_value){
      var self=this;
     var error_free=true;

        var valid=element.hasClass("valid");
          if(element.selector=="[id*=claimGroup]"){		
				valid=true;		
          }
        var error_element=$("span", element.parent());
		var eleId = $(element).attr('id');
		if(eleId == "tax_day" || eleId == "tax_month" || eleId == "tax_year")
				error_element=$('.vatDateOfBirth').find('span.'+eleId+'_error');


        if (!valid && element.length>0){
          error_element.removeClass("error").addClass("error_show");
          error_free=false;
          var $_field=element.attr('data-lbl');
          var $_mandatoryErrorMsg = "";
			/*postcode customize*/
				/*$(".postalcode_overlay_error_text").css("display","none");             
    			var postalcity = $(".postalcode_overlay_error_text").text(); 
				$("#postalcode_overlay_error").text(postalcity); 
                $("#postalcode_overlay_error").removeClass("error").addClass("error_show");

				$(".postalcode_contact_error_text").css("display","none");             
    			var postalcontact = $(".postalcode_contact_error_text").text(); 
				$("#postalcode_contact_error").text(postalcontact); 
                $("#postalcode_contact_error").removeClass("error").addClass("error_show");

				$(".postalcode_tax_error_text").css("display","none");             
    			var postaltax = $(".postalcode_tax_error_text").text(); 
				$("#postalcode_tax_error").text(postaltax); 
                $("#postalcode_tax_error").removeClass("error").addClass("error_show");

				$(".postcodeform_error_text").css("display","none");             
    			var postcodeform = $(".postcodeform_error_text").text(); 
				$("#postcodeform_error").text(postcodeform); 
                $("#postcodeform_error").removeClass("error").addClass("error_show");

				$(".cityform_error_text").css("display","none");             
    			var postcodeform = $(".cityform_error_text").text(); 
				$("#cityform_error").text(postcodeform); 
                $("#cityform_error").removeClass("error").addClass("error_show");


				$(".shipping_postcode_error_text").css("display","none");             
    			var postcodeform = $(".shipping_postcode_error_text").text(); 
				$("#shipping_postcode_error").text(postcodeform); 
                $("#shipping_postcode_error").removeClass("error").addClass("error_show");

				$(".shipping_citycode_error_text").css("display","none");             
    			var postcodeform = $(".shipping_citycode_error_text").text(); 
				$("#shipping_citycode_error").text(postcodeform); 
                $("#shipping_citycode_error").removeClass("error").addClass("error_show");


				$(".tax_city_error_text").css("display","none");             
    			var postalcity = $(".tax_city_error_text").text(); 
				$("#tax_city_error").text(postalcity); 
                $("#tax_city_error").removeClass("error").addClass("error_show"); */

			/*postcode customize end*/
            /*DOB customize*/
				/*$(".tax_day_error").css("display","none");             
    			var day = $(".tax_day_error").text();    
				$("#tax_day_error").text(day); 
                $("#tax_day_error").removeClass("error").addClass("error_show");

				$(".tax_month_error").css("display","none");             
    			var month = $(".tax_month_error").text();    
				$("#tax_month_error").text(month); 
                $("#tax_month_error").removeClass("error").addClass("error_show");

				$(".tax_year_error").css("display","none");             
    			var year = $(".tax_year_error").text();    
				$("#tax_year_error").text(year); 
                $("#tax_year_error").removeClass("error").addClass("error_show");*/

             /*DOB customize End*/
		  if(form_data_value == ""){
				$_mandatoryErrorMsg = $_field+  $(form).find('#mandatory-message').text();
		  }else{
              	$_mandatoryErrorMsg = self.getErrorMessage(false, true, name, $_field, element);
		  } 
          error_element.text($_mandatoryErrorMsg);
         }
         else{
          error_element.removeClass("error_show").addClass("error");
        }

      return [$_mandatoryErrorMsg, error_free] ;
  }



  app.utils.validator = new Validator();

})();
