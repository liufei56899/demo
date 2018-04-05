/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 学生信息记录Entity
 * @author lg
 * @version 2016-07-26
 */
public class XsJbxxRecord extends DataEntity<XsJbxxRecord> {
	
	private static final long serialVersionUID = 1L;
	private String xsId;		// 学生编号
	private String jhid; // 招生计划
	private String xm; // 姓名
	private String xbm; // 性别码 0：未知；1：男；2：女；9：未说明
	private String csrq; // 出生日期
	private String sfzjlxm; // 身份证件类型
	private String sfzjh; // 身份证件号
	private String xmpy; // 姓名拼音
	// private String bjmc; // 班级名称
	private BjJbxx bjmc;
	private String bjName; // 班级名称
	private String xh; // 学号
	private String xslbm; // 学生类别
	private String xxxsm; // 学习形式
	private String rxfsm; // 入学方式
	private String jdfsm; // 就读方式
	private String gjdqm; // 国籍/地区
	private String gatqwm; // 港澳台侨外
	private String hyzkm; // 婚姻状况
	private String chcqj; // 乘火车区间
	private String sfsqzn; // 是否随迁子女
	private String sydxzqhm; // 生源地行政区划码
	private String csdxzqhm; // 出生地行政区划码
	private String jgdxzqhm; // 籍贯地行政区划码
	private String hkszdqxyxxxdz; // 户口所在地区县以下详细地址
	private String scpcs; // 所属派出所
	private String hkszdxzqhm; // 户口所在地行政区划码
	private String hkxz; // 户口性质
	private String xsjzdlx; // 学生居住地类型
	private String rxny; // 入学年月
	// private String zy; // 专业

	private ZyJbxx zyId; // 专业
	private ZylxJbxx zylxId; // 专业类别 zylx_id
	private String zyName; // 专业名称

	private String zyjc; // 专业简称
	private String zyfx; // 专业方向
	private String xz; // 学制
	private String mzm; // 民族
	private String zzmmm; // 政治面貌
	private String jkzkm; // 健康状况
	private String xslym; // 学生来源
	private String zsdx; // 招生对象
	private String jhrlxdh; // 监护人联系电话
	private String byxx; // 毕业学校
	private String lxdh; // 联系电话
	private String zsfs; // 招生方式
	private String lzhzlx; // 联招合作类型
	private String zkzh; // 准考证号
	private String ksh; // 考生号
	private String kszf; // 考生总分
	private String kstc; // 考生特长
	private String ksjwbs; // 考生既往病史
	private String tjjl; // 体检结论
	private String lzhzbxfs; // 联招合作办学方式
	private String lzhzxxdm; // 联招合作学校代码
	private String xwjxd; // 校外教学点
	private String fdpyfs; // 分段培养方式
	private String ywxm; // 英文姓名
	private String dzxx; // 电子信箱/其他联系方式
	private String jtxdz; // 家庭现地址
	private String jtyzbm; // 家庭邮政编码
	private String jtdh; // 家庭电话
	private String cyyxm; // 成员1姓名
	private String cyygx; // 成员1关系
	private String cyysfjhr; // 成员1是否监护人
	private String cyylxdh; // 成员1联系电话
	private String cyycsny; // 成员1出生年月
	private String cyysfzjlx; // 成员1身份证件类型
	private String cyysfzjh; // 成员1身份证件号
	private String cyymzm; // 成员1民族
	private String cyyzzmmm; // 成员1政治面貌
	private String cyyjkzkm; // 成员1健康状况
	private String cyygzhxxdw; // 成员1工作或学习单位
	private String cyyzw; // 成员1职务
	private String cyexm; // 成员2姓名
	private String cyegx; // 成员2关系
	private String cyesfjhr; // 成员2是否监护人
	private String cyelxdh; // 成员2联系电话
	private String cyecsny; // 成员2出生年月
	private String cyesfzjlx; // 成员2身份证件类型
	private String cyesfzjh; // 成员2身份证件号
	private String cyemzm; // 成员2民族
	private String cyezzmmm; // 成员2政治面貌
	private String cyejkzkm; // 成员2健康状况
	private String cyegzhxxdw; // 成员2工作或学习单位
	private String cyezw; // 成员2职务
	private String shzt; //  1：通过 2：不通过
	private String spnr;//审批内容(审核意见)


	// 各专业招生情况统计需要字段
	private String zymc; // 专业名称
	private int rwl; // 任务量
	private int zsl; // 招生量
	private int bml; // 报名量

	// 各专业招生情况统计需要字段
	private int zsw; // 招生网
	private int zsls; // 招生老师
	private int muming; // 慕名
	private int dljg; // 代理机构

	private String csid;//传递参数
	private String quyu;//返回结果
	
	public String getXsId() {
		return xsId;
	}

	public void setXsId(String xsId) {
		this.xsId = xsId;
	}

	public String getCsid() {
		return csid;
	}

	public void setCsid(String csid) {
		this.csid = csid;
	}

	public String getQuyu() {
		return quyu;
	}

	public void setQuyu(String quyu) {
		this.quyu = quyu;
	}

	public int getZsw() {
		return zsw;
	}

	public void setZsw(int zsw) {
		this.zsw = zsw;
	}

	public int getZsls() {
		return zsls;
	}

	public void setZsls(int zsls) {
		this.zsls = zsls;
	}

	public int getMuming() {
		return muming;
	}

	public void setMuming(int muming) {
		this.muming = muming;
	}

	public int getDljg() {
		return dljg;
	}

	public void setDljg(int dljg) {
		this.dljg = dljg;
	}

	public String getZymc() {
		return zymc;
	}

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}

	public int getRwl() {
		return rwl;
	}

	public void setRwl(int rwl) {
		this.rwl = rwl;
	}

	public int getZsl() {
		return zsl;
	}

	public void setZsl(int zsl) {
		this.zsl = zsl;
	}

	public int getBml() {
		return bml;
	}

	public void setBml(int bml) {
		this.bml = bml;
	}

	public String getJhid() {
		return jhid;
	}

	public void setJhid(String jhid) {
		this.jhid = jhid;
	}

	public String getShzt() {
		return shzt;
	}

	public void setShzt(String shzt) {
		this.shzt = shzt;
	}
	
	public String getSpnr() {
		return spnr;
	}

	public void setSpnr(String spnr) {
		this.spnr = spnr;
	}

	public XsJbxxRecord() {
		super();
	}

	public XsJbxxRecord(String id) {
		super(id);
	}

	@Length(min = 1, max = 64, message = "姓名长度必须介于 1 和 64 之间")
	@ExcelField(title = "姓名", align = 2, sort = 10, groups = { 1, 2 })
	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	@Length(min = 1, max = 64, message = "性别码 0：未知；1：男；2：女；9：未说明长度必须介于 1 和 64 之间")
	@ExcelField(title = "性别", align = 2, sort = 20, groups = { 1, 2 }, dictType = "sex")
	public String getXbm() {
		return xbm;
	}

	public void setXbm(String xbm) {
		this.xbm = xbm;
	}

	@Length(min = 1, max = 12, message = "出生日期长度必须介于 1 和 12 之间")
	@ExcelField(title = "出生日期", align = 2, sort = 30, groups = { 1, 2 })
	public String getCsrq() {
		return csrq;
	}

	public void setCsrq(String csrq) {
		this.csrq = csrq;
	}

	@Length(min = 0, max = 64, message = "身份证件类型长度必须介于 0 和 64 之间")
	@ExcelField(title = "身份证件类型", align = 2, sort = 40, groups = { 1, 2 }, dictType = "sfzjlx")
	public String getSfzjlxm() {
		return sfzjlxm;
	}

	public void setSfzjlxm(String sfzjlxm) {
		this.sfzjlxm = sfzjlxm;
	}

	@Length(min = 1, max = 18, message = "身份证件号长度必须介于 1 和 18 之间")
	@ExcelField(title = "身份证件号", align = 2, sort = 50, groups = { 1, 2 })
	public String getSfzjh() {
		return sfzjh;
	}

	public void setSfzjh(String sfzjh) {
		this.sfzjh = sfzjh;
	}

	@Length(min = 0, max = 64, message = "姓名拼音长度必须介于 0 和 64 之间")
	@ExcelField(title = "姓名拼音", align = 2, sort = 60, groups = { 2 })
	public String getXmpy() {
		return xmpy;
	}

	public void setXmpy(String xmpy) {
		this.xmpy = xmpy;
	}

	/*
	 * @Length(min=0, max=32, message="班级名称长度必须介于 0 和 32 之间") public String
	 * getBjmc() { return bjmc; }
	 * 
	 * public void setBjmc(String bjmc) { this.bjmc = bjmc; }
	 */

	@Length(min = 0, max = 18, message = "学号长度必须介于 0 和 18 之间")
	@ExcelField(title = "学号", align = 2, sort = 80, groups = { 2 })
	public String getXh() {
		return xh;
	}

	public BjJbxx getBjmc() {
		return bjmc;
	}

	public void setBjmc(BjJbxx bjmc) {
		this.bjmc = bjmc;
	}

	@ExcelField(title = "班级名称", align = 2, sort = 70, groups = { 2 })
	public String getBjName() {
		return bjName;
	}

	public void setBjName(String bjName) {
		this.bjName = bjName;
	}

	public void setXh(String xh) {
		this.xh = xh;
	}

	@Length(min = 0, max = 64, message = "学生类别长度必须介于 0 和 64 之间")
	@ExcelField(title = "学生类别", align = 2, sort = 90, groups = { 2 }, dictType = "xslb")
	public String getXslbm() {
		return xslbm;
	}

	public void setXslbm(String xslbm) {
		this.xslbm = xslbm;
	}

	@Length(min = 0, max = 64, message = "学习形式长度必须介于 0 和 64 之间")
	@ExcelField(title = "学习形式", align = 2, sort = 100, groups = { 2 }, dictType = "xxxs")
	public String getXxxsm() {
		return xxxsm;
	}

	public void setXxxsm(String xxxsm) {
		this.xxxsm = xxxsm;
	}

	@Length(min = 0, max = 64, message = "入学方式长度必须介于 0 和 64 之间")
	@ExcelField(title = "入学方式", align = 2, sort = 110, groups = { 2 }, dictType = "rxfs")
	public String getRxfsm() {
		return rxfsm;
	}

	public void setRxfsm(String rxfsm) {
		this.rxfsm = rxfsm;
	}

	@Length(min = 0, max = 64, message = "就读方式长度必须介于 0 和 64 之间")
	@ExcelField(title = "就读方式", align = 2, sort = 120, groups = { 2 }, dictType = "jdfs")
	public String getJdfsm() {
		return jdfsm;
	}

	public void setJdfsm(String jdfsm) {
		this.jdfsm = jdfsm;
	}

	@ExcelField(title = "国籍/地区", align = 2, sort = 130, groups = { 2 }, dictType = "gjdqm")
	public String getGjdqm() {
		return gjdqm;
	}

	public void setGjdqm(String gjdqm) {
		this.gjdqm = gjdqm;
	}

	@Length(min = 0, max = 64, message = "港澳台侨外长度必须介于 0 和 64 之间")
	@ExcelField(title = "港澳台侨外", align = 2, sort = 140, groups = { 2 }, dictType = "gatqwm")
	public String getGatqwm() {
		return gatqwm;
	}

	public void setGatqwm(String gatqwm) {
		this.gatqwm = gatqwm;
	}

	@Length(min = 0, max = 64, message = "婚姻状况长度必须介于 0 和 64 之间")
	@ExcelField(title = "婚姻状况", align = 2, sort = 150, groups = { 2 }, dictType = "hyzk")
	public String getHyzkm() {
		return hyzkm;
	}

	public void setHyzkm(String hyzkm) {
		this.hyzkm = hyzkm;
	}

	@Length(min = 0, max = 64, message = "乘火车区间长度必须介于 0 和 64 之间")
	@ExcelField(title = "乘火车区间", align = 2, sort = 160, groups = { 2 })
	public String getChcqj() {
		return chcqj;
	}

	public void setChcqj(String chcqj) {
		this.chcqj = chcqj;
	}

	@Length(min = 0, max = 1, message = "是否随迁子女长度必须介于 0 和 1 之间")
	@ExcelField(title = "是否随迁子女", align = 2, sort = 170, groups = { 2 }, dictType = "sfdm")
	public String getSfsqzn() {
		return sfsqzn;
	}

	public void setSfsqzn(String sfsqzn) {
		this.sfsqzn = sfsqzn;
	}

	@Length(min = 0, max = 64, message = "生源地行政区划码长度必须介于 0 和 64 之间")
	@ExcelField(title = "生源地行政区划码", align = 2, sort = 290, groups = { 1, 2 })
	public String getSydxzqhm() {
		return sydxzqhm;
	}

	public void setSydxzqhm(String sydxzqhm) {
		this.sydxzqhm = sydxzqhm;
	}

	@Length(min = 0, max = 64, message = "出生地行政区划码长度必须介于 0 和 64 之间")
	@ExcelField(title = "出生地行政区划码", align = 2, sort = 300, groups = { 2 })
	public String getCsdxzqhm() {
		return csdxzqhm;
	}

	public void setCsdxzqhm(String csdxzqhm) {
		this.csdxzqhm = csdxzqhm;
	}

	@Length(min = 0, max = 64, message = "籍贯地行政区划码长度必须介于 0 和 64 之间")
	@ExcelField(title = "籍贯地行政区划码", align = 2, sort = 310, groups = { 2 })
	public String getJgdxzqhm() {
		return jgdxzqhm;
	}

	public void setJgdxzqhm(String jgdxzqhm) {
		this.jgdxzqhm = jgdxzqhm;
	}

	@Length(min = 0, max = 64, message = "户口所在地区县以下详细地址长度必须介于 0 和 64 之间")
	@ExcelField(title = "户口所在地区县以下详细地址", align = 2, sort = 320, groups = { 2 })
	public String getHkszdqxyxxxdz() {
		return hkszdqxyxxxdz;
	}

	public void setHkszdqxyxxxdz(String hkszdqxyxxxdz) {
		this.hkszdqxyxxxdz = hkszdqxyxxxdz;
	}

	@Length(min = 0, max = 64, message = "所属派出所长度必须介于 0 和 64 之间")
	@ExcelField(title = "所属派出所", align = 2, sort = 330, groups = { 2 })
	public String getScpcs() {
		return scpcs;
	}

	public void setScpcs(String scpcs) {
		this.scpcs = scpcs;
	}

	@Length(min = 0, max = 64, message = "户口所在地行政区划码长度必须介于 0 和 64 之间")
	@ExcelField(title = "户口所在地行政区划码", align = 2, sort = 340, groups = { 1, 2 })
	public String getHkszdxzqhm() {
		return hkszdxzqhm;
	}

	public void setHkszdxzqhm(String hkszdxzqhm) {
		this.hkszdxzqhm = hkszdxzqhm;
	}

	@Length(min = 0, max = 64, message = "户口性质长度必须介于 0 和 64 之间")
	@ExcelField(title = "户口性质", align = 2, sort = 350, groups = { 1, 2 }, dictType = "hkxz")
	public String getHkxz() {
		return hkxz;
	}

	public void setHkxz(String hkxz) {
		this.hkxz = hkxz;
	}

	@Length(min = 0, max = 64, message = "学生居住地类型长度必须介于 0 和 64 之间")
	@ExcelField(title = "学生居住地类型", align = 2, sort = 360, groups = { 1, 2 }, dictType = "xsjzdlx")
	public String getXsjzdlx() {
		return xsjzdlx;
	}

	public void setXsjzdlx(String xsjzdlx) {
		this.xsjzdlx = xsjzdlx;
	}

	@Length(min = 0, max = 64, message = "入学年月长度必须介于 0 和64 之间")
	@ExcelField(title = "入学年月", align = 2, sort = 370, groups = { 1, 2 })
	public String getRxny() {
		return rxny;
	}

	public void setRxny(String rxny) {
		this.rxny = rxny;
	}

	/*
	 * @Length(min=0, max=64, message="专业长度必须介于 0 和 64 之间") public String
	 * getZy() { return zy; }
	 * 
	 * public void setZy(String zy) { this.zy = zy; }
	 */

	public ZylxJbxx getZylxId() {
		return zylxId;
	}

	public ZyJbxx getZyId() {
		return zyId;
	}

	public void setZyId(ZyJbxx zyId) {
		this.zyId = zyId;
	}

	@ExcelField(title = "专业", align = 2, sort = 380, groups = { 2 })
	public String getZyName() {
		return zyName;
	}

	public void setZyName(String zyName) {
		this.zyName = zyName;
	}

	public void setZylxId(ZylxJbxx zylxId) {
		this.zylxId = zylxId;
	}

	@Length(min = 0, max = 32, message = "专业简称长度必须介于 0 和 32 之间")
	@ExcelField(title = "专业简称", align = 2, sort = 180, groups = { 1 })
	public String getZyjc() {
		return zyjc;
	}

	public void setZyjc(String zyjc) {
		this.zyjc = zyjc;
	}

	@Length(min = 0, max = 32, message = "专业方向长度必须介于 0 和 32 之间")
	@ExcelField(title = "专业方向", align = 2, sort = 390, groups = { 2 })
	public String getZyfx() {
		return zyfx;
	}

	public void setZyfx(String zyfx) {
		this.zyfx = zyfx;
	}

	@Length(min = 0, max = 64, message = "学制长度必须介于 0 和 64 之间")
	@ExcelField(title = "学制", align = 2, sort = 400, groups = { 2 }, dictType = "xzdm")
	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	@Length(min = 0, max = 64, message = "民族长度必须介于 0 和 64 之间")
	@ExcelField(title = "民族", align = 2, sort = 410, groups = { 1, 2 }, dictType = "nation")
	public String getMzm() {
		return mzm;
	}

	public void setMzm(String mzm) {
		this.mzm = mzm;
	}

	@Length(min = 0, max = 64, message = "政治面貌长度必须介于 0 和 64 之间")
	@ExcelField(title = "政治面貌", align = 2, sort = 420, groups = { 1, 2 }, dictType = "zzmm")
	public String getZzmmm() {
		return zzmmm;
	}

	public void setZzmmm(String zzmmm) {
		this.zzmmm = zzmmm;
	}

	@Length(min = 0, max = 64, message = "健康状况长度必须介于 0 和 64 之间")
	@ExcelField(title = "健康状况", align = 2, sort = 430, groups = { 1, 2 }, dictType = "health")
	public String getJkzkm() {
		return jkzkm;
	}

	public void setJkzkm(String jkzkm) {
		this.jkzkm = jkzkm;
	}

	@Length(min = 0, max = 64, message = "学生来源长度必须介于 0 和 64 之间")
	@ExcelField(title = "学生来源", align = 2, sort = 440, groups = { 1, 2 }, dictType = "xs_ly")
	public String getXslym() {
		return xslym;
	}

	public void setXslym(String xslym) {
		this.xslym = xslym;
	}

	@Length(min = 0, max = 64, message = "招生对象长度必须介于 0 和 64 之间")
	@ExcelField(title = "招生对象", align = 2, sort = 450, groups = { 1, 2 }, dictType = "zsdx")
	public String getZsdx() {
		return zsdx;
	}

	public void setZsdx(String zsdx) {
		this.zsdx = zsdx;
	}

	@Length(min = 0, max = 32, message = "监护人联系电话长度必须介于 0 和 32 之间")
	@ExcelField(title = "监护人联系电话", align = 2, sort = 160, groups = { 1 })
	public String getJhrlxdh() {
		return jhrlxdh;
	}

	public void setJhrlxdh(String jhrlxdh) {
		this.jhrlxdh = jhrlxdh;
	}

	@Length(min = 0, max = 50, message = "毕业学校长度必须介于 0 和 50 之间")
	@ExcelField(title = "毕业学校", align = 2, sort = 170, groups = { 1 })
	public String getByxx() {
		return byxx;
	}

	public void setByxx(String byxx) {
		this.byxx = byxx;
	}

	@Length(min = 0, max = 32, message = "联系电话长度必须介于 0 和 32 之间")
	@ExcelField(title = "联系电话", align = 2, sort = 460, groups = { 2 })
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	@Length(min = 0, max = 64, message = "招生方式长度必须介于 0 和 64 之间")
	@ExcelField(title = "招生方式", align = 2, sort = 470, groups = { 1, 2 }, dictType = "zsfs")
	public String getZsfs() {
		return zsfs;
	}

	public void setZsfs(String zsfs) {
		this.zsfs = zsfs;
	}

	@Length(min = 0, max = 64, message = "联招合作类型长度必须介于 0 和 64 之间")
	@ExcelField(title = "联招合作类型", align = 2, sort = 480, groups = { 2 }, dictType = "lzhzlx")
	public String getLzhzlx() {
		return lzhzlx;
	}

	public void setLzhzlx(String lzhzlx) {
		this.lzhzlx = lzhzlx;
	}

	@Length(min = 0, max = 32, message = "准考证号长度必须介于 0 和 32 之间")
	@ExcelField(title = "准考证号", align = 2, sort = 490, groups = { 1, 2 })
	public String getZkzh() {
		return zkzh;
	}

	public void setZkzh(String zkzh) {
		this.zkzh = zkzh;
	}

	@Length(min = 0, max = 32, message = "考生号长度必须介于 0 和 32 之间")
	@ExcelField(title = "考生号", align = 2, sort = 500, groups = { 1, 2 })
	public String getKsh() {
		return ksh;
	}

	public void setKsh(String ksh) {
		this.ksh = ksh;
	}

	@Length(min = 0, max = 10, message = "考生总分长度必须介于 0 和 10 之间")
	@ExcelField(title = "考试总分", align = 2, sort = 510, groups = { 1, 2 })
	public String getKszf() {
		return kszf;
	}

	public void setKszf(String kszf) {
		this.kszf = kszf;
	}

	@Length(min = 0, max = 255, message = "考生特长长度必须介于 0 和 255 之间")
	@ExcelField(title = "考生特长", align = 2, sort = 520, groups = { 1 })
	public String getKstc() {
		return kstc;
	}

	public void setKstc(String kstc) {
		this.kstc = kstc;
	}

	@Length(min = 0, max = 255, message = "考生既往病史长度必须介于 0 和 255 之间")
	@ExcelField(title = "考生既往病史", align = 2, sort = 530, groups = { 1 })
	public String getKsjwbs() {
		return ksjwbs;
	}

	public void setKsjwbs(String ksjwbs) {
		this.ksjwbs = ksjwbs;
	}

	@Length(min = 0, max = 255, message = "体检结论长度必须介于 0 和 255 之间")
	@ExcelField(title = "体检结论", align = 2, sort = 540, groups = { 1 })
	public String getTjjl() {
		return tjjl;
	}

	public void setTjjl(String tjjl) {
		this.tjjl = tjjl;
	}

	@Length(min = 0, max = 64, message = "联招合作办学形式长度必须介于 0 和 64 之间")
	@ExcelField(title = "联招合作办学形式", align = 2, sort = 550, groups = { 2 }, dictType = "lzhzbxxs")
	public String getLzhzbxfs() {
		return lzhzbxfs;
	}

	public void setLzhzbxfs(String lzhzbxfs) {
		this.lzhzbxfs = lzhzbxfs;
	}

	@Length(min = 0, max = 32, message = "联招合作学校代码长度必须介于 0 和 32 之间")
	@ExcelField(title = "联招合作学校代码", align = 2, sort = 560, groups = { 2 })
	public String getLzhzxxdm() {
		return lzhzxxdm;
	}

	public void setLzhzxxdm(String lzhzxxdm) {
		this.lzhzxxdm = lzhzxxdm;
	}

	@Length(min = 0, max = 32, message = "校外教学点长度必须介于 0 和 32 之间")
	@ExcelField(title = "校外教学点", align = 2, sort = 570, groups = { 2 })
	public String getXwjxd() {
		return xwjxd;
	}

	public void setXwjxd(String xwjxd) {
		this.xwjxd = xwjxd;
	}

	@Length(min = 0, max = 64, message = "分段培养方式长度必须介于 0 和 64 之间")
	@ExcelField(title = "分段培养方式", align = 2, sort = 580, groups = { 2 })
	public String getFdpyfs() {
		return fdpyfs;
	}

	public void setFdpyfs(String fdpyfs) {
		this.fdpyfs = fdpyfs;
	}

	@Length(min = 0, max = 32, message = "英文姓名长度必须介于 0 和 32 之间")
	@ExcelField(title = "英文姓名", align = 2, sort = 590, groups = { 2 })
	public String getYwxm() {
		return ywxm;
	}

	public void setYwxm(String ywxm) {
		this.ywxm = ywxm;
	}

	@Length(min = 0, max = 64, message = "电子信箱/其他联系方式长度必须介于 0 和 64 之间")
	@ExcelField(title = "电子信箱/其他联系方式", align = 2, sort = 600, groups = { 2 })
	public String getDzxx() {
		return dzxx;
	}

	public void setDzxx(String dzxx) {
		this.dzxx = dzxx;
	}

	@Length(min = 0, max = 128, message = "家庭现地址长度必须介于 0 和 128 之间")
	@ExcelField(title = "家庭现地址", align = 2, sort = 610, groups = { 2 })
	public String getJtxdz() {
		return jtxdz;
	}

	public void setJtxdz(String jtxdz) {
		this.jtxdz = jtxdz;
	}

	@Length(min = 0, max = 6, message = "家庭邮政编码长度必须介于 0 和 6 之间")
	@ExcelField(title = "家庭邮政编码", align = 2, sort = 620, groups = { 2 })
	public String getJtyzbm() {
		return jtyzbm;
	}

	public void setJtyzbm(String jtyzbm) {
		this.jtyzbm = jtyzbm;
	}

	@Length(min = 0, max = 32, message = "家庭电话长度必须介于 0 和 32 之间")
	@ExcelField(title = "家庭电话", align = 2, sort = 630, groups = { 2 })
	public String getJtdh() {
		return jtdh;
	}

	public void setJtdh(String jtdh) {
		this.jtdh = jtdh;
	}

	@Length(min = 0, max = 64, message = "成员1姓名长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员1姓名", align = 2, sort = 640, groups = { 2 })
	public String getCyyxm() {
		return cyyxm;
	}

	public void setCyyxm(String cyyxm) {
		this.cyyxm = cyyxm;
	}

	@Length(min = 0, max = 32, message = "成员1关系长度必须介于 0 和 32 之间")
	@ExcelField(title = "成员1关系", align = 2, sort = 650, groups = { 2 })
	public String getCyygx() {
		return cyygx;
	}

	public void setCyygx(String cyygx) {
		this.cyygx = cyygx;
	}

	@Length(min = 0, max = 1, message = "成员1是否监护人长度必须介于 0 和 1 之间")
	@ExcelField(title = "成员1是否监护人", align = 2, sort = 660, groups = { 2 }, dictType = "sfdm")
	public String getCyysfjhr() {
		return cyysfjhr;
	}

	public void setCyysfjhr(String cyysfjhr) {
		this.cyysfjhr = cyysfjhr;
	}

	@Length(min = 0, max = 32, message = "成员1联系电话长度必须介于 0 和 32 之间")
	@ExcelField(title = "成员1联系电话", align = 2, sort = 670, groups = { 2 })
	public String getCyylxdh() {
		return cyylxdh;
	}

	public void setCyylxdh(String cyylxdh) {
		this.cyylxdh = cyylxdh;
	}

	@Length(min = 0, max = 64, message = "成员1出生年月长度必须介于 0 和 64之间")
	@ExcelField(title = "成员1出生年月", align = 2, sort = 680, groups = { 2 })
	public String getCyycsny() {
		return cyycsny;
	}

	public void setCyycsny(String cyycsny) {
		this.cyycsny = cyycsny;
	}

	@Length(min = 0, max = 64, message = "成员1身份证件类型长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员1身份证件类型", align = 2, sort = 690, groups = { 2 }, dictType = "sfzjlx")
	public String getCyysfzjlx() {
		return cyysfzjlx;
	}

	public void setCyysfzjlx(String cyysfzjlx) {
		this.cyysfzjlx = cyysfzjlx;
	}

	@Length(min = 0, max = 18, message = "成员1身份证件号长度必须介于 0 和 18 之间")
	@ExcelField(title = "成员1身份证件号", align = 2, sort = 700, groups = { 2 })
	public String getCyysfzjh() {
		return cyysfzjh;
	}

	public void setCyysfzjh(String cyysfzjh) {
		this.cyysfzjh = cyysfzjh;
	}

	@Length(min = 0, max = 64, message = "成员1民族长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员1民族", align = 2, sort = 710, groups = { 2 }, dictType = "nation")
	public String getCyymzm() {
		return cyymzm;
	}

	public void setCyymzm(String cyymzm) {
		this.cyymzm = cyymzm;
	}

	@Length(min = 0, max = 64, message = "成员1政治面貌长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员1政治面貌", align = 2, sort = 720, groups = { 2 }, dictType = "zzmm")
	public String getCyyzzmmm() {
		return cyyzzmmm;
	}

	public void setCyyzzmmm(String cyyzzmmm) {
		this.cyyzzmmm = cyyzzmmm;
	}

	@Length(min = 0, max = 64, message = "成员1健康状况长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员1健康状况", align = 2, sort = 730, groups = { 2 }, dictType = "health")
	public String getCyyjkzkm() {
		return cyyjkzkm;
	}

	public void setCyyjkzkm(String cyyjkzkm) {
		this.cyyjkzkm = cyyjkzkm;
	}

	@Length(min = 0, max = 255, message = "成员1工作或学习单位长度必须介于 0 和 255 之间")
	@ExcelField(title = "成员1工作或学习单位", align = 2, sort = 740, groups = { 2 })
	public String getCyygzhxxdw() {
		return cyygzhxxdw;
	}

	public void setCyygzhxxdw(String cyygzhxxdw) {
		this.cyygzhxxdw = cyygzhxxdw;
	}

	@Length(min = 0, max = 20, message = "成员1职务长度必须介于 0 和 20 之间")
	@ExcelField(title = "成员1职务", align = 2, sort = 750, groups = { 2 })
	public String getCyyzw() {
		return cyyzw;
	}

	public void setCyyzw(String cyyzw) {
		this.cyyzw = cyyzw;
	}

	@Length(min = 0, max = 64, message = "成员2姓名长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员2姓名", align = 2, sort = 760, groups = { 2 })
	public String getCyexm() {
		return cyexm;
	}

	public void setCyexm(String cyexm) {
		this.cyexm = cyexm;
	}

	@Length(min = 0, max = 32, message = "成员2关系长度必须介于 0 和 32 之间")
	@ExcelField(title = "成员2关系", align = 2, sort = 770, groups = { 2 })
	public String getCyegx() {
		return cyegx;
	}

	public void setCyegx(String cyegx) {
		this.cyegx = cyegx;
	}

	@Length(min = 0, max = 1, message = "成员2是否监护人长度必须介于 0 和 1 之间")
	@ExcelField(title = "成员2是否监护人", align = 2, sort = 780, groups = { 2 }, dictType = "sfdm")
	public String getCyesfjhr() {
		return cyesfjhr;
	}

	public void setCyesfjhr(String cyesfjhr) {
		this.cyesfjhr = cyesfjhr;
	}

	@Length(min = 0, max = 32, message = "成员2联系电话长度必须介于 0 和 32 之间")
	@ExcelField(title = "成员2联系电话", align = 2, sort = 790, groups = { 2 })
	public String getCyelxdh() {
		return cyelxdh;
	}

	public void setCyelxdh(String cyelxdh) {
		this.cyelxdh = cyelxdh;
	}

	@Length(min = 0, max = 64, message = "成员2出生年月长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员2出生年月", align = 2, sort = 800, groups = { 2 })
	public String getCyecsny() {
		return cyecsny;
	}

	public void setCyecsny(String cyecsny) {
		this.cyecsny = cyecsny;
	}

	@Length(min = 0, max = 64, message = "成员2身份证件类型长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员2身份证件类型", align = 2, sort = 810, groups = { 2 }, dictType = "sfzjlx")
	public String getCyesfzjlx() {
		return cyesfzjlx;
	}

	public void setCyesfzjlx(String cyesfzjlx) {
		this.cyesfzjlx = cyesfzjlx;
	}

	@Length(min = 0, max = 18, message = "成员2身份证件号长度必须介于 0 和 18 之间")
	@ExcelField(title = "成员2身份证件号", align = 2, sort = 820, groups = { 2 })
	public String getCyesfzjh() {
		return cyesfzjh;
	}

	public void setCyesfzjh(String cyesfzjh) {
		this.cyesfzjh = cyesfzjh;
	}

	@Length(min = 0, max = 64, message = "成员2民族长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员2民族", align = 2, sort = 830, groups = { 2 }, dictType = "nation")
	public String getCyemzm() {
		return cyemzm;
	}

	public void setCyemzm(String cyemzm) {
		this.cyemzm = cyemzm;
	}

	@Length(min = 0, max = 64, message = "成员2政治面貌长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员2政治面貌", align = 2, sort = 840, groups = { 2 }, dictType = "zzmm")
	public String getCyezzmmm() {
		return cyezzmmm;
	}

	public void setCyezzmmm(String cyezzmmm) {
		this.cyezzmmm = cyezzmmm;
	}

	@Length(min = 0, max = 64, message = "成员2健康状况长度必须介于 0 和 64 之间")
	@ExcelField(title = "成员2健康状况", align = 2, sort = 850, groups = { 2 }, dictType = "health")
	public String getCyejkzkm() {
		return cyejkzkm;
	}

	public void setCyejkzkm(String cyejkzkm) {
		this.cyejkzkm = cyejkzkm;
	}

	@Length(min = 0, max = 255, message = "成员2工作或学习单位长度必须介于 0 和 255 之间")
	@ExcelField(title = "成员2工作或学习单位", align = 2, sort = 860, groups = { 2 })
	public String getCyegzhxxdw() {
		return cyegzhxxdw;
	}

	public void setCyegzhxxdw(String cyegzhxxdw) {
		this.cyegzhxxdw = cyegzhxxdw;
	}

	@Length(min = 0, max = 20, message = "成员2职务长度必须介于 0 和 20 之间")
	@ExcelField(title = "成员2职务", align = 2, sort = 870, groups = { 2 })
	public String getCyezw() {
		return cyezw;
	}

	public void setCyezw(String cyezw) {
		this.cyezw = cyezw;
	}

}