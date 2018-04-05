/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjh.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;

/**
 * 计划招生Entity
 * 
 * @author XFB
 * @version 2016-07-20
 */
public class ZsjhRecord extends ActEntity<ZsjhRecord> {

	private static final long serialVersionUID = 1L;
	private String cid;// 招生计划ID
	private String jhmc; // 计划名称
	private XnxqJbxx nf; // 年份
	private String xqId; // 学期
	private String zsrs; // 招生人数
	private String procInsId; // 流程实例ID
	private String jhsm; // 计划说明
	private String zt; // 0：已保存(未提交)；1：未审核(已提交)；2：审核不通过；3：审核通过
	private String bcStatus;// 1：(保存)通过 2：(提交)不通过
	private String spnr;// 审批内容
	private int surplus;// 剩余人数
	private Date startDate;// 开始时间
	private Date endDate;// 结束时间
	

	public XnxqJbxx getNf() {
		return nf;
	}

	public void setNf(XnxqJbxx nf) {
		this.nf = nf;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public int getSurplus() {
		return surplus;
	}

	public void setSurplus(int surplus) {
		this.surplus = surplus;
	}

	private List<JhZyInfo> jhZyInfos;

	public ZsjhRecord() {
		super();
	}

	public ZsjhRecord(String id) {
		super(id);
	}

	@Length(min = 1, max = 64, message = "计划名称长度必须介于 1 和 64 之间")
	public String getJhmc() {
		return jhmc;
	}

	public void setJhmc(String jhmc) {
		this.jhmc = jhmc;
	}



	public String getXqId() {
		return xqId;
	}

	public void setXqId(String xqId) {
		this.xqId = xqId;
	}

	@Length(min = 1, max = 11, message = "招生人数长度必须介于 1 和 11 之间")
	public String getZsrs() {
		return zsrs;
	}

	public void setZsrs(String zsrs) {
		this.zsrs = zsrs;
	}

	@Length(min = 0, max = 64, message = "流程实例ID长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}

	@Length(min = 0, max = 255, message = "计划说明长度必须介于 0 和 255 之间")
	public String getJhsm() {
		return jhsm;
	}

	public void setJhsm(String jhsm) {
		this.jhsm = jhsm;
	}

	@Length(min = 0, max = 1, message = "0：已保存；1：未审核；2：审核不通过；3：审核通过长度必须介于 0 和 1 之间")
	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getBcStatus() {
		return bcStatus;
	}

	public void setBcStatus(String bcStatus) {
		this.bcStatus = bcStatus;
	}

	public List<JhZyInfo> getJhZyInfos() {
		return jhZyInfos;
	}

	public void setJhZyInfos(List<JhZyInfo> jhZyInfos) {
		this.jhZyInfos = jhZyInfos;
	}

	public String getSpnr() {
		return spnr;
	}

	public void setSpnr(String spnr) {
		this.spnr = spnr;
	}

}