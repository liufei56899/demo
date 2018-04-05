/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xjxx.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;

/**
 * 年级信息DAO接口
 * @author st
 * @version 2016-09-27
 */
@MyBatisDao
public interface XnJbxxDao extends CrudDao<XnJbxx> {
	
	public List<XnJbxx> findXnList(XnJbxx xnJbxx);
	
	public List<XnJbxx> findListByXn(XnJbxx xnJbxx);
	
}