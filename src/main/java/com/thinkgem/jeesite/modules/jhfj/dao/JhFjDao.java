/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;

/**
 * 计划分解DAO接口
 * @author lg
 * @version 2016-05-20
 */
@MyBatisDao
public interface JhFjDao extends CrudDao<JhFj> {
	/**
	 * 获取最新的一条计划分解
	 * @return
	 */
	public JhFj getLastJhFj(JhFj jhFj);
	/**
	 * 根据编号删除计划分解任务
	 * @param id
	 */
	public void deleteJhFj(String id);
}