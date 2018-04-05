/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.practicemanagement.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 艺术实践管理Entity
 * @author lf
 * @version 2018-03-19
 */
public class InformationTable extends DataEntity<InformationTable> {
	
	private static final long serialVersionUID = 1L;
	private String xnxq;		// 学年学期
	private Date shijiantime1;		// 艺术实践开始时间
	private Date shijiantime2;		// 艺术实践结束时间
	private Integer shijiantype;		// 艺术实践类型
	private Integer znum;		// 小组总数
	private String groupstuid;		// 小组负责教师
	private String zhihui;		// 指挥教师
	private Date zhihuitime1;		// 指挥教师考勤开始时间
	private Date zhihuitime2;		// 指挥教师考勤结束时间
	private String musical;		// 乐器
	private Date mback;		// 乐器返还时间
	private String clothing;		// 服装
	private Date cback;		// 服装返还时间
	private Date sttime1;		// 学生考勤开始时间
	private Date sttime2;		// 学生考勤结束时间
	private String score;		// 学生成绩
	private Date tetime1;		// 教师考勤开始时间
	private Date tetime2;		// 教师考勤结束时间
	private String remake;		// 课堂情况
	
	public InformationTable() {
		super();
	}

	public InformationTable(String id){
		super(id);
	}

	@Length(min=0, max=255, message="学年学期长度必须介于 0 和 255 之间")
	public String getXnxq() {
		return xnxq;
	}

	public void setXnxq(String xnxq) {
		this.xnxq = xnxq;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getShijiantime1() {
		return shijiantime1;
	}

	public void setShijiantime1(Date shijiantime1) {
		this.shijiantime1 = shijiantime1;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getShijiantime2() {
		return shijiantime2;
	}

	public void setShijiantime2(Date shijiantime2) {
		this.shijiantime2 = shijiantime2;
	}
	
	public Integer getShijiantype() {
		return shijiantype;
	}

	public void setShijiantype(Integer shijiantype) {
		this.shijiantype = shijiantype;
	}
	
	public Integer getZnum() {
		return znum;
	}

	public void setZnum(Integer znum) {
		this.znum = znum;
	}
	


	public String getGroupstuid() {
		return groupstuid;
	}

	public void setGroupstuid(String groupstuid) {
		this.groupstuid = groupstuid;
	}

	@Length(min=0, max=255, message="指挥教师长度必须介于 0 和 255 之间")
	public String getZhihui() {
		return zhihui;
	}

	public void setZhihui(String zhihui) {
		this.zhihui = zhihui;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getZhihuitime1() {
		return zhihuitime1;
	}

	public void setZhihuitime1(Date zhihuitime1) {
		this.zhihuitime1 = zhihuitime1;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getZhihuitime2() {
		return zhihuitime2;
	}

	public void setZhihuitime2(Date zhihuitime2) {
		this.zhihuitime2 = zhihuitime2;
	}
	
	@Length(min=0, max=255, message="乐器长度必须介于 0 和 255 之间")
	public String getMusical() {
		return musical;
	}

	public void setMusical(String musical) {
		this.musical = musical;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getMback() {
		return mback;
	}

	public void setMback(Date mback) {
		this.mback = mback;
	}
	
	@Length(min=0, max=255, message="服装长度必须介于 0 和 255 之间")
	public String getClothing() {
		return clothing;
	}

	public void setClothing(String clothing) {
		this.clothing = clothing;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCback() {
		return cback;
	}

	public void setCback(Date cback) {
		this.cback = cback;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSttime1() {
		return sttime1;
	}

	public void setSttime1(Date sttime1) {
		this.sttime1 = sttime1;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSttime2() {
		return sttime2;
	}

	public void setSttime2(Date sttime2) {
		this.sttime2 = sttime2;
	}
	
	@Length(min=0, max=255, message="学生成绩长度必须介于 0 和 255 之间")
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTetime1() {
		return tetime1;
	}

	public void setTetime1(Date tetime1) {
		this.tetime1 = tetime1;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTetime2() {
		return tetime2;
	}

	public void setTetime2(Date tetime2) {
		this.tetime2 = tetime2;
	}
	
	@Length(min=0, max=255, message="课堂情况长度必须介于 0 和 255 之间")
	public String getRemake() {
		return remake;
	}

	public void setRemake(String remake) {
		this.remake = remake;
	}
	
}