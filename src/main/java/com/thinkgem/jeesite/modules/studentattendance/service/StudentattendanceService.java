/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.studentattendance.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.studentattendance.entity.Studentattendance;
import com.thinkgem.jeesite.modules.studentattendance.dao.StudentattendanceDao;

/**
 * 学生考勤信息Service
 * @author lf
 * @version 2018-03-25
 */
@Service
@Transactional(readOnly = true)
public class StudentattendanceService extends CrudService<StudentattendanceDao, Studentattendance> {

	public Studentattendance get(String id) {
		return super.get(id);
	}
	
	public List<Studentattendance> findList(Studentattendance studentattendance) {
		return super.findList(studentattendance);
	}
	
	public Page<Studentattendance> findPage(Page<Studentattendance> page, Studentattendance studentattendance) {
		return super.findPage(page, studentattendance);
	}
	
	@Transactional(readOnly = false)
	public void save(Studentattendance studentattendance) {
		super.save(studentattendance);
	}
	
	@Transactional(readOnly = false)
	public void delete(Studentattendance studentattendance) {
		super.delete(studentattendance);
	}
	
}