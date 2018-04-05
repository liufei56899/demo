package com.thinkgem.jeesite.modules.statistics.entity;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 统计类--实体工具类
 * @author lf
 * @version 2017-03-28
 */
public class SchoolAndZy {
	private String school;//统计项名称
	private String zymc;//统计项名称
	private String zsnd;//统计项名称
	@ExcelField(title ="招生年度")
	public String getZsnd() {
		return zsnd;
	}
	public void setZsnd(String zsnd) {
		this.zsnd = zsnd;
	}
	private int rws;//统计项数据1（一般为任务数）
	private int djs;//统计项数据2（一般为登记数）
	private int wcs;//统计项数据3（一般为完成数）
	@ExcelField(title ="学校名称")
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	@ExcelField(title ="专业名称")
	public String getZymc() {
		return zymc;
	}
	public void setZymc(String zymc) {
		this.zymc = zymc;
	}
	/*@ExcelField(title ="专业任务数")*/
	public int getRws() {
		return rws;
	}
	public void setRws(int rws) {
		this.rws = rws;
	}
	@ExcelField(title ="专业登记数")
	public int getDjs() {
		return djs;
	}
	public void setDjs(int djs) {
		this.djs = djs;
	}
	@ExcelField(title ="专业完成数")
	public int getWcs() {
		return wcs;
	}
	public void setWcs(int wcs) {
		this.wcs = wcs;
	}
}
