package com.hcicloud.sap.service.webservice;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for saResult complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="saResult">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="failedList" type="{http://webservice.sap.hcicloud.com/}failedFile" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="processedCount" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="squenceId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="status" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="totalFileCount" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "saResult", propOrder = { "failedList", "processedCount",
		"squenceId", "status", "totalFileCount" })
public class SaResult {

	@XmlElement(nillable = true)
	protected List<FailedFile> failedList;
	protected int processedCount;
	protected String squenceId;
	protected String status;
	protected int totalFileCount;

	/**
	 * Gets the value of the failedList property.
	 * 
	 * <p>
	 * This accessor method returns a reference to the live list, not a
	 * snapshot. Therefore any modification you make to the returned list will
	 * be present inside the JAXB object. This is why there is not a
	 * <CODE>set</CODE> method for the failedList property.
	 * 
	 * <p>
	 * For example, to add a new item, do as follows:
	 * 
	 * <pre>
	 * getFailedList().add(newItem);
	 * </pre>
	 * 
	 * 
	 * <p>
	 * Objects of the following type(s) are allowed in the list
	 * {@link FailedFile }
	 * 
	 * 
	 */
	public List<FailedFile> getFailedList() {
		if (failedList == null) {
			failedList = new ArrayList<FailedFile>();
		}
		return this.failedList;
	}

	/**
	 * Gets the value of the processedCount property.
	 * 
	 */
	public int getProcessedCount() {
		return processedCount;
	}

	/**
	 * Sets the value of the processedCount property.
	 * 
	 */
	public void setProcessedCount(int value) {
		this.processedCount = value;
	}

	/**
	 * Gets the value of the squenceId property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSquenceId() {
		return squenceId;
	}

	/**
	 * Sets the value of the squenceId property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSquenceId(String value) {
		this.squenceId = value;
	}

	/**
	 * Gets the value of the status property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * Sets the value of the status property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setStatus(String value) {
		this.status = value;
	}

	/**
	 * Gets the value of the totalFileCount property.
	 * 
	 */
	public int getTotalFileCount() {
		return totalFileCount;
	}

	/**
	 * Sets the value of the totalFileCount property.
	 * 
	 */
	public void setTotalFileCount(int value) {
		this.totalFileCount = value;
	}

}
