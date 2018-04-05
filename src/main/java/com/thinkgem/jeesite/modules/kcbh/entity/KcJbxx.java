/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kcbh.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 考场基本信息Entity
 * @author cpf
 * @version 2018-03-15
 */
public class KcJbxx extends DataEntity<KcJbxx> {
	
	private static final long serialVersionUID = 1L;
	private String kcmc;		// 考场名称
	private String kcdz;		// 考场地址
	private String xsrs;		// 学生人数
	private String jkrs;		// 监考人数
	private String sycs;		// 使用次数
	private String ksjhId;		// 使用次数
	private String zt;		// 状态
	
	public KcJbxx() {
		super();
	}

	public KcJbxx(String id){
		super(id);
	}
	
	
	@Length(min=0, max=64, message="考场名称长度必须介于 0 和 64 之间")
	public String getKsjhId() {
		return ksjhId;
	}

	public void setKsjhId(String ksjhId) {
		this.ksjhId = ksjhId;
	}

	@Length(min=0, max=64, message="考场名称长度必须介于 0 和 64 之间")
	public String getKcmc() {
		return kcmc;
	}

	public void setKcmc(String kcmc) {
		this.kcmc = kcmc;
	}
	
	@Length(min=0, max=64, message="考场地址长度必须介于 0 和 64 之间")
	public String getKcdz() {
		return kcdz;
	}

	public void setKcdz(String kcdz) {
		this.kcdz = kcdz;
	}
	
	@Length(min=0, max=11, message="学生人数长度必须介于 0 和 11 之间")
	public String getXsrs() {
		return xsrs;
	}

	public void setXsrs(String xsrs) {
		this.xsrs = xsrs;
	}
	
	@Length(min=0, max=2, message="监考人数长度必须介于 0 和 2 之间")
	public String getJkrs() {
		return jkrs;
	}

	public void setJkrs(String jkrs) {
		this.jkrs = jkrs;
	}
	
	@Length(min=0, max=11, message="使用次数长度必须介于 0 和 11 之间")
	public String getSycs() {
		return sycs;
	}

	public void setSycs(String sycs) {
		this.sycs = sycs;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}
	
}