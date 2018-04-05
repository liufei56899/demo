/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.um.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户菜单关系Entity
 * @author lg
 * @version 2016-08-01
 */
public class SysUserMenu extends DataEntity<SysUserMenu> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户编号
	private String menuId;		// 菜单编号
	
	public SysUserMenu() {
		super();
	}

	public SysUserMenu(String id){
		super(id);
	}

	@NotNull(message="用户编号不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=64, message="菜单编号长度必须介于 1 和 64 之间")
	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
}