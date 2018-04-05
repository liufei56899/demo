/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;

/**
 * 学生信息DAO接口
 * 
 * @author st
 * @version 2016-05-23
 */
@MyBatisDao
public interface XsJbxxDao extends CrudDao<XsJbxx> {
	// 获取班级集合
	List<BjJbxx> findBanJiList(XsJbxx xsJbxx);

	// 获取已分班人数
	List<XsJbxx> getBanJiNum(XsJbxx xsJbxx);
	//根据身份证件号获取学生信息
	public List<XsJbxx> selectXjList(XsJbxx xsJbxx);

	// 修改审核状态
	public void updateShzt(XsJbxx xsJbxx);

	// 修改学生学籍（招生信息）
	public void updateZsxx(XsJbxx xsJbxx);

	// 修改学生学籍（新生信息）
	public void updateXsxx(XsJbxx xsJbxx);

	// 各专业招生情况统计
	public List<XsJbxx> zytjList(String jhid);

	// 各专业来源情况统计
	public List<XsJbxx> lytjList(String jhid);

	// 各区域情况统计
	public List<XsJbxx> qytjList(String jhid, String csid);

	public String getZuiXinJhId();// 获取最新的招生计划

	
	
	// 招生部门/个人 统计
	public List<XsJbxx> zstjGrList(String adminUser,String adminUser1);

	// 当前登录用户所在部门的成员招生记录
	public Zsdj zstjBmcyList(Zsdj zsdj);

	// 部门招生情况
	public List<Zsdj> zstjgzyList(Zsdj zsdj);

	// 部门招生任务/招生登记 招生情况
	public List<Zsdj> zstjgbmDbList(Zsdj zsdj);
	
	//部门分解到个人 招生情况
	public List<Zsdj> zstjBmgrList(Zsdj zsdj);

	public List<XsJbxx> zstjRoleList(String role);

	// 根据班级获取学生信息
	public List<XsJbxx> findXueShengListByBj(XsJbxx xsJbxx);

	// 修改班级名称
	public void updateBanJi(Map<String, Object> map);

	// 获取个人招生信息
	public XsJbxx getGeRenXinXi(String userId);
	
	//批量提交
	public void updateXjShzt(Map<String, Object> map);
	
	// 获取学年学期下的学生信息
	List<XsJbxx> getStudent(XsJbxx xsJbxx);
}