/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zylx.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.syxx.entity.SyJbxx;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
import com.thinkgem.jeesite.modules.zylx.dao.ZylxJbxxDao;

/**
 * 专业类别Service
 * 
 * @author zw
 * @version 2016-04-25
 */
@Service
@Transactional(readOnly = true)
public class ZylxJbxxService extends CrudService<ZylxJbxxDao, ZylxJbxx> {

	public ZylxJbxx get(String id) {
		return super.get(id);
	}

	public List<ZylxJbxx> findList(ZylxJbxx zylxJbxx) {
		return super.findList(zylxJbxx);
	}

	public Page<ZylxJbxx> findPage(Page<ZylxJbxx> page, ZylxJbxx zylxJbxx) {
		return super.findPage(page, zylxJbxx);
	}

	@Transactional(readOnly = false)
	public void save(ZylxJbxx zylxJbxx) {
		super.save(zylxJbxx);
	}

	@Transactional(readOnly = false)
	public void delete(ZylxJbxx zylxJbxx) {
		super.delete(zylxJbxx);
	}

	@Transactional(readOnly = false)
	public String getZhuanYeById(String id) {
		return dao.getZhuanYeById(id);
	}
	
	public List<ZylxJbxx> findZylxList(ZylxJbxx zylxJbxx)
	{
		return dao.findZylxList(zylxJbxx);
	}

}