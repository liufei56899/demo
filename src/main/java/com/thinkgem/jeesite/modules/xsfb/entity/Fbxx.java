package com.thinkgem.jeesite.modules.xsfb.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
/**
 * 分班信息Entity
 * 
 * @author zh
 * @version 2018-02-08
 */
public class Fbxx extends DataEntity<Fbxx>{
	private static final long serialVersionUID = 1L;
	private String bjmc;
	private String zyid;
	private String zymc;
	private String yyxs;
	private String man;
	private String woman;
	public Fbxx() {
		super();
	}
	public Fbxx(String id){
		super(id);
	}
	public String getBjmc() {
		return bjmc;
	}
	public String getZyid() {
		return zyid;
	}
	public String getZymc() {
		return zymc;
	}	
	public String getYyxs() {
		return yyxs;
	}	
	public String getMan() {
		return man;
	}	
	public String getWoman() {
		return woman;
	}
	public void setBjmc(String bjmc) {
		this.bjmc = bjmc;
	}
	public void setZyid(String zyid) {
		this.zyid = zyid;
	}
	public void setZymc(String zymc) {
		this.zymc = zymc;
	}
	public void setYyxs(String yyxs) {
		this.yyxs = yyxs;
	}
	public void setMan(String man) {
		this.man = man;
	}
	public void setWoman(String woman) {
		this.woman = woman;
	}
	
}
