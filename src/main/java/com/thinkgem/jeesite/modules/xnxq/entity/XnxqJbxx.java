/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xnxq.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学年学期Entity
 * @author st
 * @version 2016-09-22
 */
public class XnxqJbxx extends DataEntity<XnxqJbxx> {
	
	private static final long serialVersionUID = 1L;
	private String xnmc;		// 学年名称
	private String xq;		// 学期名称
	private Date kssj;		// 开始时间
	private Date jssj;		// 结束时间
	
	public XnxqJbxx() {
		super();
	}

	public XnxqJbxx(String id){
		super(id);
	}

	@Length(min=0, max=200, message="学年名称长度必须介于 0 和 200 之间")
	public String getXnmc() {
		return xnmc;
	}

	public void setXnmc(String xnmc) {
		this.xnmc = xnmc;
	}
	
	@Length(min=0, max=64, message="学期名称长度必须介于 0 和 64 之间")
	public String getXq() {
		return xq;
	}

	public void setXq(String xq) {
		this.xq = xq;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getKssj() {
		return kssj;
	}

	public void setKssj(Date kssj) {
		this.kssj = kssj;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getJssj() {
		return jssj;
	}

	public void setJssj(Date jssj) {
		this.jssj = jssj;
	}
	
}