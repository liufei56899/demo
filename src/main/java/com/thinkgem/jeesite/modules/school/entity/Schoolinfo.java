/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.school.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学校信息Entity
 * @author lg
 * @version 2016-07-11
 */
public class Schoolinfo extends DataEntity<Schoolinfo> {
	
	private static final long serialVersionUID = 1L;
	private String xxdm;		// 学校代码
	private String xxmc;		// 学校名称
	private String xxywmc;		// 学校英文名称
	private String xxdz;		// 学校地址
	private String xxyzbm;		// 学校邮政编码
	private String xzqhm;		// 行政区划码
	private Date jxny;		// 建校年月
	private String xzxm;		// 校长姓名
	private String lxdh;		// 联系电话
	private String czdh;		// 传真电话
	private String dzxx;		// 电子信箱
	private String zydz;		// 主页地址
	private String xxyhbm;	//学校用户编码
	
	public Schoolinfo() {
		super();
	}

	public Schoolinfo(String id){
		super(id);
	}

	
	public String getXxyhbm() {
		return xxyhbm;
	}

	public void setXxyhbm(String xxyhbm) {
		this.xxyhbm = xxyhbm;
	}

	@Length(min=0, max=64, message="学校代码长度必须介于 0 和 64 之间")
	public String getXxdm() {
		return xxdm;
	}

	public void setXxdm(String xxdm) {
		this.xxdm = xxdm;
	}
	
	@Length(min=1, max=64, message="学校名称长度必须介于 1 和 64 之间")
	public String getXxmc() {
		return xxmc;
	}

	public void setXxmc(String xxmc) {
		this.xxmc = xxmc;
	}
	
	@Length(min=0, max=64, message="学校英文名称长度必须介于 0 和 64 之间")
	public String getXxywmc() {
		return xxywmc;
	}

	public void setXxywmc(String xxywmc) {
		this.xxywmc = xxywmc;
	}
	
	@Length(min=0, max=255, message="学校地址长度必须介于 0 和 255 之间")
	public String getXxdz() {
		return xxdz;
	}

	public void setXxdz(String xxdz) {
		this.xxdz = xxdz;
	}
	
	@Length(min=0, max=6, message="学校邮政编码长度必须介于 0 和 6 之间")
	public String getXxyzbm() {
		return xxyzbm;
	}

	public void setXxyzbm(String xxyzbm) {
		this.xxyzbm = xxyzbm;
	}
	
	@Length(min=0, max=12, message="行政区划码长度必须介于 0 和 12 之间")
	public String getXzqhm() {
		return xzqhm;
	}

	public void setXzqhm(String xzqhm) {
		this.xzqhm = xzqhm;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getJxny() {
		return jxny;
	}

	public void setJxny(Date jxny) {
		this.jxny = jxny;
	}
	
	@Length(min=0, max=10, message="校长姓名长度必须介于 0 和 10 之间")
	public String getXzxm() {
		return xzxm;
	}

	public void setXzxm(String xzxm) {
		this.xzxm = xzxm;
	}
	
	@Length(min=0, max=20, message="联系电话长度必须介于 0 和 20 之间")
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
	
	@Length(min=0, max=20, message="传真电话长度必须介于 0 和 20 之间")
	public String getCzdh() {
		return czdh;
	}

	public void setCzdh(String czdh) {
		this.czdh = czdh;
	}
	
	@Length(min=0, max=50, message="电子信箱长度必须介于 0 和 50 之间")
	public String getDzxx() {
		return dzxx;
	}

	public void setDzxx(String dzxx) {
		this.dzxx = dzxx;
	}
	
	@Length(min=0, max=255, message="主页地址长度必须介于 0 和 255 之间")
	public String getZydz() {
		return zydz;
	}

	public void setZydz(String zydz) {
		this.zydz = zydz;
	}
	
}