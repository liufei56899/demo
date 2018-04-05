/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zylx.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 专业类别Entity
 * @author zw
 * @version 2016-04-25
 */
public class ZylxJbxx extends DataEntity<ZylxJbxx> {
	
	private static final long serialVersionUID = 1L;
	private String lxmc;		// 类型名称
	private String lxms;		// 类型描述
	
	public ZylxJbxx() {
		super();
	}

	public ZylxJbxx(String id){
		super(id);
	}

	@Length(min=1, max=64, message="类型名称长度必须介于 1 和 64 之间")
	public String getLxmc() {
		return lxmc;
	}

	public void setLxmc(String lxmc) {
		this.lxmc = lxmc;
	}
	
	@Length(min=0, max=255, message="类型描述长度必须介于 0 和 255 之间")
	public String getLxms() {
		return lxms;
	}

	public void setLxms(String lxms) {
		this.lxms = lxms;
	}
	
}