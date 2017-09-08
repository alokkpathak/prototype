/**
* Copyright (c)  Vorwerk POC
* Program Name :  AdcFslException.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  this class is used for handling custom exceptions
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 7-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.exception;


import com.vorwerk.adc.workshop.core.exception.BaseException;

/**
 * <p>
 * 	These is generic exception class which will provide all the necessary attributes which 
 * 	will provide information about the exception and all other custom exception class will extend
 * 	this class and do the necessary implementation
 * 
 * 	A customized exception handling having a single exception class BaseException 
 * 	which extends com.bsc.cwr.common.exception.BaseException
 * 	This does not constraint any class either in web layer or in business layer 
 * 	to catch BaseException, unless needed
 * 	java.lang.Throwable is caught in ServiceAccess classes and thrown upstream 
 * 	post encapsulation in BaseException
 * 	ProducerBaseException is mandatory to caught in delegate  classes
 * 	java.lang.Throwable is mandatory to caught in delegate  classes and thrown 
 * 	post encapsulation in BaseException
 * 	BaseException has the following properties
 * 		o    exceptionRoot e.g. DataAcess, BusinessProcessor
 *		o    exceptionMessageId (optional and set by throwing class) ; 
 *			 displayed to user on screen, which the user can refer on lodging complains to customer service representatives
 *		o    exceptionMessage
 *		o    time stamp (set by throwing class) ; 
 *			 this will help the IT team to look for the exact time of occurrence of error during debugging
 * <p>
 * 
 * @version 1.0
 */
public class AdcFslException extends BaseException{

	private static final long serialVersionUID = 2407463779424763652L;


	/**
	 * AdcFslException - constructor with exception message id parameter
	 * @param exceptionMessageId
	 * 
	 */
	public AdcFslException(final String exceptionMessageId){
		super(exceptionMessageId);
	}

	/**
	 * AdcFslException - constructor with exception message id and throwable parameters
	 * @param throwable
	 * @param exceptionMessageId
	 * 
	 */
	public AdcFslException(final Throwable throwable,final String exceptionMessageId){
		super(throwable,exceptionMessageId);
	}
	
	/**
	 * AdcFslException - constructor with exception message and exception message id parameters
	 * 
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 */
	public AdcFslException(final String exceptionMessage, final String exceptionMessageId) {
		super(exceptionMessage,exceptionMessageId);
	}
	
	/**
	 * AdcFslException - constructor with throwable, exception message and exception message id parameters
	 * 
	 * @param throwable
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 */
	public AdcFslException(final Throwable throwable, final String exceptionMessage, final String exceptionMessageId) {
		super(throwable,exceptionMessage,exceptionMessageId);
	}


	/**
	 * AdcFslException - constructor with throwable, exception message, exception message id and validation exception parameters
	 * 
	 * @param throwable
	 * @param isValidationException
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 */
	public AdcFslException(final Throwable throwable, final String exceptionMessage,final String exceptionMessageId, boolean isValidationException) {
		super(throwable,exceptionMessage,exceptionMessageId,isValidationException);
	}

	
}
