/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.sys.dao.AreaDao;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 区域Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {

	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	/**
	 * 查询所有省 通过type=2
	 * @param area
	 * @return
	 */
	public List<Area> findAllP(Area area){
		return dao.findAllP(area);
	}
	
	/**
	 * 通过父id 查询所有子类
	 * @param area
	 * @return
	 */
	public List<Area> findAllByChr(Area area){
		return dao.findAllByChr(area);
	}
 
	public String findByAll(Area area){
		return  dao.findByAll(area);
	}
	
	public String findByAllWC(Area area){
		return  dao.findByAllWC(area);
	}
	
	//遍历所有区域（不包括id是0和1的所有数据）
	public List<Area> findByAllList(){
		return dao.findByAllList();
	}
	
	//页面首次加载时页面的总招生任务数
		public List<Map> findByAllZSRS(JhFjGrRw jhFjGrRw){
			return dao.findByAllZSRS(jhFjGrRw);
		}
		//根据区域ID找区域类型
		public String findByType(String id){
			return dao.findByType(id);
		}
		
		public 	List <Map> findByAREA(Map aMap){
			return dao.findByAREA(aMap);
		}
		//导出
		public 	List <Map> expFindByAREA(Map aMap){
			return dao.expFindByAREA(aMap);
		}
}
