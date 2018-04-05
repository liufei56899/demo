package com.thinkgem.jeesite.modules.course.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course.entity.CourseZy;

/**
 * 学校课程代码表DAO接口
 * @author 赵辉
 * @version 2018-02-05
 */
@MyBatisDao
public interface CourseZyDao{
	public List<CourseZy> findList(String courseid);
	public void insert(CourseZy courseZy);
	public void delete(String courseid);
}
