package com.thinkgem.jeesite.modules.statistics.entity;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 统计类--实体工具类
 * @author dhp
 * @version 2017-03-14
 */
public class Statistics {
	private String ranking;//排行榜排名
	private String id;
	private String name;//统计项名称
	private int num1;//统计项数据1（一般为任务数）
	private int num2;//统计项数据2（一般为登记数）
	private int num3;//统计项数据3（一般为完成数）
	private String num4;//招生完成率
	
	private String id2;//备用id
	
	private String name2;//备用name
	private String zsnd;//备用zsnd
	private int num5;//计划任务总数统计项数据1（一般为任务数）
	private int num6;//计划登记总数统计项数据2（一般为登记数）
	private int num7;//计划完成总数统计项数据3（一般为完成数）
	private String num8;//计划完成率招生完成率


	public String getRanking() {
		return ranking;
	}
	public void setRanking(String ranking) {
		this.ranking = ranking;
	}
	public String getId2() {
		return id2;
	}
	public void setId2(String id2) {
		this.id2 = id2;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}

	public int getNum5() {
		return num5;
	}
	public void setNum5(int num5) {
		this.num5 = num5;
	}
	public int getNum6() {
		return num6;
	}
	public void setNum6(int num6) {
		this.num6 = num6;
	}
	public int getNum7() {
		return num7;
	}
	public void setNum7(int num7) {
		this.num7 = num7;
	}
	public String getNum8() {
		return num8;
	}
	public void setNum8(String num8) {
		this.num8 = num8;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@ExcelField(title ="区域名称")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@ExcelField(title ="招生任务数")
	public int getNum1() {
		return num1;
	}
	public void setNum1(int num1) {
		this.num1 = num1;
	}
	@ExcelField(title ="招生登记数")
	public int getNum2() {
		return num2;
	}
	public void setNum2(int num2) {
		this.num2 = num2;
	}
	@ExcelField(title ="招生完成数")
	public int getNum3() {
		return num3;
	}
	public void setNum3(int num3) {
		this.num3 = num3;
	}
	@ExcelField(title ="招生完成率")
	public String getNum4() {
		return num4;
	}
	public void setNum4(String num4) {
		this.num4 = num4;
	}
	@ExcelField(title ="招生年度")
	public String getZsnd() {
		return zsnd;
	}
	public void setZsnd(String zsnd) {
		this.zsnd = zsnd;
	}
}
