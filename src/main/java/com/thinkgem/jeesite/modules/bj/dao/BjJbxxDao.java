/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bj.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;

/**
 * 班级信息DAO接口
 * @author zw
 * @version 2016-05-18
 */
@MyBatisDao
public interface BjJbxxDao extends CrudDao<BjJbxx> {
	public List<BjJbxx> findBjJbxxList(BjJbxx bjJbxx);
	public List<BjJbxx> findBjList(BjJbxx bjJbxx);
	public List<XnJbxx> findAll();
	public List<BjJbxx> findAllBJ(XnJbxx xnJbxx);
}