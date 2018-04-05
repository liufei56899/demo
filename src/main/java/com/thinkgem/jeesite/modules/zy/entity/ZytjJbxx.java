/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zy.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 专业Entity
 * @author zw
 * @version 2016-04-25
 */
public class ZytjJbxx extends DataEntity<ZyJbxx> {
	
	private String id;
	private String zymc;		// 专业名称
	private String zsjhId;//招生计划id
	private String zsrs;// 招生人数
	private String zstype;// 招生类型
	private String zsbm;//招生部门
	private String zsbmmc;//招生部门名称
	private String newYear;//年份
	private String tjtype;//统计类型
	private String[] zsnd;//招生年度
	private String zsnd1[];
	private String zyxzmc;//专业学制名称
	
	
	
	
	
	public String getZyxzmc() {
		return zyxzmc;
	}
	public void setZyxzmc(String zyxzmc) {
		this.zyxzmc = zyxzmc;
	}
	public String[] getZsnd1() {
		return zsnd1;
	}
	public void setZsnd1(String[] zsnd1) {
		this.zsnd1 = zsnd1;
	}

	public String[] getZsnd() {
		return zsnd;
	}

	public void setZsnd(String[] zsnd) {
		this.zsnd = zsnd;
	}

	public String getNewYear() {
		return newYear;
	}

	public void setNewYear(String newYear) {
		this.newYear = newYear;
	}

	public String getTjtype() {
		return tjtype;
	}

	public void setTjtype(String tjtype) {
		this.tjtype = tjtype;
	}

	public String getZsbmmc() {
		return zsbmmc;
	}

	public void setZsbmmc(String zsbmmc) {
		this.zsbmmc = zsbmmc;
	}

	public String getZsbm() {
		return zsbm;
	}

	public void setZsbm(String zsbm) {
		this.zsbm = zsbm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getZsjhId() {
		return zsjhId;
	}

	public void setZsjhId(String zsjhId) {
		this.zsjhId = zsjhId;
	}

	public String getZsrs() {
		return zsrs;
	}

	public void setZsrs(String zsrs) {
		this.zsrs = zsrs;
	}

	public String getZstype() {
		return zstype;
	}

	public void setZstype(String zstype) {
		this.zstype = zstype;
	}

	
	@Length(min=1, max=64, message="专业名称长度必须介于 1 和 64 之间")
	public String getZymc() {
		return zymc;
	}

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}
	
}