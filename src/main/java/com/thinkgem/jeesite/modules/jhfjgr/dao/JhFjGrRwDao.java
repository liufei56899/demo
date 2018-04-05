/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;

/**
 * 计划分解个人任务明细DAO接口
 * @author lg
 * @version 2016-05-26
 */
@MyBatisDao
public interface JhFjGrRwDao extends CrudDao<JhFjGrRw> {
	/**
	 * 根据计划分解id查询计划分解任务
	 * @param id
	 * @return
	 */
	public List<JhFjGrRw> getJhFjGrRwByJhFjId(JhFjGrRw jhFjGrRw);
	
	/**
	 * 根据计划分解编号删除计划分解任务
	 * @param jhFjId
	 */
	public void deleteJhFjGrRw(String jhFjId);
}