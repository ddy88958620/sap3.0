package com.hcicloud.sap.service.webservice;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Logger;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;

/**
 * This class was generated by the JAX-WS RI. JAX-WS RI 2.1.3-hudson-390-
 * Generated source version: 2.0
 * <p>
 * An example of how this class may be used:
 * 
 * <pre>
 * SpeechToTextService service = new SpeechToTextService();
 * SpeechToTextDelegate portType = service.getSpeechToTextPort();
 * portType.getStatus(...);
 * </pre>
 * 
 * </p>
 * 
 */
@WebServiceClient(name = "SpeechToTextService", targetNamespace = "http://webservice.sap.hcicloud.com/", wsdlLocation = "http://10.0.1.176:8080/AsrTransService/SpeechToTextPort?wsdl")
public class SpeechToTextService extends Service {

	private final static URL SPEECHTOTEXTSERVICE_WSDL_LOCATION;
	private final static Logger logger = Logger
			.getLogger(com.hcicloud.sap.service.webservice.SpeechToTextService.class
					.getName());

	static {
		URL url = null;
		try {
			URL baseUrl;
			baseUrl = com.hcicloud.sap.service.webservice.SpeechToTextService.class
					.getResource(".");
			url = new URL(baseUrl,
					"http://10.0.1.176:8080/AsrTransService/SpeechToTextPort?wsdl");
		} catch (MalformedURLException e) {
			logger.warning("Failed to create URL for the wsdl Location: 'http://10.0.1.176:8080/AsrTransService/SpeechToTextPort?wsdl', retrying as a local file");
			logger.warning(e.getMessage());
		}
		SPEECHTOTEXTSERVICE_WSDL_LOCATION = url;
	}

	public SpeechToTextService(URL wsdlLocation, QName serviceName) {
		super(wsdlLocation, serviceName);
	}

	public SpeechToTextService() {
		super(SPEECHTOTEXTSERVICE_WSDL_LOCATION, new QName(
				"http://webservice.sap.hcicloud.com/", "SpeechToTextService"));
	}

	/**
	 * 
	 * @return returns SpeechToTextDelegate
	 */
	@WebEndpoint(name = "SpeechToTextPort")
	public SpeechToTextDelegate getSpeechToTextPort() {
		return super.getPort(new QName("http://webservice.sap.hcicloud.com/",
				"SpeechToTextPort"), SpeechToTextDelegate.class);
	}

}
