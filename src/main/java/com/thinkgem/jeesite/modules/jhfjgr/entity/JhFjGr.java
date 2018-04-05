/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 计划分解个人Entity
 * @author lg
 * @version 2016-05-26
 */
public class JhFjGr extends DataEntity<JhFjGr> {
	
	private static final long serialVersionUID = 1L;
	private Zsjh Zsjh;		// 招生计划
	private String jsId;		// 教师ID
	private String jsmc;		//教师名称
	private Integer zsrs;		// 招生人数
	private Integer px;		// 排序
	private Integer beginZsrs;		// 开始 招生人数
	private Integer endZsrs;		// 结束 招生人数
	private String bcStatus;// 1：(保存)通过 2：(提交)不通过
	private String spnr;//审批内容(审核意见)
	private String officeId;
	protected User approveBy;	// 审核人
	protected Date approveDate;	// 审核时间
	
	public String getOfficeId() {
		return officeId;
	}

	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}

	private String fjfs;//个人任务分解方式 1：招生办分解 2：部门内部分解
	
	public String getFjfs() {
		return fjfs;
	}

	public void setFjfs(String fjfs) {
		this.fjfs = fjfs;
	}

	public String getJsmc() {
		return jsmc;
	}

	public void setJsmc(String jsmc) {
		this.jsmc = jsmc;
	}
	
	public JhFjGr() {
		super();
	}

	public JhFjGr(String id){
		super(id);
	}

	@NotNull(message="招生计划不能为空")
	public Zsjh getZsjh() {
		return Zsjh;
	}

	public void setZsjh(Zsjh Zsjh) {
		this.Zsjh = Zsjh;
	}
	
	@Length(min=1, max=64, message="教师名称长度必须介于 1 和 64 之间")
	public String getJsId() {
		return jsId;
	}

	public void setJsId(String jsId) {
		this.jsId = jsId;
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
	
	public Integer getPx() {
		return px;
	}

	public void setPx(Integer px) {
		this.px = px;
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
		
}