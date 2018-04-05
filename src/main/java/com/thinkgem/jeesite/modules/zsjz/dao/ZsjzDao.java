/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjz.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zsjz.entity.Zsjz;

/**
 * 招生简章DAO接口
 * @author xfb
 * @version 2016-09-23
 */
@MyBatisDao
public interface ZsjzDao extends CrudDao<Zsjz> {
	
}