/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course.entity.Course;

/**
 * 学校课程代码表DAO接口
 * @author 赵辉
 * @version 2018-02-05
 */
@MyBatisDao
public interface CourseDao extends CrudDao<Course> {
	public List<Course> selectCourse(String zyid);
	public int countCourseName(String courseName);
}