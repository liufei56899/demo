/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.classroom.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.classroom.entity.Classroom;

/**
 * 教室信息管理DAO接口
 * @author zh
 * @version 2018-02-07
 */
@MyBatisDao
public interface ClassroomDao extends CrudDao<Classroom> {
	public int count(String classroomid);
	public List<Map<String, Object>>findBjJbxx(String njid);
	public BjJbxx getBjJbxx(String classroomid);
	public void emptyClassroomId(String classroomid);
}