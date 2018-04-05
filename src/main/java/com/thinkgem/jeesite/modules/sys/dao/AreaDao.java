/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 区域DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {

	List<Area> findAllP(Area area);

	List<Area> findAllByChr(Area area);
	
	String findByAll(Area area);
	
	String findByAllWC(Area area);
	
	//遍历所有区域
	List<Area> findByAllList();
	
	List<Area> findBySF();
	
	List<Map> findByAllZSRS(JhFjGrRw jhFjGrRw);
	
	String findByType(String id);
	
	List <Map> findByAREA(Map aMap);
	
	List <Map> expFindByAREA(Map aMap);
}
