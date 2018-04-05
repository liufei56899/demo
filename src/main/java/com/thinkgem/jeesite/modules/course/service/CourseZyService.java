package com.thinkgem.jeesite.modules.course.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.modules.course.dao.CourseZyDao;
import com.thinkgem.jeesite.modules.course.entity.CourseZy;
/**
 * 学校课程代码表Service
 * @author 赵辉
 * @version 2018-02-05
 */
@Service
public class CourseZyService {
	@Autowired
    private CourseZyDao coursezyDao;
	public List<CourseZy> findList(String courseid){
		return coursezyDao.findList(courseid);
	}
	public void insert(CourseZy courseZy){
		coursezyDao.insert(courseZy);
	}
	public void delete(String courseid){
		coursezyDao.delete(courseid);
	}
}
