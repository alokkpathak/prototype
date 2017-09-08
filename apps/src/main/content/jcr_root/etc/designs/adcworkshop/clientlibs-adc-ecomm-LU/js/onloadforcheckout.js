$(window).load(function() {


if($('body').hasClass('Checkoutpage')){
var username=readCookie('username');
	var guestuserid=readCookie('guestUserCookie');
	if((username==""||username==null) && (guestuserid==""||guestuserid==null)){
		window.location.replace($('#logout_url').val());
	}

}

});

function vatformcheckingforentry(data)
{
    $('#chkClaimData').prop('checked', true);
    $('#chkClaimData').next().addClass('checked');

    if ($('#chkClaimData').prop('checked') == true) {

        $('.value-tax').show();
        var on_behalf =data.cart[0].vat_info.on_behalf;
        var jsonfullstreet = data.cart[0].vat_info.street;
        var fullstreet = jsonfullstreet.split("\n");
        var firstName= data.cart[0].vat_info.firstname;
		var lastName= data.cart[0].vat_info.lastname;
        var street1 = fullstreet[0];
        var street2 = fullstreet[1];
        var city = data.cart[0].vat_info.city;
        var vat_dob =data.cart[0].vat_info.vatdob;
        var postcode=data.cart[0].vat_info.postcode;
        var dob = vat_dob.split("-");

		$('#tax_FirstName').attr('value',firstName);
		$('#tax_FirstName').addClass('valid');
		$('#tax_LastName').attr('value',lastName);
		$('#tax_LastName').addClass('valid');
		$('#tax_day').attr('value',dob[0]);
		$('#tax_day').addClass('valid');
		$('#tax_month').attr('value',dob[1]);
		$('#tax_month').addClass('valid');
		$('#tax_year').attr('value',dob[2]);
		$('#tax_year').addClass('valid');

        if(on_behalf == 0 || on_behalf == null)
        {
            $('#claimMyself').prop('checked', true);
			$('#vat_ManualAddressData').removeClass('hidden');
        $('#tax_HomeAddress').attr('value',street1);
        $('#tax_HomeAddress').addClass('valid');
        $('#tax_HomeAddressOne').attr('value',street2);
        $('#tax_HomeAddressOne').addClass('valid');
        $('#tax_City').attr('value',city);
        $('#tax_City').addClass('valid');
        $('#tax_PostalCode').attr('value',postcode);
        $('#tax_PostalCode').addClass('valid');
        }
        else
        {
			$('#climBehalf').prop('checked', true);
			$('#vat_FindAddressData').removeClass('hidden');
			$('#ShowAddress_vat').removeClass('hidden');

			$('#vat_addressline_one').attr('value',street1);
			$('#vat_addressline_one').addClass('valid');
			$('#vat_addrssline_two').attr('value',street2);
			$('#vat_addrssline_two').addClass('valid');
			$('#vat_contact_city').attr('value',city);
			$('#vat_contact_city').addClass('valid');
			$('#contact_postCode_vat').attr('value',postcode);
			$('#contact_postCode_vat').addClass('valid');
        }
    } else {

        $('.value-tax').hide();
    }
}