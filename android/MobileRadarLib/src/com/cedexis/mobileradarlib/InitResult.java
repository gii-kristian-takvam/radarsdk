package com.cedexis.mobileradarlib;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import android.util.Log;

public class InitResult {
    
    private static final String TAG = "InitResult";
    
    private String _requestSignaure;
    
    public String getRequestSignature() {
        return this._requestSignaure;
    }
    
    public InitResult(String requestSignature) {
        this._requestSignaure = requestSignature;
    }
    
    public static InitResult doInit(int zoneId, int customerId, String initHost) {
        Random randomGenerator = new Random();
        int transactionId = randomGenerator.nextInt(2147483647);
        StringBuilder initURL = new StringBuilder();
        initURL.append("http://i1-");
        initURL.append("an-");
        initURL.append(String.format("%d-", 0));
        initURL.append(String.format("%d-", 1));
        initURL.append(String.format("%02d-", zoneId));
        initURL.append(String.format("%05d-", customerId));
        initURL.append(String.format("%d-i.", transactionId));
        initURL.append(initHost);
        initURL.append("/i1");
        initURL.append(String.format("/%d", new Date().getTime() / 1000));
        initURL.append(String.format("/%d", transactionId));
        initURL.append("/xml");
        initURL.append(String.format("?rnd=%s", UUID.randomUUID().toString()));
        Log.d(TAG, "Init URL: " + initURL.toString());
        DocumentBuilder builder;
        try {
            builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            Document document = builder.parse(new URL(initURL.toString())
                .openStream());
            //Log.d(TAG, "Init document: " + document);
            
            XPath xpath = XPathFactory.newInstance().newXPath();
            XPathExpression expr = xpath
                    .compile("/initResponse/requestSignature/text()");
            String requestSignature = expr.evaluate(document);
            Log.d(TAG, "Request signature: " + requestSignature);
            expr = xpath.compile("/initResponse/countryIso/text()");
            String country = expr.evaluate(document);
            Log.d(TAG, "Country: " + country);
            
            expr = xpath.compile("/initResponse/networkType/text()");
            String networkType = expr.evaluate(document);
            Log.d(TAG, "Network type: " + networkType);
            //Log.d(TAG, "Network type (class): " + networkType.getClass());
            //Log.d(TAG, "Network type is ZLS: " + ("" == networkType));
            
            InitResult result = new InitResult(requestSignature);
            return result;
        }
        catch (ParserConfigurationException e) {
        }
        catch (MalformedURLException e) {
        }
        catch (SAXException e) {
        }
        catch (IOException e) {
        }
        catch (XPathExpressionException e) {
        }
        return null;
    }
}