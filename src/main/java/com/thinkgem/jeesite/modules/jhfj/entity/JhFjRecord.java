/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 部门任务分解记录Entity
 * @author lg
 * @version 2016-07-23
 */
public class JhFjRecord extends DataEntity<JhFjRecord> {
	
	private static final long serialVersionUID = 1L;
	private String jhFjId;		// 计划分解表ID
	private Zsjh Zsjh;		// 招生计划
	private Office office;		// 部门名称
	private Integer zsrs;		// 招生人数
	private Integer px;		// 排序
	private String fjFlag;		// 分解状态
	private String bcstatus;		// 1:通过 2:不通过
	private String spnr;		// 审批内容
	protected User approveBy;	// 审核人
	protected Date approveDate;	// 审核时间
	
	public Zsjh getZsjh() {
		return Zsjh;
	}

	public void setZsjh(Zsjh zsjh) {
		Zsjh = zsjh;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	public JhFjRecord() {
		super();
	}

	public JhFjRecord(String id){
		super(id);
	}

	@Length(min=1, max=64, message="计划分解表ID长度必须介于 1 和 64 之间")
	public String getJhFjId() {
		return jhFjId;
	}

	public void setJhFjId(String jhFjId) {
		this.jhFjId = jhFjId;
	}
	
	@Length(min=0, max=11, message="招生人数长度必须介于 0 和 11 之间")
	public Integer getZsrs() {
		return zsrs;
	}

	public void setZsrs(Integer zsrs) {
		this.zsrs = zsrs;
	}
	
	@Length(min=0, max=11, message="排序长度必须介于 0 和 11 之间")
	public Integer getPx() {
		return px;
	}

	public void setPx(Integer px) {
		this.px = px;
	}
	
	@Length(min=0, max=1, message="分解状态长度必须介于 0 和 1 之间")
	public String getFjFlag() {
		return fjFlag;
	}

	public void setFjFlag(String fjFlag) {
		this.fjFlag = fjFlag;
	}
	
	@Length(min=0, max=1, message="1:通过 2:不通过长度必须介于 0 和 1 之间")
	public String getBcstatus() {
		return bcstatus;
	}

	public void setBcstatus(String bcstatus) {
		this.bcstatus = bcstatus;
	}
	
	@Length(min=0, max=255, message="审批内容长度必须介于 0 和 255 之间")
	public String getSpnr() {
		return spnr;
	}

	public void setSpnr(String spnr) {
		this.spnr = spnr;
	}
	
	@JsonIgnore
	public User getApproveBy() {
		return approveBy;
	}

	public void setApproveBy(User approveBy) {
		this.approveBy = approveBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(Date approveDate) {
		this.approveDate = approveDate;
	}
	
}