package com.hcicloud.sap.service.webservice;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for saParams complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="saParams">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="audioFormat" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="fileExtention" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="reservedParam01" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="reservedParam02" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="reservedParam03" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "saParams", propOrder = { "audioFormat", "fileExtention",
		"reservedParam01", "reservedParam02", "reservedParam03" })
public class SaParams {

	protected String audioFormat;
	protected String fileExtention;
	protected String reservedParam01;
	protected String reservedParam02;
	protected String reservedParam03;

	/**
	 * Gets the value of the audioFormat property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAudioFormat() {
		return audioFormat;
	}

	/**
	 * Sets the value of the audioFormat property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAudioFormat(String value) {
		this.audioFormat = value;
	}

	/**
	 * Gets the value of the fileExtention property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getFileExtention() {
		return fileExtention;
	}

	/**
	 * Sets the value of the fileExtention property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setFileExtention(String value) {
		this.fileExtention = value;
	}

	/**
	 * Gets the value of the reservedParam01 property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedParam01() {
		return reservedParam01;
	}

	/**
	 * Sets the value of the reservedParam01 property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedParam01(String value) {
		this.reservedParam01 = value;
	}

	/**
	 * Gets the value of the reservedParam02 property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedParam02() {
		return reservedParam02;
	}

	/**
	 * Sets the value of the reservedParam02 property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedParam02(String value) {
		this.reservedParam02 = value;
	}

	/**
	 * Gets the value of the reservedParam03 property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedParam03() {
		return reservedParam03;
	}

	/**
	 * Sets the value of the reservedParam03 property.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedParam03(String value) {
		this.reservedParam03 = value;
	}

}
