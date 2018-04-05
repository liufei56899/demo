/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zszy.entity;

import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 招生计划专业人数记录Entity
 * @author zw
 * @version 2016-05-13
 */
public class JhZyInfo extends DataEntity<JhZyInfo> {
	
	private static final long serialVersionUID = 1L;
	private Zsjh zsjhId;		// 招生计划
	private ZylxJbxx zylxId;		// 专业类别
	private ZyJbxx zyId;		// 专业
	private Integer zsrs;		// 计划人数
	
	public JhZyInfo() {
		super();
	}

	public JhZyInfo(String id){
		super(id);
	}

	public Zsjh getZsjhId() {
		return zsjhId;
	}

	public void setZsjhId(Zsjh zsjhId) {
		this.zsjhId = zsjhId;
	}
	
	public ZylxJbxx getZylxId() {
		return zylxId;
	}

	public void setZylxId(ZylxJbxx zylxId) {
		this.zylxId = zylxId;
	}
	
	public ZyJbxx getZyId() {
		return zyId;
	}

	public void setZyId(ZyJbxx zyId) {
		this.zyId = zyId;
	}
	
	public Integer getZsrs() {
		return zsrs;
	}

	public void setZsrs(Integer zsrs) {
		this.zsrs = zsrs;
	}
	
}