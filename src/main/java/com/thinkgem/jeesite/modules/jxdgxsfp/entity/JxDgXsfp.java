/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdgxsfp.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学时分配Entity
 * @author zx
 * @version 2018-03-01
 */
public class JxDgXsfp extends DataEntity<JxDgXsfp> {
	
	private static final long serialVersionUID = 1L;
	private String jxdgId;		// 教学大纲ID
	private String xuhao1;
	private String jxnr;		// 教学内容
	private String jkCount1;		// 讲课时数
	private String sjCount1;		// 实践时数
	private String kwCount1;		// 课外时数
	private String xjCount;		// 小计
	
	public JxDgXsfp() {
		super();
	}

	public JxDgXsfp(String id){
		super(id);
	}
  
	public String getXuhao1() {
		return xuhao1;
	}

	public void setXuhao1(String xuhao1) {
		this.xuhao1 = xuhao1;
	}

	@Length(min=0, max=64, message="教学大纲ID长度必须介于 0 和 64 之间")
	public String getJxdgId() {
		return jxdgId;
	}

	public void setJxdgId(String jxdgId) {
		this.jxdgId = jxdgId;
	}
	
	@Length(min=0, max=200, message="教学内容长度必须介于 0 和 200 之间")
	public String getJxnr() {
		return jxnr;
	}

	public void setJxnr(String jxnr) {
		this.jxnr = jxnr;
	}
	
	@Length(min=0, max=11, message="讲课时数长度必须介于 0 和 11 之间")
	public String getJkCount1() {
		return jkCount1;
	}

	public void setJkCount1(String jkCount1) {
		this.jkCount1 = jkCount1;
	}
	
	@Length(min=0, max=11, message="实践时数长度必须介于 0 和 11 之间")
	public String getSjCount1() {
		return sjCount1;
	}

	public void setSjCount1(String sjCount1) {
		this.sjCount1 = sjCount1;
	}
	
	@Length(min=0, max=11, message="课外时数长度必须介于 0 和 11 之间")
	public String getKwCount1() {
		return kwCount1;
	}

	public void setKwCount1(String kwCount1) {
		this.kwCount1 = kwCount1;
	}
	
	@Length(min=0, max=11, message="小计长度必须介于 0 和 11 之间")
	public String getXjCount() {
		return xjCount;
	}

	public void setXjCount(String xjCount) {
		this.xjCount = xjCount;
	}
	
}