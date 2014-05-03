/*
 * An XML Jasper interface; Takes XML data from the standard input
 * and uses JRXmlDataSource to generate Jasper reports in the
 * specified output format using the specified compiled Jasper design.
 * 
 * Inspired by the xmldatasource sample application provided with
 * jasperreports-1.1.0
 */

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter; 
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRXmlDataSource;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.query.JRXPathQueryExecuterFactory;


import java.util.Map; 
import java.util.HashMap;

/**
 * @author Jonas Schwertfeger (jonas at schwertfeger dot ch)
 * @version $Id: XmlJasperInterface.java 97 2005-11-23 14:48:15Z js $
 */
public class XmlJasperInterface {
  private static final String TYPE_PDF = "pdf";
  private static final String TYPE_XML = "xml";
  private static final String TYPE_RTF = "rtf";
  private static final String TYPE_XLS = "xls";
  private static final String TYPE_CSV = "csv";
  private static final String TYPE_HTML = "html";
  
  private String outputType;
  private String compiledDesign;
  private String selectCriteria;
  private String imageDirectory;

  public static void main(String[] args) {
    String outputType = null;
    String compiledDesign = null;
    String selectCriteria = null;
    String imageDirectory = null;

    if (args.length != 4) {
      printUsage();
      return;
    }

    for (int k = 0; k < args.length; ++k) {
      if (args[k].startsWith("-o"))
        outputType = args[k].substring(2);
      else if (args[k].startsWith("-f"))
        compiledDesign = args[k].substring(2);
      else if (args[k].startsWith("-x"))
        selectCriteria = args[k].substring(2);
      else if (args[k].startsWith("-d"))
          imageDirectory = args[k].substring(2);
    }
    
    XmlJasperInterface jasperInterface = new XmlJasperInterface(outputType, compiledDesign, selectCriteria,imageDirectory);
    if (!jasperInterface.report()) {
      System.exit(1);
    }
  }
  
  public XmlJasperInterface(
      String outputType,
      String compiledDesign,
      String selectCriteria,
      String imagesDirectory) {
    this.outputType = outputType;
    this.compiledDesign = compiledDesign;
    this.selectCriteria = selectCriteria;
    this.imageDirectory = imagesDirectory;
  }
  
  public boolean report() {
    try {

      Map params = new HashMap();

      
      if (TYPE_XLS.equals(outputType)) {
    	  params.put(JRParameter.IS_IGNORE_PAGINATION, Boolean.TRUE);  
      }

      JRXmlDataSource reportSource = new JRXmlDataSource(System.in, selectCriteria);
      reportSource.setDatePattern("yyyy-MM-dd");
  //    reportSource.setNumberPattern("####0.00");
      
      JasperPrint jasperPrint = JasperFillManager.fillReport(compiledDesign, params, reportSource );    	  
     
      
      
      if (TYPE_PDF.equals(outputType)) {
        JasperExportManager.exportReportToPdfStream(jasperPrint, System.out);
      }
      else if (TYPE_XML.equals(outputType)) {
        JasperExportManager.exportReportToXmlStream(jasperPrint, System.out);
      }
      else if (TYPE_RTF.equals(outputType)) {
        JRRtfExporter rtfExporter = new JRRtfExporter();
        rtfExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        rtfExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
        rtfExporter.exportReport();
      }
      else if (TYPE_XLS.equals(outputType)) {
        JRXlsExporter xlsExporter = new JRXlsExporter();
        xlsExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        xlsExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);        
        xlsExporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET, Integer.decode("60000"));
        xlsExporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
        xlsExporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN, Boolean.TRUE);
        xlsExporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
        xlsExporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
        xlsExporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);  
        xlsExporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);  
         
//        xlsExporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
        xlsExporter.exportReport();
      }
      else if (TYPE_CSV.equals(outputType)) {
        JRCsvExporter csvExporter = new JRCsvExporter();
        csvExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        csvExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
        csvExporter.exportReport();
      }
      else if (TYPE_HTML.equals(outputType)) {
    	  	JRHtmlExporter htmlExporter = new JRHtmlExporter();
    	  	htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
    	  	htmlExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
    	  	htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.TRUE);  	
    	  	htmlExporter.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR, Boolean.TRUE);
    	  	htmlExporter.setParameter(JRHtmlExporterParameter.IMAGES_DIR_NAME, this.imageDirectory);
    	  	htmlExporter.setParameter(JRHtmlExporterParameter.IMAGES_URI,"/images/reports/");
    	  	
    	  	
    	  	htmlExporter.exportReport();
      } else {
        printUsage();
      }
    } catch (JRException e) {
      e.printStackTrace();
      return false;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
    return true;
  }
  
  private static void printUsage() {
    System.out.println("XmlJasperInterface usage:");
    System.out.println("\tjava XmlJasperInterface -oOutputType -fCompiledDesign -xSelectExpression -dImageDirectory< input.xml > report\n");
    System.out.println("\tOutput types:\t\tpdf | xml | rtf | xls | csv | html");
    System.out.println("\tCompiled design:\tFilename of the compiled Jasper design");
    System.out.println("\tSelect expression:\tXPath expression that specifies the select criteria");
    System.out.println("\t\t\t\t(See net.sf.jasperreports.engine.data.JRXmlDataSource for further information)");
    System.out.println("\tStandard input:\t\tXML input data");
    System.out.println("\tStandard output:\tReport generated by Jasper");
  }
}
