/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.syxx.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 生源信息Entity
 * 
 * @author xfb
 * @version 2016-05-05
 */
public class SyJbxx extends DataEntity<SyJbxx> {

	private static final long serialVersionUID = 1L;
	private String xm; // 姓名
	private String xbm; // 性别
	private String sfzjh; // 身份证件号
	private String byxx; // 毕业学校
	private String xsly; // 学生来源
	private String nf; // 年份
	private String xlm; // 学历码
	private String xxdz; // 详细地址
	
	
	private Area sfId; // 省份
	private Area csId; // 城市
	private Area qxId; // 区县
	private String lxdh; // 联系电话
	private Office office; // 归属部门
	private String xqId; // 学期
	private Date csrq; // 出生日期
	private String xxmc; // 学校名称

	public SyJbxx() {
		super();
	}

	public SyJbxx(String id) {
		super(id);
	}

	@Length(min = 1, max = 64, message = "姓名长度必须介于 1 和 64 之间")
	@ExcelField(title = "姓名", align = 2, sort = 10)
	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	@Length(min = 1, max = 64, message = "性别长度必须介于 1 和 64 之间")
	@ExcelField(title = "性别", align = 2, sort = 20, dictType = "sex")
	public String getXbm() {
		return xbm;
	}

	public void setXbm(String xbm) {
		this.xbm = xbm;
	}

	@Length(min = 0, max = 64, message = "身份证件号长度必须介于 0 和 64 之间")
	@ExcelField(title = "身份证号码", align = 2, sort = 30)
	public String getSfzjh() {
		return sfzjh;
	}

	public void setSfzjh(String sfzjh) {
		this.sfzjh = sfzjh;
	}

	@Length(min = 0, max = 64, message = "毕业学校长度必须介于 0 和 64 之间")
	@ExcelField(title = "毕业学校", align = 2, sort = 40)
	public String getByxx() {
		return byxx;
	}

	public void setByxx(String byxx) {
		this.byxx = byxx;
	}

	@Length(min = 0, max = 64, message = "学生来源长度必须介于 0 和 64 之间")
	@ExcelField(title = "应届/往届", align = 2, sort = 50, dictType = "xs_ly")
	public String getXsly() {
		return xsly;
	}

	public void setXsly(String xsly) {
		this.xsly = xsly;
	}

	@Length(min = 0, max = 11, message = "年份长度必须介于 0 和 11 之间")
	@ExcelField(title = "毕业年份", align = 2, sort = 60)
	public String getNf() {
		return nf;
	}

	public void setNf(String nf) {
		this.nf = nf;
	}

	@Length(min = 0, max = 64, message = "学历码长度必须介于 0 和 64 之间")
	@ExcelField(title = "学历层次", align = 2, sort = 70, dictType = "education_type")
	public String getXlm() {
		return xlm;
	}

	public void setXlm(String xlm) {
		this.xlm = xlm;
	}

	@Length(min = 0, max = 255, message = "详细地址长度必须介于 0 和 255 之间")
	@ExcelField(title = "详细地址", align = 2, sort = 80)
	public String getXxdz() {
		return xxdz;
	}

	public void setXxdz(String xxdz) {
		this.xxdz = xxdz;
	}

	/* @ExcelField(title = "省份", align = 2, sort = 30) */
	public Area getSfId() {
		return sfId;
	}

	public void setSfId(Area sfId) {
		this.sfId = sfId;
	}

	/* @ExcelField(title = "城市", align = 2, sort = 40) */
	public Area getCsId() {
		return csId;
	}

	public void setCsId(Area csId) {
		this.csId = csId;
	}

	/* @ExcelField(title = "区县", align = 2, sort = 50) */
	public Area getQxId() {
		return qxId;
	}

	public void setQxId(Area qxId) {
		this.qxId = qxId;
	}

	@Length(min = 0, max = 32, message = "联系电话长度必须介于 0 和 32 之间")
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	@Length(min = 0, max = 64, message = "学期长度必须介于 0 和 64 之间")
	public String getXqId() {
		return xqId;
	}

	public void setXqId(String xqId) {
		this.xqId = xqId;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	/*@NotNull(message = "出生日期不能为空")*/
	/* @ExcelField(title = "出生日期", align = 2, sort = 85) */
	public Date getCsrq() {
		return csrq;
	}

	public void setCsrq(Date csrq) {
		this.csrq = csrq;
	}

	@Length(min = 0, max = 64, message = "学校名称长度必须介于 0 和 64 之间")
	/* @ExcelField(title = "学校名称", align = 2, sort = 90) */
	public String getXxmc() {
		return xxmc;
	}

	public void setXxmc(String xxmc) {
		this.xxmc = xxmc;
	}

}