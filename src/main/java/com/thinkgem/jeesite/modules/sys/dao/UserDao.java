/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
/**
 * 
 * 类名：UserDao
 * 功能：
 * 详细：
 * 作者：fn
 * 版本：1.0
 * 日期：2016-10-28 上午11:20:10
 *
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {
	
	/**
	 * 根据登录名称查询用户
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(User user);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 * @param user
	 * @return
	 */
	public List<User> findUserByOfficeId(User user);
	
	public List<User> findSysUserByOfficeId(String officeId);
	/**
	 * 查询全部教师
	 * @return
	 */
	public List<JsJbxx> findAllUser();
	/**
	 * 查询全部用户数目
	 * @return
	 */
	public long findAllCount(User user);
	
	/**
	 * 更新用户密码
	 * @param user
	 * @return
	 */
	public int updatePasswordById(User user);
	
	/**
	 * 更新登录信息，如：登录IP、登录时间
	 * @param user
	 * @return
	 */
	public int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 * @param user
	 * @return
	 */
	public int deleteUserRole(User user);
	
	/**
	 * 插入用户角色关联数据
	 * @param user
	 * @return
	 */
	public int insertUserRole(User user);
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	public int updateUserInfo(User user);
	
	/**
	 * 根据编号查询用户
	 * @param id
	 * @return
	 */
	public User getUserById(String id);
	

	/**
	 * Des:根据用户id查询是否有审核节点
	 * 2016-10-28
	 * @author fn
	 * @param user
	 * @return
	 * List<User>
	 */
	public List<User> findUserByJdId(User user);
	/**
	 * 根据数据库中用户编号，查询并生成账号
	 * @return String
	 */
	public User getNewLoginName(User user);

}
