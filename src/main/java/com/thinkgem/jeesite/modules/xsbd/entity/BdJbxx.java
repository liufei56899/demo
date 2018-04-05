/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsbd.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 新生报到Entity
 * @author xfb_20161206
 * @version 2016-12-06
 */
public class BdJbxx extends DataEntity<BdJbxx> {
	
	private static final long serialVersionUID = 1L;
	private String nf;		// 年份
	private String xqId;		// 学期
	private String xm;		// 学生姓名
	private String xbm;		// 性别
	private String sfzjh;		// 身份证件号
	private ZylxJbxx zyId;		// 专业类别
	private String lxdh;		// 联系电话
	private Date csrq;		// 出生日期
	private String jtzz;		// 家庭住址
	private String jfzt;		// 是否缴费
	private String sfls;		// 是否老生
	private String zylxId;		// 专业id
	private String photo;		// 照片
	private String ybzy;		// 预报专业
	private String cname;		// 曾用名
	private String relation;		// 户主或与户主关系
	private String nation;		// 民族
	private String jg;		// 籍贯
	private String otheraddress;		// 本市县其他地址
	private String religion;		// 宗教信仰
	private String sg;		// 身高
	private String xx;		// 血型
	private String whcd;		// 文化程度
	private String byzk;		// 兵役状况
	private String fwcs;		// 服务处所
	private String zy;		// 职业
	private String bsx;		// 何时由何地迁来本市县
	private String bzz;		// 何时由何地迁来本址
	private String sfzjlx;		// 身份证件类型
	private String qfjg;		// 签发机关
	private Date starttime;		// 身份证件起始时间
	private Date overtime;		// 身份证件结束时间
	
	private String zyname;//专业名称
	
	private String datafrom;//信息来源2016-12-13

	private Zsjh zsjh; // 计划名称
	private String ly; // 来源

    private String sf;//省份
    private String xslym; //学生来源（应往届）
    private String zkzh; //准考证号
    private String stuNumber; //学生编号-打印
    private String bj;//班级名称
    private String bkcc;//报考层次
    private String  yyxykszsdj ;      //音乐学院考试证书等级
    private String  yyxukszscj ;      //考试证书成绩1.优秀2.良好。3合格
    private String  isyyjb     ;      //是否愿意兼报0否 1.是
    private String  jbzylxid  ;//兼报专业类型ID
    private String  jbzyid     ;      //兼报专业id
    private String jbxz;  //简报学制
    private String  isdszcks   ;      //是否特殊政策考生0.否1.是
    private String  xxdate1    ;      //学习时间段1
    private String  jdxy1      ;      //就读学校1
    private String  xxdate2    ;      //学习时间2
    private String  jdxy2      ;      //就读学校2
    private String  xxdate3    ;      //学习时间3
    private String  jdxy3      ;      //就读学校3
    private String  jcqk        ;//奖惩情况
    
    
    public String getJcqk() {
		return jcqk;
	}

	public void setJcqk(String jcqk) {
		this.jcqk = jcqk;
	}

	public String getJbzylxid() {
		return jbzylxid;
	}

	public void setJbzylxid(String jbzylxid) {
		this.jbzylxid = jbzylxid;
	}

	public String getJbxz() {
		return jbxz;
	}

	public void setJbxz(String jbxz) {
		this.jbxz = jbxz;
	}

	public String getBkcc() {
		return bkcc;
	}

	public void setBkcc(String bkcc) {
		this.bkcc = bkcc;
	}

	public String getYyxykszsdj() {
		return yyxykszsdj;
	}

	public void setYyxykszsdj(String yyxykszsdj) {
		this.yyxykszsdj = yyxykszsdj;
	}

	public String getYyxukszscj() {
		return yyxukszscj;
	}

	public void setYyxukszscj(String yyxukszscj) {
		this.yyxukszscj = yyxukszscj;
	}

	public String getIsyyjb() {
		return isyyjb;
	}

	public void setIsyyjb(String isyyjb) {
		this.isyyjb = isyyjb;
	}

	public String getJbzyid() {
		return jbzyid;
	}

	public void setJbzyid(String jbzyid) {
		this.jbzyid = jbzyid;
	}

	public String getIsdszcks() {
		return isdszcks;
	}

	public void setIsdszcks(String isdszcks) {
		this.isdszcks = isdszcks;
	}

	public String getXxdate1() {
		return xxdate1;
	}

	public void setXxdate1(String xxdate1) {
		this.xxdate1 = xxdate1;
	}

	public String getJdxy1() {
		return jdxy1;
	}

	public void setJdxy1(String jdxy1) {
		this.jdxy1 = jdxy1;
	}

	public String getXxdate2() {
		return xxdate2;
	}

	public void setXxdate2(String xxdate2) {
		this.xxdate2 = xxdate2;
	}

	public String getJdxy2() {
		return jdxy2;
	}

	public void setJdxy2(String jdxy2) {
		this.jdxy2 = jdxy2;
	}

	public String getXxdate3() {
		return xxdate3;
	}

	public void setXxdate3(String xxdate3) {
		this.xxdate3 = xxdate3;
	}

	public String getJdxy3() {
		return jdxy3;
	}

	public void setJdxy3(String jdxy3) {
		this.jdxy3 = jdxy3;
	}

	public String getBj() {
		return bj;
	}

	public void setBj(String bj) {
		this.bj = bj;
	}

	public String getStuNumber() {
		return stuNumber;
	}

	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}

	public String getXslym() {
		return xslym;
	}

	public void setXslym(String xslym) {
		this.xslym = xslym;
	}

	public String getZkzh() {
		return zkzh;
	}

	public void setZkzh(String zkzh) {
		this.zkzh = zkzh;
	}

	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
	}

	private String cs;//城市
    private String qx;//区县
    private String jd;//乡镇/街道
    private String fromSchool;//生源校
	private JsJbxx js; // 登记老师姓名
	
	
	
	public JsJbxx getJs() {
		return js;
	}

	public void setJs(JsJbxx js) {
		this.js = js;
	}

	public String getFromSchool() {
		return fromSchool;
	}

	public void setFromSchool(String fromSchool) {
		this.fromSchool = fromSchool;
	}

	public String getSf() {
		return sf;
	}

	public void setSf(String sf) {
		this.sf = sf;
	}

	public String getCs() {
		return cs;
	}

	public void setCs(String cs) {
		this.cs = cs;
	}

	public String getQx() {
		return qx;
	}

	public void setQx(String qx) {
		this.qx = qx;
	}

	public Zsjh getZsjh() {
		return zsjh;
	}

	public void setZsjh(Zsjh zsjh) {
		this.zsjh = zsjh;
	}

	public String getLy() {
		return ly;
	}

	public void setLy(String ly) {
		this.ly = ly;
	}

	public String getDatafrom() {
		return datafrom;
	}

	public void setDatafrom(String datafrom) {
		this.datafrom = datafrom;
	}

	public String getZyname() {
		return zyname;
	}

	public void setZyname(String zyname) {
		this.zyname = zyname;
	}

	public BdJbxx() {
		super();
	}

	public BdJbxx(String id){
		super(id);
	}

	@Length(min=0, max=11, message="年份长度必须介于 0 和 11 之间")
	public String getNf() {
		return nf;
	}

	public void setNf(String nf) {
		this.nf = nf;
	}
	
	@Length(min=0, max=64, message="学期长度必须介于 0 和 64 之间")
	public String getXqId() {
		return xqId;
	}

	public void setXqId(String xqId) {
		this.xqId = xqId;
	}
	
	@Length(min=1, max=64, message="学生姓名长度必须介于 1 和 64 之间")
	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}
	
	@Length(min=1, max=64, message="性别长度必须介于 1 和 64 之间")
	public String getXbm() {
		return xbm;
	}

	public void setXbm(String xbm) {
		this.xbm = xbm;
	}
	
	@Length(min=1, max=18, message="身份证件号长度必须介于 1 和 18 之间")
	public String getSfzjh() {
		return sfzjh;
	}

	public void setSfzjh(String sfzjh) {
		this.sfzjh = sfzjh;
	}
	
	public ZylxJbxx getZyId() {
		return zyId;
	}

	public void setZyId(ZylxJbxx zyId) {
		this.zyId = zyId;
	}
	
	@Length(min=0, max=32, message="联系电话长度必须介于 0 和 32 之间")
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="出生日期不能为空")
	public Date getCsrq() {
		return csrq;
	}

	public void setCsrq(Date csrq) {
		this.csrq = csrq;
	}
	
	@Length(min=0, max=255, message="家庭住址长度必须介于 0 和 255 之间")
	public String getJtzz() {
		return jtzz;
	}

	public void setJtzz(String jtzz) {
		this.jtzz = jtzz;
	}
	
	@Length(min=0, max=1, message="是否缴费长度必须介于 0 和 1 之间")
	public String getJfzt() {
		return jfzt;
	}

	public void setJfzt(String jfzt) {
		this.jfzt = jfzt;
	}
	
	@Length(min=0, max=1, message="是否老生长度必须介于 0 和 1 之间")
	public String getSfls() {
		return sfls;
	}

	public void setSfls(String sfls) {
		this.sfls = sfls;
	}
	
	@Length(min=0, max=64, message="专业类别长度必须介于 0 和 64 之间")
	public String getZylxId() {
		return zylxId;
	}

	public void setZylxId(String zylxId) {
		this.zylxId = zylxId;
	}
	
	@Length(min=0, max=128, message="照片长度必须介于 0 和 128 之间")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	@Length(min=0, max=64, message="预报专业长度必须介于 0 和 64 之间")
	public String getYbzy() {
		return ybzy;
	}

	public void setYbzy(String ybzy) {
		this.ybzy = ybzy;
	}
	
	@Length(min=0, max=64, message="曾用名长度必须介于 0 和 64 之间")
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}
	
	@Length(min=0, max=64, message="户主或与户主关系长度必须介于 0 和 64 之间")
	public String getRelation() {
		return relation;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}
	
	@Length(min=1, max=64, message="民族长度必须介于 1 和 64 之间")
	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}
	
	@Length(min=0, max=64, message="籍贯长度必须介于 0 和 64 之间")
	public String getJg() {
		return jg;
	}

	public void setJg(String jg) {
		this.jg = jg;
	}
	
	@Length(min=0, max=200, message="本市县其他地址长度必须介于 0 和 200 之间")
	public String getOtheraddress() {
		return otheraddress;
	}

	public void setOtheraddress(String otheraddress) {
		this.otheraddress = otheraddress;
	}
	
	@Length(min=0, max=200, message="宗教信仰长度必须介于 0 和 200 之间")
	public String getReligion() {
		return religion;
	}

	public void setReligion(String religion) {
		this.religion = religion;
	}
	
	@Length(min=0, max=20, message="身高长度必须介于 0 和 20 之间")
	public String getSg() {
		return sg;
	}

	public void setSg(String sg) {
		this.sg = sg;
	}
	
	@Length(min=0, max=20, message="血型长度必须介于 0 和 20 之间")
	public String getXx() {
		return xx;
	}

	public void setXx(String xx) {
		this.xx = xx;
	}
	
	@Length(min=0, max=20, message="文化程度长度必须介于 0 和 20 之间")
	public String getWhcd() {
		return whcd;
	}

	public void setWhcd(String whcd) {
		this.whcd = whcd;
	}
	
	@Length(min=0, max=20, message="兵役状况长度必须介于 0 和 20 之间")
	public String getByzk() {
		return byzk;
	}

	public void setByzk(String byzk) {
		this.byzk = byzk;
	}
	
	@Length(min=0, max=100, message="服务处所长度必须介于 0 和 100 之间")
	public String getFwcs() {
		return fwcs;
	}

	public void setFwcs(String fwcs) {
		this.fwcs = fwcs;
	}
	
	@Length(min=0, max=50, message="职业长度必须介于 0 和 50 之间")
	public String getZy() {
		return zy;
	}

	public void setZy(String zy) {
		this.zy = zy;
	}
	
	@Length(min=0, max=200, message="何时由何地迁来本市县长度必须介于 0 和 200 之间")
	public String getBsx() {
		return bsx;
	}

	public void setBsx(String bsx) {
		this.bsx = bsx;
	}
	
	@Length(min=0, max=200, message="何时由何地迁来本址长度必须介于 0 和 200 之间")
	public String getBzz() {
		return bzz;
	}

	public void setBzz(String bzz) {
		this.bzz = bzz;
	}
	
	@Length(min=1, max=50, message="身份证件类型长度必须介于 1 和 50 之间")
	public String getSfzjlx() {
		return sfzjlx;
	}

	public void setSfzjlx(String sfzjlx) {
		this.sfzjlx = sfzjlx;
	}
	
	@Length(min=0, max=50, message="签发机关长度必须介于 0 和 50 之间")
	public String getQfjg() {
		return qfjg;
	}

	public void setQfjg(String qfjg) {
		this.qfjg = qfjg;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOvertime() {
		return overtime;
	}

	public void setOvertime(Date overtime) {
		this.overtime = overtime;
	}
	private String xz;
	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}
	private String xslx;//报名登记页面（学生类型）

	public String getXslx() {
		return xslx;
	}

	public void setXslx(String xslx) {
		this.xslx = xslx;
	}
}