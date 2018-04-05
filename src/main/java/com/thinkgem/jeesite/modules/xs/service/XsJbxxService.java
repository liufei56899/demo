/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.xs.dao.XsJbxxDao;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;

/**
 * 学生信息Service
 * 
 * @author st
 * @version 2016-05-23
 */
@Service
@Transactional(readOnly = true)
public class XsJbxxService extends CrudService<XsJbxxDao, XsJbxx> {

	public XsJbxx get(String id) {
		return super.get(id);
	}

	public List<XsJbxx> findList(XsJbxx xsJbxx) {
		return super.findList(xsJbxx);
	}

	public Page<XsJbxx> findPage(Page<XsJbxx> page, XsJbxx xsJbxx) {
		return super.findPage(page, xsJbxx);
	}

	@Transactional(readOnly = false)
	public void save(XsJbxx xsJbxx) {
		super.save(xsJbxx);
	}

	@Transactional(readOnly = false)
	public void delete(XsJbxx xsJbxx) {
		super.delete(xsJbxx);
	}

	/**
	 * Des:获取班级集合 2016-5-23
	 * 
	 * @author st
	 * @return List<BjJbxx>
	 */
	public List<BjJbxx> findBanJiList(XsJbxx xsJbxx) {
		return dao.findBanJiList(xsJbxx);
	}

	/**
	 * Des:获取已分班人数 2016-5-23
	 * 
	 * @author st
	 * @param xsJbxx
	 * @return List<XsJbxx>
	 */
	public List<XsJbxx> getBanJiNum(XsJbxx xsJbxx) {
		return dao.getBanJiNum(xsJbxx);
	}
	
	//根据身份证件号获取学生信息
	public List<XsJbxx> selectXjList(XsJbxx xsJbxx){
		return dao.selectXjList(xsJbxx);
	}

	@Transactional(readOnly = false)
	public void updateShzt(XsJbxx xsJbxx) {
		dao.updateShzt(xsJbxx);
	}

	/**
	 * 招生信息
	 * 
	 * @param xsJbxx
	 */
	@Transactional(readOnly = false)
	public void updateZsxx(XsJbxx xsJbxx) {
		dao.updateZsxx(xsJbxx);
	}

	/**
	 * 新生信息
	 * 
	 * @param xsJbxx
	 */
	@Transactional(readOnly = false)
	public void updateXsxx(XsJbxx xsJbxx) {
		dao.updateXsxx(xsJbxx);
	}

	/**
	 * 各专业招生情况统计
	 * 
	 * @param jhid
	 * @return
	 */
	public List<XsJbxx> zytjList(String jhid) {
		return dao.zytjList(jhid);
	}

	/**
	 * 各专业来源情况统计
	 * 
	 * @param jhid
	 * @return
	 */
	public List<XsJbxx> lytjList(String jhid) {
		return dao.lytjList(jhid);
	}

	public List<XsJbxx> qytjList(String jhid, String csid) {
		return dao.qytjList(jhid, csid);
	}

	public String getZuiXinJhId() {
		return dao.getZuiXinJhId();
	}
	public List<XsJbxx> zstjGrList(String adminUser,String adminUser1) {
		return dao.zstjGrList(adminUser,adminUser1);
	}
	public Zsdj zstjBmcyList(Zsdj zsdj) {
		return dao.zstjBmcyList(zsdj);
	}

	public List<Zsdj> zstjgzyList(Zsdj zsdj) {
		return dao.zstjgzyList(zsdj);
	}

	public List<Zsdj> zstjgbmDbList(Zsdj zsdj) {
		return dao.zstjgbmDbList(zsdj);
	}
	
	public List<Zsdj> zstjBmgrList(Zsdj zsdj)
	{
		return dao.zstjBmgrList(zsdj);
	}

	public List<XsJbxx> zstjRoleList(String role) {
		return dao.zstjRoleList(role);
	}

	public List<XsJbxx> findXueShengListByBj(XsJbxx xsJbxx) {
		return dao.findXueShengListByBj(xsJbxx);
	}

	@Transactional(readOnly = false)
	public void updateBanJi(Map<String, Object> map) {
		dao.updateBanJi(map);
	}

	public XsJbxx getGeRenXinXi(String userId) {
		return dao.getGeRenXinXi(userId);
	}
	
	//批量提交
	@Transactional(readOnly = false)
	public void updateXjShzt(Map<String, Object> map){
		dao.updateXjShzt(map);
	}
	// 获取学年学期下的学生信息
	public  List<XsJbxx> getStudent(XsJbxx xsJbxx){
		return dao.getStudent(xsJbxx);
	}
}