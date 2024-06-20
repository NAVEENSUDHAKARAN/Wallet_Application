package com.chainsys.dao;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import com.chainsys.model.WalletIdInfo;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
public class DynamicQR {

	private DynamicQR() {
        throw new IllegalStateException("Utility class");
    }
	
	public static void generateQr(String imageName, String qrCodeData, WalletIdInfo walletIdInfo) {
	    try {
	        String filePath = "C:\\Users\\nave3557\\git\\WalletApplication\\WalletApplication\\src\\main\\webapp\\images\\" + imageName + ".png";
	        String charset = "UTF-8";
	        Map<EncodeHintType, ErrorCorrectionLevel> hintMap = new HashMap<>();
	        hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
	        BitMatrix matrix = new MultiFormatWriter().encode(
	            new String(qrCodeData.getBytes(charset), charset),
	            BarcodeFormat.QR_CODE, 200, 200, hintMap);
	        MatrixToImageWriter.writeToFile(matrix, filePath.substring(filePath.lastIndexOf('.') + 1), new File(filePath));
	       
	        byte[] qrCodeImageData = Files.readAllBytes(Paths.get(filePath));
	        
	        walletIdInfo.setImage(qrCodeImageData);
	        
	    } catch (Exception e) {
	       e.printStackTrace();
	    }
	}

}
