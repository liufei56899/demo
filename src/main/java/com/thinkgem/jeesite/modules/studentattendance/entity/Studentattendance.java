/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.studentattendance.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学生考勤信息Entity
 * @author lf
 * @version 2018-03-25
 */
public class Studentattendance extends DataEntity<Studentattendance> {
	
	private static final long serialVersionUID = 1L;
	private String groupname;		// 小组名称
	private String student;		// 学生
	private String musical;		// 乐器
	private Date mback;		// 乐器返还时间
	private String clothing;		// 服装
	private Date cback;		// 服装返还时间
	private Date worktime1;		// 考勤开始时间
	private Date worktime2;		// 考勤结束时间
	private String score;		// 成绩


	public Studentattendance() {
		super();
	}

	public Studentattendance(String id){
		super(id);
	}

	@Length(min=1, max=255, message="小组名称长度必须介于 1 和 255 之间")
	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	
	@Length(min=1, max=255, message="学生长度必须介于 1 和 255 之间")
	public String getStudent() {
		return student;
	}

	public void setStudent(String student) {
		this.student = student;
	}
	
	@Length(min=1, max=255, message="乐器长度必须介于 1 和 255 之间")
	public String getMusical() {
		return musical;
	}

	public void setMusical(String musical) {
		this.musical = musical;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="乐器返还时间不能为空")
	public Date getMback() {
		return mback;
	}

	public void setMback(Date mback) {
		this.mback = mback;
	}
	
	@Length(min=1, max=255, message="服装长度必须介于 1 和 255 之间")
	public String getClothing() {
		return clothing;
	}

	public void setClothing(String clothing) {
		this.clothing = clothing;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="服装返还时间不能为空")
	public Date getCback() {
		return cback;
	}

	public void setCback(Date cback) {
		this.cback = cback;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="考勤开始时间不能为空")
	public Date getWorktime1() {
		return worktime1;
	}

	public void setWorktime1(Date worktime1) {
		this.worktime1 = worktime1;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="考勤结束时间不能为空")
	public Date getWorktime2() {
		return worktime2;
	}

	public void setWorktime2(Date worktime2) {
		this.worktime2 = worktime2;
	}
	
	@Length(min=1, max=255, message="成绩长度必须介于 1 和 255 之间")
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
}