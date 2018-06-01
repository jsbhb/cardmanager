package com.card.manager.factory.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.card.manager.factory.goods.model.GoodsStockEntity;
import com.card.manager.factory.order.pojo.ExpressMaintenanceBO;

public class ExcelUtil {
	/**
	 * 生成excel文件
	 * 
	 * @param list 数据
	 * @param nameArray 表头中文
	 * @param colArray 需要生成的列
	 * @param clazz list中对象的类型
	 * @return 
	 */
	public static void createExcel(List dataList,String[] nameArray,String[] colArray,String filePath, int index, String sheetName, Workbook swb) throws Exception{
		File dir = new File(filePath.substring(0,filePath.lastIndexOf("/")));
		int size = dataList.size();//list长度
		Class clazz = null;//list中数据类型
		Sheet sheet = null;//工作表
		Row row = null;
		index++;
		
		if(!dir.exists()){
			dir.mkdirs();
		}
		
		sheet = swb.getSheet(sheetName);
		if(sheet != null){
			swb.removeSheetAt(swb.getSheetIndex(sheetName));
		}
		
		sheet = swb.getSheet(sheetName);
		if(sheet == null){
			sheet = swb.createSheet(sheetName);
			row = sheet.createRow(0);
			for (int i = 0; i < nameArray.length; i++) {
				Cell cell = row.createCell(i);
				cell.setCellValue(nameArray[i]);
			}
		}
		
		if (size>0) {
			clazz = dataList.get(0).getClass();
			Method[] methods = new Method[colArray.length];//方法数组
			for (int i = 0; i < colArray.length; i++) {
				Method m = clazz.getMethod("get" + colArray[i], null);
				methods[i] = m;
			}
			
			int j = index;
			for (Object o : dataList) {
				row = sheet.createRow(j);
				for (int i = 0; i < nameArray.length; i++) {
					Cell cell = row.createCell(i);
					cell.setCellValue(methods[i].invoke(o, null)==null ? "" :methods[i].invoke(o, null) + "");
				}
				j++;
			} 
		}
		
	}
	
	public static void writeToExcel(Workbook swb, String filePath) throws Exception{
		FileOutputStream fileOut = new FileOutputStream(filePath);
		swb.write(fileOut);
		fileOut.close();
	}
	
	private static List<Object> readExcel(String path, String type) throws IOException {
		if (path == null || "".equals(path)) {
			return null;
		} else {
			String postfix = path.substring(path.lastIndexOf(".") + 1, path.length());
			if (!"".equals(postfix)) {
				if ("xls".equals(postfix)) {
//					return readXls(path, clazz);
					return null;
				} else if ("xlsx".equals(postfix)) {
					return readXlsx(path, type);
				}
			} else {
				return null;
			}
		}
		return null;
	}

	/**
	 * Read the Excel 2010
	 * 
	 * @param path
	 *            the path of the excel file
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	private static List<Object> readXlsx(String path, String type) throws IOException {
		List<Object> list = new ArrayList<Object>();
		InputStream is = new FileInputStream(path);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
		// Read the Sheet
		XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);
		if (xssfSheet == null) {
			return null;
		}

		// Read the Row
//		List<String> colNameList = new ArrayList<>();
		for (int rowNum = 0; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
			XSSFRow xssfRow = xssfSheet.getRow(rowNum);
			if (xssfRow != null && rowNum == 0) {
//				Short start = xssfRow.getFirstCellNum();
//				Short end = xssfRow.getLastCellNum();
//				for (int i = start; i <= end; i++) {
//					colNameList.add(getValue(xssfRow.getCell(i)));
//				}
			}else if(xssfRow != null && rowNum > 0){
				try {
					if ("stock".equals(type)) {
						if ("0".equals(getValue(xssfRow.getCell(7)))) {
							continue;
						}
						GoodsStockEntity model = new GoodsStockEntity();
						model.setItemId(Integer.parseInt(getValue(xssfRow.getCell(1)))+"");
						if (getValue(xssfRow.getCell(7)).indexOf(".")>0) {
							model.setFxQty(Integer.parseInt(getValue(xssfRow.getCell(7)).substring(0,getValue(xssfRow.getCell(7)).lastIndexOf("."))));
						} else {
							model.setFxQty(Integer.parseInt(getValue(xssfRow.getCell(7))));
						}
//						model.setFxQty((int)Double.parseDouble(getValue(xssfRow.getCell(7))));
						list.add(model);
					} else if ("order".equals(type)) {
						if ("".equals(getValue(xssfRow.getCell(0)))
								||"".equals(getValue(xssfRow.getCell(1)))
								||"".equals(getValue(xssfRow.getCell(2)))) {
							continue;
						}
						ExpressMaintenanceBO model = new ExpressMaintenanceBO();
						model.setOrderId(getValue(xssfRow.getCell(0)));
						model.setExpressName(getValue(xssfRow.getCell(1)));
						if (getValue(xssfRow.getCell(2)).indexOf(".")>0) {
							model.setExpressId(getValue(xssfRow.getCell(2)).substring(0,getValue(xssfRow.getCell(2)).lastIndexOf(".")));
						} else {
							model.setExpressId(getValue(xssfRow.getCell(2)));
						}
						list.add(model);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
		}
		return list;
	}

	/**
	 * Read the Excel 2003-2007
	 * 
	 * @param path
	 *            the path of the Excel
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	private static <T> List<T> readXls(String path, Class clazz) throws IOException {
		List<T> list = new ArrayList<T>();
		InputStream is = new FileInputStream(path);
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		T hSModel = null;
		// Read the Sheet
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		if (hssfSheet == null) {
			return null;
		}

		// Read the Row
		List<String> colNameList = new ArrayList<>();
		for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
			HSSFRow hssfRow = hssfSheet.getRow(rowNum);
			if (hssfRow != null && rowNum == 0) {
				Short start = hssfRow.getFirstCellNum();
				Short end = hssfRow.getLastCellNum();
				for (int i = start; i <= end; i++) {
					colNameList.add(getValue(hssfRow.getCell(i)));
				}
			}else if(hssfRow != null && rowNum > 0){
				try {
					hSModel = (T) clazz.newInstance();
					for(int i=0;i<colNameList.size();i++){
						Method method = clazz.getMethod("set" + colNameList.get(i),String.class);
						method.invoke(hSModel, getValue(hssfRow.getCell(i)));
					}
					list.add(hSModel);
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
		}
		return list;
	}

	@SuppressWarnings("static-access")
	private static String getValue(XSSFCell xssfRow) {
		if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {
			return String.valueOf(xssfRow.getBooleanCellValue());
		} else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {
			return String.valueOf(xssfRow.getNumericCellValue());
		} else {
			return String.valueOf(xssfRow.getStringCellValue());
		}
	}

	@SuppressWarnings("static-access")
	private static String getValue(HSSFCell hssfCell) {
		if (hssfCell == null) {
			return "";
		}
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			return String.valueOf(hssfCell.getNumericCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_STRING) {
			return String.valueOf(hssfCell.getStringCellValue());
		} else {
			return "";
		}
	}

	public static List<Object> getCache(String path, String type) {
		try {
			return readExcel(path, type);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	 
}
