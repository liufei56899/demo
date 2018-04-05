/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.dk.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 身份证读卡信息Entity
 * @author lf
 * @version 2016-12-06
 */
public class Readcard extends DataEntity<Readcard> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 姓名
	private String sex;		// 性别
	private String nation;		// 民族
	private String cardtype;		// 身份类型
	private String cardno;		// 证件号码
	private Date birthday;		// 出生日期
	private String address;		// 家庭住址
	private String qfjg;		// 签发机关
	private Date starttime;		// 证件起始时间
	private Date overtime;		// 证件结束时间
	private String xdzy;		// 专业名称
	private String zymc;		// 专业名称
	private String photo;		// 身份照片
	
	public Readcard() {
		super();
	}

	public Readcard(String id){
		super(id);
	}

	@Length(min=1, max=64, message="姓名长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=64, message="性别长度必须介于 1 和 64 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Length(min=1, max=64, message="民族长度必须介于 1 和 64 之间")
	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}
	
	@Length(min=0, max=200, message="身份类型长度必须介于 0 和 200 之间")
	public String getCardtype() {
		return cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}
	
	@Length(min=1, max=20, message="证件号码长度必须介于 1 和 20 之间")
	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="出生日期不能为空")
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	@Length(min=1, max=200, message="家庭住址长度必须介于 1 和 200 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=1, max=100, message="签发机关长度必须介于 1 和 100 之间")
	public String getQfjg() {
		return qfjg;
	}

	public void setQfjg(String qfjg) {
		this.qfjg = qfjg;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="证件起始时间不能为空")
	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="证件结束时间不能为空")
	public Date getOvertime() {
		return overtime;
	}

	public void setOvertime(Date overtime) {
		this.overtime = overtime;
	}
	
	@Length(min=0, max=64, message="专业名称长度必须介于 0 和 64 之间")
	public String getXdzy() {
		return xdzy;
	}

	public void setXdzy(String xdzy) {
		this.xdzy = xdzy;
	}
	
	@Length(min=0, max=64, message="专业名称长度必须介于 0 和 64 之间")
	public String getZymc() {
		return zymc;
	}

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}
	
	@Length(min=1, max=200, message="身份照片长度必须介于 1 和 200 之间")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}