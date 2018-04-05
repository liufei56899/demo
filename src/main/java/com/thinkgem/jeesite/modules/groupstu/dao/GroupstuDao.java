/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.groupstu.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.groupstu.entity.Groupstu;

/**
 * 学生小组信息DAO接口
 * @author lf
 * @version 2018-03-23
 */
@MyBatisDao
public interface GroupstuDao extends CrudDao<Groupstu> {
	
}