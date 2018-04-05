/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 计划分解Entity
 * @author lg
 * @version 2016-05-20
 */
public class JhFj extends DataEntity<JhFj> {
	
	private static final long serialVersionUID = 1L;
	private Zsjh Zsjh;		// 招生计划
	private Office office;		// 部门名称
	private Integer zsrs;		// 招生人数
	private Integer px;		//排序
	private String fjFlag; //分解状态
	private Integer beginZsrs;		// 开始 招生人数
	private Integer endZsrs;		// 结束 招生人数
	private String bcStatus;// 1：(保存)通过 2：(提交)不通过
	protected User approveBy;	// 审核人
	protected Date approveDate;	// 审核时间
	private String spnr;//审批内容(审核意见)
	private String grShZt;// 部门内部任务 1：通过 2：不通过
	private String grSpnr;//部门内部任务审批内容(审核意见)
	protected User grApproveBy;	// 审核人
	protected Date grApproveDate;	// 审核时间
	
	public String getGrShZt() {
		return grShZt;
	}

	public void setGrShZt(String grShZt) {
		this.grShZt = grShZt;
	}

	public String getGrSpnr() {
		return grSpnr;
	}

	public void setGrSpnr(String grSpnr) {
		this.grSpnr = grSpnr;
	}
	
	public String getFjFlag() {
		return fjFlag;
	}

	public void setFjFlag(String fjFlag) {
		this.fjFlag = fjFlag;
	}

	public Integer getPx() {
		return px;
	}

	public void setPx(Integer px) {
		this.px = px;
	}
	public JhFj() {
		super();
	}

	public JhFj(String id){
		super(id);
	}

	@NotNull(message="招生计划不能为空")
	public Zsjh getZsjh() {
		return Zsjh;
	}

	public void setZsjh(Zsjh Zsjh) {
		this.Zsjh = Zsjh;
	}
	
	@NotNull(message="部门名称不能为空")
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	public Integer getZsrs() {
		return zsrs;
	}

	public void setZsrs(Integer zsrs) {
		this.zsrs = zsrs;
	}
	
	public Integer getBeginZsrs() {
		return beginZsrs;
	}

	public void setBeginZsrs(Integer beginZsrs) {
		this.beginZsrs = beginZsrs;
	}
	
	public Integer getEndZsrs() {
		return endZsrs;
	}

	public void setEndZsrs(Integer endZsrs) {
		this.endZsrs = endZsrs;
	}
	
	public String getBcStatus() {
		return bcStatus;
	}

	public void setBcStatus(String bcStatus) {
		this.bcStatus = bcStatus;
	}
	
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
	
	@JsonIgnore
	public User getGrApproveBy() {
		return grApproveBy;
	}

	public void setGrApproveBy(User grApproveBy) {
		this.grApproveBy = grApproveBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getGrApproveDate() {
		return grApproveDate;
	}

	public void setGrApproveDate(Date grApproveDate) {
		this.grApproveDate = grApproveDate;
	}
		
}