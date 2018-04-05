/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjz.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 招生简章Entity
 * 
 * @author xfb
 * @version 2016-09-23
 */
public class Zsjz extends DataEntity<Zsjz> {

	private static final long serialVersionUID = 1L;
	private String title; // 标题
	private String content; // 内容
	private String releaseby; // 发布人---取当前登录用户信息
	private Date releasedate; // 发布时间
	
	private String titleimg;		// 标题图
	private String url;		// url
	private String laiyuan;		// 来源
	
	

	public String getTitleimg() {
		return titleimg;
	}

	public void setTitleimg(String titleimg) {
		this.titleimg = titleimg;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLaiyuan() {
		return laiyuan;
	}

	public void setLaiyuan(String laiyuan) {
		this.laiyuan = laiyuan;
	}

	public Zsjz() {
		super();
	}

	public Zsjz(String id) {
		super(id);
	}

	@Length(min = 0, max = 32, message = "标题长度必须介于 0 和 32 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Length(min = 0, max = 255, message = "内容长度必须介于 0 和 255 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Length(min = 0, max = 32, message = "发布人长度必须介于 0 和 32 之间")
	public String getReleaseby() {
		return releaseby;
	}

	public void setReleaseby(String releaseby) {
		this.releaseby = releaseby;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReleasedate() {
		return releasedate;
	}

	public void setReleasedate(Date releasedate) {
		this.releasedate = releasedate;
	}

}