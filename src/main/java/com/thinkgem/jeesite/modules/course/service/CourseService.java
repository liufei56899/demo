/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.course.entity.Course;
import com.thinkgem.jeesite.modules.course.dao.CourseDao;

/**
 * 学校课程代码表Service
 * @author 赵辉
 * @version 2018-02-05
 */
@Service
@Transactional(readOnly = true)
public class CourseService extends CrudService<CourseDao, Course> {
	@Autowired
    private CourseDao courseDao;
	public Course get(String id) {
		return super.get(id);
	}
	
	public List<Course> findList(Course course) {
		return super.findList(course);
	}
	
	public Page<Course> findPage(Page<Course> page, Course course) {
		return super.findPage(page, course);
	}
	
	@Transactional(readOnly = false)
	public void save(Course course) {
		super.save(course);
	}
	
	@Transactional(readOnly = false)
	public void delete(Course course) {
		super.delete(course);
	}
	public List<Course> selectCourse(String zyid){
		return (List<Course>) courseDao.selectCourse(zyid);
	}
	public int countCourseName(String courseName){
		return courseDao.countCourseName(courseName);
	}
}