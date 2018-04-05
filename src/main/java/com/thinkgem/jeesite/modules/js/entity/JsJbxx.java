/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.js.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 教师信息Entity
 * @author st
 * @version 2016-05-19
 */
public class JsJbxx extends DataEntity<JsJbxx> {
	
	private static final long serialVersionUID = 1L;
	private String xxdm;		// 学校代码
	private String xm;		// 姓名
	private String gh;		// 工号
	private String xbm;		// 性别
	private String csrq;		// 出生日期
	private String lxdh;		// 联系电话
	private String ywxm;		// 英文姓名
	private String xmpy;		// 姓名拼音
	private String jtzz;		// 家庭住址
	private String sfzjh;		// 身份证件号
	private String cym;		// 曾用名
	private String mzm;		// 民族
	private String jg;		// 籍贯
	private String xlm;		// 学历
	private Area csdm;		// 出生地码
	private String hyzkm;		// 婚姻状况
	private String zzmmm;		// 政治面貌
	private String gzny;		// 参加工作年月
	private String gjdqm;		// 国籍/地区码
	private String sfzjlxm;		// 身份证件类型码
	private String lxny;		// 来校年月
	private String cjny;		// 从教年月
	private String xxm;		// 血型
	private String jkzkm;		// 健康状况
	private String gatqwm;		// 港澳台侨外码
	private String xyzjm;		// 信仰宗教
	private String dzxx;		// 电子信箱
	private String yzbm;		// 邮政编码
	private String zydz;		// 主页地址
	private String tc;		// 特长
	private String gwzym;		// 岗位职业码
	private String zyrkxd;		// 主要任课学段
	private String bzlbm;		// 编制类别码
	private String dabh;		// 档案编号
	private String dawb;		// 档案文本
	private String txdz;		// 通信地址
	private String sfzjyxq;		// 身份证件有效期
	private Office jgh;		// 机构号
	private String xzz;		// 现住址
	private String hkszd;		// 户口所在地
	private String hkxzm;		// 户口性质码
	
	public JsJbxx() {
		super();
	}

	public JsJbxx(String id){
		super(id);
	}

	@Length(min=0, max=64, message="学校代码长度必须介于 0 和 64 之间")
	public String getXxdm() {
		return xxdm;
	}

	public void setXxdm(String xxdm) {
		this.xxdm = xxdm;
	}
	
	@Length(min=1, max=64, message="姓名长度必须介于 1 和 64 之间")
	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}
	
	@Length(min=1, max=64, message="工号长度必须介于 1 和 64 之间")
	public String getGh() {
		return gh;
	}

	public void setGh(String gh) {
		this.gh = gh;
	}
	
	@Length(min=1, max=64, message="性别长度必须介于 1 和 64 之间")
	public String getXbm() {
		return xbm;
	}

	public void setXbm(String xbm) {
		this.xbm = xbm;
	}
	
	@Length(min=1, max=12, message="出生日期长度必须介于 1 和 12 之间")
	public String getCsrq() {
		return csrq;
	}

	public void setCsrq(String csrq) {
		this.csrq = csrq;
	}
	
	@Length(min=0, max=32, message="联系电话长度必须介于 0 和 32 之间")
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
	
	@Length(min=0, max=64, message="英文姓名长度必须介于 0 和 64 之间")
	public String getYwxm() {
		return ywxm;
	}

	public void setYwxm(String ywxm) {
		this.ywxm = ywxm;
	}
	
	@Length(min=0, max=64, message="姓名拼音长度必须介于 0 和 64 之间")
	public String getXmpy() {
		return xmpy;
	}

	public void setXmpy(String xmpy) {
		this.xmpy = xmpy;
	}
	
	@Length(min=0, max=128, message="家庭住址长度必须介于 0 和 128 之间")
	public String getJtzz() {
		return jtzz;
	}

	public void setJtzz(String jtzz) {
		this.jtzz = jtzz;
	}
	
	@Length(min=1, max=18, message="身份证件号长度必须介于 1 和 18 之间")
	public String getSfzjh() {
		return sfzjh;
	}

	public void setSfzjh(String sfzjh) {
		this.sfzjh = sfzjh;
	}
	
	@Length(min=0, max=64, message="曾用名长度必须介于 0 和 64 之间")
	public String getCym() {
		return cym;
	}

	public void setCym(String cym) {
		this.cym = cym;
	}
	
	@Length(min=0, max=64, message="民族长度必须介于 0 和 64 之间")
	public String getMzm() {
		return mzm;
	}

	public void setMzm(String mzm) {
		this.mzm = mzm;
	}
	
	@Length(min=0, max=64, message="籍贯长度必须介于 0 和 64 之间")
	public String getJg() {
		return jg;
	}

	public void setJg(String jg) {
		this.jg = jg;
	}
	
	@Length(min=0, max=64, message="学历长度必须介于 0 和 64 之间")
	public String getXlm() {
		return xlm;
	}

	public void setXlm(String xlm) {
		this.xlm = xlm;
	}
	
	public Area getCsdm() {
		return csdm;
	}

	public void setCsdm(Area csdm) {
		this.csdm = csdm;
	}
	
	@Length(min=0, max=64, message="婚姻状况长度必须介于 0 和 64 之间")
	public String getHyzkm() {
		return hyzkm;
	}

	public void setHyzkm(String hyzkm) {
		this.hyzkm = hyzkm;
	}
	
	@Length(min=0, max=64, message="政治面貌长度必须介于 0 和 64 之间")
	public String getZzmmm() {
		return zzmmm;
	}

	public void setZzmmm(String zzmmm) {
		this.zzmmm = zzmmm;
	}
	
	@Length(min=0, max=12, message="参加工作年月长度必须介于 0 和 12 之间")
	public String getGzny() {
		return gzny;
	}

	public void setGzny(String gzny) {
		this.gzny = gzny;
	}
	
	@Length(min=0, max=64, message="国籍/地区码长度必须介于 0 和 64 之间")
	public String getGjdqm() {
		return gjdqm;
	}

	public void setGjdqm(String gjdqm) {
		this.gjdqm = gjdqm;
	}
	
	@Length(min=0, max=64, message="身份证件类型码长度必须介于 0 和 64 之间")
	public String getSfzjlxm() {
		return sfzjlxm;
	}

	public void setSfzjlxm(String sfzjlxm) {
		this.sfzjlxm = sfzjlxm;
	}
	
	@Length(min=0, max=12, message="来校年月长度必须介于 0 和 12 之间")
	public String getLxny() {
		return lxny;
	}

	public void setLxny(String lxny) {
		this.lxny = lxny;
	}
	
	@Length(min=0, max=12, message="从教年月长度必须介于 0 和 12 之间")
	public String getCjny() {
		return cjny;
	}

	public void setCjny(String cjny) {
		this.cjny = cjny;
	}
	
	@Length(min=0, max=64, message="血型长度必须介于 0 和 64 之间")
	public String getXxm() {
		return xxm;
	}

	public void setXxm(String xxm) {
		this.xxm = xxm;
	}
	
	@Length(min=0, max=64, message="健康状况长度必须介于 0 和 64 之间")
	public String getJkzkm() {
		return jkzkm;
	}

	public void setJkzkm(String jkzkm) {
		this.jkzkm = jkzkm;
	}
	
	@Length(min=0, max=64, message="港澳台侨外码长度必须介于 0 和 64 之间")
	public String getGatqwm() {
		return gatqwm;
	}

	public void setGatqwm(String gatqwm) {
		this.gatqwm = gatqwm;
	}
	
	@Length(min=0, max=64, message="信仰宗教长度必须介于 0 和 64 之间")
	public String getXyzjm() {
		return xyzjm;
	}

	public void setXyzjm(String xyzjm) {
		this.xyzjm = xyzjm;
	}
	
	@Length(min=0, max=64, message="电子信箱长度必须介于 0 和 64 之间")
	public String getDzxx() {
		return dzxx;
	}

	public void setDzxx(String dzxx) {
		this.dzxx = dzxx;
	}
	
	@Length(min=0, max=6, message="邮政编码长度必须介于 0 和 6 之间")
	public String getYzbm() {
		return yzbm;
	}

	public void setYzbm(String yzbm) {
		this.yzbm = yzbm;
	}
	
	@Length(min=0, max=128, message="主页地址长度必须介于 0 和 128 之间")
	public String getZydz() {
		return zydz;
	}

	public void setZydz(String zydz) {
		this.zydz = zydz;
	}
	
	@Length(min=0, max=255, message="特长长度必须介于 0 和 255 之间")
	public String getTc() {
		return tc;
	}

	public void setTc(String tc) {
		this.tc = tc;
	}
	
	@Length(min=0, max=64, message="岗位职业码长度必须介于 0 和 64 之间")
	public String getGwzym() {
		return gwzym;
	}

	public void setGwzym(String gwzym) {
		this.gwzym = gwzym;
	}
	
	@Length(min=0, max=64, message="主要任课学段长度必须介于 0 和 64 之间")
	public String getZyrkxd() {
		return zyrkxd;
	}

	public void setZyrkxd(String zyrkxd) {
		this.zyrkxd = zyrkxd;
	}
	
	@Length(min=0, max=64, message="编制类别码长度必须介于 0 和 64 之间")
	public String getBzlbm() {
		return bzlbm;
	}

	public void setBzlbm(String bzlbm) {
		this.bzlbm = bzlbm;
	}
	
	@Length(min=0, max=10, message="档案编号长度必须介于 0 和 10 之间")
	public String getDabh() {
		return dabh;
	}

	public void setDabh(String dabh) {
		this.dabh = dabh;
	}
	
	@Length(min=0, max=512, message="档案文本长度必须介于 0 和 512 之间")
	public String getDawb() {
		return dawb;
	}

	public void setDawb(String dawb) {
		this.dawb = dawb;
	}
	
	@Length(min=0, max=255, message="通信地址长度必须介于 0 和 255 之间")
	public String getTxdz() {
		return txdz;
	}

	public void setTxdz(String txdz) {
		this.txdz = txdz;
	}
	
	@Length(min=0, max=64, message="身份证件有效期长度必须介于 0 和 64 之间")
	public String getSfzjyxq() {
		return sfzjyxq;
	}

	public void setSfzjyxq(String sfzjyxq) {
		this.sfzjyxq = sfzjyxq;
	}
	
	@NotNull(message="机构号不能为空")
	public Office getJgh() {
		return jgh;
	}

	public void setJgh(Office jgh) {
		this.jgh = jgh;
	}
	
	@Length(min=0, max=255, message="现住址长度必须介于 0 和 255 之间")
	public String getXzz() {
		return xzz;
	}

	public void setXzz(String xzz) {
		this.xzz = xzz;
	}
	
	@Length(min=0, max=64, message="户口所在地长度必须介于 0 和 64 之间")
	public String getHkszd() {
		return hkszd;
	}

	public void setHkszd(String hkszd) {
		this.hkszd = hkszd;
	}
	
	@Length(min=0, max=64, message="户口性质码长度必须介于 0 和 64 之间")
	public String getHkxzm() {
		return hkxzm;
	}

	public void setHkxzm(String hkxzm) {
		this.hkxzm = hkxzm;
	}
	
}