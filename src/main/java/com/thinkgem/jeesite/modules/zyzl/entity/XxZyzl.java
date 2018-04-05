/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zyzl.entity;

import org.hibernate.validator.constraints.Length;

import java.io.File;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 专业资料管理Entity
 * @author zh
 * @version 2018-02-25
 */
public class XxZyzl extends DataEntity<XxZyzl> {
	
	private static final long serialVersionUID = 1L;
	private String xh;  //序号
	private String zlname;		// 资料名称
	private Date uploaddate;		// 上传时间
	private String uploadname;		// 上传人
	private String fj;		// 附件
	private String remarks; //说明
	public XxZyzl() {
		super();
	}

	public XxZyzl(String id){
		super(id);
	}	
	public String getXh() {
		return xh;
	}
	public void setXh(String xh) {
		this.xh = xh;
	}

	@Length(min=1, max=64, message="资料名称长度必须介于 1 和 64 之间")
	public String getZlname() {
		return zlname;
	}

	public void setZlname(String zlname) {
		this.zlname = zlname;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUploaddate() {
		return uploaddate;
	}

	public void setUploaddate(Date uploaddate) {
		this.uploaddate = uploaddate;
	}
	
	@Length(min=1, max=64, message="上传人长度必须介于 1 和 64 之间")
	public String getUploadname() {
		return uploadname;
	}

	public void setUploadname(String uploadname) {
		this.uploadname = uploadname;
	}
	
	@Length(min=1, max=64, message="附件长度必须介于 1 和 64 之间")
	public String getFj() {
		return fj;
	}

	public void setFj(String fj) {
		this.fj = fj;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}