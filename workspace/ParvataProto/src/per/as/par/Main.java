package per.as.par;

public class Main {

	static boolean debug = true;
	static boolean helpPrinted = false;

	public static void main(String[] args) {
		Parvata pav = null;
		if (args.length < 2) {
			System.out.println("More information needed. Printing help (--?, --help)");
			printHelp();
		} else {
			pav = new Parvata("f", args[args.length - 2], args[args.length - 1]);
			for (int i = 0; i < args.length - 2; i++) {
				String arg = args[i];
				switch (arg) {
				case "-w":
					pav.setPageWidth(Integer.parseInt(args[++i]));
					System.out.println("Page Width Set To " + pav.getPageWidth());
					break;
				case "-h":
					pav.setPageHeight(Integer.parseInt(args[++i]));
					System.out.println("Page Height Set To " + pav.getPageHeight());
					break;
				case "-outoff":
				case "-fo":
				case "-firstout":
					pav.setOutputPageOffset(Integer.parseInt(args[++i]));
					System.out.println("Page Output Offset Set To " + pav.getOutputPageOffset());
					break;
				case "-inoff":
				case "-fi":
				case "-firstin":
					pav.setInputPageOffset(Integer.parseInt(args[++i]));
					System.out.println("Page Input Offset Set To " + pav.getInputPageOffset());
					break;
				case "-sc":
					pav.setSignatureCount(Integer.parseInt(args[++i]));
					System.out.println("Signature Count Set To " + pav.getSignatureCount());
					break;
				default:
					printHelp();
					break;
				}
			}
			System.out.println("Attempting to impose...");
			pav.spanishImposition();
		}

	}

	public static void printHelp() {
		if (!helpPrinted) {
			System.out.println("Usage: pavarta [options] <imageprefix> <output file>");
			System.out.println("\t imageprefix -> \t images must end in a four digit number padded by zeros");
			System.out
					.println("\t\t\t\t if the first file is named inputImage0000.png, the prefix would \"inputImage\"");
			System.out.println("\t output file -> \t file name of output pdf. Must include file extension");
			System.out.println("\t\t\t\t EX: \"outputFile.pdf\"");

			System.out.println("\t [OPTIONS]   ---------");
			System.out.println("\t\t -fi, -firstin, -inoff:\t Sets the suffix number of the first input page");
			System.out.println("\t\t\t\t\t If the first input page of signature 3 is the 32nd page use \"-inoff 32\"");
			System.out.println("\t\t -fo, -firstout, -outoff:\t Sets the suffix number of the first output page");
			helpPrinted = true;
		}
	}

	public static void exit(boolean inProcess) {
		System.out.print("System Exiting");
		if (inProcess) {
			System.out.print(" while in process");
		}
		System.out.println("...");
		System.exit(0);
	}
}
