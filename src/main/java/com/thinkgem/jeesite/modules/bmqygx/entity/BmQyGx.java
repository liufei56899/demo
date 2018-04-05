/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmqygx.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.Area;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 部门区域关系Entity
 * @author lg
 * @version 2016-04-25
 */
public class BmQyGx extends DataEntity<BmQyGx> {
	
	private static final long serialVersionUID = 1L;
	private String nf;		// 年份
	private String xqId;		// 学期
	private Office office;		// 部门
	private Area area;		// 区域
	private String sysl;		// 生源数量
	
	public BmQyGx() {
		super();
	}

	public BmQyGx(String id){
		super(id);
	}

	@Length(min=1, max=11, message="年份长度必须介于 1 和 11 之间")
	public String getNf() {
		return nf;
	}

	public void setNf(String nf) {
		this.nf = nf;
	}
	
	@Length(min=1, max=64, message="学期长度必须介于 1 和 64 之间")
	public String getXqId() {
		return xqId;
	}

	public void setXqId(String xqId) {
		this.xqId = xqId;
	}
	
	@NotNull(message="部门不能为空")
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@NotNull(message="区域不能为空")
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=0, max=11, message="生源数量长度必须介于 0 和 11 之间")
	public String getSysl() {
		return sysl;
	}

	public void setSysl(String sysl) {
		this.sysl = sysl;
	}
	
}