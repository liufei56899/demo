package com.thinkgem.jeesite.modules.course.entity;

import java.util.Date;
import com.thinkgem.jeesite.common.persistence.DataEntity;
/**
 * 学校课程代码表Entity
 * @author 赵辉
 * @version 2018-02-05
 */
public class CourseZy extends DataEntity<CourseZy> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String courseid;	// 课程编号
	private String zylxid;		// 专业类型编号
	private String zyid;		// 开始时间
	private String remarks;		// 备注	
	private String createperson;// 创建人
	private Date createdate;	// 创建时间
	private String updateperson;// 创建人
	private Date updatedate;	// 创建时间
	public String getCourseid() {
		return courseid;
	}
	public void setCourseid(String courseid) {
		this.courseid = courseid;
	}
	public String getZylxid() {
		return zylxid;
	}
	public void setZylxid(String zylxid) {
		this.zylxid = zylxid;
	}
	public String getZyid() {
		return zyid;
	}
	public void setZyid(String zyid) {
		this.zyid = zyid;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getCreateperson() {
		return createperson;
	}
	public void setCreateperson(String createperson) {
		this.createperson = createperson;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getUpdateperson() {
		return updateperson;
	}
	public void setUpdateperson(String updateperson) {
		this.updateperson = updateperson;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
}
