/**
 * Copyright &copy; 2012-2013 <a href="httparamMap://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sun.org.apache.bcel.internal.generic.NEW;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.sys.dao.LogDao;
import com.thinkgem.jeesite.modules.sys.entity.Log;

/**
 * 日志Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class LogService extends CrudService<LogDao, Log> {

	public Page<Log> findPage(Page<Log> page, Log log) {
		
		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null){
			//log.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));//当前月的第一天
			//log.setBeginDate(DateUtils.parseDate(DateUtils.getDate()));//当前时间
			log.setBeginDate(DateUtils.addDays(DateUtils.parseDate(DateUtils.getDate()), -1));
		}
		
		if (log.getEndDate() == null){
			log.setEndDate(DateUtils.addDays(log.getBeginDate(), 2));
			/*System.out.println("结束时间====="+log.getEndDate());
			System.out.println("开始时间====="+log.getBeginDate());
			System.out.println("当天时间====="+DateUtils.parseDate(DateUtils.getDate()));
			System.out.println(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));*/
		}
		
		return super.findPage(page, log);
		
	}
	
}
