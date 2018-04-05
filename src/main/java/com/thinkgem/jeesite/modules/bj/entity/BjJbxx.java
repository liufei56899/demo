/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bj.entity;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 班级信息Entity
 * 
 * @author zw
 * @version 2016-05-18
 */
public class BjJbxx extends DataEntity<BjJbxx> {

	private static final long serialVersionUID = 1L;
	private String bjmc; // 班级名称
	private Integer nf; // 年份
	private String xqId; // 学期
	private ZyJbxx zyId; // 专业ID，专业表主键
	private String rnrs; // 容纳人数
	private ZylxJbxx zylxId; // 专业类别
	private User jsId; // 教师id
	
	private String bh;//班号
	private XnJbxx njid;//
	private Date jbny;
	private String xqmc;
	private String jsbh;
	private String sfssmzjxb;
	private String ssmzjxbmzyymc;
	private String ssmzsyjxms;
	private String sfqrz;
	private String ndxjzzb;
	private String ndxzzzb;
	private String sfbyb;
	private Date byrq;
	private String classroomid;
	private List<JsJbxx> teacher;
	public List<JsJbxx> getTeacher() {
		return teacher;
	}

	public void setTeacher(List<JsJbxx> teacher) {
		this.teacher = teacher;
	}

	public String getClassroomid() {
		return classroomid;
	}

	public void setClassroomid(String classroomid) {
		this.classroomid = classroomid;
	}

	public String getBh() {
		return bh;
	}

	public void setBh(String bh) {
		this.bh = bh;
	}
	@NotNull(message="年级信息，年级信息表主键不能为空")
	public XnJbxx getNjid() {
		return njid;
	}

	public void setNjid(XnJbxx njid) {
		this.njid = njid;
	}
		
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getJbny() {
		return jbny;
	}

	public void setJbny(Date jbny) {
		this.jbny = jbny;
	}

	public String getXqmc() {
		return xqmc;
	}

	public void setXqmc(String xqmc) {
		this.xqmc = xqmc;
	}

	public String getJsbh() {
		return jsbh;
	}

	public void setJsbh(String jsbh) {
		this.jsbh = jsbh;
	}

	public String getSfssmzjxb() {
		return sfssmzjxb;
	}

	public void setSfssmzjxb(String sfssmzjxb) {
		this.sfssmzjxb = sfssmzjxb;
	}

	public String getSsmzjxbmzyymc() {
		return ssmzjxbmzyymc;
	}

	public void setSsmzjxbmzyymc(String ssmzjxbmzyymc) {
		this.ssmzjxbmzyymc = ssmzjxbmzyymc;
	}

	public String getSsmzsyjxms() {
		return ssmzsyjxms;
	}

	public void setSsmzsyjxms(String ssmzsyjxms) {
		this.ssmzsyjxms = ssmzsyjxms;
	}

	public String getSfqrz() {
		return sfqrz;
	}

	public void setSfqrz(String sfqrz) {
		this.sfqrz = sfqrz;
	}

	public String getNdxjzzb() {
		return ndxjzzb;
	}

	public void setNdxjzzb(String ndxjzzb) {
		this.ndxjzzb = ndxjzzb;
	}

	public String getNdxzzzb() {
		return ndxzzzb;
	}

	public void setNdxzzzb(String ndxzzzb) {
		this.ndxzzzb = ndxzzzb;
	}

	public String getSfbyb() {
		return sfbyb;
	}

	public void setSfbyb(String sfbyb) {
		this.sfbyb = sfbyb;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getByrq() {
		return byrq;
	}

	public void setByrq(Date byrq) {
		this.byrq = byrq;
	}

	public BjJbxx() {
		super();
	}

	public BjJbxx(String id) {
		super(id);
	}

	@Length(min = 1, max = 64, message = "班级名称长度必须介于 1 和 64 之间")
	public String getBjmc() {
		return bjmc;
	}

	public void setBjmc(String bjmc) {
		this.bjmc = bjmc;
	}

	public Integer getNf() {
		return nf;
	}

	public void setNf(Integer nf) {
		this.nf = nf;
	}

	public String getXqId() {
		return xqId;
	}

	public void setXqId(String xqId) {
		this.xqId = xqId;
	}

	@NotNull(message = "专业ID，专业表主键不能为空")
	public ZyJbxx getZyId() {
		return zyId;
	}

	public void setZyId(ZyJbxx zyId) {
		this.zyId = zyId;
	}

	@Length(min = 0, max = 11, message = "容纳人数长度必须介于 0 和 11 之间")
	public String getRnrs() {
		return rnrs;
	}

	public void setRnrs(String rnrs) {
		this.rnrs = rnrs;
	}

	public ZylxJbxx getZylxId() {
		return zylxId;
	}

	public void setZylxId(ZylxJbxx zylxId) {
		this.zylxId = zylxId;
	}

	public User getJsId() {
		return jsId;
	}

	public void setJsId(User jsId) {
		this.jsId = jsId;
	}

}