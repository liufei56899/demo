/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;

/**
 * 计划分解任务DAO接口
 * @author lg
 * @version 2016-05-20
 */
@MyBatisDao
public interface JhFjRwDao extends CrudDao<JhFjRw> {
	/**
	 * 根据计划分解id查询计划分解任务
	 * @param id
	 * @return
	 */
	public List<JhFjRw> getJhFjRwByJhFjId(JhFjRw jhFjRw);
	
	/**
	 * 根据计划分解编号删除计划分解任务
	 * @param jhFjId
	 */
	public void deleteJhFjRw(String jhFjId);
}