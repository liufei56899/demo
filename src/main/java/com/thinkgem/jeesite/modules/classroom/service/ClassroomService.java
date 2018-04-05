/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.classroom.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.classroom.entity.Classroom;
import com.thinkgem.jeesite.modules.classroom.dao.ClassroomDao;

/**
 * 教室信息管理Service
 * @author zh
 * @version 2018-02-07
 */
@Service
@Transactional(readOnly = false)
public class ClassroomService extends CrudService<ClassroomDao, Classroom> {
	@Autowired
    private ClassroomDao classroomdao;
	public Classroom get(String id) {
		return super.get(id);
	}
	
	public List<Classroom> findList(Classroom classroom) {
		return super.findList(classroom);
	}
	
	public Page<Classroom> findPage(Page<Classroom> page, Classroom classroom) {
		return super.findPage(page, classroom);
	}
	
	@Transactional(readOnly = false)
	public void save(Classroom classroom) {
		super.save(classroom);
	}
	
	@Transactional(readOnly = false)
	public void delete(Classroom classroom) {
		super.delete(classroom);
	}
	public int count(String classroomid){
		return classroomdao.count(classroomid);
	}
	public List<Map<String, Object>>findBjJbxx(String njid){
		return classroomdao.findBjJbxx(njid);
	}
	public BjJbxx getBjJbxx(String classroomid){
		return classroomdao.getBjJbxx(classroomid);
	}
	public void emptyClassroomId(String classroomid){
		classroomdao.emptyClassroomId(classroomid);
	}
}