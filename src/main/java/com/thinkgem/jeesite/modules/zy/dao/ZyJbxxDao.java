/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zy.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.entity.ZytjJbxx;

/**
 * 专业DAO接口
 * @author zw
 * @version 2016-04-25
 */
@MyBatisDao
public interface ZyJbxxDao extends CrudDao<ZyJbxx> {
	public ZyJbxx getValueByName(String name);
	
	public List<ZyJbxx> findZyJbList(ZyJbxx zyJbxx);
	
	
	
	
	//年度专业统计
	public List<ZytjJbxx> findNdzytjList(ZytjJbxx zyJbxx);
	public List<ZytjJbxx> findAllZy(ZytjJbxx zyJbxx);
	public List<ZytjJbxx> findNdzytjzysByid(ZytjJbxx zyJbxx);
	public List<ZytjJbxx> findNdzytjListByid(ZytjJbxx zyJbxx);
}