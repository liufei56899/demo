/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsdj.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.dao.ZsdjDao;

/**
 * 招生登记Service
 * @author lg
 * @version 2016-05-05
 */
@Service
@Transactional(readOnly = true)
public class ZsdjService extends CrudService<ZsdjDao, Zsdj> {

	public Zsdj get(String id) {
		return super.get(id);
	}
	
	public List<Zsdj> findList(Zsdj zsdj) {
		return super.findList(zsdj);
	}
	
	public Page<Zsdj> findPage(Page<Zsdj> page, Zsdj zsdj) {
		return super.findPage(page, zsdj);
	}
	
	@Transactional(readOnly = false)
	public void save(Zsdj zsdj) {
		super.save(zsdj);
	}
	
	@Transactional(readOnly = false)
	public void delete(Zsdj zsdj) {
		super.delete(zsdj);
	}

	public Zsdj getZsdjBySfzh(Zsdj zsdj) {
		return dao.getZsdjBySfzh(zsdj);
	}
	
	public List<Zsdj> findZsdjBySfzh(Zsdj zsdj)
	{
		return dao.findZsdjBySfzh(zsdj);
	}
	
	
	public List<Zsdj> getZsdjList(String jhid){
		return dao.getZsdjList(jhid);
	}
	
	public List<Zsdj> getZsdjListByCreate(String jsid){
		return dao.getZsdjListByCreate(jsid);
	}
	
	public List<Map> getBySchool(String zsnd){
		return dao.getBySchool(zsnd);
	}//查询生源校
	public List<Map> getBySchools(Map zsndmap){
		return dao.getBySchools(zsndmap);
	}//查询生源校
	
	public List <Map> getSchoolByZYMC(Zsdj zsdj){
		return dao.getSchoolByZYMC(zsdj);//根据学校查询专业名称
	}
	public  List <Map> getSchoolByDATE(Zsdj zsdj){
		return dao.getSchoolByDATE(zsdj);//<!-- 年度间生源校分布情况 -->
	}
	public  List <Map> getSchoolAndZY(Map zsndmap){
		return dao.getSchoolAndZY(zsndmap);//根据年度查询所有生源校和专业
	}
	
}