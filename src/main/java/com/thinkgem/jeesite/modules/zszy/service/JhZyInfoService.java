/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zszy.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;
import com.thinkgem.jeesite.modules.zszy.dao.JhZyInfoDao;

/**
 * 招生计划专业人数记录Service
 * @author zw
 * @version 2016-05-13
 */
@Service
@Transactional(readOnly = true)
public class JhZyInfoService extends CrudService<JhZyInfoDao, JhZyInfo> {

	public JhZyInfo get(String id) {
		return super.get(id);
	}
	
	public List<JhZyInfo> findList(JhZyInfo jhZyInfo) {
		return super.findList(jhZyInfo);
	}
	
	public Page<JhZyInfo> findPage(Page<JhZyInfo> page, JhZyInfo jhZyInfo) {
		return super.findPage(page, jhZyInfo);
	} 
	
	/**
	 * 通过专业计划id 查询所有记录
	 * @param jhZyInfo
	 * @return
	 */
	public List<JhZyInfo> findListByJhId(JhZyInfo jhZyInfo){
		
		return dao.findListByJhId(jhZyInfo);
	}
	public List<JhZyInfo> findZyListByJhId(JhZyInfo jhZyInfo){
		return dao.findZyListByJhId(jhZyInfo);
	}
	public List<JhZyInfo> findZylxListByJhId(JhZyInfo jhZyInfo){
		return dao.findZylxListByJhId(jhZyInfo);
	}
	public void delByJhId(JhZyInfo jhZyInfo){
		 dao.delByJhId(jhZyInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(JhZyInfo jhZyInfo) {
		super.save(jhZyInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhZyInfo jhZyInfo) {
		super.delete(jhZyInfo);
	}
	
}