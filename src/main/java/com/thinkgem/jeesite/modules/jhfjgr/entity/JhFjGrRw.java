/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 计划分解个人任务明细Entity
 * @author lg
 * @version 2016-05-26
 */
public class JhFjGrRw extends DataEntity<JhFjGrRw> {
	
	private static final long serialVersionUID = 1L;
	private String jhFjId;		// 计划分解编号
	private String jhId;	//计划id
	private String jsId;	//教师id
	private String sf;		// 省份
	private String sfName;
	private String cs;		// 城市
	private String csName;
	
	private String zsnd;//临时使用招生年度
	private String type;//临时使用区域类型
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getZsnd() {
		return zsnd;
	}

	public void setZsnd(String zsnd) {
		this.zsnd = zsnd;
	}

	public String getJsId() {
		return jsId;
	}

	public void setJsId(String jsId) {
		this.jsId = jsId;
	}
	
	public String getJhId() {
		return jhId;
	}

	public void setJhId(String jhId) {
		this.jhId = jhId;
	}

	public String getSfName() {
		return sfName;
	}

	public void setSfName(String sfName) {
		this.sfName = sfName;
	}

	public String getCsName() {
		return csName;
	}

	public void setCsName(String csName) {
		this.csName = csName;
	}

	public String getQxName() {
		return qxName;
	}

	public void setQxName(String qxName) {
		this.qxName = qxName;
	}

	public String getXzName() {
		return xzName;
	}

	public void setXzName(String xzName) {
		this.xzName = xzName;
	}

	private String qx;		// 区县
	private String qxName;
	private String xz;		// 乡镇
	private String xzName;
	
	public JhFjGrRw() {
		super();
	}

	public JhFjGrRw(String id){
		super(id);
	}

	@Length(min=1, max=64, message="计划分解编号长度必须介于 1 和 64 之间")
	public String getJhFjId() {
		return jhFjId;
	}

	public void setJhFjId(String jhFjId) {
		this.jhFjId = jhFjId;
	}
	
	@Length(min=0, max=64, message="省份长度必须介于 0 和 64 之间")
	public String getSf() {
		return sf;
	}

	public void setSf(String sf) {
		this.sf = sf;
	}
	
	@Length(min=0, max=64, message="城市长度必须介于 0 和 64 之间")
	public String getCs() {
		return cs;
	}

	public void setCs(String cs) {
		this.cs = cs;
	}
	
	@Length(min=0, max=64, message="区县长度必须介于 0 和 64 之间")
	public String getQx() {
		return qx;
	}

	public void setQx(String qx) {
		this.qx = qx;
	}
	
	@Length(min=0, max=64, message="乡镇长度必须介于 0 和 64 之间")
	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}
	
}