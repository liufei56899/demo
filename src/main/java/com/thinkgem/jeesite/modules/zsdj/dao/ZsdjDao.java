/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsdj.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 招生登记DAO接口
 * 
 * @author lg
 * @version 2016-05-05
 */
@MyBatisDao
public interface ZsdjDao extends CrudDao<Zsdj> {

	Zsdj getZsdjBySfzh(Zsdj zsdj);

	List<Zsdj> getZsdjList(String jhid);
	List<Zsdj> getZsdjListByCreate(String jsid);
	public List<Zsdj> findZsdjBySfzh(Zsdj zsdj);

    List <Map>getBySchool(String zsnd);//查询生源校
    List <Map>getBySchools(Map zsndmap);//查询生源校
    List <Map> getSchoolByZYMC(Zsdj zsdj);//根据学校查询专业名称
    List <Map> getSchoolByDATE(Zsdj zsdj);//<!-- 年度间生源校分布情况 -->
    List <Map> getSchoolAndZY(Map zsndmap);//根据年度查询所有生源校和专业
    
    
}