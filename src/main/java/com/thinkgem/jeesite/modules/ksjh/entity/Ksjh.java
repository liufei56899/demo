/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ksjh.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.classroom.entity.Classroom;
import com.thinkgem.jeesite.modules.kcbh.entity.KcJbxx;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 考试计划Entity
 * @author cpf
 * @version 2018-03-16
 */
public class Ksjh extends DataEntity<Ksjh> {
	
	private static final long serialVersionUID = 1L;
	private String ksjhmc;		// 考试计划名称
	private Date stime;		// 计划开始时间
	private Date etime;		// 计划结束时间
	private String kcId;		// 考场编号
	private String jkrs;		// 监考人数
	private String kcsl;		// 考场数量
	private String ckrs;		// 考试人数
	private String jhzt;		// 状态
	private String jclsId;		// 监考老师编号
	private String jcname;		// 监考老师名称
	private String bjId;		// 班级编号
	private List<KcJbxx> classroom; // 考场对象集合
	
	public Ksjh() {
		super();
	}

	public Ksjh(String id){
		super(id);
	}
	
	public String getJcname() {
		return jcname;
	}
	
	public void setJcname(String jcname) {
		this.jcname = jcname;
	}
	
	public List<KcJbxx> getClassroom() {
		return classroom;
	}
	
	
	public void setClassroom(List<KcJbxx> classroom) {
		this.classroom = classroom;
	}
	
	@Length(min=0, max=1280, message="考试计划名称长度必须介于 0 和 1280之间")
	public String getKcId() {
		return kcId;
	}

	public void setKcId(String kcId) {
		this.kcId = kcId;
	}

	@Length(min=0, max=64, message="考试计划名称长度必须介于 0 和 64 之间")
	public String getKsjhmc() {
		return ksjhmc;
	}

	public void setKsjhmc(String ksjhmc) {
		this.ksjhmc = ksjhmc;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStime() {
		return stime;
	}

	public void setStime(Date stime) {
		this.stime = stime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEtime() {
		return etime;
	}

	public void setEtime(Date etime) {
		this.etime = etime;
	}
	
	@Length(min=0, max=11, message="监考人数长度必须介于 0 和 11 之间")
	public String getJkrs() {
		return jkrs;
	}

	public void setJkrs(String jkrs) {
		this.jkrs = jkrs;
	}

	@Length(min=0, max=11, message="考场数量长度必须介于 0 和 11 之间")
	public String getKcsl() {
		return kcsl;
	}

	public void setKcsl(String kcsl) {
		this.kcsl = kcsl;
	}
	
	@Length(min=0, max=11, message="考试人数长度必须介于 0 和 11 之间")
	public String getCkrs() {
		return ckrs;
	}

	public void setCkrs(String ckrs) {
		this.ckrs = ckrs;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getJhzt() {
		return jhzt;
	}

	public void setJhzt(String jhzt) {
		this.jhzt = jhzt;
	}
	
	@Length(min=0, max=1280, message="监考老师编号长度必须介于 0 和 1280之间")
	public String getJclsId() {
		return jclsId;
	}

	public void setJclsId(String jclsId) {
		this.jclsId = jclsId;
	}
	
	@Length(min=0, max=1280, message="班级编号长度必须介于 0 和 1280之间")
	public String getBjId() {
		return bjId;
	}

	public void setBjId(String bjId) {
		this.bjId = bjId;
	}
	
}