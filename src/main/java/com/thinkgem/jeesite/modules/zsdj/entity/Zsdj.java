/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsdj.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 招生登记Entity
 * 
 * @author lg
 * @version 2016-05-05
 */
public class Zsdj extends DataEntity<Zsdj> {

	private static final long serialVersionUID = 1L;
	private Zsjh zsjh; // 计划名称
	private String xm; // 学生姓名
	private String xbm; // 性别
	private String ly; // 来源
	private JsJbxx js; // 老师姓名
	private Office office; // 部门名称
	private String sfzjh; // 身份证号
	private ZyJbxx zy; // 专业名称
	private String zylxId;	// 专业id
	private ZylxJbxx zylx; // 专业类别
	private String jtzz; // 家庭住址
	private String lxdh; // 联系电话
	private String sfSy; // 是否是生源 0：否；1：是
	private XnJbxx nj;//年级
	private XnxqJbxx xnxq;//学年学期
	private String xz; //学制
	private String nation; //民族
	private String sfzjlx; //身份证类型
	private Date csrq; //出生日期
	private String zsdjzt;//招生登记状态
	
	private String xbname; //性别1

	private String nationNmae; //民族名称
	private String zjlxName; //组织类型名称

	private String zymc;// ====Excel-专业名称======
	private String lxmc;// ====Excel-类型名称======

	private String name;// 增加字段(教师姓名)
	private int rwl; // 任务量
	private int zsl; // 招生量
	private int bml; // 报名量
	private String officeId;//部门id\
    private String jhId;//计划id
    private String sf;//省份
    private String cs;//城市
    private String qx;//区县
    private String jd;//街道
    private String sfName;//省份名称
    private String csName;//城市名称
    private String qxName;//区县名称
    private String jdName;//街道名称
    
    private Date start;//查询的开始时间（临时）
    private Date end;//查询的结束时间（临时）
    
    
    private String zsnd;//临时使用
    private String checkType;//复选框类型
    private String zsdjztname;//招生登记状态名称
    private Date createDate;//创建时间
    private String xslym; //学生来源（应往届）
    private String zkzh; //准考证号
    private String remarks; //备注
    private String fromSchool;//生源校（毕业学校）
    private String jzName; //家长姓名
    private String jzNumber; //家长电话
    private String xslx;  //学生类型：1：初中专；2：高中专；3：五年制大专；4：高考单招；5：成人大专；
    private String stuNumber; //学生编号-打印
    private String bj;//班级名称
    private String bkcc;//报考层次
    private String  yyxykszsdj ;      //音乐学院考试证书等级
    private String  yyxukszscj ;      //考试证书成绩1.优秀2.良好。3合格
    private String  isyyjb     ;      //是否愿意兼报0否 1.是
    private String  jbzylxid  ;//兼报专业类型ID
    private String  jbzylxnm ;//兼报专业类型名称
    private String  jbzyid     ;      //兼报专业id
    private String  jbzynm  ;//兼报专业名称
    
    private String jbxz;  //简报学制
    private String  isdszcks   ;      //是否特殊政策考生0.否1.是
    private String  xxdate1    ;      //学习时间段1
    private String  jdxy1      ;      //就读学校1
    private String  xxdate2    ;      //学习时间2
    private String  jdxy2      ;      //就读学校2
    private String  xxdate3    ;      //学习时间3
    private String  jdxy3      ;      //就读学校3
    private String  jcqk        ;//奖惩情况
    private String  photo  ;//照片
    private String qfjg;		// 签发机关
	private Date starttime;		// 身份证件起始时间
	private Date overtime;		// 身份证件结束时间
    
	
	public String getJbzylxnm() {
		return jbzylxnm;
	}

	public void setJbzylxnm(String jbzylxnm) {
		this.jbzylxnm = jbzylxnm;
	}

	public String getJbzynm() {
		return jbzynm;
	}

	public void setJbzynm(String jbzynm) {
		this.jbzynm = jbzynm;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getOvertime() {
		return overtime;
	}

	public void setOvertime(Date overtime) {
		this.overtime = overtime;
	}

	public String getQfjg() {
		return qfjg;
	}

	public void setQfjg(String qfjg) {
		this.qfjg = qfjg;
	}

	public String getZylxId() {
		return zylxId;
	}

	public void setZylxId(String zylxId) {
		this.zylxId = zylxId;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
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

	public String getJbzylxid() {
		return jbzylxid;
	}

	public void setJbzylxid(String jbzylxid) {
		this.jbzylxid = jbzylxid;
	}

	public String getJbzyid() {
		return jbzyid;
	}

	public void setJbzyid(String jbzyid) {
		this.jbzyid = jbzyid;
	}

	public String getJbxz() {
		return jbxz;
	}

	public void setJbxz(String jbxz) {
		this.jbxz = jbxz;
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

	public String getJcqk() {
		return jcqk;
	}

	public void setJcqk(String jcqk) {
		this.jcqk = jcqk;
	}

	@ExcelField(title = "班级名称", align = 2, sort = 5)
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

	public String getXslx() {
		return xslx;
	}

	public void setXslx(String xslx) {
		this.xslx = xslx;
	}

	
	public String getJzName() {
		return jzName;
	}

	public void setJzName(String jzName) {
		this.jzName = jzName;
	}
	

	public String getJzNumber() {
		return jzNumber;
	}

	public void setJzNumber(String jzNumber) {
		this.jzNumber = jzNumber;
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

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getZsdjztname() {
		return zsdjztname;
	}

	public void setZsdjztname(String zsdjztname) {
		this.zsdjztname = zsdjztname;
	}

	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
	}

	public String getJdName() {
		return jdName;
	}

	public void setJdName(String jdName) {
		this.jdName = jdName;
	}

	
	
	public String getZsnd() {
		return zsnd;
	}

	public void setZsnd(String zsnd) {
		this.zsnd = zsnd;
	}

	public String getSfName() {
		return sfName;
	}

	public void setSfName(String sfName) {
		this.sfName = sfName;
	}

	public String getCsName() {
		return csName;
	}

	public void setCsName(String csName) {
		this.csName = csName;
	}

	public String getQxName() {
		return qxName;
	}

	public void setQxName(String qxName) {
		this.qxName = qxName;
	}
	
	@Length(min = 0, max = 255, message = "家庭住址长度必须介于 0 和 255 之间")
	@ExcelField(title = "生源校", align = 2, sort = 85)
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

	public String getJhId() {
		return jhId;
	}

	public void setJhId(String jhId) {
		this.jhId = jhId;
	}

	public String getOfficeId() {
		return officeId;
	}

	public void setOfficeId(String officeId) {
		this.officeId = officeId;
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

	public String getZjlxName() {
		return zjlxName;
	}

	public void setZjlxName(String zjlxName) {
		this.zjlxName = zjlxName;
	}

	public String getXbname() {
		return xbname;
	}

	public void setXbname(String xbname) {
		this.xbname = xbname;
	}
	
	
	public String getNationNmae() {
		return nationNmae;
	}

	public void setNationNmae(String nationNmae) {
		this.nationNmae = nationNmae;
	}
	
	public String getZsdjzt() {
		return zsdjzt;
	}

	public void setZsdjzt(String zsdjzt) {
		this.zsdjzt = zsdjzt;
	}
	
	@Length(min = 1, max = 64, message = "民族长度必须介于 2 和 20之间")
	@ExcelField(title = "民族", align = 2, sort = 80, dictType = "nation")
	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getSfzjlx() {
		return sfzjlx;
	}

	public void setSfzjlx(String sfzjlx) {
		this.sfzjlx = sfzjlx;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="出生日期不能为空")
	public Date getCsrq() {
		return csrq;
	}

	public void setCsrq(Date csrq) {
		this.csrq = csrq;
	}

	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String bcfs;

	public String getBcfs() {
		return bcfs;
	}

	public void setBcfs(String bcfs) {
		this.bcfs = bcfs;
	}

	@ExcelField(title = "专业名称", align = 2, sort = 40)
	public String getZymc() {
		return zymc;
	}

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}

	@ExcelField(title = "类型名称", align = 2, sort = 35)
	public String getLxmc() {
		return lxmc;
	}

	public void setLxmc(String lxmc) {
		this.lxmc = lxmc;
	}

	public Zsdj() {
		super();
	}

	public Zsdj(String id) {
		super(id);
	}

	@NotNull(message = "计划名称不能为空")
	public Zsjh getZsjh() {
		return zsjh;
	}

	public void setZsjh(Zsjh zsjh) {
		this.zsjh = zsjh;
	}

	@Length(min = 1, max = 64, message = "学生姓名长度必须介于 1 和 64 之间")
	@ExcelField(title = "学生姓名", align = 2, sort = 10)
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

	@Length(min = 0, max = 1, message = "来源长度必须介于 0 和 1 之间")
	public String getLy() {
		return ly;
	}

	public void setLy(String ly) {
		this.ly = ly;
	}

	@NotNull(message = "老师姓名不能为空")
	public JsJbxx getJs() {
		return js;
	}

	public void setJs(JsJbxx js) {
		this.js = js;
	}

	@NotNull(message = "部门名称不能为空")
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	@Length(min = 1, max = 18, message = "身份证号长度必须介于 1 和 18 之间")
	@ExcelField(title = "身份证号", align = 2, sort = 30)
	public String getSfzjh() {
		return sfzjh;
	}

	public void setSfzjh(String sfzjh) {
		this.sfzjh = sfzjh;
	}

	@NotNull(message = "专业名称不能为空")
	public ZyJbxx getZy() {
		return zy;
	}

	public void setZy(ZyJbxx zy) {
		this.zy = zy;
	}
	public ZylxJbxx getZylx() {
		return zylx;
	}

	public void setZylx(ZylxJbxx zylx) {
		this.zylx = zylx;
	}

	@Length(min = 0, max = 255, message = "家庭住址长度必须介于 1 和 255 之间")
	@ExcelField(title = "家庭住址", align = 2, sort = 50)
	public String getJtzz() {
		return jtzz;
	}

	public void setJtzz(String jtzz) {
		this.jtzz = jtzz;
	}

	@Length(min = 0, max = 32, message = "联系电话长度必须介于 1 和 32 之间")
	@ExcelField(title = "联系电话", align = 2, sort = 60)
	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	@Length(min = 0, max = 1, message = "是否是生源  0：否；1：是长度必须介于 0 和 1 之间")
	public String getSfSy() {
		return sfSy;
	}

	public void setSfSy(String sfSy) {
		this.sfSy = sfSy;
	}

	public XnJbxx getNj() {
		return nj;
	}

	public void setNj(XnJbxx nj) {
		this.nj = nj;
	}

	public XnxqJbxx getXnxq() {
		return xnxq;
	}

	public void setXnxq(XnxqJbxx xnxq) {
		this.xnxq = xnxq;
	}
	
	
	

}