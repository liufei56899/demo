/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 计划分解个人记录Entity
 * @author lg
 * @version 2016-07-23
 */
public class JhFjGrRecord extends DataEntity<JhFjGrRecord> {
	
	private static final long serialVersionUID = 1L;
	private String jhFjGrId;		// 计划分解个人
	private Zsjh Zsjh;		// 招生计划
	private String jhId;		// 招生计划
	private String jsId;		// 招生老师
	private String jsmc;		//教师名称
	protected User approveBy;	// 审核人
	protected Date approveDate;	// 审核时间
	public Zsjh getZsjh() {
		return Zsjh;
	}

	public void setZsjh(Zsjh zsjh) {
		Zsjh = zsjh;
	}

	public String getJsmc() {
		return jsmc;
	}

	public void setJsmc(String jsmc) {
		this.jsmc = jsmc;
	}

	private Integer zsrs;		// 招生人数
	private Integer px;		// 排序
	private String bcstatus;		// 1:通过 2:不通过
	private String spnr;		// 审批内容
	
	public JhFjGrRecord() {
		super();
	}

	public JhFjGrRecord(String id){
		super(id);
	}

	@Length(min=1, max=64, message="计划分解个人长度必须介于 1 和 64 之间")
	public String getJhFjGrId() {
		return jhFjGrId;
	}

	public void setJhFjGrId(String jhFjGrId) {
		this.jhFjGrId = jhFjGrId;
	}
	
	@Length(min=1, max=64, message="招生计划长度必须介于 1 和 64 之间")
	public String getJhId() {
		return jhId;
	}

	public void setJhId(String jhId) {
		this.jhId = jhId;
	}
	
	@Length(min=1, max=64, message="招生老师长度必须介于 1 和 64 之间")
	public String getJsId() {
		return jsId;
	}

	public void setJsId(String jsId) {
		this.jsId = jsId;
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