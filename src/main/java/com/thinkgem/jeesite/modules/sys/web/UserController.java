/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.school.entity.Schoolinfo;
import com.thinkgem.jeesite.modules.school.service.SchoolinfoService;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.UserExpor;
import com.thinkgem.jeesite.modules.sys.service.DictService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 用户Controller
 * 
 * @author ThinkGem
 * @version 2013-8-29
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/user")
public class UserController extends BaseController {

	@Autowired
	private SystemService systemService;	
	@Autowired
	private SchoolinfoService schoolinfoService;

	@Autowired
	private DictService dictService;
	@Autowired
	private UserDao userDao;
	@ModelAttribute
	public User get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			System.out.println(systemService.findUserById(id).getRemarks());
			return systemService.findUserById(id);
		} else {
			return new User();
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = { "getSysUserUi", "getSysUserUi" })
	public String getSysUserUi(@RequestParam("id") String id) {
		User entity = null;
		Map m = new HashMap();
		if (StringUtils.isNotBlank(id)) {
			entity = systemService.getUser(id);
			m.put("mobile", entity.getMobile());
			m.put("phone", entity.getPhone());
			// m.put("psword", entity.getPassword());
			m.put("name", entity.getName());
			m.put("xb", entity.getXbm());
			m.put("gwzym", entity.getGwzym());
			m.put("email", entity.getEmail());
			m.put("loginFlag", entity.getLoginFlag());

		}
		return JsonMapper.toJsonString(m);
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "index" })
	public String index(User user, Model model) {
		return "modules/sys/userIndex";
	}
	
	
	/**
	 * Des:通讯录
	 * 2016-11-28
	 * @author fn
	 * @param user
	 * @param model
	 * @return
	 * String
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "tongXuLuIndex" })
	public String tongXuLu(User user, Model model)
	{
		return "modules/sys/userTXLIndex";
	}
	
	/**
	 * Des:通讯录人员信息
	 * 2016-11-28
	 * @author fn
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * String
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "tongXunLuList", "" })
	public String tongXunLuList(User user, HttpServletRequest request,
			HttpServletResponse response, Model model)
	{
		Page<User> page = systemService.findUser(new Page<User>(request,
				response), user);
		for (int i = 0; i < page.getList().size(); i++) {
			String id = page.getList().get(i).getId();
			List<Role> roles = systemService.getRoleByUserId(id);
			page.getList().get(i).setRoleList(roles);
			String value = page.getList().get(i).getGwzym();
			String gwzym = dictService.getGwzyByValue(value);
			page.getList().get(i).setGwzym(gwzym);
		}
		User loginUser = UserUtils.getUser();
		model.addAttribute("page", page);
		model.addAttribute("loginUser", loginUser);
		return "modules/sys/tongXunLuList";
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "list", "" })
	public String list(User user, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<User> page = systemService.findUser(new Page<User>(request,
				response), user);
		for (int i = 0; i < page.getList().size(); i++) {
			String id = page.getList().get(i).getId();
			List<Role> roles = systemService.getRoleByUserId(id);
			page.getList().get(i).setRoleList(roles);
			String value = page.getList().get(i).getGwzym();
			String gwzym = dictService.getGwzyByValue(value);
			page.getList().get(i).setGwzym(gwzym);
		}
		User loginUser = UserUtils.getUser();
		model.addAttribute("page", page);
		model.addAttribute("loginUser", loginUser);
		return "modules/sys/userList";
	}

	@ResponseBody
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "listData" })
	public Page<User> listData(User user, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<User> page = systemService.findUser(new Page<User>(request,
				response), user);
		return page;
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "form")
	public String form(User user, Model model) {
		if (user.getCompany() == null || user.getCompany().getId() == null) {
			user.setCompany(UserUtils.getUser().getCompany());
		}
		if (user.getOffice() == null || user.getOffice().getId() == null) {
			//查询用户编码规则，并生成新账号
			String xxyhbm=schoolinfoService.findList(new Schoolinfo()).get(0).getXxyhbm();
			user.setRemarks(xxyhbm);
			User u=systemService.getNewLoginName(user);
			String newLoginName;
			if(u==null){
				newLoginName=xxyhbm+"000";
			}else{
				newLoginName=Integer.parseInt(u.getLoginName())+1+"";
			}
			user.setLoginName(newLoginName);
			user.setRemarks("");
			user.setOffice(UserUtils.getUser().getOffice());
		}
		model.addAttribute("user", user);
		model.addAttribute("allRoles", systemService.findAllRole());
		return "modules/sys/userForm";
	}

	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "save")
	public String save(User user, HttpServletRequest request, Model model,
			RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/user/list?repage";
		}
		// 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
		user.setCompany(new Office("1"));
		user.setOffice(new Office(request.getParameter("office.id")));
		// 如果新密码为空，则不更换密码
		if (StringUtils.isNotBlank(user.getNewPassword())) {
			user.setPassword(SystemService.entryptPassword(user
					.getNewPassword()));
		}
		if (!beanValidator(model, user)) {
			return form(user, model);
		}
		if (!"true".equals(checkLoginName(user.getOldLoginName(),
				user.getLoginName()))) {
			addMessage(model, "保存用户'" + user.getLoginName() + "'失败，登录名已存在");
			return form(user, model);
		}
		// 角色数据有效性验证，过滤不在授权内的角色
		List<Role> roleList = Lists.newArrayList();
		List<String> roleIdList = user.getRoleIdList();
		for (Role r : systemService.findAllRole()) {
			if (roleIdList.contains(r.getId())) {
				roleList.add(r);
			}
		}
		user.setRoleList(roleList);
		// 保存用户信息
		systemService.saveUser(user);
		// 清除当前用户缓存
		if (user.getLoginName().equals(UserUtils.getUser().getLoginName())) {
			UserUtils.clearCache();
			// UserUtils.getCacheMap().clear();
		}
		addMessage(redirectAttributes, "保存用户'" + user.getLoginName() + "'成功");
		return "redirect:" + adminPath + "/sys/user/list?repage";
	}

	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "delete")
	public String delete(User user, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/user/list?repage";
		}
		if (UserUtils.getUser().getId().equals(user.getId())) {
			addMessage(redirectAttributes, "删除用户失败, 不允许删除当前用户");
		} else if (User.isAdmin(user.getId())) {
			addMessage(redirectAttributes, "删除用户失败, 不允许删除超级管理员用户");
		} else {
			systemService.deleteUser(user);
			addMessage(redirectAttributes, "删除用户成功");
		}
		return "redirect:" + adminPath + "/sys/user/list?repage";
	}

	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "deletes")
	public String deletes(String ids, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/user/list?repage";
		}
		String[] idArr = ids.split(",");
		for (String id : idArr) {
			User user = this.get(id);
			if (UserUtils.getUser().getId().equals(user.getId())) {
				addMessage(redirectAttributes, "删除用户失败, 不允许删除当前用户");
			} else if (User.isAdmin(user.getId())) {
				addMessage(redirectAttributes, "删除用户失败, 不允许删除超级管理员用户");
			} else {
				systemService.deleteUser(user);
				addMessage(redirectAttributes, "删除用户成功");
			}
		}
		addMessage(redirectAttributes, "删除用户成功");
		return "redirect:" + Global.getAdminPath() + "/sys/user/list?repage";
	}

	/**
	 * 导出用户数据
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(User user, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户数据" + DateUtils.getDate("yyyyMMddHHmmss")
					+ ".xlsx";
			Page<User> page = systemService.findUser(new Page<User>(request,
					response, -1), user);
			new ExportExcel("用户数据", UserExpor.class).setDataList(page.getList())
					.write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/sys/user/list?repage";
	}

	/**
	 * 导入用户数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file,
			RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/user/list?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<User> list = ei.getDataList(User.class);
			for (User user : list) {
				try {
					if ("true".equals(checkLoginName("", user.getLoginName()))) {
						user.setPassword(SystemService
								.entryptPassword("123456"));
						BeanValidators.validateWithException(validator, user);
						systemService.saveUser(user);
						successNum++;
					} else {
						failureMsg.append("<br/>登录名 " + user.getLoginName()
								+ " 已存在; ");
						failureNum++;
					}
				} catch (ConstraintViolationException ex) {
					failureMsg.append("<br/>登录名 " + user.getLoginName()
							+ " 导入失败：");
					List<String> messageList = BeanValidators
							.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList) {
						failureMsg.append(message + "; ");
						failureNum++;
					}
				} catch (Exception ex) {
					failureMsg.append("<br/>登录名 " + user.getLoginName()
							+ " 导入失败：" + ex.getMessage());
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条用户，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条用户"
					+ failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/sys/user/list?repage";
	}

	/**
	 * 下载导入用户数据模板
	 * 
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户数据导入模板.xlsx";
			List<User> list = Lists.newArrayList();
			list.add(UserUtils.getUser());
			new ExportExcel("用户数据", User.class, 2).setDataList(list)
					.write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/sys/user/list?repage";
	}

	/**
	 * 验证登录名是否有效
	 * 
	 * @param oldLoginName
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "checkLoginName")
	public String checkLoginName(String oldLoginName, String loginName) {
		if (loginName != null && loginName.equals(oldLoginName)) {
			return "true";
		} else if (loginName != null
				&& systemService.getUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}

	/**
	 * 用户信息显示及保存
	 * 
	 * @param user
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "info")
	public String info(User user, HttpServletResponse response, Model model) {
		User currentUser = UserUtils.getUser();
		if (StringUtils.isNotBlank(user.getName())) {
			if (Global.isDemoMode()) {
				model.addAttribute("message", "演示模式，不允许操作！");
				return "modules/sys/userInfo";
			}
			currentUser.setEmail(user.getEmail());
			currentUser.setPhone(user.getPhone());
			currentUser.setMobile(user.getMobile());
			currentUser.setRemarks(user.getRemarks());
			currentUser.setPhoto(user.getPhoto());
			systemService.updateUserInfo(currentUser);
			model.addAttribute("message", "保存用户信息成功");
		}
		model.addAttribute("user", currentUser);
		model.addAttribute("Global", new Global());
		return "modules/sys/userInfo";
	}

	@RequestMapping(value = "mainpage")
	public String mainpage(HttpServletResponse response, Model model) {
		User user = UserUtils.getUser().getCurrentUser();
		String userType = user.getUserType();
		System.out.println("用户类型：" + userType);
		if (userType.equals("2") || userType.equals("1")) {
			return "modules/sys/mainPageLg";
		} else {
			return "modules/sys/mainPage";
		}
	}

	/**
	 * 返回用户信息
	 * 
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "infoData")
	public User infoData() {
		return UserUtils.getUser();
	}

	/**
	 * 修改个人用户密码
	 * 
	 * @param oldPassword
	 * @param newPassword
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "modifyPwd")
	public String modifyPwd(String oldPassword, String newPassword, Model model) {
		User user = UserUtils.getUser();
		if (StringUtils.isNotBlank(oldPassword)
				&& StringUtils.isNotBlank(newPassword)) {
			if (Global.isDemoMode()) {
				model.addAttribute("message", "演示模式，不允许操作！");
				return "modules/sys/userModifyPwd";
			}
			if (SystemService.validatePassword(oldPassword, user.getPassword())) {
				systemService.updatePasswordById(user.getId(),
						user.getLoginName(), newPassword);
				model.addAttribute("message", "修改密码成功");
			} else {
				model.addAttribute("message", "修改密码失败，旧密码错误");
			}
		}
		model.addAttribute("user", user);
		return "modules/sys/userModifyPwd";
	}
//=================================
	@RequiresPermissions("user")
	@RequestMapping(value = "modifyPwdnew")
	public String modifyPwdnew(String oldPassword, String newPassword, Model model) {
		User user = UserUtils.getUser();
		if (StringUtils.isNotBlank(oldPassword)
				&& StringUtils.isNotBlank(newPassword)) {
			
			if (SystemService.validatePassword(oldPassword, user.getPassword())) {
				systemService.updatePasswordById(user.getId(),
						user.getLoginName(), newPassword);
				user.setCount(2);
				userDao.update(user);
				model.addAttribute("message", "修改密码成功");
				return "modules/sys/sysIndex";//密码修改成功后跳转主页
			} else {
				model.addAttribute("message", "修改密码失败，旧密码错误");
			}
		}
		model.addAttribute("user", user);
		return "modules/sys/userModifyPwdnew";
	}
	//-------------------------------------------------------------------------------------
	
	
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(
			@RequestParam(required = false) String officeId,
			HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<User> list = systemService.findUserByOfficeId(officeId);
		for (int i = 0; i < list.size(); i++) {
			User e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", "u_" + e.getId());
			map.put("pId", officeId);
			map.put("name", StringUtils.replace(e.getName(), " ", ""));
			mapList.add(map);
		}
		return mapList;
	}

	// 获取用户列表
	@ResponseBody
	@RequestMapping(value = "findUserByOfficeId")
	public List<User> findSysUserByOfficeId(String officeId) {
		return systemService.findSysUserByOfficeId(officeId);
	}

	/*
	 * 获取当前登录用户信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = "getUserDefault", method = RequestMethod.GET)
	public String getUserDefault(HttpServletRequest request,HttpServletResponse response,
			RedirectAttributes redirectAttributes, Model model) {
		User user = UserUtils.getUser();

		String id = user.getId();
		List<Role> roles = systemService.getRoleByUserId(id);
		String roleName = "";
		for (int i = 0; i < roles.size(); i++) {
			roleName += "[" + roles.get(i).getName() + "]";
		}
		String value = user.getGwzym();
		String gwzym = dictService.getGwzyByValue(value);
		String path= request.getRealPath("/");
		String imagePath =  user.getPhoto();
		path = path.substring(0,path.lastIndexOf("\\"));
		path = path.substring(0,path.lastIndexOf("\\")); 
		//System.out.println(path+"========================"+imagePath);
		File f = new File(path+""+imagePath);
		//System.out.println("-----------------------------------------------"+f.getPath());
		Map m = new HashMap();
		m.put("username", user.getName());
		m.put("photo", user.getPhoto());
		m.put("officename", user.getOffice().getName());
		m.put("roleName", roleName);
		m.put("gwzym", gwzym);
        if(f.exists()){
        	m.put("boo", true);
		}else{
			m.put("boo", false);
		}
		return JsonMapper.toJsonString(m);
	}
	
	
	/**
	 * Des:判断当前用户是否具有审核功能
	 * 2016-10-28
	 * @author fn
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @param model
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findUserByJdId", method = RequestMethod.GET)
	public String findUserByJdId(HttpServletRequest request,
			HttpServletResponse response,
			RedirectAttributes redirectAttributes, Model model)
	{
		User user = UserUtils.getUser();
		List<User> list = systemService.findUserByJdId(user);
		Map<String,Object> map = new HashMap<String, Object>();
		if(list!=null && list.size()>0){
			map.put("istrue", true);
		}else{
			map.put("istrue", false);
		}
		return JsonMapper.toJsonString(map);
	} 

}
