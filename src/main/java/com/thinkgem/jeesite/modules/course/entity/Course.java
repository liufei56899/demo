/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;

/**
 * 学校课程代码表Entity
 * @author 赵辉
 * @version 2018-02-05
 */
public class Course extends DataEntity<Course> {
	
	private static final long serialVersionUID = 1L;
	private String coursename;		// 课程名称
	private String teacherid;		// 教师ID
	private Date kssj;		// 开始时间
	private String teachername;		// 教师名称
	private Date jssj;		// 结束时间
	private String createperson;		// 创建人
	private Date createdate;		// 创建时间
	private String updateperson;		// 创建人
	private Date updatedate;		// 创建时间
	private User jsId; // 教师id
	private String zylxid;
	private String zyid; //专业ID
	/*
	private String zymc;
	private ZyJbxx zyId; // 专业ID，专业表主键
	private String xnid;
	private String xn;
	
	private String zylxmc;*/
	public User getJsId() {
		return jsId;
	}

	public void setJsId(User jsId) {
		this.jsId = jsId;
	}

	public Course() {
		super();
	}

	public Course(String id){
		super(id);
	}

	@Length(min=1, max=64, message="课程名称长度必须介于 1 和 64 之间")
	public String getCoursename() {
		return coursename;
	}

	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}
	
	@Length(min=1, max=640, message="教师ID长度必须介于 1 和 640 之间")
	public String getTeacherid() {
		return teacherid;
	}

	public void setTeacherid(String teacherid) {
		this.teacherid = teacherid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="开始时间不能为空")
	public Date getKssj() {
		return kssj;
	}

	public void setKssj(Date kssj) {
		this.kssj = kssj;
	}
	
	@Length(min=1, max=64, message="教师名称长度必须介于 1 和 100 之间")
	public String getTeachername() {
		return teachername;
	}

	public void setTeachername(String teachername) {
		this.teachername = teachername;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="结束时间不能为空")
	public Date getJssj() {
		return jssj;
	}

	public void setJssj(Date jssj) {
		this.jssj = jssj;
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
	
	@Length(min=1, max=64, message="创建人长度必须介于 1 和 64 之间")
	public String getUpdateperson() {
		return updateperson;
	}

	public void setUpdateperson(String updateperson) {
		this.updateperson = updateperson;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="创建时间不能为空")
	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public String getZylxid() {
		return zylxid;
	}

	public void setZylxid(String zylxid) {
		this.zylxid = zylxid;
	}

	public String getZyid() {
		return zyid;
	}

	public void setZyid(String zyid) {
		this.zyid = zyid;
	}
	
	/*public String getZymc() {
		return zymc;
	}

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}

	public String getXn() {
		return xn;
	}

	public void setXn(String xn) {
		this.xn = xn;
	}

	public String getZylxmc() {
		return zylxmc;
	}

	public void setZylxmc(String zylxmc) {
		this.zylxmc = zylxmc;
	}

	public ZyJbxx getZyId() {
		return zyId;
	}

	public void setZyId(ZyJbxx zyId) {
		this.zyId = zyId;
	}

	public String getXnid() {
		return xnid;
	}

	public void setXnid(String xnid) {
		this.xnid = xnid;
	}
	*/
}