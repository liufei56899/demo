/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kjcdsz.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 快捷菜单设置Entity
 * @author st
 * @version 2016-07-26
 */
public class SysMenu extends DataEntity<SysMenu> {
	
	private static final long serialVersionUID = 1L;
	private SysMenu parent;		// 父级编号
	private String parentIds;		// 所有父级编号
	private String name;		// 名称
	private String sort;		// 排序
	private String href;		// 链接
	private String target;		// 目标
	private String icon;		// 图标
	private String isShow;		// 是否在菜单中显示
	private String permission;		// 权限标识
	private String iskjmenu;		// 是否快捷菜单
	private String userId;
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public SysMenu() {
		super();
	}

	public SysMenu(String id){
		super(id);
	}

	@JsonBackReference
	@NotNull(message="父级编号不能为空")
	public SysMenu getParent() {
		return parent;
	}

	public void setParent(SysMenu parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=2000, message="所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=1, max=2000, message="链接长度必须介于 1 和 2000 之间")
	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}
	
	@Length(min=1, max=20, message="目标长度必须介于 1 和 20 之间")
	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}
	
	@Length(min=0, max=100, message="图标长度必须介于 0 和 100 之间")
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	@Length(min=1, max=1, message="是否在菜单中显示长度必须介于 1 和 1 之间")
	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}
	
	@Length(min=0, max=200, message="权限标识长度必须介于 0 和 200 之间")
	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}
	
	@Length(min=0, max=2, message="是否快捷菜单长度必须介于 0 和 2 之间")
	public String getIskjmenu() {
		return iskjmenu;
	}

	public void setIskjmenu(String iskjmenu) {
		this.iskjmenu = iskjmenu;
	}
	
}