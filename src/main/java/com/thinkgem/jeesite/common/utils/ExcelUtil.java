package com.thinkgem.jeesite.common.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;

public class ExcelUtil {
	public String filePath = "e:\\招生信息采集表 V1.1.xls";

	public void newWordBook() {
		HSSFWorkbook wb = new HSSFWorkbook();
		try {
			FileOutputStream fileOut = new FileOutputStream(filePath);
			wb.write(fileOut);
			fileOut.close();
		} catch (FileNotFoundException ex) {
			System.out.println(ex.getMessage());
		} catch (IOException ex) {
			System.out.println(ex.getMessage());
		}
	}

	/**
	 * 创建空白文件
	 */
	public void newSheet() {
		HSSFWorkbook wb = new HSSFWorkbook();
		wb.createSheet("第一页");
		wb.createSheet("第二页");
		try {
			FileOutputStream fileOut = new FileOutputStream(filePath);
			wb.write(fileOut);
			fileOut.close();
		} catch (FileNotFoundException ex) {
			System.out.println(ex.getMessage());
		} catch (IOException ex) {
			System.out.println(ex.getMessage());
		}
	}

	private void saveWorkBook(HSSFWorkbook wb,String file) {
		try {
			FileOutputStream fileOut = new FileOutputStream(file);
			wb.write(fileOut);
			fileOut.close();
		} catch (FileNotFoundException ex) {
			System.out.println(ex.getMessage());
		} catch (IOException ex) {
			System.out.println(ex.getMessage());
		}
	}

	private HSSFWorkbook getWorkBook(String filePath) {
		try {
			FileInputStream fileIn = new FileInputStream(filePath);
			HSSFWorkbook wb = new HSSFWorkbook(fileIn);
			fileIn.close();
			return wb;
		} catch (IOException ex) {
			System.out.println(ex.getMessage());
			return null;
		}
	}

	@SuppressWarnings("deprecation")
	private HSSFCell getCell(HSSFSheet sheet, int rowIndex, short columnIndex) {
		HSSFRow row = sheet.getRow(rowIndex);
		if (row == null) {
			row = sheet.createRow(rowIndex);
		}
		HSSFCell cell = row.getCell(columnIndex);
		if (cell == null) {
			cell = row.createCell((short) columnIndex);
		}
		return cell;
	}
	
	public void copyFile(String oldPath, String newPath) { 
		try { 
		int byteread = 0; 
		File oldfile = new File(oldPath); 
		if (oldfile.exists()) { //文件存在时 
		InputStream inStream = new FileInputStream(oldPath); //读入原文件 
		FileOutputStream fs = new FileOutputStream(newPath); 
		byte[] buffer = new byte[1444]; 
		while ( (byteread = inStream.read(buffer)) != -1) { 
		fs.write(buffer, 0, byteread); 
		} 
		inStream.close(); 
		fs.close();
		} 
		} 
		catch (Exception e) { 
		System.out.println("复制单个文件操作出错"); 
		e.printStackTrace(); 

		} 

		} 

	/**
	 * 招生信息
	 * 
	 * @param file
	 */
	public void writeZsxx(String file,List<XsJbxx> list) {
		// 创建工作薄
		HSSFWorkbook wb = getWorkBook(file);
		if (wb == null) {
			return;
		}
		// 获取工作表
		HSSFSheet sheet = wb.getSheetAt(1);
		if (sheet == null) {
			sheet = wb.createSheet("第一页");
		}
		
		HSSFCell xmCell = getCell(sheet, 0, (short) 0);
		XsJbxx xsInfo = null;
		for (int i = 0; i < list.size(); i++) {
			xsInfo = list.get(i);
			//姓名
			HSSFRichTextString xmStr = new HSSFRichTextString(xsInfo.getXm());
			xmCell = getCell(sheet, i+3, (short) 0);
			xmCell.setCellValue(xmStr);
			
			//性别
			String sex = DictUtils.getDictLabel(xsInfo.getXbm(), "sex", "");
			HSSFRichTextString xbStr = new HSSFRichTextString(sex);
			xmCell = getCell(sheet, i+3, (short) 1);
			xmCell.setCellValue(xbStr);
			
			//出生日期
			String csrq = DateUtils.getDateForYMD(xsInfo.getCsrq());
			HSSFRichTextString csrqStr = new HSSFRichTextString(csrq);
			xmCell = getCell(sheet, i+3, (short) 2);
			xmCell.setCellValue(csrqStr);
			
			//身份证类型
			String sfzlx = DictUtils.getDictLabel(xsInfo.getSfzjlxm(), "sfzjlx", "");
			HSSFRichTextString sfzlxStr = new HSSFRichTextString(sfzlx);
			xmCell = getCell(sheet, i+3, (short) 3);
			xmCell.setCellValue(sfzlxStr);
			
			//身份证件号
			HSSFRichTextString sfzjhStr = new HSSFRichTextString(xsInfo.getSfzjh());
			xmCell = getCell(sheet, i+3, (short) 4);
			xmCell.setCellValue(sfzjhStr);
			
			//入学年月
			String rxny = DateUtils.getDateForYM(xsInfo.getRxny());
			HSSFRichTextString rxnyStr = new HSSFRichTextString(rxny);
			xmCell = getCell(sheet, i+3, (short) 5);
			xmCell.setCellValue(rxnyStr);
			
			//专业简称
			HSSFRichTextString zyjcStr = new HSSFRichTextString(xsInfo.getZyjc());
			xmCell = getCell(sheet, i+3, (short) 6);
			xmCell.setCellValue(zyjcStr);
			
			//民族
			String mz = DictUtils.getDictLabel(xsInfo.getMzm(), "nation", "");
			HSSFRichTextString mzStr = new HSSFRichTextString(mz);
			xmCell = getCell(sheet, i+3, (short) 7);
			xmCell.setCellValue(mzStr);
			
			//户口所在地行政区划码
			HSSFRichTextString hkszdxzqhmStr = new HSSFRichTextString(xsInfo.getHkszdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 8);
			xmCell.setCellValue(hkszdxzqhmStr);
			
			//户口性质
			String hkxz = DictUtils.getDictLabel(xsInfo.getHkxz(), "hkxz", "");
			HSSFRichTextString hkxzStr = new HSSFRichTextString(hkxz);
			xmCell = getCell(sheet, i+3, (short) 9);
			xmCell.setCellValue(hkxzStr);
			
			//学生居住地类型
			String xsjzdlx = DictUtils.getDictLabel(xsInfo.getXsjzdlx(), "xsjzdlx", "");
			HSSFRichTextString xsjzdlxStr = new HSSFRichTextString(xsjzdlx);
			xmCell = getCell(sheet, i+3, (short) 10);
			xmCell.setCellValue(xsjzdlxStr);
			
			//政治面貌
			String zzmm = DictUtils.getDictLabel(xsInfo.getZzmmm(), "zzmm", "");
			HSSFRichTextString zzmmStr = new HSSFRichTextString(zzmm);
			xmCell = getCell(sheet, i+3, (short) 11);
			xmCell.setCellValue(zzmmStr);
			
			//健康状况
			String jkzk = DictUtils.getDictLabel(xsInfo.getJkzkm(), "health", "");
			HSSFRichTextString jkzkStr = new HSSFRichTextString(jkzk);
			xmCell = getCell(sheet, i+3, (short) 12);
			xmCell.setCellValue(jkzkStr);
			
			//学生来源
			String xsly = DictUtils.getDictLabel(xsInfo.getXslym(), "xs_ly", "");
			HSSFRichTextString xslyStr = new HSSFRichTextString(xsly);
			xmCell = getCell(sheet, i+3, (short) 13);
			xmCell.setCellValue(xslyStr);
			
			//招生对象
			String zsdx = DictUtils.getDictLabel(xsInfo.getZsdx(), "zsdx", "");
			HSSFRichTextString zsdxStr = new HSSFRichTextString(zsdx);
			xmCell = getCell(sheet, i+3, (short) 14);
			xmCell.setCellValue(zsdxStr);
			
			//监护人电话
			HSSFRichTextString jhrdhStr = new HSSFRichTextString(xsInfo.getJhrlxdh());
			xmCell = getCell(sheet, i+3, (short) 15);
			xmCell.setCellValue(jhrdhStr);
			
			//毕业学校
			HSSFRichTextString byxxStr = new HSSFRichTextString(xsInfo.getByxx());
			xmCell = getCell(sheet, i+3, (short) 16);
			xmCell.setCellValue(byxxStr);
			
			//生源地学生区划码
			HSSFRichTextString sydxsqhmStr = new HSSFRichTextString(xsInfo.getSydxzqhm());
			xmCell = getCell(sheet, i+3, (short) 17);
			xmCell.setCellValue(sydxsqhmStr);
			
			//招生方式
			String zsfs = DictUtils.getDictLabel(xsInfo.getZsfs(), "zsfs", "");
			HSSFRichTextString zsfsStr = new HSSFRichTextString(zsfs);
			xmCell = getCell(sheet, i+3, (short) 18);
			xmCell.setCellValue(zsfsStr);
			
			//准考证号
			HSSFRichTextString zkzhStr = new HSSFRichTextString(xsInfo.getZkzh());
			xmCell = getCell(sheet, i+3, (short) 19);
			xmCell.setCellValue(zkzhStr);
			
			//考生号
			HSSFRichTextString kshStr = new HSSFRichTextString(xsInfo.getKsh());
			xmCell = getCell(sheet, i+3, (short) 20);
			xmCell.setCellValue(kshStr);
			
			//考试总分
			HSSFRichTextString kszfStr = new HSSFRichTextString(xsInfo.getKszf());
			xmCell = getCell(sheet, i+3, (short) 21);
			xmCell.setCellValue(kszfStr);
			
			//考生特长
			HSSFRichTextString kstcStr = new HSSFRichTextString(xsInfo.getKstc());
			xmCell = getCell(sheet, i+3, (short) 22);
			xmCell.setCellValue(kstcStr);
			
			//考生既往病史
			HSSFRichTextString ksjwbsStr = new HSSFRichTextString(xsInfo.getKsjwbs());
			xmCell = getCell(sheet, i+3, (short) 23);
			xmCell.setCellValue(ksjwbsStr);
			
			//体检结论
			HSSFRichTextString tjjlStr = new HSSFRichTextString(xsInfo.getTjjl());
			xmCell = getCell(sheet, i+3, (short) 24);
			xmCell.setCellValue(tjjlStr);
		}
			
		// 保存
		saveWorkBook(wb,file);
	}
	
	/**
	 * 新生信息
	 * @param file
	 * @param list
	 */
	public void writeXsxx(String file,List<XsJbxx> list) {
		// 创建工作薄
		HSSFWorkbook wb = getWorkBook(file);
		if (wb == null) {
			return;
		}
		// 获取工作表
		HSSFSheet sheet = wb.getSheetAt(1);
		if (sheet == null) {
			sheet = wb.createSheet("第一页");
		}
		
		HSSFCell xmCell = getCell(sheet, 0, (short) 0);
		XsJbxx xsInfo = null;
		for (int i = 0; i < list.size(); i++) {
			xsInfo = list.get(i);
			//姓名
			HSSFRichTextString xmStr = new HSSFRichTextString(xsInfo.getXm());
			xmCell = getCell(sheet, i+3, (short) 0);
			xmCell.setCellValue(xmStr);
			
			//性别
			String sex = DictUtils.getDictLabel(xsInfo.getXbm(), "sex", "");
			HSSFRichTextString xbStr = new HSSFRichTextString(sex);
			xmCell = getCell(sheet, i+3, (short) 1);
			xmCell.setCellValue(xbStr);
			
			//出生日期
			String csrq = DateUtils.getDateForYMD(xsInfo.getCsrq());
			HSSFRichTextString csrqStr = new HSSFRichTextString(csrq);
			xmCell = getCell(sheet, i+3, (short) 2);
			xmCell.setCellValue(csrqStr);
			
			//身份证类型
			String sfzlx = DictUtils.getDictLabel(xsInfo.getSfzjlxm(), "sfzjlx", "");
			HSSFRichTextString sfzlxStr = new HSSFRichTextString(sfzlx);
			xmCell = getCell(sheet, i+3, (short) 3);
			xmCell.setCellValue(sfzlxStr);
			
			//身份证件号
			HSSFRichTextString sfzjhStr = new HSSFRichTextString(xsInfo.getSfzjh());
			xmCell = getCell(sheet, i+3, (short) 4);
			xmCell.setCellValue(sfzjhStr);
			
			//姓名拼音
			HSSFRichTextString xmpyStr = new HSSFRichTextString(xsInfo.getXmpy());
			xmCell = getCell(sheet, i+3, (short) 5);
			xmCell.setCellValue(xmpyStr);
			
			//班级名称
			HSSFRichTextString bjmcStr = new HSSFRichTextString(xsInfo.getBjName());
			xmCell = getCell(sheet, i+3, (short) 6);
			xmCell.setCellValue(bjmcStr);
			
			//学号
			HSSFRichTextString xhStr = new HSSFRichTextString(xsInfo.getXh());
			xmCell = getCell(sheet, i+3, (short) 7);
			xmCell.setCellValue(xhStr);
			
			//学生类别
			String xslb = DictUtils.getDictLabel(xsInfo.getXslbm(), "xslb", "");
			HSSFRichTextString xslbStr = new HSSFRichTextString(xslb);
			xmCell = getCell(sheet, i+3, (short) 8);
			xmCell.setCellValue(xslbStr);
			
			//学习形式
			String xxxs = DictUtils.getDictLabel(xsInfo.getXxxsm(), "xxxs", "");
			HSSFRichTextString xxxsStr = new HSSFRichTextString(xxxs);
			xmCell = getCell(sheet, i+3, (short) 9);
			xmCell.setCellValue(xxxsStr);
			
			//入学方式
			String rxfs = DictUtils.getDictLabel(xsInfo.getRxfsm(), "rxfs", "");
			HSSFRichTextString rxfsStr = new HSSFRichTextString(rxfs);
			xmCell = getCell(sheet, i+3, (short) 10);
			xmCell.setCellValue(rxfsStr);
			
			//就读方式
			String jdfs = DictUtils.getDictLabel(xsInfo.getJdfsm(), "jdfs", "");
			HSSFRichTextString jdfsStr = new HSSFRichTextString(jdfs);
			xmCell = getCell(sheet, i+3, (short) 11);
			xmCell.setCellValue(jdfsStr);
			
			//国籍/地区
			String dq = DictUtils.getDictLabel(xsInfo.getGjdqm(), "gjdqm", "");
			HSSFRichTextString dqStr = new HSSFRichTextString(dq);
			xmCell = getCell(sheet, i+3, (short) 12);
			xmCell.setCellValue(dqStr);
			
			//港澳台侨外
			String gatqw = DictUtils.getDictLabel(xsInfo.getGatqwm(), "gatqwm", "");
			HSSFRichTextString gatqwStr = new HSSFRichTextString(gatqw);
			xmCell = getCell(sheet, i+3, (short) 13);
			xmCell.setCellValue(gatqwStr);
			
			//婚姻状况
			String hyzk = DictUtils.getDictLabel(xsInfo.getHyzkm(), "hyzk", "");
			HSSFRichTextString hyzkStr = new HSSFRichTextString(hyzk);
			xmCell = getCell(sheet, i+3, (short) 14);
			xmCell.setCellValue(hyzkStr);
			
			//乘火车区间
			HSSFRichTextString chcqjStr = new HSSFRichTextString(xsInfo.getChcqj());
			xmCell = getCell(sheet, i+3, (short) 15);
			xmCell.setCellValue(chcqjStr);
			
			//是否随迁子女
			String sfsqzn = DictUtils.getDictLabel(xsInfo.getSfsqzn(), "sfdm", "");
			HSSFRichTextString sfsqznStr = new HSSFRichTextString(sfsqzn);
			xmCell = getCell(sheet, i+3, (short) 16);
			xmCell.setCellValue(sfsqznStr);
			
			//生源地行政区划码
			HSSFRichTextString sydxsqhmStr = new HSSFRichTextString(xsInfo.getSydxzqhm());
			xmCell = getCell(sheet, i+3, (short) 17);
			xmCell.setCellValue(sydxsqhmStr);
			
			//出生地行政区划码
			HSSFRichTextString csdxsqhmStr = new HSSFRichTextString(xsInfo.getCsdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 18);
			xmCell.setCellValue(csdxsqhmStr);
			
			//籍贯地行政区划码
			HSSFRichTextString jgdxsqhmStr = new HSSFRichTextString(xsInfo.getJgdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 19);
			xmCell.setCellValue(jgdxsqhmStr);
			
			//户口所在地区县以下详细地址
			HSSFRichTextString xxdzStr = new HSSFRichTextString(xsInfo.getHkszdqxyxxxdz());
			xmCell = getCell(sheet, i+3, (short) 20);
			xmCell.setCellValue(xxdzStr);
			
			//所属派出所
			HSSFRichTextString sspcsStr = new HSSFRichTextString(xsInfo.getScpcs());
			xmCell = getCell(sheet, i+3, (short) 21);
			xmCell.setCellValue(sspcsStr);
			
			//户口所在地行政区划码
			HSSFRichTextString hkszdxzqhmStr = new HSSFRichTextString(xsInfo.getHkszdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 22);
			xmCell.setCellValue(hkszdxzqhmStr);
			
			//户口性质
			String hkxz = DictUtils.getDictLabel(xsInfo.getHkxz(), "hkxz", "");
			HSSFRichTextString hkxzStr = new HSSFRichTextString(hkxz);
			xmCell = getCell(sheet, i+3, (short) 23);
			xmCell.setCellValue(hkxzStr);
			
			//学生居住地类型
			String xsjzdlx = DictUtils.getDictLabel(xsInfo.getXsjzdlx(), "xsjzdlx", "");
			HSSFRichTextString xsjzdlxStr = new HSSFRichTextString(xsjzdlx);
			xmCell = getCell(sheet, i+3, (short) 24);
			xmCell.setCellValue(xsjzdlxStr);
			
			//入学年月
			String rxny = DateUtils.getDateForYM(xsInfo.getRxny());
			HSSFRichTextString rxnyStr = new HSSFRichTextString(rxny);
			xmCell = getCell(sheet, i+3, (short) 25);
			xmCell.setCellValue(rxnyStr);
			
			//专业
			HSSFRichTextString zyStr = new HSSFRichTextString(xsInfo.getZymc());
			xmCell = getCell(sheet, i+3, (short) 26);
			xmCell.setCellValue(zyStr);
			
			//专业方向
			HSSFRichTextString zyfxStr = new HSSFRichTextString(xsInfo.getZyfx());
			xmCell = getCell(sheet, i+3, (short) 27);
			xmCell.setCellValue(zyfxStr);
			
			//学制
			String xz = DictUtils.getDictLabel(xsInfo.getXz(), "xzdm", "");
			HSSFRichTextString xzStr = new HSSFRichTextString(xz);
			xmCell = getCell(sheet, i+3, (short) 28);
			xmCell.setCellValue(xzStr);
			
			//民族
			String mz = DictUtils.getDictLabel(xsInfo.getMzm(), "nation", "");
			HSSFRichTextString mzStr = new HSSFRichTextString(mz);
			xmCell = getCell(sheet, i+3, (short) 29);
			xmCell.setCellValue(mzStr);
			
			//政治面貌
			String zzmm = DictUtils.getDictLabel(xsInfo.getZzmmm(), "zzmm", "");
			HSSFRichTextString zzmmStr = new HSSFRichTextString(zzmm);
			xmCell = getCell(sheet, i+3, (short) 30);
			xmCell.setCellValue(zzmmStr);
			
			//健康状况
			String jkzk = DictUtils.getDictLabel(xsInfo.getJkzkm(), "health", "");
			HSSFRichTextString jkzkStr = new HSSFRichTextString(jkzk);
			xmCell = getCell(sheet, i+3, (short) 31);
			xmCell.setCellValue(jkzkStr);
			
			//学生来源
			String xsly = DictUtils.getDictLabel(xsInfo.getXslym(), "xs_ly", "");
			HSSFRichTextString xslyStr = new HSSFRichTextString(xsly);
			xmCell = getCell(sheet, i+3, (short) 32);
			xmCell.setCellValue(xslyStr);
			
			//招生对象
			String zsdx = DictUtils.getDictLabel(xsInfo.getZsdx(), "zsdx", "");
			HSSFRichTextString zsdxStr = new HSSFRichTextString(zsdx);
			xmCell = getCell(sheet, i+3, (short) 33);
			xmCell.setCellValue(zsdxStr);
			
			//联系电话
			HSSFRichTextString lxdhStr = new HSSFRichTextString(xsInfo.getLxdh());
			xmCell = getCell(sheet, i+3, (short) 34);
			xmCell.setCellValue(lxdhStr);
			
			//招生方式
			String zsfs = DictUtils.getDictLabel(xsInfo.getZsfs(), "zsfs", "");
			HSSFRichTextString zsfsStr = new HSSFRichTextString(zsfs);
			xmCell = getCell(sheet, i+3, (short) 35);
			xmCell.setCellValue(zsfsStr);
			
			//联招合作类型
			String lzhzlx = DictUtils.getDictLabel(xsInfo.getLzhzlx(), "lzhzlx", "");
			HSSFRichTextString lzhzlxStr = new HSSFRichTextString(lzhzlx);
			xmCell = getCell(sheet, i+3, (short) 36);
			xmCell.setCellValue(lzhzlxStr);
			
			//准考证号
			HSSFRichTextString zkzhStr = new HSSFRichTextString(xsInfo.getZkzh());
			xmCell = getCell(sheet, i+3, (short) 37);
			xmCell.setCellValue(zkzhStr);
			
			//考生号
			HSSFRichTextString kshStr = new HSSFRichTextString(xsInfo.getKsh());
			xmCell = getCell(sheet, i+3, (short) 38);
			xmCell.setCellValue(kshStr);
			
			//考试总分
			HSSFRichTextString kszfStr = new HSSFRichTextString(xsInfo.getKszf());
			xmCell = getCell(sheet, i+3, (short) 39);
			xmCell.setCellValue(kszfStr);
			
			//联招合作办学形式
			String lzhzbxxs = DictUtils.getDictLabel(xsInfo.getLzhzbxfs(), "lzhzbxxs", "");
			HSSFRichTextString lzhzbxxsStr = new HSSFRichTextString(lzhzbxxs);
			xmCell = getCell(sheet, i+3, (short) 40);
			xmCell.setCellValue(lzhzbxxsStr);
			
			//联招合作学校代码
			HSSFRichTextString lzhzxxdmStr = new HSSFRichTextString(xsInfo.getLzhzxxdm());
			xmCell = getCell(sheet, i+3, (short) 41);
			xmCell.setCellValue(lzhzxxdmStr);
			
			//校外教学点
			HSSFRichTextString xwjxdStr = new HSSFRichTextString(xsInfo.getXwjxd());
			xmCell = getCell(sheet, i+3, (short) 42);
			xmCell.setCellValue(xwjxdStr);
			
			//分段培养方式
			String fdpyfs = DictUtils.getDictLabel(xsInfo.getFdpyfs(), "fdpyfs", "");
			HSSFRichTextString fdpyfsStr = new HSSFRichTextString(fdpyfs);
			xmCell = getCell(sheet, i+3, (short) 43);
			xmCell.setCellValue(fdpyfsStr);
			
			//英文姓名
			HSSFRichTextString ywxmStr = new HSSFRichTextString(xsInfo.getYwxm());
			xmCell = getCell(sheet, i+3, (short) 44);
			xmCell.setCellValue(ywxmStr);
			
			//电子信箱/其他联系方式
			HSSFRichTextString dzxxStr = new HSSFRichTextString(xsInfo.getDzxx());
			xmCell = getCell(sheet, i+3, (short) 45);
			xmCell.setCellValue(dzxxStr);
			
			//家庭现地址
			HSSFRichTextString jtxdzStr = new HSSFRichTextString(xsInfo.getJtxdz());
			xmCell = getCell(sheet, i+3, (short) 46);
			xmCell.setCellValue(jtxdzStr);
			
			//家庭邮政编码
			HSSFRichTextString jtyzbmStr = new HSSFRichTextString(xsInfo.getJtyzbm());
			xmCell = getCell(sheet, i+3, (short) 47);
			xmCell.setCellValue(jtyzbmStr);
			
			//家庭电话
			HSSFRichTextString jtdhStr = new HSSFRichTextString(xsInfo.getJtdh());
			xmCell = getCell(sheet, i+3, (short) 48);
			xmCell.setCellValue(jtdhStr);
			
			/**
			 * 成员1 信息
			 */

			//成员1姓名
			HSSFRichTextString cyyxmStr = new HSSFRichTextString(xsInfo.getCyyxm());
			xmCell = getCell(sheet, i+3, (short) 49);
			xmCell.setCellValue(cyyxmStr);
			
			//成员1关系
			String cyygx = DictUtils.getDictLabel(xsInfo.getCyygx(), "cygx", "");
			HSSFRichTextString cyygxStr = new HSSFRichTextString(cyygx);
			xmCell = getCell(sheet, i+3, (short) 50);
			xmCell.setCellValue(cyygxStr);
			
			//成员1是否监护人
			String cyyjhr = DictUtils.getDictLabel(xsInfo.getCyysfjhr(), "sfdm", "");
			HSSFRichTextString cyyjhrStr = new HSSFRichTextString(cyyjhr);
			xmCell = getCell(sheet, i+3, (short) 51);
			xmCell.setCellValue(cyyjhrStr);
			
			//成员1联系电话
			HSSFRichTextString cyylxdhStr = new HSSFRichTextString(xsInfo.getCyylxdh());
			xmCell = getCell(sheet, i+3, (short) 52);
			xmCell.setCellValue(cyylxdhStr);
			
			//成员1出生年月
			String cyycsny = DateUtils.getDateForYM(xsInfo.getCyycsny());
			HSSFRichTextString cyycsnyStr = new HSSFRichTextString(cyycsny);
			xmCell = getCell(sheet, i+3, (short) 53);
			xmCell.setCellValue(cyycsnyStr);
			
			//成员1身份证件类型
			String cyysfzlx = DictUtils.getDictLabel(xsInfo.getCyysfzjlx(), "sfzjlx", "");
			HSSFRichTextString cyysfzlxStr = new HSSFRichTextString(cyysfzlx);
			xmCell = getCell(sheet, i+3, (short) 54);
			xmCell.setCellValue(cyysfzlxStr);
			
			//成员1身份证件号
			HSSFRichTextString cyysfzjhStr = new HSSFRichTextString(xsInfo.getCyysfzjh());
			xmCell = getCell(sheet, i+3, (short) 55);
			xmCell.setCellValue(cyysfzjhStr);
			
			//成员1民族
			String cyymz = DictUtils.getDictLabel(xsInfo.getCyymzm(), "nation", "");
			HSSFRichTextString cyymzStr = new HSSFRichTextString(cyymz);
			xmCell = getCell(sheet, i+3, (short) 56);
			xmCell.setCellValue(cyymzStr);
			
			//成员1政治面貌
			String cyyzzmm = DictUtils.getDictLabel(xsInfo.getCyyzzmmm(), "zzmm", "");
			HSSFRichTextString cyyzzmmStr = new HSSFRichTextString(cyyzzmm);
			xmCell = getCell(sheet, i+3, (short) 57);
			xmCell.setCellValue(cyyzzmmStr);
			
			//成员1健康状况
			String cyyjkzk = DictUtils.getDictLabel(xsInfo.getCyyjkzkm(), "health", "");
			HSSFRichTextString cyyjkzkStr = new HSSFRichTextString(cyyjkzk);
			xmCell = getCell(sheet, i+3, (short) 58);
			xmCell.setCellValue(cyyjkzkStr);
			
			//成员1工作或学习单位
			HSSFRichTextString cyygzhxxdwStr = new HSSFRichTextString(xsInfo.getCyygzhxxdw());
			xmCell = getCell(sheet, i+3, (short) 59);
			xmCell.setCellValue(cyygzhxxdwStr);
			
			//成员1职务
			HSSFRichTextString cyyzwStr = new HSSFRichTextString(xsInfo.getCyyzw());
			xmCell = getCell(sheet, i+3, (short) 60);
			xmCell.setCellValue(cyyzwStr);
			
			/**
			 * 成员2 信息
			 */

			//成员2姓名
			HSSFRichTextString cyexmStr = new HSSFRichTextString(xsInfo.getCyexm());
			xmCell = getCell(sheet, i+3, (short) 61);
			xmCell.setCellValue(cyexmStr);
			
			//成员2关系
			String cyegx = DictUtils.getDictLabel(xsInfo.getCyegx(), "cygx", "");
			HSSFRichTextString cyegxStr = new HSSFRichTextString(cyegx);
			xmCell = getCell(sheet, i+3, (short) 62);
			xmCell.setCellValue(cyegxStr);
			
			//成员2是否监护人
			String cyejhr = DictUtils.getDictLabel(xsInfo.getCyesfjhr(), "sfdm", "");
			HSSFRichTextString cyejhrStr = new HSSFRichTextString(cyejhr);
			xmCell = getCell(sheet, i+3, (short) 63);
			xmCell.setCellValue(cyejhrStr);
			
			//成员2联系电话
			HSSFRichTextString cyelxdhStr = new HSSFRichTextString(xsInfo.getCyelxdh());
			xmCell = getCell(sheet, i+3, (short) 64);
			xmCell.setCellValue(cyelxdhStr);
			
			//成员2出生年月
			String cyecsny = DateUtils.getDateForYM(xsInfo.getCyecsny());
			HSSFRichTextString cyecsnyStr = new HSSFRichTextString(cyecsny);
			xmCell = getCell(sheet, i+3, (short) 65);
			xmCell.setCellValue(cyecsnyStr);
			
			//成员2身份证件类型
			String cyesfzlx = DictUtils.getDictLabel(xsInfo.getCyesfzjlx(), "sfzjlx", "");
			HSSFRichTextString cyesfzlxStr = new HSSFRichTextString(cyesfzlx);
			xmCell = getCell(sheet, i+3, (short) 66);
			xmCell.setCellValue(cyesfzlxStr);
			
			//成员2身份证件号
			HSSFRichTextString cyesfzjhStr = new HSSFRichTextString(xsInfo.getCyesfzjh());
			xmCell = getCell(sheet, i+3, (short) 67);
			xmCell.setCellValue(cyesfzjhStr);
			
			//成员2民族
			String cyemz = DictUtils.getDictLabel(xsInfo.getCyemzm(), "nation", "");
			HSSFRichTextString cyemzStr = new HSSFRichTextString(cyemz);
			xmCell = getCell(sheet, i+3, (short) 68);
			xmCell.setCellValue(cyemzStr);
			
			//成员2政治面貌
			String cyezzmm = DictUtils.getDictLabel(xsInfo.getCyezzmmm(), "zzmm", "");
			HSSFRichTextString cyezzmmStr = new HSSFRichTextString(cyezzmm);
			xmCell = getCell(sheet, i+3, (short) 69);
			xmCell.setCellValue(cyezzmmStr);
			
			//成员2健康状况
			String cyejkzk = DictUtils.getDictLabel(xsInfo.getCyejkzkm(), "health", "");
			HSSFRichTextString cyejkzkStr = new HSSFRichTextString(cyejkzk);
			xmCell = getCell(sheet, i+3, (short) 70);
			xmCell.setCellValue(cyejkzkStr);
			
			//成员2工作或学习单位
			HSSFRichTextString cyegzhxxdwStr = new HSSFRichTextString(xsInfo.getCyegzhxxdw());
			xmCell = getCell(sheet, i+3, (short) 71);
			xmCell.setCellValue(cyegzhxxdwStr);
			
			//成员2职务
			HSSFRichTextString cyezwStr = new HSSFRichTextString(xsInfo.getCyezw());
			xmCell = getCell(sheet, i+3, (short) 72);
			xmCell.setCellValue(cyezwStr);
		}
			
		// 保存
		saveWorkBook(wb,file);
	}
	
	// 下载web应用下的文件
	public void upload(HttpServletRequest request, HttpServletResponse response,String filePath) {
			try {
				File outfile = new File(filePath);
				String filename = outfile.getName();// 获取文件名称
				InputStream fis = new BufferedInputStream(new FileInputStream(
						filePath));
				byte[] buffer = new byte[fis.available()];
				fis.read(buffer); // 读取文件流
				fis.close();
				response.reset(); // 重置结果集
				response.addHeader("Content-Disposition", "attachment;filename="
						+ new String(
								filename.replaceAll(" ", "").getBytes("utf-8"),
								"iso8859-1")); // 返回头 文件名
				response.addHeader("Content-Length", "" + outfile.length()); // 返回头
																				// 文件大小
				response.setContentType("application/octet-stream"); // 设置数据种类
				// 获取返回体输出权
				OutputStream os = new BufferedOutputStream(
						response.getOutputStream());
				os.write(buffer); // 输出文件
				os.flush();
				os.close();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	public static void main(String[] args) {
		ExcelUtil excel = new ExcelUtil();
		//excel.writeData(excel.filePath);
	}
	
	/**
	 * @param file
	 * @param list
	 */
	public void writeXsInfo(String file,List<XsJbxx> list) {
		// 创建工作薄
		HSSFWorkbook wb = getWorkBook(file);
		if (wb == null) {
			return;
		}
		// 获取工作表
		HSSFSheet sheet = wb.getSheetAt(1);
		if (sheet == null) {
			sheet = wb.createSheet("第一页");
		}
		
		HSSFCell xmCell = getCell(sheet, 0, (short) 0);
		XsJbxx xsInfo = null;
		for (int i = 0; i < list.size(); i++) {
			xsInfo = list.get(i);
			//姓名
			HSSFRichTextString xmStr = new HSSFRichTextString(xsInfo.getXm());
			xmCell = getCell(sheet, i+3, (short) 0);
			xmCell.setCellValue(xmStr);
			
			//性别
			String sex = DictUtils.getDictLabel(xsInfo.getXbm(), "sex", "");
			HSSFRichTextString xbStr = new HSSFRichTextString(sex);
			xmCell = getCell(sheet, i+3, (short) 1);
			xmCell.setCellValue(xbStr);
			
			//出生日期
			String csrq = DateUtils.getDateForYMD(xsInfo.getCsrq());
			HSSFRichTextString csrqStr = new HSSFRichTextString(csrq);
			xmCell = getCell(sheet, i+3, (short) 2);
			xmCell.setCellValue(csrqStr);
			
			//身份证类型
			String sfzlx = DictUtils.getDictLabel(xsInfo.getSfzjlxm(), "sfzjlx", "");
			HSSFRichTextString sfzlxStr = new HSSFRichTextString(sfzlx);
			xmCell = getCell(sheet, i+3, (short) 3);
			xmCell.setCellValue(sfzlxStr);
			
			//身份证件号
			HSSFRichTextString sfzjhStr = new HSSFRichTextString(xsInfo.getSfzjh());
			xmCell = getCell(sheet, i+3, (short) 4);
			xmCell.setCellValue(sfzjhStr);
			
			//姓名拼音
			HSSFRichTextString xmpyStr = new HSSFRichTextString(xsInfo.getXmpy());
			xmCell = getCell(sheet, i+3, (short) 5);
			xmCell.setCellValue(xmpyStr);
			
			//班级名称
			HSSFRichTextString bjmcStr = new HSSFRichTextString(xsInfo.getBjmc().getBjmc());
			xmCell = getCell(sheet, i+3, (short) 6);
			xmCell.setCellValue(bjmcStr);
			
			//学号
			HSSFRichTextString xhStr = new HSSFRichTextString(xsInfo.getXh());
			xmCell = getCell(sheet, i+3, (short) 7);
			xmCell.setCellValue(xhStr);
			
			//学生类别
			String xslb = DictUtils.getDictLabel(xsInfo.getXslbm(), "xslb", "");
			HSSFRichTextString xslbStr = new HSSFRichTextString(xslb);
			xmCell = getCell(sheet, i+3, (short) 8);
			xmCell.setCellValue(xslbStr);
			
			//学习形式
			String xxxs = DictUtils.getDictLabel(xsInfo.getXxxsm(), "xxxs", "");
			HSSFRichTextString xxxsStr = new HSSFRichTextString(xxxs);
			xmCell = getCell(sheet, i+3, (short) 9);
			xmCell.setCellValue(xxxsStr);
			
			//入学方式
			String rxfs = DictUtils.getDictLabel(xsInfo.getRxfsm(), "rxfs", "");
			HSSFRichTextString rxfsStr = new HSSFRichTextString(rxfs);
			xmCell = getCell(sheet, i+3, (short) 10);
			xmCell.setCellValue(rxfsStr);
			
			//就读方式
			String jdfs = DictUtils.getDictLabel(xsInfo.getJdfsm(), "jdfs", "");
			HSSFRichTextString jdfsStr = new HSSFRichTextString(jdfs);
			xmCell = getCell(sheet, i+3, (short) 11);
			xmCell.setCellValue(jdfsStr);
			
			//国籍/地区
			String dq = DictUtils.getDictLabel(xsInfo.getGjdqm(), "gjdqm", "");
			HSSFRichTextString dqStr = new HSSFRichTextString(dq);
			xmCell = getCell(sheet, i+3, (short) 12);
			xmCell.setCellValue(dqStr);
			
			//港澳台侨外
			String gatqw = DictUtils.getDictLabel(xsInfo.getGatqwm(), "gatqwm", "");
			HSSFRichTextString gatqwStr = new HSSFRichTextString(gatqw);
			xmCell = getCell(sheet, i+3, (short) 13);
			xmCell.setCellValue(gatqwStr);
			
			//婚姻状况
			String hyzk = DictUtils.getDictLabel(xsInfo.getHyzkm(), "hyzk", "");
			HSSFRichTextString hyzkStr = new HSSFRichTextString(hyzk);
			xmCell = getCell(sheet, i+3, (short) 14);
			xmCell.setCellValue(hyzkStr);
			
			//乘火车区间
			HSSFRichTextString chcqjStr = new HSSFRichTextString(xsInfo.getChcqj());
			xmCell = getCell(sheet, i+3, (short) 15);
			xmCell.setCellValue(chcqjStr);
			
			//是否随迁子女
			String sfsqzn = DictUtils.getDictLabel(xsInfo.getSfsqzn(), "sfdm", "");
			HSSFRichTextString sfsqznStr = new HSSFRichTextString(sfsqzn);
			xmCell = getCell(sheet, i+3, (short) 16);
			xmCell.setCellValue(sfsqznStr);
			
			//生源地行政区划码
			HSSFRichTextString sydxsqhmStr = new HSSFRichTextString(xsInfo.getSydxzqhm());
			xmCell = getCell(sheet, i+3, (short) 17);
			xmCell.setCellValue(sydxsqhmStr);
			
			//出生地行政区划码
			HSSFRichTextString csdxsqhmStr = new HSSFRichTextString(xsInfo.getCsdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 18);
			xmCell.setCellValue(csdxsqhmStr);
			
			//籍贯地行政区划码
			HSSFRichTextString jgdxsqhmStr = new HSSFRichTextString(xsInfo.getJgdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 19);
			xmCell.setCellValue(jgdxsqhmStr);
			
			//户口所在地区县以下详细地址
			HSSFRichTextString xxdzStr = new HSSFRichTextString(xsInfo.getHkszdqxyxxxdz());
			xmCell = getCell(sheet, i+3, (short) 20);
			xmCell.setCellValue(xxdzStr);
			
			//所属派出所
			HSSFRichTextString sspcsStr = new HSSFRichTextString(xsInfo.getScpcs());
			xmCell = getCell(sheet, i+3, (short) 21);
			xmCell.setCellValue(sspcsStr);
			
			//户口所在地行政区划码
			HSSFRichTextString hkszdxzqhmStr = new HSSFRichTextString(xsInfo.getHkszdxzqhm());
			xmCell = getCell(sheet, i+3, (short) 22);
			xmCell.setCellValue(hkszdxzqhmStr);
			
			//户口性质
			String hkxz = DictUtils.getDictLabel(xsInfo.getHkxz(), "hkxz", "");
			HSSFRichTextString hkxzStr = new HSSFRichTextString(hkxz);
			xmCell = getCell(sheet, i+3, (short) 23);
			xmCell.setCellValue(hkxzStr);
			
			//学生居住地类型
			String xsjzdlx = DictUtils.getDictLabel(xsInfo.getXsjzdlx(), "xsjzdlx", "");
			HSSFRichTextString xsjzdlxStr = new HSSFRichTextString(xsjzdlx);
			xmCell = getCell(sheet, i+3, (short) 24);
			xmCell.setCellValue(xsjzdlxStr);
			
			//入学年月
			String rxny = DateUtils.getDateForYM(xsInfo.getRxny());
			HSSFRichTextString rxnyStr = new HSSFRichTextString(rxny);
			xmCell = getCell(sheet, i+3, (short) 25);
			xmCell.setCellValue(rxnyStr);
			
			//专业
			HSSFRichTextString zyStr = new HSSFRichTextString(xsInfo.getZyId().getZymc());
			xmCell = getCell(sheet, i+3, (short) 26);
			xmCell.setCellValue(zyStr);
			
			//专业方向
			HSSFRichTextString zyfxStr = new HSSFRichTextString(xsInfo.getZyId().getZyfxmc());
			xmCell = getCell(sheet, i+3, (short) 27);
			xmCell.setCellValue(zyfxStr);
			
			//学制
			String xz = DictUtils.getDictLabel(xsInfo.getXz(), "xzdm", "");
			HSSFRichTextString xzStr = new HSSFRichTextString(xz);
			xmCell = getCell(sheet, i+3, (short) 28);
			xmCell.setCellValue(xzStr);
			
			//民族
			String mz = DictUtils.getDictLabel(xsInfo.getMzm(), "nation", "");
			HSSFRichTextString mzStr = new HSSFRichTextString(mz);
			xmCell = getCell(sheet, i+3, (short) 29);
			xmCell.setCellValue(mzStr);
			
			//政治面貌
			String zzmm = DictUtils.getDictLabel(xsInfo.getZzmmm(), "zzmm", "");
			HSSFRichTextString zzmmStr = new HSSFRichTextString(zzmm);
			xmCell = getCell(sheet, i+3, (short) 30);
			xmCell.setCellValue(zzmmStr);
			
			//健康状况
			String jkzk = DictUtils.getDictLabel(xsInfo.getJkzkm(), "health", "");
			HSSFRichTextString jkzkStr = new HSSFRichTextString(jkzk);
			xmCell = getCell(sheet, i+3, (short) 31);
			xmCell.setCellValue(jkzkStr);
			
			//学生来源
			String xsly = DictUtils.getDictLabel(xsInfo.getXslym(), "xs_ly", "");
			HSSFRichTextString xslyStr = new HSSFRichTextString(xsly);
			xmCell = getCell(sheet, i+3, (short) 32);
			xmCell.setCellValue(xslyStr);
			
			//招生对象
			String zsdx = DictUtils.getDictLabel(xsInfo.getZsdx(), "zsdx", "");
			HSSFRichTextString zsdxStr = new HSSFRichTextString(zsdx);
			xmCell = getCell(sheet, i+3, (short) 33);
			xmCell.setCellValue(zsdxStr);
			
			//联系电话
			HSSFRichTextString lxdhStr = new HSSFRichTextString(xsInfo.getLxdh());
			xmCell = getCell(sheet, i+3, (short) 34);
			xmCell.setCellValue(lxdhStr);
			
			//招生方式
			String zsfs = DictUtils.getDictLabel(xsInfo.getZsfs(), "zsfs", "");
			HSSFRichTextString zsfsStr = new HSSFRichTextString(zsfs);
			xmCell = getCell(sheet, i+3, (short) 35);
			xmCell.setCellValue(zsfsStr);
			
			//联招合作类型
			String lzhzlx = DictUtils.getDictLabel(xsInfo.getLzhzlx(), "lzhzlx", "");
			HSSFRichTextString lzhzlxStr = new HSSFRichTextString(lzhzlx);
			xmCell = getCell(sheet, i+3, (short) 36);
			xmCell.setCellValue(lzhzlxStr);
			
			//准考证号
			HSSFRichTextString zkzhStr = new HSSFRichTextString(xsInfo.getZkzh());
			xmCell = getCell(sheet, i+3, (short) 37);
			xmCell.setCellValue(zkzhStr);
			
			//考生号
			HSSFRichTextString kshStr = new HSSFRichTextString(xsInfo.getKsh());
			xmCell = getCell(sheet, i+3, (short) 38);
			xmCell.setCellValue(kshStr);
			
			//考试总分
			HSSFRichTextString kszfStr = new HSSFRichTextString(xsInfo.getKszf());
			xmCell = getCell(sheet, i+3, (short) 39);
			xmCell.setCellValue(kszfStr);
			
			//联招合作办学形式
			String lzhzbxxs = DictUtils.getDictLabel(xsInfo.getLzhzbxfs(), "lzhzbxxs", "");
			HSSFRichTextString lzhzbxxsStr = new HSSFRichTextString(lzhzbxxs);
			xmCell = getCell(sheet, i+3, (short) 40);
			xmCell.setCellValue(lzhzbxxsStr);
			
			//联招合作学校代码
			HSSFRichTextString lzhzxxdmStr = new HSSFRichTextString(xsInfo.getLzhzxxdm());
			xmCell = getCell(sheet, i+3, (short) 41);
			xmCell.setCellValue(lzhzxxdmStr);
			
			//校外教学点
			HSSFRichTextString xwjxdStr = new HSSFRichTextString(xsInfo.getXwjxd());
			xmCell = getCell(sheet, i+3, (short) 42);
			xmCell.setCellValue(xwjxdStr);
			
			//分段培养方式
			String fdpyfs = DictUtils.getDictLabel(xsInfo.getFdpyfs(), "fdpyfs", "");
			HSSFRichTextString fdpyfsStr = new HSSFRichTextString(fdpyfs);
			xmCell = getCell(sheet, i+3, (short) 43);
			xmCell.setCellValue(fdpyfsStr);
			
			//英文姓名
			HSSFRichTextString ywxmStr = new HSSFRichTextString(xsInfo.getYwxm());
			xmCell = getCell(sheet, i+3, (short) 44);
			xmCell.setCellValue(ywxmStr);
			
			//电子信箱/其他联系方式
			HSSFRichTextString dzxxStr = new HSSFRichTextString(xsInfo.getDzxx());
			xmCell = getCell(sheet, i+3, (short) 45);
			xmCell.setCellValue(dzxxStr);
			
			//家庭现地址
			HSSFRichTextString jtxdzStr = new HSSFRichTextString(xsInfo.getJtxdz());
			xmCell = getCell(sheet, i+3, (short) 46);
			xmCell.setCellValue(jtxdzStr);
			
			//家庭邮政编码
			HSSFRichTextString jtyzbmStr = new HSSFRichTextString(xsInfo.getJtyzbm());
			xmCell = getCell(sheet, i+3, (short) 47);
			xmCell.setCellValue(jtyzbmStr);
			
			//家庭电话
			HSSFRichTextString jtdhStr = new HSSFRichTextString(xsInfo.getJtdh());
			xmCell = getCell(sheet, i+3, (short) 48);
			xmCell.setCellValue(jtdhStr);
			
			/**
			 * 成员1 信息
			 */

			//成员1姓名
			HSSFRichTextString cyyxmStr = new HSSFRichTextString(xsInfo.getCyyxm());
			xmCell = getCell(sheet, i+3, (short) 49);
			xmCell.setCellValue(cyyxmStr);
			
			//成员1关系
			String cyygx = DictUtils.getDictLabel(xsInfo.getCyygx(), "cygx", "");
			HSSFRichTextString cyygxStr = new HSSFRichTextString(cyygx);
			xmCell = getCell(sheet, i+3, (short) 50);
			xmCell.setCellValue(cyygxStr);
			
			//成员1是否监护人
			String cyyjhr = DictUtils.getDictLabel(xsInfo.getCyysfjhr(), "sfdm", "");
			HSSFRichTextString cyyjhrStr = new HSSFRichTextString(cyyjhr);
			xmCell = getCell(sheet, i+3, (short) 51);
			xmCell.setCellValue(cyyjhrStr);
			
			//成员1联系电话
			HSSFRichTextString cyylxdhStr = new HSSFRichTextString(xsInfo.getCyylxdh());
			xmCell = getCell(sheet, i+3, (short) 52);
			xmCell.setCellValue(cyylxdhStr);
			
			//成员1出生年月
			String cyycsny = DateUtils.getDateForYM(xsInfo.getCyycsny());
			HSSFRichTextString cyycsnyStr = new HSSFRichTextString(cyycsny);
			xmCell = getCell(sheet, i+3, (short) 53);
			xmCell.setCellValue(cyycsnyStr);
			
			//成员1身份证件类型
			String cyysfzlx = DictUtils.getDictLabel(xsInfo.getCyysfzjlx(), "sfzjlx", "");
			HSSFRichTextString cyysfzlxStr = new HSSFRichTextString(cyysfzlx);
			xmCell = getCell(sheet, i+3, (short) 54);
			xmCell.setCellValue(cyysfzlxStr);
			
			//成员1身份证件号
			HSSFRichTextString cyysfzjhStr = new HSSFRichTextString(xsInfo.getCyysfzjh());
			xmCell = getCell(sheet, i+3, (short) 55);
			xmCell.setCellValue(cyysfzjhStr);
			
			//成员1民族
			String cyymz = DictUtils.getDictLabel(xsInfo.getCyymzm(), "nation", "");
			HSSFRichTextString cyymzStr = new HSSFRichTextString(cyymz);
			xmCell = getCell(sheet, i+3, (short) 56);
			xmCell.setCellValue(cyymzStr);
			
			//成员1政治面貌
			String cyyzzmm = DictUtils.getDictLabel(xsInfo.getCyyzzmmm(), "zzmm", "");
			HSSFRichTextString cyyzzmmStr = new HSSFRichTextString(cyyzzmm);
			xmCell = getCell(sheet, i+3, (short) 57);
			xmCell.setCellValue(cyyzzmmStr);
			
			//成员1健康状况
			String cyyjkzk = DictUtils.getDictLabel(xsInfo.getCyyjkzkm(), "health", "");
			HSSFRichTextString cyyjkzkStr = new HSSFRichTextString(cyyjkzk);
			xmCell = getCell(sheet, i+3, (short) 58);
			xmCell.setCellValue(cyyjkzkStr);
			
			//成员1工作或学习单位
			HSSFRichTextString cyygzhxxdwStr = new HSSFRichTextString(xsInfo.getCyygzhxxdw());
			xmCell = getCell(sheet, i+3, (short) 59);
			xmCell.setCellValue(cyygzhxxdwStr);
			
			//成员1职务
			HSSFRichTextString cyyzwStr = new HSSFRichTextString(xsInfo.getCyyzw());
			xmCell = getCell(sheet, i+3, (short) 60);
			xmCell.setCellValue(cyyzwStr);
			
			/**
			 * 成员2 信息
			 */

			//成员2姓名
			HSSFRichTextString cyexmStr = new HSSFRichTextString(xsInfo.getCyexm());
			xmCell = getCell(sheet, i+3, (short) 61);
			xmCell.setCellValue(cyexmStr);
			
			//成员2关系
			String cyegx = DictUtils.getDictLabel(xsInfo.getCyegx(), "cygx", "");
			HSSFRichTextString cyegxStr = new HSSFRichTextString(cyegx);
			xmCell = getCell(sheet, i+3, (short) 62);
			xmCell.setCellValue(cyegxStr);
			
			//成员2是否监护人
			String cyejhr = DictUtils.getDictLabel(xsInfo.getCyesfjhr(), "sfdm", "");
			HSSFRichTextString cyejhrStr = new HSSFRichTextString(cyejhr);
			xmCell = getCell(sheet, i+3, (short) 63);
			xmCell.setCellValue(cyejhrStr);
			
			//成员2联系电话
			HSSFRichTextString cyelxdhStr = new HSSFRichTextString(xsInfo.getCyelxdh());
			xmCell = getCell(sheet, i+3, (short) 64);
			xmCell.setCellValue(cyelxdhStr);
			
			//成员2出生年月
			String cyecsny = DateUtils.getDateForYM(xsInfo.getCyecsny());
			HSSFRichTextString cyecsnyStr = new HSSFRichTextString(cyecsny);
			xmCell = getCell(sheet, i+3, (short) 65);
			xmCell.setCellValue(cyecsnyStr);
			
			//成员2身份证件类型
			String cyesfzlx = DictUtils.getDictLabel(xsInfo.getCyesfzjlx(), "sfzjlx", "");
			HSSFRichTextString cyesfzlxStr = new HSSFRichTextString(cyesfzlx);
			xmCell = getCell(sheet, i+3, (short) 66);
			xmCell.setCellValue(cyesfzlxStr);
			
			//成员2身份证件号
			HSSFRichTextString cyesfzjhStr = new HSSFRichTextString(xsInfo.getCyesfzjh());
			xmCell = getCell(sheet, i+3, (short) 67);
			xmCell.setCellValue(cyesfzjhStr);
			
			//成员2民族
			String cyemz = DictUtils.getDictLabel(xsInfo.getCyemzm(), "nation", "");
			HSSFRichTextString cyemzStr = new HSSFRichTextString(cyemz);
			xmCell = getCell(sheet, i+3, (short) 68);
			xmCell.setCellValue(cyemzStr);
			
			//成员2政治面貌
			String cyezzmm = DictUtils.getDictLabel(xsInfo.getCyezzmmm(), "zzmm", "");
			HSSFRichTextString cyezzmmStr = new HSSFRichTextString(cyezzmm);
			xmCell = getCell(sheet, i+3, (short) 69);
			xmCell.setCellValue(cyezzmmStr);
			
			//成员2健康状况
			String cyejkzk = DictUtils.getDictLabel(xsInfo.getCyejkzkm(), "health", "");
			HSSFRichTextString cyejkzkStr = new HSSFRichTextString(cyejkzk);
			xmCell = getCell(sheet, i+3, (short) 70);
			xmCell.setCellValue(cyejkzkStr);
			
			//成员2工作或学习单位
			HSSFRichTextString cyegzhxxdwStr = new HSSFRichTextString(xsInfo.getCyegzhxxdw());
			xmCell = getCell(sheet, i+3, (short) 71);
			xmCell.setCellValue(cyegzhxxdwStr);
			
			//成员2职务
			HSSFRichTextString cyezwStr = new HSSFRichTextString(xsInfo.getCyezw());
			xmCell = getCell(sheet, i+3, (short) 72);
			xmCell.setCellValue(cyezwStr);
		}
			
		// 保存
		saveWorkBook(wb,file);
	}

}
