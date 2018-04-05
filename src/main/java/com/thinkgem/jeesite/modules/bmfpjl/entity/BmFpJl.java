/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmfpjl.entity;

import java.util.List;

import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 部门分配招生人数记录Entity
 * @author zw
 * @version 2016-04-26
 */
public class BmFpJl extends DataEntity<BmFpJl> {
	
	private static final long serialVersionUID = 1L;
	private Office bmId;		// 部门ID，部门表主键
	private Area areaSh; //区域省
	private Area areaS; //区域市
	private Area areaQ; //区域县
	private String jhId;		// 计划ID，招生计划表主键
	private int bmZsrs;		// 部门招生人数
	private int syrs;  //生源人数 
	private List<Area> areasList;
	
	@Length(min=0, max=11, message="生源人数长度必须介于 0 和 11 之间")
	public int getSyrs() {
		return syrs;
	}

	public void setSyrs(int syrs) {
		this.syrs = syrs;
	}

	public BmFpJl() {
		super();
	}

	public BmFpJl(String id){
		super(id);
	}

	@NotNull(message="部门ID，部门表主键不能为空")
	public Office getBmId() {
		return bmId;
	}

	public void setBmId(Office bmId) {
		this.bmId = bmId;
	}
	
	@Length(min=1, max=64, message="计划ID，招生计划表主键长度必须介于 1 和 64 之间")
	public String getJhId() {
		return jhId;
	}

	public void setJhId(String jhId) {
		this.jhId = jhId;
	}
	
	@Length(min=0, max=11, message="部门招生人数长度必须介于 0 和 11 之间")
	public int getBmZsrs() {
		return bmZsrs;
	}

	public void setBmZsrs(int bmZsrs) {
		this.bmZsrs = bmZsrs;
	}
	@Length(min=1, max=64, message="省必须介于 1 和 64 之间")
	public Area getAreaSh() {
		return areaSh;
	}

	public void setAreaSh(Area areaSh) {
		this.areaSh = areaSh;
	}
	@Length(min=1, max=64, message="市必须介于 1 和 64 之间")
	public Area getAreaS() {
		return areaS;
	}

	public void setAreaS(Area areaS) {
		this.areaS = areaS;
	}
	@Length(min=1, max=64, message="区/县必须介于 1 和 64 之间")
	public Area getAreaQ() {
		return areaQ;
	}

	public void setAreaQ(Area areaQ) {
		this.areaQ = areaQ;
	}

	public List<Area> getAreasList() {
		return areasList;
	}

	public void setAreasList(List<Area> areasList) {
		this.areasList = areasList;
	}
	
}