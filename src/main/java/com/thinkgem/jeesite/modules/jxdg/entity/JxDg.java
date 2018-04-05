/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdg.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.jxdgxsfp.entity.JxDgXsfp;

/**
 * 教学大纲Entity
 * @author zx
 * @version 2018-03-01
 */
public class JxDg extends DataEntity<JxDg> {
	
	private static final long serialVersionUID = 1L;
	private String xuhao;       //序号
	private String xnxq;        //学年学期
	private String jhId;		// 计划ID，招生计划表主键
	private String zyId;		// 专业ID，专业表主键
	private String kcmc;        //课程名称
	private String kcId;		// 课程id
	private String kcxz;		// 课程性质
	private String kcxzid;		// 课程性质id
	private String skjs;        //授课教师
	private String zxsCount;		// 总学时数
	private String jkCount;		// 讲课时数
	private String sjCount;		// 实践时数
	private String kwsjCount;		// 课外实践时数
	private String shccId;		// 适合层次
	private String kkxq;		// 开课学期
	private String kcmdrw;		// 开课目的与任务
	private String lljyyq;		// 理论教学要求
	private String kcxgsm;		// 课程相关说明
	private String jxjy;		// 教学建议
	private String zdrmc;      //制定人名字
	private String zt;		// 0：已保存；1：提交；2：审核；3：结束
	
	private List<JxDgXsfp> jxdgXsfp;
	
	
	public List<JxDgXsfp> getJxdgXsfp() {
		return jxdgXsfp;
	}
	public void setJxdgXsfp(List<JxDgXsfp> jxdgXsfp) {
		this.jxdgXsfp = jxdgXsfp;
	}
	public String getSkjs() {
		return skjs;
	}
	public void setSkjs(String skjs) {
		this.skjs = skjs;
	}
	public JxDg() {
		super();
	}
	public JxDg(String id){
		super(id);
	}
	
	public String getZdrmc() {
		return zdrmc;
	}
	public void setZdrmc(String zdrmc) {
		this.zdrmc = zdrmc;
	}
	public String getXuhao() {
		return xuhao;
	}
   
	public String getXnxq() {
		return xnxq;
	}
	public void setXnxq(String xnxq) {
		this.xnxq = xnxq;
	}
	public void setXuhao(String xuhao) {
		this.xuhao = xuhao;
	}

	public String getKcmc() {
		return kcmc;
	}

	public void setKcmc(String kcmc) {
		this.kcmc = kcmc;
	}

	public String getKcxz() {
		return kcxz;
	}

	public void setKcxz(String kcxz) {
		this.kcxz = kcxz;
	}

	@Length(min=0, max=64, message="计划ID，招生计划表主键长度必须介于 0 和 64 之间")
	public String getJhId() {
		return jhId;
	}

	public void setJhId(String jhId) {
		this.jhId = jhId;
	}
	
	@Length(min=0, max=64, message="专业ID，专业表主键长度必须介于 0 和 64 之间")
	public String getZyId() {
		return zyId;
	}

	public void setZyId(String zyId) {
		this.zyId = zyId;
	}
	
	@Length(min=0, max=64, message="课程id长度必须介于 0 和 64 之间")
	public String getKcId() {
		return kcId;
	}

	public void setKcId(String kcId) {
		this.kcId = kcId;
	}
	
	@Length(min=0, max=64, message="课程性质id长度必须介于 0 和 64 之间")
	public String getKcxzid() {
		return kcxzid;
	}

	public void setKcxzid(String kcxzid) {
		this.kcxzid = kcxzid;
	}
	
	@Length(min=0, max=11, message="总学时数长度必须介于 0 和 11 之间")
	public String getZxsCount() {
		return zxsCount;
	}

	public void setZxsCount(String zxsCount) {
		this.zxsCount = zxsCount;
	}
	
	@Length(min=0, max=11, message="讲课时数长度必须介于 0 和 11 之间")
	public String getJkCount() {
		return jkCount;
	}

	public void setJkCount(String jkCount) {
		this.jkCount = jkCount;
	}
	
	@Length(min=0, max=11, message="实践时数长度必须介于 0 和 11 之间")
	public String getSjCount() {
		return sjCount;
	}

	public void setSjCount(String sjCount) {
		this.sjCount = sjCount;
	}
	
	@Length(min=0, max=11, message="课外实践时数长度必须介于 0 和 11 之间")
	public String getKwsjCount() {
		return kwsjCount;
	}

	public void setKwsjCount(String kwsjCount) {
		this.kwsjCount = kwsjCount;
	}
	
	@Length(min=0, max=64, message="适合层次长度必须介于 0 和 64 之间")
	public String getShccId() {
		return shccId;
	}

	public void setShccId(String shccId) {
		this.shccId = shccId;
	}
	
	@Length(min=0, max=64, message="开课学期长度必须介于 0 和 64 之间")
	public String getKkxq() {
		return kkxq;
	}

	public void setKkxq(String kkxq) {
		this.kkxq = kkxq;
	}
	
	@Length(min=0, max=64, message="开课目的与任务长度必须介于 0 和 64 之间")
	public String getKcmdrw() {
		return kcmdrw;
	}

	public void setKcmdrw(String kcmdrw) {
		this.kcmdrw = kcmdrw;
	}
	
	@Length(min=0, max=64, message="理论教学要求长度必须介于 0 和 64 之间")
	public String getLljyyq() {
		return lljyyq;
	}

	public void setLljyyq(String lljyyq) {
		this.lljyyq = lljyyq;
	}
	
	@Length(min=0, max=64, message="课程相关说明长度必须介于 0 和 64 之间")
	public String getKcxgsm() {
		return kcxgsm;
	}

	public void setKcxgsm(String kcxgsm) {
		this.kcxgsm = kcxgsm;
	}
	
	@Length(min=0, max=64, message="教学建议长度必须介于 0 和 64 之间")
	public String getJxjy() {
		return jxjy;
	}

	public void setJxjy(String jxjy) {
		this.jxjy = jxjy;
	}
	

	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}
	
}