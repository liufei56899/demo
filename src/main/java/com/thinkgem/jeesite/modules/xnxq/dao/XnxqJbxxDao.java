/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xnxq.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;

/**
 * 学年学期DAO接口
 * @author st
 * @version 2016-09-22
 */
@MyBatisDao
public interface XnxqJbxxDao extends CrudDao<XnxqJbxx> {
	
	public List<XnxqJbxx> findXnxqList(XnxqJbxx xnxqJbxx);
	public List<XnxqJbxx> getxnxx();
	
	public List<XnxqJbxx> findXnxq();
	public List<XnxqJbxx> getAll();
}