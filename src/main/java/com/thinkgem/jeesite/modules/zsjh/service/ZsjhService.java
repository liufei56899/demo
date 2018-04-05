/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjh.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.statistics.entity.Statistics;
import com.thinkgem.jeesite.modules.zsjh.dao.ZsjhDao;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zszy.dao.JhZyInfoDao;
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;

/**
 * 计划招生Service
 * 
 * @author zw
 * @version 2016-04-25
 */
@Service
@Transactional(readOnly = true)
public class ZsjhService extends CrudService<ZsjhDao, Zsjh> {

	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private JhZyInfoDao jhZyInfoDao;

	public Zsjh get(String id) {
		return super.get(id);
	}

	public List<Zsjh> findList(Zsjh zsjh) {
		return super.findList(zsjh);
	}
	public List<Zsjh> getZsjhList(Zsjh zsjh){
		return dao.getZsjhList(zsjh);
	}
	
	//验证计划名称是否存在
	public	List<Zsjh> findAllListZsjh(Zsjh zsjh)
	{
		return dao.findAllListZsjh(zsjh);
	}

	public Page<Zsjh> findPage(Page<Zsjh> page, Zsjh zsjh) {
		return super.findPage(page, zsjh);
	}

	/**
	 * 流程开启，提交
	 * 
	 * @param zsjh
	 * @return
	 */
	@Transactional(readOnly = false)
	public String saveProcess(Zsjh zsjh) {
		String result = "";
		if (zsjh != null) 
		{
			zsjh = saveZsjh(zsjh);
			String statu = zsjh.getBcStatus();// 状态
			if (statu == "1" || statu.equals("1")) 
			{
				zsjh.setZt("0");
				result = "保存计划招生成功";
			} 
			else if (statu == "2" || statu.equals("2")) 
			{
				zsjh.setZt("1");
				result = "提交计划招生成功";
			}
			save(zsjh);
		}
		return result;
	}
	
	@Transactional(readOnly = false)
	public String saveJh(Zsjh zsjh)
	{
		
		String result = "";
		if (zsjh != null) 
		{
			zsjh = saveZsjh(zsjh);
			String statu = zsjh.getBcStatus();// 状态
			if (statu == "1" || statu.equals("1")) 
			{
				zsjh.setZt("0");
				result = "1";
			} 
			else if (statu == "2" || statu.equals("2")) 
			{
				zsjh.setZt("1");
				result = "2";
			}
			save(zsjh);
		}
		return result;
	}

	@Transactional(readOnly = false)
	public Zsjh saveZsjh(Zsjh zsjh) {
		try {
			if (zsjh.getId() != null && !zsjh.getId().equals("")) 
			{
				zsjh.preUpdate();
				dao.update(zsjh);
			} else {
				zsjh.preInsert();
				dao.insert(zsjh);
			}
//			super.save(zsjh);
			if (zsjh.getJhZyInfos() != null && zsjh.getJhZyInfos().size() > 0) 
			{
				JhZyInfo info = new JhZyInfo();
				info.setZsjhId(zsjh);
				jhZyInfoDao.delByJhId(info);
				for (JhZyInfo bm : zsjh.getJhZyInfos()) {
					if (bm.getZylxId() != null) {
						bm.preInsert();
						bm.setZsjhId(zsjh);
						jhZyInfoDao.insert(bm);
					}
				}
			}
		} catch (Exception e) {
			return zsjh;
		}
		return zsjh;
	}

	@Transactional(readOnly = false)
	public void delete(Zsjh zsjh) {
		super.delete(zsjh);
	}

	@Transactional(readOnly = false)
	public String reNew(Zsjh zsjh) {
		String result = "";
		String content = "同意";
		if (zsjh.getSpnr() != null && !zsjh.getSpnr().equals("")) {
			content = zsjh.getSpnr();
		}
		Map<String, Object> vars = Maps.newHashMap();
		// String taskDefKey = zsjh.getAct().getTaskDefKey();
		if (zsjh.getAct().getTaskDefKey().equals("jh_commit")) {
			vars.put("pass", 2);
			zsjh.setZt("1");
			content = "";
			result = "提交计划招生成功";
		} else if (zsjh.getAct().getTaskDefKey().equals("jh_approve")) {
			if (zsjh.getAct().getFlag().equals("yes")) {
				vars.put("pass", 2);
				zsjh.setZt("2");
			} else {
				vars.put("pass", 1);
				zsjh.setZt("3");
			}
			result = "审核计划招生成功";
		}

		actTaskService.complete(zsjh.getAct().getTaskId(), zsjh.getAct()
				.getProcInsId(), content, zsjh.getJhmc(), vars);
		return result;
	}

	public List<Zsjh> findZsjhByPnsId(Zsjh zsjh2) {
		return dao.findZsjhByPnsId(zsjh2);
	}
	
	/**
	 * 正在使用的招生计划
	 * 
	 * @return
	 */
	public Zsjh findUseZsjh() {
		return dao.findUseZsjh();
	}

	@Transactional(readOnly = false)
	public int updateUsed(Zsjh zsjh) {
		return dao.updateUsed(zsjh);
	}
	
	public int getTeacherNum(String jsid){
		return dao.getTeacherNum(jsid);
	}	
	//查找所有招生年度
	public List<Map> findAllZsnd(){
		return dao.findAllZsnd();
	}	
	//统计招生总体完成情况
	public List<Map> statAll(String zsnd){
		return dao.statAll(zsnd);
	}	
	//统计部门招生完成情况
	public List<Map> statBMAll(String zsnd){
		return dao.statBMAll(zsnd);
	}	
	//招生总完成情况分类统计--个人
	public List<Map> statRYPart(String zsnd){
		return dao.statRYPart(zsnd);
	}	
	//招生总完成情况分类统计--部门
	public List<Map> statBMPart(String zsnd){
		return dao.statBMPart(zsnd);
	}	
	//排行榜--个人
	public List<Statistics> paiHangGRByZsjhAndBm(String jhid,String bmid){
		return dao.paiHangGRByZsjhAndBm(jhid,bmid);
	}
	//排行榜--部门
	public List<Statistics> paiHangBMByZsjh(String jhid){
		return dao.paiHangBMByZsjh(jhid);
	}

}