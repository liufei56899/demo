/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.userui.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.userui.entity.SysUserUi;
import com.thinkgem.jeesite.modules.userui.dao.SysUserUiDao;

/**
 * 终端用户Service
 * 
 * @author XFB
 * @version 2016-09-29
 */
@Service
@Transactional(readOnly = true)
public class SysUserUiService extends CrudService<SysUserUiDao, SysUserUi> {


	public SysUserUi get(String id) {
		return super.get(id);
	}

	public List<SysUserUi> findList(SysUserUi sysUserUi) {
		return super.findList(sysUserUi);
	}

	public Page<SysUserUi> findPage(Page<SysUserUi> page, SysUserUi sysUserUi) {
		return super.findPage(page, sysUserUi);
	}

	@Transactional(readOnly = false)
	public void save(SysUserUi sysUserUi) {
		super.save(sysUserUi);
	}

	@Transactional(readOnly = false)
	public void delete(SysUserUi sysUserUi) {
		super.delete(sysUserUi);
	}

	public List<SysUserUi> findListByOfficeId(String id) {
		return dao.findListByOfficeId(id);
	}
}