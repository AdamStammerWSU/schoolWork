package per.as.par;

import java.awt.Graphics;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Parvata {

	public boolean debug;

	BufferedImage input1;
	BufferedImage cropped;
	BufferedImage output;

	String inputPrefix = "";
	String outputPrefix = "output";

	int sigCount = 1;
	int inputPageWidth = 0, inputPageHeight = 0;
	int pageHeight = 0, pageWidth = 0;

	int inputPageOffset = 0;
	int outputPageOffset = 0;
	int signatureInputPageCount = 4;
	int signatureOutputPageCount = 1;

	public Parvata(boolean debug, String inputPrefix, String outputPrefix) {
		this.debug = debug;
		this.inputPrefix = inputPrefix;
		this.outputPrefix = outputPrefix;
	}

	public void spanishImposition() {
		for (int i = 0; i < sigCount; i++) {
			System.out.println("Imposing " + inputPageOffset + "-" + (inputPageOffset + signatureInputPageCount - 1)
					+ " to " + outputPageOffset + "-" + (outputPageOffset + signatureOutputPageCount - 1));
			signatureImpose();
			inputPageOffset += signatureInputPageCount;
			outputPageOffset += signatureOutputPageCount;
		}

		System.out.println("Done!");
	}

	private void signatureImpose() {

		int inputPage0OffsetOrdering[] = { 4, 11, 3, 12 };
		int inputPage1OffsetOrdering[] = { 10, 5, 13, 2 };
		int inputPage2OffsetOrdering[] = { 6, 9, 1, 14 };
		int inputPage3OffsetOrdering[] = { 8, 7, 15, 0 };
		int i = 0;

		// render the 4 output pages
		BufferedImage page0 = renderPage(pageWidth, pageHeight,
				inputPrefix + String.format("%04d", inputPage0OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage0OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage0OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage0OffsetOrdering[i++] + inputPageOffset) + ".png");
		i = 0;
		BufferedImage page1 = renderPage(pageWidth, pageHeight,
				inputPrefix + String.format("%04d", inputPage1OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage1OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage1OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage1OffsetOrdering[i++] + inputPageOffset) + ".png");
		i = 0;
		BufferedImage page2 = renderPage(pageWidth, pageHeight,
				inputPrefix + String.format("%04d", inputPage2OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage2OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage2OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage2OffsetOrdering[i++] + inputPageOffset) + ".png");
		i = 0;
		BufferedImage page3 = renderPage(pageWidth, pageHeight,
				inputPrefix + String.format("%04d", inputPage3OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage3OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage3OffsetOrdering[i++] + inputPageOffset) + ".png",
				inputPrefix + String.format("%04d", inputPage3OffsetOrdering[i++] + inputPageOffset) + ".png");

		// save the page
		saveFile(page0, outputPrefix + String.format("%04d", 0 + outputPageOffset) + ".png");
		saveFile(page1, outputPrefix + String.format("%04d", 1 + outputPageOffset) + ".png");
		saveFile(page2, outputPrefix + String.format("%04d", 2 + outputPageOffset) + ".png");
		saveFile(page3, outputPrefix + String.format("%04d", 3 + outputPageOffset) + ".png");
	}

	private BufferedImage renderPage(int width, int height, String a, String b, String c, String d) {
		// declare input images
		BufferedImage bufA;
		BufferedImage bufB;
		BufferedImage bufC;
		BufferedImage bufD;

		// read in the images
		bufA = readFile(a);
		bufB = readFile(b);
		bufC = readFile(c);
		bufD = readFile(d);

		// size output image accordingly
		setPageWidth(bufA.getWidth() * 2);
		setPageHeight(bufA.getHeight() * 2);

		// create output image to draw on
		BufferedImage page = new BufferedImage(pageWidth, pageHeight, BufferedImage.TYPE_INT_ARGB);
		Graphics pageGraphics = page.getGraphics();

		bufA = flipImage(bufA, (byte) 3);
		bufB = flipImage(bufB, (byte) 3);

		// draw on the page |A B|
		// -----------------|C D|
		// with A and B upside down
		pageGraphics.drawImage(bufA, 0, 0, null);
		pageGraphics.drawImage(bufB, bufB.getWidth(), 0, null);
		pageGraphics.drawImage(bufC, 0, bufC.getHeight(), null);
		pageGraphics.drawImage(bufD, bufD.getWidth(), bufD.getHeight(), null);

		return page;
	}

	private BufferedImage flipImage(BufferedImage image, byte axis) {
		// 0 -> no flip
		// 1 -> vertical flip
		// 2 -> horizontal flip
		// 3 -> both flip (equal to 180 degree rotation)

		int scaleHo = (((axis >> 1) % 2) == 1) ? -1 : 1;
		int scaleV = ((axis % 2) == 1) ? -1 : 1;

		int scaleWidth = -image.getWidth() * ((axis >> 1) % 2);
		int scaleHeight = -image.getHeight() * (axis % 2);

		AffineTransform tx = AffineTransform.getScaleInstance(scaleHo, scaleV);
		tx.translate(scaleWidth, scaleHeight);
		AffineTransformOp op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
		image = op.filter(image, null);

		return image;
	}

	private void saveFile(BufferedImage image, String name) {
		try {
			ImageIO.write(image, "png", new File(name));
		} catch (IOException e) {
			System.out.println("Failed to write " + name + ".");
			Main.exit(true);
			e.printStackTrace();
		}
	}

	private BufferedImage readFile(String name) {
		try {
			return ImageIO.read(new File(name));
		} catch (IOException e) {
			System.out.println("Failed to read " + name + ".");
			Main.exit(true);
			e.printStackTrace();
		}
		return null;
	}

	public void setSignatureCount(int sigCount) {
		if (sigCount < 1) {
			System.out.println("Signature count must be >= 1");
			Main.exit(true);
		} else {
			this.sigCount = sigCount;
		}
	}

	public void setSignatureInputPageCount(int inputPageCount) {
		this.signatureInputPageCount = inputPageCount;
	}

	public void setSignatureOutputPageCount(int outputPageCount) {
		this.signatureOutputPageCount = outputPageCount;
	}

	public void setPageWidth(int pageWidth) {
		this.pageWidth = pageWidth;
	}

	public void setPageHeight(int pageHeight) {
		this.pageHeight = pageHeight;
	}

	public void setOutputPageOffset(int offset) {
		this.outputPageOffset = offset;
	}

	public void setInputPageOffset(int offset) {
		this.inputPageOffset = offset;
	}

	public int getSignatureCount() {
		return sigCount;
	}

	public int getSignatureSize() {
		return signatureInputPageCount;
	}

	public int getPageWidth() {
		return pageWidth;
	}

	public int getPageHeight() {
		return pageHeight;
	}

	public int getInputPageOffset() {
		return inputPageOffset;
	}

	public int getOutputPageOffset() {
		return outputPageOffset;
	}

	public int getSignatureInputPageCount() {
		return signatureInputPageCount;
	}

	public int getSignatureOutputPageCount() {
		return signatureOutputPageCount;
	}
}
