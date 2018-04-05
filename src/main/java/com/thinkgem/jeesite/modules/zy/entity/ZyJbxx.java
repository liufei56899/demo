/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zy.entity;


import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 专业Entity
 * @author zw
 * @version 2016-04-25
 */
public class ZyJbxx extends DataEntity<ZyJbxx> {
	
	private static final long serialVersionUID = 1L;
	private ZylxJbxx zylx;		// 专业类别，专业类别表主键
	private String zymc;		// 专业名称
	private String zyms;		// 专业描述
	
	private String zymlbb;
	private String zyfxmc;
	private String xz;			//学制id
	private String sfsnzy;
	private String bxzybh;
	private String zyjc;
	private Integer zyjss;
	private double zyzfs;
	private Date jlny;
	private String bxzt;
	private String zydm;		//专业代码
	private String xzmc;		//学制名称
	
	
	
	private String zsjhId;//招生计划id
	private String zsrs;// 招生人数
	private String zstype;// 招生类型
	
	private String zyxzmc;//专业（学制）
	
	
	
	public String getZyxzmc() {
		return zyxzmc;
	}

	public void setZyxzmc(String zyxzmc) {
		this.zyxzmc = zyxzmc;
	}

	public String getZsjhId() {
		return zsjhId;
	}

	public void setZsjhId(String zsjhId) {
		this.zsjhId = zsjhId;
	}

	public String getZsrs() {
		return zsrs;
	}

	public void setZsrs(String zsrs) {
		this.zsrs = zsrs;
	}

	public String getZstype() {
		return zstype;
	}

	public void setZstype(String zstype) {
		this.zstype = zstype;
	}

	public String getXzmc() {
		return xzmc;
	}

	public void setXzmc(String xzmc) {
		this.xzmc = xzmc;
	}

	public String getZydm() {
		return zydm;
	}

	public void setZydm(String zydm) {
		this.zydm = zydm;
	}

	public String getZymlbb() {
		return zymlbb;
	}

	public void setZymlbb(String zymlbb) {
		this.zymlbb = zymlbb;
	}

	public String getZyfxmc() {
		return zyfxmc;
	}

	public void setZyfxmc(String zyfxmc) {
		this.zyfxmc = zyfxmc;
	}

	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	public String getSfsnzy() {
		return sfsnzy;
	}

	public void setSfsnzy(String sfsnzy) {
		this.sfsnzy = sfsnzy;
	}

	public String getBxzybh() {
		return bxzybh;
	}

	public void setBxzybh(String bxzybh) {
		this.bxzybh = bxzybh;
	}

	public String getZyjc() {
		return zyjc;
	}

	public void setZyjc(String zyjc) {
		this.zyjc = zyjc;
	}

	public Integer getZyjss() {
		return zyjss;
	}

	public void setZyjss(Integer zyjss) {
		this.zyjss = zyjss;
	}

	public double getZyzfs() {
		return zyzfs;
	}

	public void setZyzfs(double zyzfs) {
		this.zyzfs = zyzfs;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getJlny() {
		return jlny;
	}

	public void setJlny(Date jlny) {
		this.jlny = jlny;
	}

	public String getBxzt() {
		return bxzt;
	}

	public void setBxzt(String bxzt) {
		this.bxzt = bxzt;
	}

	public ZyJbxx() {
		super();
	}

	public ZyJbxx(String id){
		super(id);
	}

	@NotNull(message="专业类别，专业类别表主键不能为空")
	public ZylxJbxx getZylx() {
		return zylx;
	}

	public void setZylx(ZylxJbxx zylx) {
		this.zylx = zylx;
	}
	
	@Length(min=1, max=64, message="专业名称长度必须介于 1 和 64 之间")
	public String getZymc() {
		return zymc;
	}

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}
	
	@Length(min=0, max=255, message="专业描述长度必须介于 0 和 255 之间")
	public String getZyms() {
		return zyms;
	}

	public void setZyms(String zyms) {
		this.zyms = zyms;
	}
	
}