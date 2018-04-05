/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ksjh.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.kcbh.entity.KcJbxx;
import com.thinkgem.jeesite.modules.ksjh.entity.Ksjh;

/**
 * 考试计划DAO接口
 * @author cpf
 * @version 2018-03-16
 */
@MyBatisDao
public interface KsjhDao extends CrudDao<Ksjh> {
	
	/**
	 * 根据考试计划id查询考场信息
	 * @return 返回考场信息对象集合
	 */
	List<KcJbxx> findClassroom(String id);
	
	List<BjJbxx> findBjJbxx();
	
}