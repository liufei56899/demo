/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjh.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.statistics.entity.Statistics;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 计划招生DAO接口
 * 
 * @author zw
 * @version 2016-04-25
 */
@MyBatisDao
public interface ZsjhDao extends CrudDao<Zsjh> {

	List<Zsjh> findZsjhByPnsId(Zsjh zsjh2);

	// 根据创建时间排序
	List<Zsjh> findAllListByCreateDate(Zsjh zsjh);

	//查询正在使用的招生计划
	Zsjh findUseZsjh();
	//修改招生计划是否启用
	int updateUsed(Zsjh zsjh);
	
	int getTeacherNum(String jhid);
	//查找所有招生年度
	List<Map> findAllZsnd();
	//统计招生总体完成情况
	List<Map> statAll(String zsnd);
	//统计部门招生完成情况
	List<Map> statBMAll(String zsnd);
	//招生总完成情况分类统计--个人
	List<Map> statRYPart(String zsnd);
	//招生总完成情况分类统计--部门
	List<Map> statBMPart(String zsnd);	
	//排行榜--个人
	List<Statistics> paiHangGRByZsjhAndBm(@Param("jhid")String jhid,@Param("bmid")String bmid);
	//排行榜--部门
	List<Statistics> paiHangBMByZsjh(@Param("jhid")String jhid);
	
	//根据启用/停用查询招生计划
	List<Zsjh> findListByUsed(Zsjh zsjh);
	//查询某个用户关联的招生计划
	List<Zsjh> findListByUserId(Zsjh zsjh);
	
	//查询未过期 审核通过的招生计划
	List<Zsjh> findZsjhListByUserId(Zsjh zsjh);
	
	//审核通过并招生计划未结束
	List<Zsjh> findListZsjh(Zsjh zsjh);
	
	//验证计划名称是否存在
	public List<Zsjh> findAllListZsjh(Zsjh zsjh);
	
	public List<Zsjh> getZsjhList(Zsjh zsjh);

}