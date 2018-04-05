/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xjxx.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 年级信息Entity
 * @author st
 * @version 2016-09-27
 */
public class XnJbxx extends DataEntity<XnJbxx> {
	
	private static final long serialVersionUID = 1L;
	private String nf;		// nf
	
	public XnJbxx() {
		super();
	}

	public XnJbxx(String id){
		super(id);
	}

	@Length(min=0, max=20, message="nf长度必须介于 0 和 20 之间")
	public String getNf() {
		return nf;
	}

	public void setNf(String nf) {
		this.nf = nf;
	}
	
}