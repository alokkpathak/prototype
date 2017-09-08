/**
* Copyright (c)  Vorwerk POC
* Program Name :  BaseException.java
* Application  :  Vorwerk POC
* Purpose      :  See description
* Description  :  These is generic exception class which will provide all the necessary attributes which 
* 	will provide information about the exception and all other custom exception class will extend
* 	this class and do the necessary implementation
* Modification History:
* ---------------------
*    Date                                Modified by                                       Modification Description
* -----------                         ----------------                                    -------------------------
* 7-Sep-2016                  Cognizant Technology solutions            					Initial Creation
* -----------                         -----------------                                   -------------------------
**/

package com.vorwerk.adc.workshop.core.exception;

import java.util.Date;

import com.vorwerk.adc.workshop.core.util.AdcFSLConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.PrintWriter;
import java.io.StringWriter;

import org.apache.commons.lang.StringUtils;
import org.apache.felix.scr.annotations.Reference;
import org.osgi.service.cm.Configuration;
import org.osgi.service.cm.ConfigurationAdmin;

/**
 * <p>
 * 	These is generic exception class which will provide all the necessary attributes which 
 * 	will provide information about the exception and all other custom exception class will extend
 * 	this class and do the necessary implementation
 * 
 * 	A customized exception handling having a single exception class BaseException 
 * 	which extends java.lang.Exception 
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
 * 
 * @author Cognizant
 * 
 */
public abstract class BaseException extends Exception{

	private static final long serialVersionUID = 2740604896291802237L;
	private static final String CLASS_NAME = BaseException.class.getSimpleName();
	private static final Logger log = LoggerFactory.getLogger(BaseException.class);
	
	/* class attributes */
	private String exceptionMessage;
	private String exceptionMessageId;  
	private String exceptionRoot; 
	private Date timestamp; 
	private boolean isValidationException=false;
	
	// internal message for logging
	private String internalMessage;
	//presentable message for displaying in the portal
	private String presentableMessage;
	
	// the nested exception associated with this exception 
	private Throwable cause;
	// the full stack trace string associated with this exception 
	private String stackTrace;
	
	@Reference
	private ConfigurationAdmin configurationAdmin;

		
	/**
	 * Constructor for Base Exception with message id as parameter
	 * @param exceptionMessageId
	 */
	public BaseException(final String exceptionMessageId) {
		super(exceptionMessageId);
		this.exceptionMessageId = exceptionMessageId;
		
		//create the internal and presentable messages for the exception message id
		this.internalMessage = this.resolveInternalMessage(exceptionMessageId);
		
		this.logMessage(this.internalMessage,exceptionMessageId);
	}
	
	
	/**
	 * BaseException with exception Message and exception message id as parameters
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 */
	public BaseException(final String exceptionMessage, final String exceptionMessageId) {
		super(exceptionMessageId);
		this.exceptionMessageId = exceptionMessageId;
		this.exceptionMessage = exceptionMessage;
		
		this.logMessage(exceptionMessage,exceptionMessageId);
	}

	/**
	 * BaseException with throwable cause and exception message id as parameters
	 * @param pCause
	 * @param exceptionMessageId
	 */
	public BaseException(final Throwable pCause, final String exceptionMessageId) {
		super(exceptionMessageId);
		this.exceptionMessageId = exceptionMessageId;
		this.cause = pCause;
		this.stackTrace = this.generatePrintStackTrace(pCause);
		
		this.internalMessage = this.resolveInternalMessage(exceptionMessageId);
		
		this.logMessage(this.internalMessage,exceptionMessageId);
	}
	
	
	/**
	 * BaseException with exception Message and exception message id and throwable as parameters
	 * @param pCause
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 */
	public BaseException(final Throwable pCause, final String exceptionMessage, final String exceptionMessageId) {
		super(exceptionMessageId);
		this.exceptionMessageId = exceptionMessageId;
		this.exceptionMessage = exceptionMessage;
		this.cause = pCause;	
		
		this.stackTrace = generatePrintStackTrace(pCause);
		this.logMessage(pCause,stackTrace,exceptionMessageId);
	}
	
	
	/**
	 * BaseException with exception Message and exception message id, throwable and isvalidation Exception as parameters
	 * @param pCause
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 * @param isValidationException
	 */
	public BaseException(final Throwable pCause, final String exceptionMessage,final String exceptionMessageId, boolean isValidationException) {
		super(exceptionMessageId);
		this.exceptionMessageId = exceptionMessageId;
		this.exceptionMessage = exceptionMessage;
		this.cause = pCause;	
		this.isValidationException = isValidationException;
		
		this.stackTrace = generatePrintStackTrace(pCause);
		this.logMessage(pCause,stackTrace,exceptionMessageId);
	}
	
	/**
	 * Parameterized constructor BaseException with exception message, exception message id and exception root
	 * 
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 * @param exceptionRoot
	 */
	public BaseException(final String exceptionMessage, String exceptionMessageId, String exceptionRoot) {
		super(exceptionMessageId);
		this.exceptionMessage = exceptionMessage;
		this.exceptionMessageId = exceptionMessageId;
		this.exceptionRoot = exceptionRoot;
	}
	
	/**
	 * Parameterized constructor BaseException with exception message, exception message id, exception root and timestamp 
	 * 
	 * @param exceptionMessage
	 * @param exceptionMessageId
	 * @param exceptionRoot
	 * @param timestamp
	 */
	public BaseException(final String exceptionMessage, String exceptionMessageId, String exceptionRoot, Date timestamp) {
		super(exceptionMessageId);
		this.exceptionMessage = exceptionMessage;
		this.exceptionMessageId = exceptionMessageId;
		this.exceptionRoot = exceptionRoot;
		this.timestamp = timestamp;
	}
	
	/**
	* generates the stack trace string for this exceptionMessage
	* @param pCause this can be exception of any type
	* @returns the stack trace string
	*/
	private String generatePrintStackTrace(Throwable pCause){
		StringWriter stringWriter = new StringWriter();
		pCause.printStackTrace(new PrintWriter(stringWriter));
		return stringWriter.toString();
	}
	
	
	/**
	 * logMessage - logs message and message id to log file. Logs only debug messages.
	 * @param pMessage
	 * @param pMessageId
	 */
	private void logMessage(String pMessage, String pMessageId){
		log.debug(pMessage,pMessageId,CLASS_NAME);
	}

	
	/**
	 * logMessage - logs message, message id and throwable. Logs only debug messages.
	 * @param throwable
	 * @param pMessage
	 * @param pMessageId
	 */
	private void logMessage(Throwable throwable, String pMessage, String pMessageId){
		log.debug(pMessage,pMessageId,throwable);
	}
	
	/**
	 * @return the exceptionMessage
	 */
	public String getExceptionMessage() {
		return exceptionMessage;
	}

	/**
	 * @return the exceptionMessageId
	 */
	public String getExceptionMessageId() {
		return exceptionMessageId;
	}
	
	/**
	 * get internal message for logging
	 * @return String
	 */
	public String getInternalMessage()
	{
		return this.internalMessage;
	}
	
	
	/**
	 * gets presentable message for the UI
	 * @return String
	 */
	public String getPresentableMessage()
	{
		return this.presentableMessage;
	}

	/**
	 * @return the exceptionRoot
	 */
	public String getExceptionRoot() {
		return exceptionRoot;
	}

	/**
	 * @return the timestamp
	 */
	public Date getTimestamp() {
		return timestamp;
	}

	/**
	 * @return the isValidationException
	 */
	public boolean isValidationException() {
		return isValidationException;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	/**
	 * @return stack trace as String
	 */
	public String getStackTraceAsString(){
		return this.stackTrace;
	}
	
	/**
	 * @param exceptionMessage the exceptionMessage to set
	 */
	public void setExceptionMessage(String exceptionMessage) {
		this.exceptionMessage = exceptionMessage;
	}

	/**
	 * @param exceptionMessageId the exceptionMessageId to set
	 */
	public void setExceptionMessageId(String exceptionMessageId) {
		this.exceptionMessageId = exceptionMessageId;
	}

	/**
	 * @param exceptionRoot the exceptionRoot to set
	 */
	public void setExceptionRoot(String exceptionRoot) {
		this.exceptionRoot = exceptionRoot;
	}

	/**
	 * @param timestamp the timestamp to set
	 */
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	/**
	 * @param isValidationException the isValidationException to set
	 */
	public void setValidationException(boolean isValidationException) {
		this.isValidationException = isValidationException;
	}
	
	
	/**
	 * resolveInternalMessage - resolves the message code by actual message from the ExceptionInternalMessages Properties file
	 * @param exceptionMessageId
	 * @return String
	 */
	private String resolveInternalMessage(String confName){
		String confValue = StringUtils.EMPTY;
		try
		{
			Configuration conf=configurationAdmin.getConfiguration(AdcFSLConstants.EXCEPTION_INTERNAL_MESSAGES);
			if(conf != null){
				confValue = conf.getProperties().get(confName) != null ? conf.getProperties().get(confName).toString() : AdcFSLConstants.EMPTY ;
			}
		}
		catch(Exception ex){
			logMessage(ex, "Unable to read config property", confName);
		}
		
		return confValue;
	}
	

	
}
