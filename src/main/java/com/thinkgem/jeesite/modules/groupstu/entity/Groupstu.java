/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.groupstu.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学生小组信息Entity
 * @author lf
 * @version 2018-03-23
 */
public class Groupstu extends DataEntity<Groupstu> {
	
	private static final long serialVersionUID = 1L;
	private String groupname;		// 小组名称
	private String groupnum;		// 小组人数
	private String groupstudent;		// 小组学生
	private String groupteacher;		// 小组教师
	private String temp;//临时字段
	private String xnxq;
	
	public String getXnxq() {
		return xnxq;
	}

	public void setXnxq(String xnxq) {
		this.xnxq = xnxq;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
	public Groupstu() {
		super();
	}

	public Groupstu(String id){
		super(id);
	}

	@Length(min=1, max=255, message="小组名称长度必须介于 1 和 255 之间")
	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	
	@Length(min=1, max=255, message="小组人数长度必须介于 1 和 255 之间")
	public String getGroupnum() {
		return groupnum;
	}

	public void setGroupnum(String groupnum) {
		this.groupnum = groupnum;
	}
	
	@Length(min=1, max=255, message="小组学生长度必须介于 1 和 255 之间")
	public String getGroupstudent() {
		return groupstudent;
	}

	public void setGroupstudent(String groupstudent) {
		this.groupstudent = groupstudent;
	}
	
	@Length(min=1, max=255, message="小组教师长度必须介于 1 和 255 之间")
	public String getGroupteacher() {
		return groupteacher;
	}

	public void setGroupteacher(String groupteacher) {
		this.groupteacher = groupteacher;
	}
	
}