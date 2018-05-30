package com.card.manager.factory.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.card.manager.factory.goods.grademodel.GradeTypeDTO;

public class ExcelUtils {

	private static ExcelUtils instance = null;

	public static ExcelUtils instance() {
		if (instance == null) {
			instance = new ExcelUtils();
		}

		return instance;
	}

	/**
	 * read the Excel file
	 * 
	 * @param path
	 *            the path of the Excel file
	 * @return
	 * @throws IOException
	 */
	public <T> List<T> readExcel(String path, Class<? extends Object> clazz, boolean needConvert) {
		if (path == null || "".equals(path)) {
			return null;
		} else {
			String postfix = path.substring(path.lastIndexOf(".") + 1, path.length());
			if (!"".equals(postfix)) {
				if ("xls".equals(postfix)) {
					return readXls(path, clazz, needConvert);
				} else if ("xlsx".equals(postfix)) {
					return readXlsx(path, clazz, needConvert);
				}
			} else {
				return null;
			}
		}
		return null;
	}

	/**
	 * @fun 增加头部列(头部包括第一行描述和第二行系统字段)
	 * @param path
	 * @param row
	 * @throws IOException
	 */
	public void addHead(String path, List<GradeTypeDTO> list) throws IOException {
		if (path == null || "".equals(path)) {
			return;
		} else {
			String postfix = path.substring(path.lastIndexOf(".") + 1, path.length());
			if (!"".equals(postfix)) {
				if ("xls".equals(postfix)) {
					addHeadXls(path, list);
				} else if ("xlsx".equals(postfix)) {
					addHeadXlsx(path, list);
				}
			} else {
				return;
			}
		}
		return;
	}

	/**
	 * @fun 获取指定行最后一列
	 * @param path
	 * @return
	 */
	public String getLastColumn(String path, int row) {
		if (path == null || "".equals(path)) {
			return null;
		} else {
			String postfix = path.substring(path.lastIndexOf(".") + 1, path.length());
			if (!"".equals(postfix)) {
				if ("xls".equals(postfix)) {
					return getLastColumnXls(path, row);
				} else if ("xlsx".equals(postfix)) {
					return getLastColumnXlsx(path, row);
				}
			} else {
				return null;
			}
		}
		return null;
	}

	public <T> void createSheet(String filePath, String sheetName, List<T> list, String[] nameArray) {
		if (filePath == null || "".equals(filePath)) {
			return;
		} else {
			String postfix = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length());
			if (!"".equals(postfix)) {
				if ("xls".equals(postfix)) {
					createSheetXls(filePath, sheetName, list, nameArray);
				} else if ("xlsx".equals(postfix)) {
					createSheetXlsx(filePath, sheetName, list, nameArray);
				}
			}
		}
	}

	private <T> void createSheetXlsx(String filePath, String sheetName, List<T> list, String[] nameArray) {

	}

	private <T> void createSheetXls(String filePath, String sheetName, List<T> list, String[] nameArray) {
		HSSFWorkbook hssfWorkbook = null;
		Sheet sheet = null;// 工作表
		Row row = null;
		try {
			InputStream is = new FileInputStream(filePath);
			hssfWorkbook = new HSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		sheet = hssfWorkbook.getSheet(sheetName);
		if (sheet == null) {
			sheet = hssfWorkbook.createSheet(sheetName);
			row = sheet.createRow(0);
			for (int i = 0; i < nameArray.length; i++) {
				Cell cell = row.createCell(i);
				cell.setCellValue(nameArray[i]);
			}
		}
	}

	private ExcelUtils() {
	}

	private static DecimalFormat df = new DecimalFormat("#.######");

	@SuppressWarnings("static-access")
	private static String getValue(XSSFCell xssfRow) {
		if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {
			return String.valueOf(xssfRow.getBooleanCellValue());
		} else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {
			return String.valueOf(df.format(xssfRow.getNumericCellValue()));
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
			return String.valueOf(df.format(hssfCell.getNumericCellValue()));
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_STRING) {
			return String.valueOf(hssfCell.getStringCellValue());
		} else {
			return "";
		}
	}

	private void addHeadXls(String path, List<GradeTypeDTO> list) throws IOException {
		HSSFWorkbook hssfWorkbook = null;
		try {
			InputStream is = new FileInputStream(path);
			hssfWorkbook = new HSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		// Read the Sheet
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		if (hssfSheet == null) {
			return;
		}
		HSSFRow row1 = hssfSheet.getRow(0);
		HSSFRow row2 = hssfSheet.getRow(1);
		// 生成单元格样式
		HSSFCellStyle cellStyle = hssfWorkbook.createCellStyle();
		// 新建font实体
		HSSFFont hssfFont = hssfWorkbook.createFont();
		hssfFont.setFontName("宋体");
		// 设置字体颜色
		hssfFont.setColor(HSSFColor.RED.index);
		cellStyle.setFont(hssfFont);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);// 水平居中
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);// 垂直居中
		int coloumNum = hssfSheet.getRow(0).getPhysicalNumberOfCells();
		for (int i = 0; i < list.size(); i++) {
			Cell cell = row1.createCell(coloumNum + i);
			cell.setCellStyle(cellStyle);
			cell.setCellValue(list.get(i).getName() + "返佣比例(例0.15)*");
			cell = row2.createCell(coloumNum + i);
			cell.setCellValue("rebate_" + list.get(i).getId());
		}
		FileOutputStream excelFileOutPutStream = new FileOutputStream(path);// 写数据到这个路径上
		hssfWorkbook.write(excelFileOutPutStream);
		excelFileOutPutStream.flush();
		excelFileOutPutStream.close();
	}

	private void addHeadXlsx(String path, List<GradeTypeDTO> list) throws IOException {
		XSSFWorkbook xssfWorkbook = null;
		try {
			InputStream is = new FileInputStream(path);
			xssfWorkbook = new XSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		// Read the Sheet
		XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);
		if (xssfSheet == null) {
			return;
		}
		XSSFRow row1 = xssfSheet.getRow(0);
		XSSFRow row2 = xssfSheet.getRow(1);
		// 生成单元格样式
		XSSFCellStyle cellStyle = xssfWorkbook.createCellStyle();
		// 新建font实体
		XSSFFont xssfFont = xssfWorkbook.createFont();
		xssfFont.setFontName("宋体");
		// 设置字体颜色
		xssfFont.setColor(HSSFColor.RED.index);
		cellStyle.setFont(xssfFont);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);// 水平居中
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);// 垂直居中
		int coloumNum = xssfSheet.getRow(0).getPhysicalNumberOfCells();
		for (int i = 0; i < list.size(); i++) {
			Cell cell = row1.createCell(coloumNum + i);
			cell.setCellStyle(cellStyle);
			cell.setCellValue(list.get(i).getName() + "返佣比例(例0.15)*");
			cell = row2.createCell(coloumNum + i);
			cell.setCellValue("rebate_" + list.get(i).getId());
		}
		FileOutputStream excelFileOutPutStream = new FileOutputStream(path);// 写数据到这个路径上
		xssfWorkbook.write(excelFileOutPutStream);
		excelFileOutPutStream.flush();
		excelFileOutPutStream.close();
	}

	private String getLastColumnXlsx(String path, int rowNum) {

		XSSFWorkbook xssfWorkbook = null;
		try {
			InputStream is = new FileInputStream(path);
			xssfWorkbook = new XSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		// Read the Sheet
		XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);
		if (xssfSheet == null) {
			return null;
		}
		int coloumNum = xssfSheet.getRow(0).getPhysicalNumberOfCells();
		XSSFRow row = xssfSheet.getRow(rowNum);// 获取第二行
		XSSFCell cell = row.getCell(coloumNum - 1);// 获取第二行最后一列
		return getValue(cell);
	}

	private String getLastColumnXls(String path, int rowNum) {

		HSSFWorkbook hssfWorkbook = null;
		try {
			InputStream is = new FileInputStream(path);
			hssfWorkbook = new HSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		// Read the Sheet
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		if (hssfSheet == null) {
			return null;
		}
		int coloumNum = hssfSheet.getRow(0).getPhysicalNumberOfCells();
		HSSFRow row = hssfSheet.getRow(rowNum);
		HSSFCell cell = row.getCell(coloumNum - 1);// 获取第二行最后一列
		return getValue(cell);
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
	private <T> List<T> readXlsx(String path, Class<? extends Object> clazz, boolean needConvert) {
		List<T> list = new ArrayList<T>();
		XSSFWorkbook xssfWorkbook = null;
		try {
			InputStream is = new FileInputStream(path);
			xssfWorkbook = new XSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		// Read the Sheet
		XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);
		if (xssfSheet == null) {
			return null;
		}
		Map<Integer, String> map = new HashMap<Integer, String>();
		XSSFRow xssfRow = null;
		T hSModel = null;
		XSSFCell temp = null;
		int startRow;
		if(needConvert){
			Map<String,String> convertMap = URLUtils.getExcelconvert();
			xssfRow = xssfSheet.getRow(0);
			if (xssfRow != null) {
				int coloumNum = xssfSheet.getRow(0).getPhysicalNumberOfCells();
				for (int i = 0; i < coloumNum; i++) {
					temp = xssfRow.getCell(i);
					map.put(i, StringToUtf8(convertMap.get(getValue(temp).trim()),"iso-8859-1"));
				}
			}
			startRow = 1;
		} else {
			xssfRow = xssfSheet.getRow(1);
			if (xssfRow != null) {
				int coloumNum = xssfSheet.getRow(0).getPhysicalNumberOfCells();
				for (int i = 0; i < coloumNum; i++) {
					temp = xssfRow.getCell(i);
					map.put(i, getValue(temp).trim());
				}
			}
			startRow = 2;
		}
		// Read the Row
		for (int rowNum = startRow; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
			xssfRow = xssfSheet.getRow(rowNum);
			if (xssfRow != null) {
				try {
					hSModel = (T) clazz.newInstance();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				for (Map.Entry<Integer, String> entry : map.entrySet()) {
					temp = xssfRow.getCell(entry.getKey());
					if (temp == null) {
						continue;
					}
					Method method;
					try {
						method = clazz.getMethod(
								"set" + entry.getValue().substring(0, 1).toUpperCase() + entry.getValue().substring(1),
								String.class);
						method.invoke(hSModel, getValue(temp).trim());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				list.add(hSModel);
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
	private <T> List<T> readXls(String path, Class<? extends Object> clazz, boolean needConvert) {
		List<T> list = new ArrayList<T>();
		HSSFWorkbook hssfWorkbook = null;
		try {
			InputStream is = new FileInputStream(path);
			hssfWorkbook = new HSSFWorkbook(is);
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		// Read the Sheet
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		if (hssfSheet == null) {
			return null;
		}
		Map<Integer, String> map = new HashMap<Integer, String>();
		HSSFRow hssfRow = null;
		T hSModel = null;
		HSSFCell temp = null;
		int startRow;
		if(needConvert){
			Map<String,String> convertMap = URLUtils.getExcelconvert();
			hssfRow = hssfSheet.getRow(0);
			if (hssfRow != null) {
				int coloumNum = hssfSheet.getRow(0).getPhysicalNumberOfCells();
				for (int i = 0; i < coloumNum; i++) {
					temp = hssfRow.getCell(i);
					map.put(i, StringToUtf8(convertMap.get(getValue(temp).trim()),"iso-8859-1"));
				}
			}
			startRow = 1;
		} else {
			hssfRow = hssfSheet.getRow(1);
			if (hssfRow != null) {
				int coloumNum = hssfSheet.getRow(0).getPhysicalNumberOfCells();
				for (int i = 0; i < coloumNum; i++) {
					temp = hssfRow.getCell(i);
					map.put(i, getValue(temp).trim());
				}
			}
			startRow = 2;
		}
		// Read the Row
		for (int rowNum = startRow; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
			hssfRow = hssfSheet.getRow(rowNum);
			if (hssfRow != null) {
				try {
					hSModel = (T) clazz.newInstance();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				for (Map.Entry<Integer, String> entry : map.entrySet()) {
					temp = hssfRow.getCell(entry.getKey());
					if (temp == null) {
						continue;
					}
					Method method;
					try {
						method = clazz.getMethod(
								"set" + entry.getValue().substring(0, 1).toUpperCase() + entry.getValue().substring(1),
								String.class);
						method.invoke(hSModel, getValue(temp).trim());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				list.add(hSModel);
			}
		}
		return list;
	}
	
	private String StringToUtf8(String str, String charsetName){
		try {
			return new String(str.getBytes(charsetName), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

}
