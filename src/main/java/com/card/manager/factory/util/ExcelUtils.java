package com.card.manager.factory.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
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

	/**
	 * read the Excel file
	 * 
	 * @param path
	 *            the path of the Excel file
	 * @return
	 * @throws IOException
	 */
	public <T> List<T> readExcel(String path, Class<? extends Object> clazz) {
		if (path == null || "".equals(path)) {
			return null;
		} else {
			String postfix = path.substring(path.lastIndexOf(".") + 1, path.length());
			if (!"".equals(postfix)) {
				if ("xls".equals(postfix)) {
					return readXls(path, clazz);
				} else if ("xlsx".equals(postfix)) {
					return readXlsx(path, clazz);
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
					addHeadXlsx(path, list);
				} else if ("xlsx".equals(postfix)) {
					addHeadXls(path, list);
				}
			} else {
				return;
			}
		}
		return;
	}

	private void addHeadXls(String path, List<GradeTypeDTO> list) throws IOException {
		InputStream is = this.getClass().getResourceAsStream(path);
		HSSFWorkbook hssfWorkbook = null;
		try {
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
		int coloumNum = hssfSheet.getRow(0).getPhysicalNumberOfCells();
		for (int i = 0; i < list.size(); i++) {
			Cell cell = row1.createCell(coloumNum + i + 1);
			cell.setCellValue(list.get(i).getName());
			cell = row2.createCell(coloumNum + i + 1);
			cell.setCellValue("rebate_" + list.get(i).getId());
		}
		FileOutputStream excelFileOutPutStream = new FileOutputStream(path);//写数据到这个路径上  
		hssfWorkbook.write(excelFileOutPutStream);  
        excelFileOutPutStream.flush();  
        excelFileOutPutStream.close();  
	}

	private void addHeadXlsx(String path, List<GradeTypeDTO> list) throws IOException {
		InputStream is = this.getClass().getResourceAsStream(path);
		XSSFWorkbook xssfWorkbook = null;
		try {
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
		int coloumNum = xssfSheet.getRow(0).getPhysicalNumberOfCells();
		for (int i = 0; i < list.size(); i++) {
			Cell cell = row1.createCell(coloumNum + i + 1);
			cell.setCellValue(list.get(i).getName());
			cell = row2.createCell(coloumNum + i + 1);
			cell.setCellValue("rebate_" + list.get(i).getId());
		}
		FileOutputStream excelFileOutPutStream = new FileOutputStream(path);//写数据到这个路径上  
		xssfWorkbook.write(excelFileOutPutStream);  
        excelFileOutPutStream.flush();  
        excelFileOutPutStream.close();  
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

	private String getLastColumnXlsx(String path, int rowNum) {
		InputStream is = this.getClass().getResourceAsStream(path);
		XSSFWorkbook xssfWorkbook = null;
		try {
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
		XSSFCell cell = row.getCell(coloumNum);// 获取第二行最后一列
		return getValue(cell);
	}

	private String getLastColumnXls(String path, int rowNum) {
		InputStream is = this.getClass().getResourceAsStream(path);
		HSSFWorkbook hssfWorkbook = null;
		try {
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
		HSSFCell cell = row.getCell(coloumNum);// 获取第二行最后一列
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
	private <T> List<T> readXlsx(String path, Class<? extends Object> clazz) {
		List<T> list = new ArrayList<T>();
		InputStream is = this.getClass().getResourceAsStream(path);
		XSSFWorkbook xssfWorkbook = null;
		try {
			xssfWorkbook = new XSSFWorkbook(is);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		// Read the Sheet
		XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);
		if (xssfSheet == null) {
			return null;
		}
		XSSFRow xssfRow = null;
		T hSModel = null;
		xssfRow = xssfSheet.getRow(1);
		XSSFCell temp = null;
		Map<Integer, String> map = new HashMap<Integer, String>();
		if (xssfRow != null) {
			Field[] fields = clazz.getDeclaredFields();
			for (int i = 0; i < fields.length; i++) {
				temp = xssfRow.getCell(i);
				map.put(i, getValue(temp).trim());
			}
		}
		// Read the Row
		for (int rowNum = 1; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
			xssfRow = xssfSheet.getRow(rowNum);
			if (xssfRow != null) {
				try {
					hSModel = (T) clazz.newInstance();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				for (Map.Entry<Integer, String> entry : map.entrySet()) {
					temp = xssfRow.getCell(entry.getKey());
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
	private <T> List<T> readXls(String path, Class<? extends Object> clazz) {
		List<T> list = new ArrayList<T>();
		InputStream is = this.getClass().getResourceAsStream(path);
		HSSFWorkbook hssfWorkbook = null;
		try {
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
		HSSFRow xssfRow = null;
		T hSModel = null;
		xssfRow = hssfSheet.getRow(1);
		HSSFCell temp = null;
		Map<Integer, String> map = new HashMap<Integer, String>();
		if (xssfRow != null) {
			Field[] fields = clazz.getDeclaredFields();
			for (int i = 0; i < fields.length; i++) {
				temp = xssfRow.getCell(i);
				map.put(i, getValue(temp).trim());
			}
		}
		// Read the Row
		for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
			xssfRow = hssfSheet.getRow(rowNum);
			if (xssfRow != null) {
				try {
					hSModel = (T) clazz.newInstance();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				for (Map.Entry<Integer, String> entry : map.entrySet()) {
					temp = xssfRow.getCell(entry.getKey());
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

}
