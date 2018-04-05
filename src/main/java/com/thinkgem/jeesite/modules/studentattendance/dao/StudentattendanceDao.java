/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.studentattendance.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.studentattendance.entity.Studentattendance;

/**
 * 学生考勤信息DAO接口
 * @author lf
 * @version 2018-03-25
 */
@MyBatisDao
public interface StudentattendanceDao extends CrudDao<Studentattendance> {
	public Studentattendance getGroupStu(String temp);
}