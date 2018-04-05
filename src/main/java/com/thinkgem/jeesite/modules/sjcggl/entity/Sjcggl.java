/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sjcggl.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.drew.lang.annotations.NotNull;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 实践成果管理Entity
 * @author zx
 * @version 2018-02-25
 */
public class Sjcggl extends DataEntity<Sjcggl> {
	
	private static final long serialVersionUID = 1L;
	private String csmc;		// 参赛名称
	private String csry;		// 参赛人员
	private Date cssj;		// 参赛时间
	private String hjqk;		// 获奖情况
	private String fj;		// 附件
	private String uploadBy; //创建人
    private String num;//序号
    
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getUploadBy() {
		return uploadBy;
	}

	public void setUploadBy(String uploadBy) {
		this.uploadBy = uploadBy;
	}

	public Sjcggl() {
		super();
	}

	public Sjcggl(String id){
		super(id);
	}

	@Length(min=0, max=64, message="参赛名称长度必须介于 0 和 64 之间")
	public String getCsmc() {
		return csmc;
	}

	public void setCsmc(String csmc) {
		this.csmc = csmc;
	}
	
	@Length(min=0, max=64, message="参赛人员长度必须介于 0 和 64 之间")
	public String getCsry() {
		return csry;
	}

	public void setCsry(String csry) {
		this.csry = csry;
	}
	@NotNull
	public Date getCssj() {
		return cssj;
	}

	public void setCssj(Date cssj) {
		this.cssj = cssj;
	}
	public String getHjqk() {
		return hjqk;
	}
	public void setHjqk(String hjqk) {
		this.hjqk = hjqk;
	}
	public String getFj() {
		return fj;
	}

	public void setFj(String fj) {
		this.fj = fj;
	}
	
}