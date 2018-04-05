/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.classroom.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 教室信息管理Entity
 * @author zh
 * @version 2018-02-07
 */
public class Classroom extends DataEntity<Classroom> {
	
	private static final long serialVersionUID = 1L;
	private String xh;         //序号
	private String jslh;		// 教室楼号
	private String jsmph;		// 教室门牌号
	private String jslx;		// 教室类型（1 普通教室 2 非普通教室）
	private String rnrs;		// 可容纳人数
	private String status;		// 状态(0 停用 1 启用）
	private String createperson;		// 创建人
	private Date createdate;		// 创建时间
	private String updateperson;		// 修改人
	private Date updatedate;		// 修改时间
	public Classroom() {
		super();
	}

	public Classroom(String id){
		super(id);
	}
	@Length(min=1, max=64, message="教室楼号长度必须介于 1 和 64 之间")
	public String getXh() {
		return xh;
	}

	public void setXh(String xh) {
		this.xh = xh;
	}

	@Length(min=1, max=64, message="教室楼号长度必须介于 1 和 64 之间")
	public String getJslh() {
		return jslh;
	}

	public void setJslh(String jslh) {
		this.jslh = jslh;
	}
	
	@Length(min=1, max=64, message="教室门牌号长度必须介于 1 和 64 之间")
	public String getJsmph() {
		return jsmph;
	}

	public void setJsmph(String jsmph) {
		this.jsmph = jsmph;
	}
	
	@Length(min=1, max=5, message="教室类型（1 普通教室 2 非普通教室）长度必须介于 1 和 5 之间")
	public String getJslx() {
		return jslx;
	}

	public void setJslx(String jslx) {
		this.jslx = jslx;
	}
	
	@Length(min=1, max=64, message="可容纳人数长度必须介于 1 和 64 之间")
	public String getRnrs() {
		return rnrs;
	}

	public void setRnrs(String rnrs) {
		this.rnrs = rnrs;
	}
	
	@Length(min=1, max=5, message="状态(0 停用 1 启用）长度必须介于 1 和 5 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=64, message="创建人长度必须介于 1 和 64 之间")
	public String getCreateperson() {
		return createperson;
	}

	public void setCreateperson(String createperson) {
		this.createperson = createperson;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="创建时间不能为空")
	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
	@Length(min=1, max=64, message="修改人长度必须介于 1 和 64 之间")
	public String getUpdateperson() {
		return updateperson;
	}

	public void setUpdateperson(String updateperson) {
		this.updateperson = updateperson;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="修改时间不能为空")
	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	
}