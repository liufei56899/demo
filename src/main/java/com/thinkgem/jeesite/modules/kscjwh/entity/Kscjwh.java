/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kscjwh.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 考试成绩维护Entity
 * @author lmy
 * @version 2018-03-21
 */
public class Kscjwh extends DataEntity<Kscjwh> {
	
	private static final long serialVersionUID = 1L;
	private String xh;  //序号
	private String name;		// 考试名称
	private String tybe;		// 类别
	private String way;		// 考试方式
	private String schoolYear;		// 学年
	private String semester;		// 学期
	private String score;		// 分数线
	
	public Kscjwh() {
		super();
	}

	public Kscjwh(String id){
		super(id);
	}
	
	public String getXh() {
		return xh;
	}
	public void setXh(String xh) {
		this.xh = xh;
	}

	@Length(min=1, max=64, message="考试名称长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=5, message="类别长度必须介于 0 和 5 之间")
	public String getTybe() {
		return tybe;
	}

	public void setTybe(String tybe) {
		this.tybe = tybe;
	}
	
	@Length(min=0, max=5, message="考试方式长度必须介于 0 和 5 之间")
	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}
	
	@Length(min=0, max=32, message="学年长度必须介于 0 和 32 之间")
	public String getSchoolYear() {
		return schoolYear;
	}

	public void setSchoolYear(String schoolYear) {
		this.schoolYear = schoolYear;
	}
	
	@Length(min=0, max=32, message="学期长度必须介于 0 和 32 之间")
	public String getSemester() {
		return semester;
	}

	public void setSemester(String semester) {
		this.semester = semester;
	}
	
	@Length(min=0, max=32, message="分数线长度必须介于 0 和 32 之间")
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
}