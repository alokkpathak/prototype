$(document).ready(function() {

	/*Default constructor*/
	function addressFormValidator(){
		this.init();
	};

	addressFormValidator.prototype.init = function(){
		var self= this;

		$(".infoSubmit").click(function(event){

			var parent = $('#personal-details');

			var objValidator= app.utils.validator;
			var error_free=objValidator.submitForm($("#detailsForm"),parent);

			if (!error_free){

			}
			else{
			}
		});
$('#register_email').on('input',function(e){
    if($('#confirmEmail').val() != ''){
 		$('#confirmEmail').val('');
    	$('#confirmEmail').removeClass('valid');
		$('#confirmEmail').addClass('invalid');
		$('#confirmEmail').css("border","2px solid #c6C6C6", "important");
    }
});
$('#pwd').on('input',function(e){
    if($('#confirmPassword').val() != ''){
 		$('#confirmPassword').val('');
    	$('#confirmPassword').removeClass('valid');
		$('#confirmPassword').addClass('invalid');
		$('#confirmPassword').css("border","2px solid #c6C6C6", "important");
    }
});
        $(document).on("click", "#edit-submit", function() {

			var parent = $('.edit-address');
			var objValidator= app.utils.validator;
			var error_free=objValidator.submitForm($("#updateForm"),parent);

			if (!error_free){

			}
			else{

			}
		});

		self.validateForm();
	}

	addressFormValidator.prototype.validateForm= function(){

		var self=this;
		var objValidator= app.utils.validator;
		var form = $('#personal-details');
		var warrentyform = $('#warrentyForm');







		var $_field='';
		/*only alphabetic fields*/

		var $_firstName=$(form).find('input[id*=contact_firstName]');
		var $_lastName=$(form).find('input[id*=contact_lastName]');
		var $_email=$(form).find('input[id*=register_email]');
		var $_emailConfirm=$(form).find('input[id*=confirmEmail]');
		var $_password =$(form).find('input[id*=pwd]');
		var $_confirmPassword=$(form).find('input[id*=confirmPassword]');

		var formName = $("#formName").val();

        var $_firstNameForm=$('input[id*='+formName+'_firstNameForm]');
		var $_lastNameForm=$('input[id*='+formName+'_lastNameForm]');
        var $_address_one=$('input[id*='+formName+'_address_one]');
		var $_address_two=$('input[id*='+formName+'_addrss_two]');
		var $_postCodeForm=$('input[id*='+formName+'_postCodeForm]');
		var $_cityForm=$('input[id*='+formName+'_cityForm]');
		var $_phoneForm=$('input[id*='+formName+'_phoneForm]');
        var $_AddressName=$('input[id*='+formName+'_AddressName]');

		var $_serialNo=$(warrentyform).find('input[id*=serialNo]');


		var alphabeticFields =[$_firstName, $_firstNameForm, $_lastNameForm,  $_lastName, $_cityForm];
		var $_alphaResult = $();
		$.each(alphabeticFields, function() {
    		$_alphaResult = $_alphaResult.add(this);
		});

		var alphaNumericFields =[$_postCodeForm,$_serialNo];
		var $_alphaNumericResult = $();
		$.each(alphaNumericFields, function() {
    		$_alphaNumericResult = $_alphaNumericResult.add(this);
		});

        $_alphaNumericResult.focusout('input', function() {
			var input=$(this);
			var isAlphaNumeric = objValidator.validateAlbhaNumericFifty(input);
			objValidator.toggleErrorMsg(input,isAlphaNumeric,"serial_number");
		});
		 var chkForNullFields = [$_address_one, $_AddressName];

        var $_nullFieldResult = $();
        $.each(chkForNullFields, function() {
            $_nullFieldResult = $_nullFieldResult.add(this);
        });

        $_nullFieldResult.focusout('input', function() {
            var input = $(this);
            var isEmpty = objValidator.validateEmptyField(input);
            objValidator.toggleErrorMsg(input, true);
		});

		if(readCookie('countryCookie')!='LU'){
		var numericFields =[$_phoneForm];
		var $_numResult = $();
		$.each(numericFields, function() {
    			$_numResult = $_numResult.add(this);
        });
        }
		
		$_alphaResult.focusout('input', function() {
			var input=$(this);
			var isAlphabetic = objValidator.validateAlbhabetic(input);
			objValidator.toggleErrorMsg(input,isAlphabetic,"alpha");
		});
		
         if(readCookie('countryCookie')!='LU'){
		$_numResult.focusout('input', function() {
			var input=$(this);
			var val=input.val();
			var isNumeric= $.isNumeric(val);
			objValidator.toggleErrorMsg(input,isNumeric,"numeric");

		});
		}

		$($_email).focusout('input', function() {
			var input=$(this);
			var isValidFormat= objValidator.validateEmail(input);
			objValidator.toggleErrorMsg(input,isValidFormat,"email");

		});
		
		if(readCookie('countryCookie')!='LU'){
		$($_phoneForm).focusout('input', function() {
			var input=$(this);
			var isValidFormat= objValidator.validatePhoneNumber(input);
			objValidator.toggleErrorMsg(input,isValidFormat,"alpha");

		});
		}

		$($_emailConfirm).focusout('input', function() {
			var email=$('#register_email');
			var isMatched = objValidator.confirmEmail(email,$(this));
			objValidator.toggleErrorMsg($(this),isMatched,"confirm_email");
		});

		$($_password).focusout('input', function() {
			var input=$(this);
			//var re = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;
			var isValidFormat= objValidator.validatePassword(input);
			objValidator.toggleErrorMsg(input,isValidFormat,"password");

		});

		$($_confirmPassword).focusout('input', function() {
			var confirmPassword=$(this);
			var parent=  $(this).parent();
			var password = $(parent).siblings().find('#pwd');
			//var re = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;
			var isValidFormat= objValidator.confirmPassword(password,confirmPassword);
			objValidator.toggleErrorMsg(confirmPassword,isValidFormat,"confirm_password");
		});
	}

	app.addressFormValidator = new addressFormValidator();
});