/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdg.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jxdg.entity.JxDg;

/**
 * 教学大纲DAO接口
 * @author zx
 * @version 2018-03-01
 */
@MyBatisDao
public interface JxDgDao extends CrudDao<JxDg> {
	public List<Map> fingZyByCourseId(String id);
	public JxDg findjxdgByCourseXnxq(JxDg jxdg);
	
}