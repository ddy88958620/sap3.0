package com.hcicloud.sap.common.utils;

import java.io.IOException;
import java.io.StringReader;
import java.util.Vector;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.TermAttribute;

import net.paoding.analysis.analyzer.PaodingAnalyzer;
import net.sf.classifier4J.ITokenizer;

/**
 * @author hongyu
 */
public class PaodingTokenizer implements ITokenizer {
	
	private Analyzer paoding;
	
	public PaodingTokenizer() {
		paoding = new PaodingAnalyzer();
	}

	@Override
	public String[] tokenize(String input) {
		if(input != null) {
			StringReader inputReader = new StringReader(input);
			TokenStream ts = paoding.tokenStream("", inputReader);
			TermAttribute termAtt = (TermAttribute)ts.getAttribute(TermAttribute.class);
			
			Vector<String> tokens = new Vector<String>();
			try {
				while(ts.incrementToken()) {
					tokens.add(termAtt.term());
				}
				return tokens.toArray(new String[0]);
			} catch (IOException e) {
				return new String[0];
			}
		} else {
			return new String[0];
		}
	}

}