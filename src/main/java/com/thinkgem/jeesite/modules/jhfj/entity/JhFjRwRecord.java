/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 计划分解任务历史记录Entity
 * @author lg
 * @version 2016-07-23
 */
public class JhFjRwRecord extends DataEntity<JhFjRwRecord> {
	
	private static final long serialVersionUID = 1L;
	private String jhFjRecordId;  //计划分解记录ID
	private String jhFjRwId;		// 计划分解任务ID
	private String jhFjId;		// 计划分解
	private String jhId;	//计划id
	private String bmId;	//部门id
	private String sf;		// 省份
	private String sfName;
	private String cs;		// 城市
	private String csName;
	private String qx;		// 区县
	private String qxName;
	private String xz;		// 乡镇
	private String xzName;
	
	public String getJhFjRecordId() {
		return jhFjRecordId;
	}

	public void setJhFjRecordId(String jhFjRecordId) {
		this.jhFjRecordId = jhFjRecordId;
	}
	
	public String getJhId() {
		return jhId;
	}

	public void setJhId(String jhId) {
		this.jhId = jhId;
	}

	public String getBmId() {
		return bmId;
	}

	public void setBmId(String bmId) {
		this.bmId = bmId;
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

	public JhFjRwRecord() {
		super();
	}

	public JhFjRwRecord(String id){
		super(id);
	}

	@Length(min=1, max=64, message="计划分解任务ID长度必须介于 1 和 64 之间")
	public String getJhFjRwId() {
		return jhFjRwId;
	}

	public void setJhFjRwId(String jhFjRwId) {
		this.jhFjRwId = jhFjRwId;
	}
	
	@Length(min=1, max=64, message="计划分解长度必须介于 1 和 64 之间")
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