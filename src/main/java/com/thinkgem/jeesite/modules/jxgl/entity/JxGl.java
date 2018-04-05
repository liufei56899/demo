/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxgl.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 教学管理Entity
 * @author zx
 * @version 2018-03-01
 */
public class JxGl extends DataEntity<JxGl> {
	
	private static final long serialVersionUID = 1L;
	private String xnxqId;		// 学年学期ID
	private String kcId;		// 课程id
	private String bjId;		// 班级ID
	private String kcxz;		// 课程性质
	private String zxsCount;		// 总学时数
	private String ywcCount;		// 已完成时数
	private String xskq;		// 学生考勤
	private String skls;		// 授课老师
	private String sksj;		// 授课开始时间
	private String skjssj;      //授课结束时间
	private String jxqk;		// 教学情况
	private String ktqk;		// 课堂情况
	private String zt;		// 0：已保存；1：提交；2：审核；3：结束
	
	public JxGl() {
		super();
	}
    
	public String getSkjssj() {
		return skjssj;
	}

	public void setSkjssj(String skjssj) {
		this.skjssj = skjssj;
	}

	public JxGl(String id){
		super(id);
	}

	@Length(min=0, max=64, message="学年学期ID长度必须介于 0 和 64 之间")
	public String getXnxqId() {
		return xnxqId;
	}

	public void setXnxqId(String xnxqId) {
		this.xnxqId = xnxqId;
	}
	
	@Length(min=0, max=64, message="课程id长度必须介于 0 和 64 之间")
	public String getKcId() {
		return kcId;
	}

	public void setKcId(String kcId) {
		this.kcId = kcId;
	}
	
	@Length(min=0, max=64, message="班级ID长度必须介于 0 和 64 之间")
	public String getBjId() {
		return bjId;
	}

	public void setBjId(String bjId) {
		this.bjId = bjId;
	}
	
	@Length(min=0, max=64, message="课程性质长度必须介于 0 和 64 之间")
	public String getKcxz() {
		return kcxz;
	}

	public void setKcxz(String kcxz) {
		this.kcxz = kcxz;
	}
	
	@Length(min=0, max=11, message="总学时数长度必须介于 0 和 11 之间")
	public String getZxsCount() {
		return zxsCount;
	}

	public void setZxsCount(String zxsCount) {
		this.zxsCount = zxsCount;
	}
	
	@Length(min=0, max=11, message="已完成时数长度必须介于 0 和 11 之间")
	public String getYwcCount() {
		return ywcCount;
	}

	public void setYwcCount(String ywcCount) {
		this.ywcCount = ywcCount;
	}
	
	@Length(min=0, max=64, message="学生考勤长度必须介于 0 和 64 之间")
	public String getXskq() {
		return xskq;
	}

	public void setXskq(String xskq) {
		this.xskq = xskq;
	}
	
	@Length(min=0, max=64, message="授课老师长度必须介于 0 和 64 之间")
	public String getSkls() {
		return skls;
	}

	public void setSkls(String skls) {
		this.skls = skls;
	}
	
	@Length(min=0, max=64, message="授课时间长度必须介于 0 和 64 之间")
	public String getSksj() {
		return sksj;
	}

	public void setSksj(String sksj) {
		this.sksj = sksj;
	}
	
	@Length(min=0, max=64, message="教学情况长度必须介于 0 和 64 之间")
	public String getJxqk() {
		return jxqk;
	}

	public void setJxqk(String jxqk) {
		this.jxqk = jxqk;
	}
	
	@Length(min=0, max=64, message="课堂情况长度必须介于 0 和 64 之间")
	public String getKtqk() {
		return ktqk;
	}

	public void setKtqk(String ktqk) {
		this.ktqk = ktqk;
	}
	
	@Length(min=0, max=1, message="0：已保存；1：提交；2：审核；3：结束长度必须介于 0 和 1 之间")
	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}
	
}