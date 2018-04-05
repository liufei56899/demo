/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
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
import com.thinkgem.jeesite.common.utils.CommonUtils;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.ExcelUtil;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.UploadUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.bj.service.BjJbxxService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRwService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrService;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.statistics.entity.Statistics;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxxRecord;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxRecordService;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxService;
import com.thinkgem.jeesite.modules.xsbd.entity.BdJbxx;
import com.thinkgem.jeesite.modules.xsbd.service.BdJbxxService;
import com.thinkgem.jeesite.modules.xsfb.service.XsfbService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.service.ZsdjService;
import com.thinkgem.jeesite.modules.zsjh.dao.ZsjhDao;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 学生信息Controller
 * 
 * @author st
 * @version 2016-05-23
 */
@Controller
@RequestMapping(value = "${adminPath}/xs/xsJbxx")
public class XsJbxxController extends BaseController {
	@Autowired
	private AreaService areaService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private XsJbxxService xsJbxxService;
	@Autowired
	private BjJbxxService bjJbxxService;
	@Autowired
	private ZyJbxxService zyJbxxService;
	@Autowired
	private XsJbxxRecordService xsJbxxRecordService;
	// xsfbService
	@Autowired
	private XsfbService xsfbService;
	@Autowired
	private JhFjGrRwService jhFjGrRwService;
	@Autowired
	private JhFjGrService jhFjGrService;
	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private ZsdjService zsdjService;
	@Autowired
	private BdJbxxService bdJbxxService;
	private POIFSFileSystem fs;
	private HSSFWorkbook wb;
	private HSSFSheet sheet;
	private HSSFRow row;

	private static ZsjhDao zsjhDao = SpringContextHolder.getBean(ZsjhDao.class);

	@ModelAttribute
	public XsJbxx get(@RequestParam(required = false) String id) {
		XsJbxx entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = xsJbxxService.get(id);
		}
		if (entity == null) {
			entity = new XsJbxx();
		}
		return entity;
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "list", "" })
	public String list(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// 当前用户操作
		if (xsJbxx == null) {
			xsJbxx = new XsJbxx();
		}
		User user = UserUtils.getUser();
		List<Role> roleList = user.getRoleList();
		Role userRole = this.getUserRole(roleList);
		if (userRole != null) {
			user.setRole(userRole);
			if (xsJbxx.getBjmc() != null && xsJbxx.getBjmc().getId() != null
					&& !xsJbxx.getBjmc().getId().equals("")) {
				xsJbxx.getBjmc().setJsId(user);
			} else {
				BjJbxx bj = new BjJbxx();
				bj.setJsId(user);
				xsJbxx.setBjmc(bj);
			}
		}
		xsJbxx.setBgydlxlszt("9");//状态为9则查询变更异动状态不等于1(变更异动审核中)的数据
		// xsJbxx.setCreateBy(user);
		Page<XsJbxx> page = xsJbxxService.findPage(new Page<XsJbxx>(request,
				response), xsJbxx);
		model.addAttribute("page", page);
		model.addAttribute("bj", xsJbxx);
		return "modules/xs/xsJbxxList";
	}
	
	
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "xsbgydlist", "" })
	public String xsbgydlist(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		xsJbxx.setBgydlxlszt("1");// 用于判断学生信息变更临时状态为1（审核中）时，新生学籍核查页面查询不到状态为1的信息
		//xsJbxx.setBgydlx("2");
		Page<XsJbxx> page = xsJbxxService.findPage(new Page<XsJbxx>(request,
				response), xsJbxx);
		/*BjJbxx bjJbxx = new BjJbxx();
		bjJbxx.setNjid(xsJbxx.getNj());
		List<BjJbxx> list = bjJbxxService.findList(bjJbxx);
		model.addAttribute("bjList", list);*/
		model.addAttribute("page", page);
		return "modules/xs/xsxxbgydshList";
	}
	
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "xsbgydshForm")
	public String xsbgydshForm(XsJbxx xsJbxx, Model model) {
		model.addAttribute("xsJbxx", xsJbxx);
		model.addAttribute("userName", UserUtils.getUser().getName());
		model.addAttribute("approveDate", new Date());
		return "modules/xs/xsbgydshForm";
	}
	
	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "savexsbgyd")
	public String savexsbgyd(XsJbxx xsJbxx, Model model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String bgydlx=xsJbxx.getBgydlx();
		UploadUtils upload = new UploadUtils();
		String sfzjh = xsJbxx.getSfzjh();
		if (xsJbxx.getFile()!=null) {
		try {
			String photo = upload.getImgName(sfzjh,request, xsJbxx.getFile().getInputStream());
			xsJbxx.setPhoto("/em/upload/images/"+photo);//保存图片路径
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		if (bgydlx!=null || !bgydlx.equals("")) {
			xsJbxx.setBgydlxzt("1");
			xsJbxxService.save(xsJbxx);
			addMessage(redirectAttributes, "变更学生信息成功");
			model.addAttribute("xsJbxx", xsJbxx);
		}
		return "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/list/?repage";
	}
	

	/**
	 * Des:获取当前用户角色 2016-6-1
	 * 
	 * @author st
	 * @param roleList
	 * @return Role
	 */
	private Role getUserRole(List<Role> roleList) {
		Role role = null;
		// 角色列表
		if (roleList != null && roleList.size() > 0) {
			for (Role roleUser : roleList) {
				// 系统管理员
				if (roleUser.getEnname().equals("dept")) {
					role = null;
					break;
				}
				// 招生办
				else if (roleUser.getEnname().equals("recruitStudentsOffice")) {
					role = null;
					break;
				}
				// 招生老师 js
				/*
				 * else if(roleUser.getEnname().equals("tech")) { role =
				 * roleUser; break; }
				 */
				// 角色
				else if (roleUser.getEnname().equals("js")) {
					role = roleUser;
					break;
				}
			}
		}
		return role;
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "xjIndex" })
	public String xjIndex(XsJbxx xsJbxx, Model model) {
		return "modules/xs/xjIndex";
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "xjList", "" })
	public String xjList(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		xsJbxx.setRemarks("3");// 用于判断审核状态为3（未提交）时，新生学籍核查页面查询不到状态为3的信息
		Page<XsJbxx> page = xsJbxxService.findPage(new Page<XsJbxx>(request,
				response), xsJbxx);
		BjJbxx bjJbxx = new BjJbxx();
		bjJbxx.setNjid(xsJbxx.getNj());
		List<BjJbxx> list = bjJbxxService.findList(bjJbxx);
		model.addAttribute("bjList", list);
		model.addAttribute("page", page);
		return "modules/xs/xjList";
	}
	
	// =============================================================================================================
	@ResponseBody
	@RequestMapping(value = "getBan")
	public String getBan(String id, String zy, String bj,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {

		Map m = new HashMap();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		BjJbxx jbxx = bjJbxxService.get(bj);
		for (ZyJbxx zyJbxx2 : zyJbxxs) {
			m.put("zymc", zyJbxx2.getZymc());
			m.put("zyfx", zyJbxx2.getZyfxmc());
			m.put("zyjc", zyJbxx2.getZyjc());
		}

		// m.put("html",zyJbxxs);
		m.put("jbxx", jbxx.getBjmc());
		return JsonMapper.toJsonString(m);

	}

	// =====================================================================

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "form")
	public String form(XsJbxx xsJbxx, Model model) {
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xs/xsJbxxForm";
	}
	
	/**
	 * 批量提交
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "piLiangTiJiao")
	public String piLiangTiJiao(String ids, RedirectAttributes redirectAttributes)
	{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("shzt", "0");//审核中状态
		List<String> idList = new ArrayList<String>();
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++)
		{
			idList.add(idArr[i]);
		}
		map.put("idList", idList);
		xsJbxxService.updateXjShzt(map);
		addMessage(redirectAttributes, "批量提交学生学籍信息成功");
		return "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/list/?repage";
	}

	/**
	 * Des:修改tab 2016-9-20
	 * 
	 * @author fn
	 * @param xsJbxx
	 * @param model
	 * @return String
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "xsUpdateTab")
	public String xsUpdateTab(XsJbxx xsJbxx, Model model) {
		model.addAttribute("id", xsJbxx.getId());
		return "modules/xs/xsJbxxUpTab";
	}

	//学籍增加拍照页面
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "getImage")
	public String getImage(XsJbxx xsJbxx, Model model) {
		model.addAttribute("id", xsJbxx.getId());
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xs/getImages";
	}
	/**
	 * Des:学生修改基本信息 2016-9-20
	 * 
	 * @author fn
	 * @param xsJbxx
	 * @param model
	 * @return String
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "xsUpdateJiBenForm")
	public String xsUpdateJiBenForm(XsJbxx xsJbxx, Model model) {
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xs/xsJbxxUpForm";
	}
	
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "getPic")
	public String getPic(XsJbxx xsJbxx, Model model) {
		model.addAttribute("id", xsJbxx.getId());
		model.addAttribute("xsJbxx", xsJbxx);
		//System.out.println(xsJbxx.getXm()+"=========="+xsJbxx.getSfzjh());
		return "modules/xs/getImage";
	}
	
	/**
	 * 学生信息变更异动
	 * @param xsJbxx
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "stuInfoUpdateStatus")
	public String stuInfoUpdateStatus(XsJbxx xsJbxx, Model model) {
		XsJbxx jbxx = xsJbxxService.get(xsJbxx.getId());
		model.addAttribute("xsJbxx",jbxx);
		return "modules/xs/stuInfoUpdateStatus";
	}

	
	/**
	 * Des:成员信息 2016-9-20
	 * 
	 * @author fn
	 * @param xsJbxx
	 * @param model
	 * @return String
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "xsUpdateChengYuanForm")
	public String xsUpdateChengYuanForm(XsJbxx xsJbxx, Model model) {
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xs/xsJbxxCyUpForm";
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "shForm")
	public String shForm(XsJbxx xsJbxx, Model model) {
		model.addAttribute("xsJbxx", xsJbxx);
		model.addAttribute("userName", UserUtils.getUser().getName());
		model.addAttribute("approveDate", new Date());
		return "modules/xs/shForm";
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "formXsJbxxHistory")
	public String formXsJbxxHistory(String id, Model model) {
		XsJbxxRecord xsJbxxRecord = xsJbxxRecordService.get(id);
		XsJbxx xsJbxx = xsJbxxService.get(xsJbxxRecord.getXsId());
		model.addAttribute("xsJbxx", xsJbxx);
		model.addAttribute("xsJbxxRecord", xsJbxxRecord);
		return "modules/xs/xsJbxxFormHistory";
	}

	/**
	 * Des:成员信息 2016-5-31
	 * 
	 * @author st
	 * @param xsJbxx
	 * @param model
	 * @return String
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "chengYuanInfo")
	public String chengYuanInfo(XsJbxx xsJbxx, Model model) {
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xs/chengYuanInfo";
	}

	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "save")
	public String save(XsJbxx xsJbxx, Model model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, xsJbxx)) {
			return form(xsJbxx, model);
		}
		UploadUtils upload = new UploadUtils();
		String sfzjh = xsJbxx.getSfzjh();
		if (xsJbxx.getFile()!=null) {
		try {
			String photo = upload.getImgName(sfzjh,request, xsJbxx.getFile().getInputStream());
			xsJbxx.setPhoto("/em/upload/images/"+photo);//保存图片路径
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	/*	UploadUtils upload = new UploadUtils();
		upload.setDirName("images");//设置文件类型，类型决定后缀名格式
		String[] path = upload.uploadFile(request);
		System.out.println(path+"================== "+path[4]);
        if(path!=null&&path.length>0){
        	xsJbxx.setPhoto(path[4]);
        }*/

}
		String zyjc1 = request.getParameter("zyId.zyjc");
		String zyfx1 = request.getParameter("zyId.zyfxmc");
		String sub = request.getParameter("sub");
//		 System.out.println(sub+"               .................===================");
		if (sub == null) {

			xsJbxx.setShzt("3");
			xsJbxx.setZyjc(zyjc1);
			xsJbxx.setZyfx(zyfx1);
			// System.out.println(jbx.getZyjc()+"      "+jbx.getZyfxmc());
			xsJbxxService.save(xsJbxx);
			addMessage(redirectAttributes, "保存学生信息成功");

		} else {
			if (sub.equals("1")) {

				xsJbxx.setShzt("3");
				xsJbxx.setZyjc(zyjc1);
				xsJbxx.setZyfx(zyfx1);
				xsJbxxService.save(xsJbxx);
				addMessage(redirectAttributes, "保存学生信息成功");
			} else if(sub.equals("4")){
				xsJbxx.setShzt("4");
				xsJbxx.setZyjc(zyjc1);
				xsJbxx.setZyfx(zyfx1);
				xsJbxxService.save(xsJbxx);
				addMessage(redirectAttributes, "保存学生信息成功");
			}else{
				xsJbxx.setShzt("0");
				xsJbxx.setZyjc(zyjc1);
				xsJbxx.setZyfx(zyfx1);
				xsJbxxService.save(xsJbxx);
				addMessage(redirectAttributes, "提交学生信息成功");
			}
		}
		return "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/list/?repage";
	}
	
	
	
	
	

	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(XsJbxx xsJbxx, RedirectAttributes redirectAttributes) {
		xsJbxxService.delete(xsJbxx);
		addMessage(redirectAttributes, "删除学生信息成功");
		return "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/list/?repage";
	}

	/*
	 * 批量删除
	 */
	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "deletes")
	public String deletes(String ids) {
		String[] idArr = ids.split(",");
		for (int i = 0; i < idArr.length; i++) {
			XsJbxx xsJbxx = xsJbxxService.get(idArr[i]);
			if (xsJbxx.getShzt().equals("3")) {
				xsJbxxService.delete(xsJbxx);
			}
		}

		return "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/list/?repage";
	}

	/**
	 * Des:异步获取班级集合 2016-5-23
	 * 
	 * @author st
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "getBanJiList")
	public String getBanJiList(XsJbxx xsJbxx, HttpServletResponse response) {
		List<BjJbxx> banJiList = xsJbxxService.findBanJiList(xsJbxx);
		return JsonMapper.toJsonString(banJiList);
	}

	/**
	 * Des:获取已分好的班级数量 2016-5-23
	 * 
	 * @author st
	 * @param xsJbxx
	 * @return String
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "getBanJiNum")
	public String getBanJiNum(XsJbxx xsJbxx) {
		Map map = new HashMap();
		List<XsJbxx> list = xsJbxxService.getBanJiNum(xsJbxx);
		map.put("bjNum", list.size());
		// map.put("bjNum", "100");
		return JsonMapper.toJsonString(map);
	}

	/**
	 * Des:保存分班情况 2016-5-23
	 * 
	 * @author st
	 * @param xsJbxx
	 * @param bjmc
	 * @param redirectAttributes
	 * @return String
	 */
	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "saveFenBan")
	public String saveFenBan(XsJbxx xsJbxx, String bjId,
			RedirectAttributes redirectAttributes) {
		BjJbxx bjJbxx = new BjJbxx();
		bjJbxx.setId(bjId);
		xsJbxx.setBjmc(bjJbxx);
		xsJbxxService.save(xsJbxx);
		addMessage(redirectAttributes, "分班成功");
		return "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/?repage";
	}

	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "updateShzt")
	public String updateShzt(XsJbxx xsJbxx, String ids) {
		String[] idArr = ids.split(",");
		for (int i = 0; i < idArr.length; i++) {
			XsJbxx xsJbxxEntity = new XsJbxx();
			xsJbxxEntity.setShzt("1");
			xsJbxxEntity.setId(idArr[i]);
			xsJbxxEntity.setApproveBy(xsJbxx.getApproveBy());
			xsJbxxEntity.setApproveDate(xsJbxx.getApproveDate());
			xsJbxxService.updateShzt(xsJbxxEntity);
		}
		return "redirect:" + Global.getAdminPath()
				+ "/xs/xsJbxx/xjList/?repage";
	}
	

	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "saveSh")
	public String saveSh(String id, String shzt, String spnr) {
		XsJbxx xsJbxx1 = xsJbxxService.get(id);
		User user = UserUtils.getUser();
		if (shzt.equals("2")) {// 审核不通过
			// 记录学生历史信息
			XsJbxxRecord xsJbxxRecord = new XsJbxxRecord();
			xsJbxxRecord.setXsId(xsJbxx1.getId());
			xsJbxxRecord.setXm(xsJbxx1.getXm());
			xsJbxxRecord.setXbm(xsJbxx1.getXbm());
			xsJbxxRecord.setCsrq(xsJbxx1.getCsrq());
			xsJbxxRecord.setSfzjlxm(xsJbxx1.getSfzjlxm());
			xsJbxxRecord.setSfzjh(xsJbxx1.getSfzjh());
			xsJbxxRecord.setXmpy(xsJbxx1.getXmpy());
			if (xsJbxx1.getBjmc() != null) {
				xsJbxxRecord.setBjmc(xsJbxx1.getBjmc());
			}
			xsJbxxRecord.setXh(xsJbxx1.getXh());
			xsJbxxRecord.setXslbm(xsJbxx1.getXslbm());
			xsJbxxRecord.setXxxsm(xsJbxx1.getXxxsm());
			xsJbxxRecord.setRxfsm(xsJbxx1.getRxfsm());
			xsJbxxRecord.setJdfsm(xsJbxx1.getJdfsm());
			xsJbxxRecord.setGjdqm(xsJbxx1.getGjdqm());
			xsJbxxRecord.setGatqwm(xsJbxx1.getGatqwm());
			xsJbxxRecord.setHyzkm(xsJbxx1.getHyzkm());
			xsJbxxRecord.setChcqj(xsJbxx1.getChcqj());
			xsJbxxRecord.setSfsqzn(xsJbxx1.getSfsqzn());
			xsJbxxRecord.setSydxzqhm(xsJbxx1.getSydxzqhm());
			xsJbxxRecord.setCsdxzqhm(xsJbxx1.getCsdxzqhm());
			xsJbxxRecord.setJgdxzqhm(xsJbxx1.getJgdxzqhm());
			xsJbxxRecord.setHkszdqxyxxxdz(xsJbxx1.getHkszdqxyxxxdz());
			xsJbxxRecord.setScpcs(xsJbxx1.getScpcs());
			xsJbxxRecord.setHkszdxzqhm(xsJbxx1.getHkszdxzqhm());
			xsJbxxRecord.setHkxz(xsJbxx1.getHkxz());
			xsJbxxRecord.setXsjzdlx(xsJbxx1.getXsjzdlx());
			xsJbxxRecord.setRxny(xsJbxx1.getRxny());
			if (xsJbxx1.getZyId() != null) {
				xsJbxxRecord.setZyId(xsJbxx1.getZyId());
			}
			if (xsJbxx1.getZylxId() != null) {
				xsJbxxRecord.setZylxId(xsJbxx1.getZylxId());
			}
			xsJbxx1.setZyName(xsJbxx1.getZyName());
			xsJbxxRecord.setZyjc(xsJbxx1.getZyjc());
			xsJbxxRecord.setZyfx(xsJbxx1.getZyfx());
			xsJbxxRecord.setXz(xsJbxx1.getXz());
			xsJbxxRecord.setMzm(xsJbxx1.getMzm());
			xsJbxxRecord.setZzmmm(xsJbxx1.getZzmmm());
			xsJbxxRecord.setJkzkm(xsJbxx1.getJkzkm());
			xsJbxxRecord.setXslym(xsJbxx1.getXslym());
			xsJbxxRecord.setZsdx(xsJbxx1.getZsdx());
			xsJbxxRecord.setJhrlxdh(xsJbxx1.getJhrlxdh());
			xsJbxxRecord.setByxx(xsJbxx1.getByxx());
			xsJbxxRecord.setLxdh(xsJbxx1.getLxdh());
			xsJbxxRecord.setZsfs(xsJbxx1.getZsfs());
			xsJbxxRecord.setLzhzlx(xsJbxx1.getLzhzlx());
			xsJbxxRecord.setZkzh(xsJbxx1.getZkzh());
			xsJbxxRecord.setKsh(xsJbxx1.getKsh());
			xsJbxxRecord.setKszf(xsJbxx1.getKszf());
			xsJbxxRecord.setKstc(xsJbxx1.getKstc());
			xsJbxxRecord.setKsjwbs(xsJbxx1.getKsjwbs());
			xsJbxxRecord.setTjjl(xsJbxx1.getTjjl());
			xsJbxxRecord.setLzhzbxfs(xsJbxx1.getLzhzbxfs());
			xsJbxxRecord.setLzhzxxdm(xsJbxx1.getLzhzxxdm());
			xsJbxxRecord.setXwjxd(xsJbxx1.getXwjxd());
			xsJbxxRecord.setFdpyfs(xsJbxx1.getFdpyfs());
			xsJbxxRecord.setYwxm(xsJbxx1.getYwxm());
			xsJbxxRecord.setDzxx(xsJbxx1.getDzxx());
			xsJbxxRecord.setJtxdz(xsJbxx1.getJtxdz());
			xsJbxxRecord.setJtyzbm(xsJbxx1.getJtyzbm());
			xsJbxxRecord.setLxdh(xsJbxx1.getLxdh());
			xsJbxxRecord.setCyyxm(xsJbxx1.getCyyxm());
			xsJbxxRecord.setCyygx(xsJbxx1.getCyygx());
			xsJbxxRecord.setCyysfjhr(xsJbxx1.getCyysfjhr());
			xsJbxxRecord.setCyylxdh(xsJbxx1.getLxdh());
			xsJbxxRecord.setCyycsny(xsJbxx1.getCyylxdh());
			xsJbxxRecord.setCyysfzjlx(xsJbxx1.getCyysfzjlx());
			xsJbxxRecord.setCyysfzjh(xsJbxx1.getCyysfzjh());
			xsJbxxRecord.setCyymzm(xsJbxx1.getCyymzm());
			xsJbxxRecord.setCyyzzmmm(xsJbxx1.getCyyzzmmm());
			xsJbxxRecord.setCyyjkzkm(xsJbxx1.getCyyjkzkm());
			xsJbxxRecord.setCyygzhxxdw(xsJbxx1.getCyygzhxxdw());
			xsJbxxRecord.setCyyzw(xsJbxx1.getCyyzw());
			xsJbxxRecord.setCyexm(xsJbxx1.getCyexm());
			xsJbxxRecord.setCyegx(xsJbxx1.getCyegx());
			xsJbxxRecord.setCyesfjhr(xsJbxx1.getCyesfjhr());
			xsJbxxRecord.setCyelxdh(xsJbxx1.getCyelxdh());
			xsJbxxRecord.setCyecsny(xsJbxx1.getCyecsny());
			xsJbxxRecord.setCyesfzjlx(xsJbxx1.getCyesfzjlx());
			xsJbxxRecord.setCyesfzjh(xsJbxx1.getCyesfzjh());
			xsJbxxRecord.setCyemzm(xsJbxx1.getCyemzm());
			xsJbxxRecord.setCyezzmmm(xsJbxx1.getCyezzmmm());
			xsJbxxRecord.setCyejkzkm(xsJbxx1.getCyejkzkm());
			xsJbxxRecord.setCyegzhxxdw(xsJbxx1.getCyegzhxxdw());
			xsJbxxRecord.setCyezw(xsJbxx1.getCyezw());
			xsJbxxRecord.setShzt(xsJbxx1.getShzt());
			xsJbxxRecord.setSpnr(xsJbxx1.getSpnr());
			xsJbxxRecord.setCreateBy(xsJbxx1.getCreateBy());
			xsJbxxRecord.setCreateDate(xsJbxx1.getCreateDate());
			xsJbxxRecord.setUpdateBy(xsJbxx1.getUpdateBy());
			xsJbxxRecord.setUpdateDate(xsJbxx1.getUpdateDate());
			xsJbxxRecord.setRemarks(xsJbxx1.getRemarks());
			xsJbxxRecord.setDelFlag(xsJbxx1.getDelFlag());
			xsJbxxRecordService.save(xsJbxxRecord);
		} else if (shzt.equals("1")) {// 审核通过

		}
		xsJbxx1.setShzt(shzt);
		xsJbxx1.setSpnr(spnr);
		xsJbxx1.setApproveBy(user);
		xsJbxx1.setApproveDate(new Date());
		xsJbxxService.save(xsJbxx1);
		return "redirect:" + Global.getAdminPath()
				+ "/xs/xsJbxx/xjList/?repage";
	}
	
	
	@RequiresPermissions("xs:xsJbxx:edit")
	@RequestMapping(value = "bgydSh")
	public String bgydSh(String id, String shzt, String spnr) {
		XsJbxx xsJbxx1 = xsJbxxService.get(id);
		User user = UserUtils.getUser();
		if (shzt.equals("2")) {// 审核不通过
			// 记录学生历史信息
			XsJbxxRecord xsJbxxRecord = new XsJbxxRecord();
			xsJbxxRecord.setXsId(xsJbxx1.getId());
			xsJbxxRecord.setXm(xsJbxx1.getXm());
			xsJbxxRecord.setXbm(xsJbxx1.getXbm());
			xsJbxxRecord.setCsrq(xsJbxx1.getCsrq());
			xsJbxxRecord.setSfzjlxm(xsJbxx1.getSfzjlxm());
			xsJbxxRecord.setSfzjh(xsJbxx1.getSfzjh());
			xsJbxxRecord.setXmpy(xsJbxx1.getXmpy());
			if (xsJbxx1.getBjmc() != null) {
				xsJbxxRecord.setBjmc(xsJbxx1.getBjmc());
			}
			xsJbxxRecord.setXh(xsJbxx1.getXh());
			xsJbxxRecord.setXslbm(xsJbxx1.getXslbm());
			xsJbxxRecord.setXxxsm(xsJbxx1.getXxxsm());
			xsJbxxRecord.setRxfsm(xsJbxx1.getRxfsm());
			xsJbxxRecord.setJdfsm(xsJbxx1.getJdfsm());
			xsJbxxRecord.setGjdqm(xsJbxx1.getGjdqm());
			xsJbxxRecord.setGatqwm(xsJbxx1.getGatqwm());
			xsJbxxRecord.setHyzkm(xsJbxx1.getHyzkm());
			xsJbxxRecord.setChcqj(xsJbxx1.getChcqj());
			xsJbxxRecord.setSfsqzn(xsJbxx1.getSfsqzn());
			xsJbxxRecord.setSydxzqhm(xsJbxx1.getSydxzqhm());
			xsJbxxRecord.setCsdxzqhm(xsJbxx1.getCsdxzqhm());
			xsJbxxRecord.setJgdxzqhm(xsJbxx1.getJgdxzqhm());
			xsJbxxRecord.setHkszdqxyxxxdz(xsJbxx1.getHkszdqxyxxxdz());
			xsJbxxRecord.setScpcs(xsJbxx1.getScpcs());
			xsJbxxRecord.setHkszdxzqhm(xsJbxx1.getHkszdxzqhm());
			xsJbxxRecord.setHkxz(xsJbxx1.getHkxz());
			xsJbxxRecord.setXsjzdlx(xsJbxx1.getXsjzdlx());
			xsJbxxRecord.setRxny(xsJbxx1.getRxny());
			if (xsJbxx1.getZyId() != null) {
				xsJbxxRecord.setZyId(xsJbxx1.getZyId());
			}
			if (xsJbxx1.getZylxId() != null) {
				xsJbxxRecord.setZylxId(xsJbxx1.getZylxId());
			}
			xsJbxx1.setZyName(xsJbxx1.getZyName());
			xsJbxxRecord.setZyjc(xsJbxx1.getZyjc());
			xsJbxxRecord.setZyfx(xsJbxx1.getZyfx());
			xsJbxxRecord.setXz(xsJbxx1.getXz());
			xsJbxxRecord.setMzm(xsJbxx1.getMzm());
			xsJbxxRecord.setZzmmm(xsJbxx1.getZzmmm());
			xsJbxxRecord.setJkzkm(xsJbxx1.getJkzkm());
			xsJbxxRecord.setXslym(xsJbxx1.getXslym());
			xsJbxxRecord.setZsdx(xsJbxx1.getZsdx());
			xsJbxxRecord.setJhrlxdh(xsJbxx1.getJhrlxdh());
			xsJbxxRecord.setByxx(xsJbxx1.getByxx());
			xsJbxxRecord.setLxdh(xsJbxx1.getLxdh());
			xsJbxxRecord.setZsfs(xsJbxx1.getZsfs());
			xsJbxxRecord.setLzhzlx(xsJbxx1.getLzhzlx());
			xsJbxxRecord.setZkzh(xsJbxx1.getZkzh());
			xsJbxxRecord.setKsh(xsJbxx1.getKsh());
			xsJbxxRecord.setKszf(xsJbxx1.getKszf());
			xsJbxxRecord.setKstc(xsJbxx1.getKstc());
			xsJbxxRecord.setKsjwbs(xsJbxx1.getKsjwbs());
			xsJbxxRecord.setTjjl(xsJbxx1.getTjjl());
			xsJbxxRecord.setLzhzbxfs(xsJbxx1.getLzhzbxfs());
			xsJbxxRecord.setLzhzxxdm(xsJbxx1.getLzhzxxdm());
			xsJbxxRecord.setXwjxd(xsJbxx1.getXwjxd());
			xsJbxxRecord.setFdpyfs(xsJbxx1.getFdpyfs());
			xsJbxxRecord.setYwxm(xsJbxx1.getYwxm());
			xsJbxxRecord.setDzxx(xsJbxx1.getDzxx());
			xsJbxxRecord.setJtxdz(xsJbxx1.getJtxdz());
			xsJbxxRecord.setJtyzbm(xsJbxx1.getJtyzbm());
			xsJbxxRecord.setLxdh(xsJbxx1.getLxdh());
			xsJbxxRecord.setCyyxm(xsJbxx1.getCyyxm());
			xsJbxxRecord.setCyygx(xsJbxx1.getCyygx());
			xsJbxxRecord.setCyysfjhr(xsJbxx1.getCyysfjhr());
			xsJbxxRecord.setCyylxdh(xsJbxx1.getLxdh());
			xsJbxxRecord.setCyycsny(xsJbxx1.getCyylxdh());
			xsJbxxRecord.setCyysfzjlx(xsJbxx1.getCyysfzjlx());
			xsJbxxRecord.setCyysfzjh(xsJbxx1.getCyysfzjh());
			xsJbxxRecord.setCyymzm(xsJbxx1.getCyymzm());
			xsJbxxRecord.setCyyzzmmm(xsJbxx1.getCyyzzmmm());
			xsJbxxRecord.setCyyjkzkm(xsJbxx1.getCyyjkzkm());
			xsJbxxRecord.setCyygzhxxdw(xsJbxx1.getCyygzhxxdw());
			xsJbxxRecord.setCyyzw(xsJbxx1.getCyyzw());
			xsJbxxRecord.setCyexm(xsJbxx1.getCyexm());
			xsJbxxRecord.setCyegx(xsJbxx1.getCyegx());
			xsJbxxRecord.setCyesfjhr(xsJbxx1.getCyesfjhr());
			xsJbxxRecord.setCyelxdh(xsJbxx1.getCyelxdh());
			xsJbxxRecord.setCyecsny(xsJbxx1.getCyecsny());
			xsJbxxRecord.setCyesfzjlx(xsJbxx1.getCyesfzjlx());
			xsJbxxRecord.setCyesfzjh(xsJbxx1.getCyesfzjh());
			xsJbxxRecord.setCyemzm(xsJbxx1.getCyemzm());
			xsJbxxRecord.setCyezzmmm(xsJbxx1.getCyezzmmm());
			xsJbxxRecord.setCyejkzkm(xsJbxx1.getCyejkzkm());
			xsJbxxRecord.setCyegzhxxdw(xsJbxx1.getCyegzhxxdw());
			xsJbxxRecord.setCyezw(xsJbxx1.getCyezw());
			xsJbxxRecord.setShzt(xsJbxx1.getShzt());
			xsJbxxRecord.setSpnr(xsJbxx1.getSpnr());
			xsJbxxRecord.setCreateBy(xsJbxx1.getCreateBy());
			xsJbxxRecord.setCreateDate(xsJbxx1.getCreateDate());
			xsJbxxRecord.setUpdateBy(xsJbxx1.getUpdateBy());
			xsJbxxRecord.setUpdateDate(xsJbxx1.getUpdateDate());
			xsJbxxRecord.setRemarks(xsJbxx1.getRemarks());
			xsJbxxRecord.setDelFlag(xsJbxx1.getDelFlag());
			xsJbxxRecordService.save(xsJbxxRecord);
			xsJbxx1.setBgydlxzt("2");
		} else if (shzt.equals("1")) {// 审核通过
			xsJbxx1.setBgydlxzt("0");
			String bgydlx=xsJbxx1.getBgydlx();
			if(bgydlx=="0" || bgydlx.equals("0")){
				xsJbxx1.setBjmc(xsJbxx1.getNewBjmc());
			}else if (bgydlx=="1" || bgydlx.equals("1")){
				xsJbxx1.setZyId(xsJbxx1.getNewZyid());
				xsJbxx1.setZylxId(zyJbxxService.get(xsJbxx1.getNewZyid()).getZylx());
				xsJbxx1.setBjmc(xsJbxx1.getNewBjmc());
			}
		}
		
		/*xsJbxx1.setShzt(shzt);*/
		xsJbxx1.setSpnr(spnr);
		xsJbxx1.setApproveBy(user);
		xsJbxx1.setApproveDate(new Date());
		xsJbxxService.save(xsJbxx1);
		return "redirect:" + Global.getAdminPath()
				+ "/xs/xsJbxx/xsbgydlist/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "moreShenHe")
	public String piliangShenHe(@RequestParam("ids") String ids,
			@RequestParam("shStatu") String shStatu,
			RedirectAttributes redirectAttributes) {
		if (ids != null && !"".equals(ids) && ids.length() > 0) {
			String[] idArr = ids.split(",");
			for (String id : idArr) {
				XsJbxx xsJbxx = xsJbxxService.get(id);
				if (xsJbxx.getShzt() == null || !xsJbxx.getShzt().equals("1")) {
					if (shStatu.equals("2")) {// 审核不通过
						// 记录学生历史信息
						XsJbxxRecord xsJbxxRecord = new XsJbxxRecord();
						xsJbxxRecord.setXsId(xsJbxx.getId());
						xsJbxxRecord.setXm(xsJbxx.getXm());
						xsJbxxRecord.setXbm(xsJbxx.getXbm());
						xsJbxxRecord.setCsrq(xsJbxx.getCsrq());
						xsJbxxRecord.setSfzjlxm(xsJbxx.getSfzjlxm());
						xsJbxxRecord.setSfzjh(xsJbxx.getSfzjh());
						xsJbxxRecord.setXmpy(xsJbxx.getXmpy());
						if (xsJbxx.getBjmc() != null) {
							xsJbxxRecord.setBjmc(xsJbxx.getBjmc());
						}
						xsJbxxRecord.setXh(xsJbxx.getXh());
						xsJbxxRecord.setXslbm(xsJbxx.getXslbm());
						xsJbxxRecord.setXxxsm(xsJbxx.getXxxsm());
						xsJbxxRecord.setRxfsm(xsJbxx.getRxfsm());
						xsJbxxRecord.setJdfsm(xsJbxx.getJdfsm());
						xsJbxxRecord.setGjdqm(xsJbxx.getGjdqm());
						xsJbxxRecord.setGatqwm(xsJbxx.getGatqwm());
						xsJbxxRecord.setHyzkm(xsJbxx.getHyzkm());
						xsJbxxRecord.setChcqj(xsJbxx.getChcqj());
						xsJbxxRecord.setSfsqzn(xsJbxx.getSfsqzn());
						xsJbxxRecord.setSydxzqhm(xsJbxx.getSydxzqhm());
						xsJbxxRecord.setCsdxzqhm(xsJbxx.getCsdxzqhm());
						xsJbxxRecord.setJgdxzqhm(xsJbxx.getJgdxzqhm());
						xsJbxxRecord
								.setHkszdqxyxxxdz(xsJbxx.getHkszdqxyxxxdz());
						xsJbxxRecord.setScpcs(xsJbxx.getScpcs());
						xsJbxxRecord.setHkszdxzqhm(xsJbxx.getHkszdxzqhm());
						xsJbxxRecord.setHkxz(xsJbxx.getHkxz());
						xsJbxxRecord.setXsjzdlx(xsJbxx.getXsjzdlx());
						xsJbxxRecord.setRxny(xsJbxx.getRxny());
						if (xsJbxx.getZyId() != null) {
							xsJbxxRecord.setZyId(xsJbxx.getZyId());
						}
						if (xsJbxx.getZylxId() != null) {
							xsJbxxRecord.setZylxId(xsJbxx.getZylxId());
						}
						xsJbxx.setZyName(xsJbxx.getZyName());
						xsJbxxRecord.setZyjc(xsJbxx.getZyjc());
						xsJbxxRecord.setZyfx(xsJbxx.getZyfx());
						xsJbxxRecord.setXz(xsJbxx.getXz());
						xsJbxxRecord.setMzm(xsJbxx.getMzm());
						xsJbxxRecord.setZzmmm(xsJbxx.getZzmmm());
						xsJbxxRecord.setJkzkm(xsJbxx.getJkzkm());
						xsJbxxRecord.setXslym(xsJbxx.getXslym());
						xsJbxxRecord.setZsdx(xsJbxx.getZsdx());
						xsJbxxRecord.setJhrlxdh(xsJbxx.getJhrlxdh());
						xsJbxxRecord.setByxx(xsJbxx.getByxx());
						xsJbxxRecord.setLxdh(xsJbxx.getLxdh());
						xsJbxxRecord.setZsfs(xsJbxx.getZsfs());
						xsJbxxRecord.setLzhzlx(xsJbxx.getLzhzlx());
						xsJbxxRecord.setZkzh(xsJbxx.getZkzh());
						xsJbxxRecord.setKsh(xsJbxx.getKsh());
						xsJbxxRecord.setKszf(xsJbxx.getKszf());
						xsJbxxRecord.setKstc(xsJbxx.getKstc());
						xsJbxxRecord.setKsjwbs(xsJbxx.getKsjwbs());
						xsJbxxRecord.setTjjl(xsJbxx.getTjjl());
						xsJbxxRecord.setLzhzbxfs(xsJbxx.getLzhzbxfs());
						xsJbxxRecord.setLzhzxxdm(xsJbxx.getLzhzxxdm());
						xsJbxxRecord.setXwjxd(xsJbxx.getXwjxd());
						xsJbxxRecord.setFdpyfs(xsJbxx.getFdpyfs());
						xsJbxxRecord.setYwxm(xsJbxx.getYwxm());
						xsJbxxRecord.setDzxx(xsJbxx.getDzxx());
						xsJbxxRecord.setJtxdz(xsJbxx.getJtxdz());
						xsJbxxRecord.setJtyzbm(xsJbxx.getJtyzbm());
						xsJbxxRecord.setLxdh(xsJbxx.getLxdh());
						xsJbxxRecord.setCyyxm(xsJbxx.getCyyxm());
						xsJbxxRecord.setCyygx(xsJbxx.getCyygx());
						xsJbxxRecord.setCyysfjhr(xsJbxx.getCyysfjhr());
						xsJbxxRecord.setCyylxdh(xsJbxx.getLxdh());
						xsJbxxRecord.setCyycsny(xsJbxx.getCyylxdh());
						xsJbxxRecord.setCyysfzjlx(xsJbxx.getCyysfzjlx());
						xsJbxxRecord.setCyysfzjh(xsJbxx.getCyysfzjh());
						xsJbxxRecord.setCyymzm(xsJbxx.getCyymzm());
						xsJbxxRecord.setCyyzzmmm(xsJbxx.getCyyzzmmm());
						xsJbxxRecord.setCyyjkzkm(xsJbxx.getCyyjkzkm());
						xsJbxxRecord.setCyygzhxxdw(xsJbxx.getCyygzhxxdw());
						xsJbxxRecord.setCyyzw(xsJbxx.getCyyzw());
						xsJbxxRecord.setCyexm(xsJbxx.getCyexm());
						xsJbxxRecord.setCyegx(xsJbxx.getCyegx());
						xsJbxxRecord.setCyesfjhr(xsJbxx.getCyesfjhr());
						xsJbxxRecord.setCyelxdh(xsJbxx.getCyelxdh());
						xsJbxxRecord.setCyecsny(xsJbxx.getCyecsny());
						xsJbxxRecord.setCyesfzjlx(xsJbxx.getCyesfzjlx());
						xsJbxxRecord.setCyesfzjh(xsJbxx.getCyesfzjh());
						xsJbxxRecord.setCyemzm(xsJbxx.getCyemzm());
						xsJbxxRecord.setCyezzmmm(xsJbxx.getCyezzmmm());
						xsJbxxRecord.setCyejkzkm(xsJbxx.getCyejkzkm());
						xsJbxxRecord.setCyegzhxxdw(xsJbxx.getCyegzhxxdw());
						xsJbxxRecord.setCyezw(xsJbxx.getCyezw());
						xsJbxxRecord.setShzt(xsJbxx.getShzt());
						xsJbxxRecord.setSpnr(xsJbxx.getSpnr());
						xsJbxxRecord.setCreateBy(xsJbxx.getCreateBy());
						xsJbxxRecord.setCreateDate(xsJbxx.getCreateDate());
						xsJbxxRecord.setUpdateBy(xsJbxx.getUpdateBy());
						xsJbxxRecord.setUpdateDate(xsJbxx.getUpdateDate());
						xsJbxxRecord.setRemarks(xsJbxx.getRemarks());
						xsJbxxRecord.setDelFlag(xsJbxx.getDelFlag());
						xsJbxxRecordService.save(xsJbxxRecord);
					} else if (shStatu.equals("1")) {// 审核通过

					}
					xsJbxx.setShzt(shStatu);
					xsJbxx.setSpnr(shStatu);
					xsJbxxService.save(xsJbxx);
				}
			}
		}
		if (shStatu.equals("2")) {
			return "2";// 审核不通过成功
		} else if (shStatu.equals("1")) {
			return "1";// 审核通过成功
		}
		return "0";
		/*
		 * addMessage(redirectAttributes, "批量审核成功"); return "redirect:" +
		 * Global.getAdminPath() + "/xs/xsJbxx/xjList/?repage";
		 */
	}

	/**
	 * 根据HSSFCell类型设置数据
	 * 
	 * @param cell
	 * @return
	 */
	private String getCellFormatValue(HSSFCell cell) {
		String cellvalue = "";
		if (cell != null) {
			// 判断当前Cell的Type
			switch (cell.getCellType()) {
			// 如果当前Cell的Type为NUMERIC
			case HSSFCell.CELL_TYPE_NUMERIC:
			case HSSFCell.CELL_TYPE_FORMULA: {
				// 判断当前的cell是否为Date
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					// 如果是Date类型则，转化为Data格式

					// 方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
					// cellvalue = cell.getDateCellValue().toLocaleString();

					// 方法2：这样子的data格式是不带带时分秒的：2011-10-12
					Date date = cell.getDateCellValue();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					cellvalue = sdf.format(date);

				}
				// 如果是纯数字
				else {
					// 取得当前Cell的数值
					cellvalue = String.valueOf(cell.getNumericCellValue());
				}
				break;
			}
			// 如果当前Cell的Type为STRIN
			case HSSFCell.CELL_TYPE_STRING:
				// 取得当前的Cell字符串
				cellvalue = cell.getRichStringCellValue().getString();
				break;
			// 默认的Cell值
			default:
				cellvalue = " ";
			}
		} else {
			cellvalue = "";
		}
		return cellvalue;

	}

	/**
	 * 导入招生信息
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "importZsxx", method = RequestMethod.POST)
	public String importZsxx(MultipartFile file, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		// 判断文件是否为空
		if (!file.isEmpty()) {
			try {
				// 文件保存路径
				String filePath = request
						.getSession()
						.getServletContext()
						.getRealPath(
								"/WEB-INF/upload/" + file.getOriginalFilename());
				// 转存文件
				file.transferTo(new File(filePath));

				try {
					// 读取Excel表格内容
					InputStream is = new FileInputStream(filePath);

					try {
						fs = new POIFSFileSystem(is);
						wb = new HSSFWorkbook(fs);
					} catch (IOException e) {
						e.printStackTrace();
					}
					sheet = wb.getSheetAt(1);
					// 得到总行数
					int rowNum = sheet.getLastRowNum();
					row = sheet.getRow(0);

					int successNum = 0;
					int failureNum = 0;
					StringBuilder failureMsg = new StringBuilder();

					// 正文内容应该从第四行开始
					for (int i = 3; i <= rowNum; i++) {
						XsJbxx xs = new XsJbxx();
						try {
							row = sheet.getRow(i);
							// 姓名
							String xm = getCellFormatValue(row.getCell((int) 0))
									.trim();
							xs.setXm(xm);
							// 性别
							String sex = getCellFormatValue(
									row.getCell((int) 1)).trim();
							String xbm = DictUtils
									.getDictValue(sex, "sex", "0");
							xs.setXbm(xbm);
							// 出生日期
							String csrq = getCellFormatValue(
									row.getCell((int) 2)).trim();
							if (!csrq.equals("") && csrq != null) {
								String year = csrq.substring(0, 4);
								String month = csrq.substring(4, 6);
								String day = csrq.substring(6, 8);
								String csrq1 = year + "-" + month + "-" + day;
								xs.setCsrq(csrq1);
							}
							// 身份证件类型
							String sfzjlxm = getCellFormatValue(
									row.getCell((int) 3)).trim();
							String sfzjlx = DictUtils.getDictValue(sfzjlxm,
									"sfzjlx", "0");
							xs.setSfzjlxm(sfzjlx);
							// 身份证件号
							String sfzjh = getCellFormatValue(
									row.getCell((int) 4)).trim();
							xs.setSfzjh(sfzjh);
							// 入学年月
							String rxny = getCellFormatValue(
									row.getCell((int) 5)).trim();
							if (!rxny.equals("") && rxny != null) {
								String year = rxny.substring(0, 4);
								String month = rxny.substring(4, 6);
								String rxny1 = year + "-" + month;
								xs.setRxny(rxny1);
							}
							// 专业简称
							String zyjc = getCellFormatValue(
									row.getCell((int) 6)).trim();
							xs.setZyjc(zyjc);
							// 民族
							String mzm = getCellFormatValue(
									row.getCell((int) 7)).trim();
							String mz = DictUtils.getDictValue(mzm, "nation",
									"0");
							xs.setMzm(mz);
							// 户口所在地行政区划码
							String hkszdxzqhm = getCellFormatValue(
									row.getCell((int) 8)).trim();
							xs.setHkszdxzqhm(hkszdxzqhm);
							// 户口性质
							String hkxz = getCellFormatValue(
									row.getCell((int) 9)).trim();
							String hkxz1 = DictUtils.getDictValue(hkxz, "hkxz",
									"0");
							xs.setHkxz(hkxz1);
							// 学生居住地类型
							String xsjzdlx = getCellFormatValue(
									row.getCell((int) 10)).trim();
							String xsjzdlx1 = DictUtils.getDictValue(xsjzdlx,
									"xsjzdlx", "0");
							xs.setXsjzdlx(xsjzdlx1);
							// 政治面貌
							String zzmmm = getCellFormatValue(
									row.getCell((int) 11)).trim();
							String zzmm = DictUtils.getDictValue(zzmmm, "zzmm",
									"0");
							xs.setZzmmm(zzmm);
							// 健康状况
							String jkzkm = getCellFormatValue(
									row.getCell((int) 12)).trim();
							String jkzk = DictUtils.getDictValue(jkzkm,
									"health", "0");
							xs.setJkzkm(jkzk);
							// 学生来源
							String xslym = getCellFormatValue(
									row.getCell((int) 13)).trim();
							String xsly = DictUtils.getDictValue(xslym,
									"xs_ly", "0");
							xs.setXslym(xsly);
							// 招生对象
							String zsdx = getCellFormatValue(
									row.getCell((int) 14)).trim();
							String zsdx1 = DictUtils.getDictValue(zsdx, "zsdx",
									"0");
							xs.setZsdx(zsdx1);
							// 监护人联系电话
							String jhrlxdh = getCellFormatValue(
									row.getCell((int) 15)).trim();
							xs.setJhrlxdh(jhrlxdh);
							// 毕业学校
							String byxx = getCellFormatValue(
									row.getCell((int) 16)).trim();
							xs.setByxx(byxx);
							// 生源地行政区划码
							String sydxzqhm = getCellFormatValue(
									row.getCell((int) 17)).trim();
							xs.setSydxzqhm(sydxzqhm);
							// 招生方式
							String zsfs = getCellFormatValue(
									row.getCell((int) 18)).trim();
							String zsfs1 = DictUtils.getDictValue(zsfs, "zsfs",
									"0");
							xs.setZsfs(zsfs1);
							// 准考证号
							String zkzh = getCellFormatValue(
									row.getCell((int) 19)).trim();
							xs.setZkzh(zkzh);
							// 考生号
							String ksh = getCellFormatValue(
									row.getCell((int) 20)).trim();
							xs.setKsh(ksh);
							// 考试总分
							String kszf = getCellFormatValue(
									row.getCell((int) 21)).trim();
							xs.setKszf(kszf);
							// 考试特长
							String kstc = getCellFormatValue(
									row.getCell((int) 22)).trim();
							xs.setKstc(kstc);
							// 考生既往病史
							String ksjwbs = getCellFormatValue(
									row.getCell((int) 23)).trim();
							xs.setKsjwbs(ksjwbs);
							// 体检结论
							String tjjl = getCellFormatValue(
									row.getCell((int) 24)).trim();
							xs.setTjjl(tjjl);

							// 修改人
							User user = UserUtils.getUser();
							xs.setUpdateBy(user);
							// 修改时间
							xs.setUpdateDate(new Date());

							xsJbxxService.updateZsxx(xs);
							successNum++;
						} catch (ConstraintViolationException ex) {
							failureMsg.append("<br/>学生 " + xs.getXm()
									+ " 更新失败：");
							List<String> messageList = BeanValidators
									.extractPropertyAndMessageAsList(ex, ": ");
							for (String message : messageList) {
								failureMsg.append(message + "; ");
								failureNum++;
							}
						} catch (Exception ex) {
							failureMsg.append("<br/>学生 " + xs.getXm()
									+ " 更新失败：" + ex.getMessage());
						}
					}
					if (failureNum > 0) {
						failureMsg.insert(0, "，失败 " + failureNum
								+ " 条数据，更新信息如下：");
					}
					addMessage(redirectAttributes, "已成功更新 " + successNum
							+ " 条数据" + failureMsg);
				} catch (Exception e) {
					addMessage(redirectAttributes,
							"更新学生失败！失败信息：" + e.getMessage());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:" + adminPath + "/xs/xsJbxx/xjList?repage";
	}

	/**
	 * 导入新生信息
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "importXsxx", method = RequestMethod.POST)
	public String importXsxx(MultipartFile file, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		// 判断文件是否为空
		if (!file.isEmpty()) {
			try {
				// 文件保存路径
				String filePath = request
						.getSession()
						.getServletContext()
						.getRealPath(
								"/WEB-INF/upload/" + file.getOriginalFilename());
				// 转存文件
				file.transferTo(new File(filePath));

				try {
					// 读取Excel表格内容
					InputStream is = new FileInputStream(filePath);

					try {
						fs = new POIFSFileSystem(is);
						wb = new HSSFWorkbook(fs);
					} catch (IOException e) {
						e.printStackTrace();
					}
					sheet = wb.getSheetAt(1);
					// 得到总行数
					int rowNum = sheet.getLastRowNum();
					row = sheet.getRow(0);

					int successNum = 0;
					int failureNum = 0;
					StringBuilder failureMsg = new StringBuilder();

					// 正文内容应该从第四行开始
					for (int i = 3; i <= rowNum; i++) {
						XsJbxx xs = new XsJbxx();
						try {
							row = sheet.getRow(i);
							// 姓名
							String xm = getCellFormatValue(row.getCell((int) 0))
									.trim();
							xs.setXm(xm);
							// 性别
							String sex = getCellFormatValue(
									row.getCell((int) 1)).trim();
							String xbm = DictUtils
									.getDictValue(sex, "sex", "0");
							xs.setXbm(xbm);
							// 出生日期
							String csrq = getCellFormatValue(
									row.getCell((int) 2)).trim();
							if (!csrq.equals("") && csrq != null) {
								String year = csrq.substring(0, 4);
								String month = csrq.substring(4, 6);
								String day = csrq.substring(6, 8);
								String csrq1 = year + "-" + month + "-" + day;
								xs.setCsrq(csrq1);
							}
							// 身份证件类型
							String sfzjlxm = getCellFormatValue(
									row.getCell((int) 3)).trim();
							String sfzjlx = DictUtils.getDictValue(sfzjlxm,
									"sfzjlx", "0");
							xs.setSfzjlxm(sfzjlx);
							// 身份证件号
							String sfzjh = getCellFormatValue(
									row.getCell((int) 4)).trim();
							xs.setSfzjh(sfzjh);
							// 姓名拼音
							String xmpy = getCellFormatValue(
									row.getCell((int) 5)).trim();
							xs.setXmpy(xmpy);
							// 班级名称
							String bjmc = getCellFormatValue(
									row.getCell((int) 6)).trim();
							xs.setBjName(bjmc);
							// 学号
							String xh = getCellFormatValue(row.getCell((int) 7))
									.trim();
							xs.setXh(xh);
							// 学生类别
							String xslbm = getCellFormatValue(
									row.getCell((int) 8)).trim();
							String xslb = DictUtils.getDictValue(xslbm, "xslb",
									"0");
							xs.setXslbm(xslb);
							// 学习形式
							String xxxsm = getCellFormatValue(
									row.getCell((int) 9)).trim();
							String xxxs = DictUtils.getDictValue(xxxsm, "xxxs",
									"0");
							xs.setXxxsm(xxxs);
							// 入学方式
							String rxfsm = getCellFormatValue(
									row.getCell((int) 10)).trim();
							String rxfs = DictUtils.getDictValue(rxfsm, "rxfs",
									"0");
							xs.setRxfsm(rxfs);
							// 就读方式
							String jdfsm = getCellFormatValue(
									row.getCell((int) 11)).trim();
							String jdfs = DictUtils.getDictValue(jdfsm, "jdfs",
									"0");
							xs.setJdfsm(jdfs);
							// 国籍/地区
							String gjdqm = getCellFormatValue(
									row.getCell((int) 12)).trim();
							String gjdq = DictUtils.getDictValue(gjdqm,
									"gjdqm", "0");
							xs.setGjdqm(gjdq);
							// 港澳台侨外
							String gatqwm = getCellFormatValue(
									row.getCell((int) 13)).trim();
							String gatqw = DictUtils.getDictValue(gatqwm,
									"gatqwm", "0");
							xs.setGatqwm(gatqw);
							// 婚姻状况
							String hyzkm = getCellFormatValue(
									row.getCell((int) 14)).trim();
							String hyzk = DictUtils.getDictValue(hyzkm, "hyzk",
									"0");
							xs.setHyzkm(hyzk);
							// 乘火车区间
							String chcqj = getCellFormatValue(
									row.getCell((int) 15)).trim();
							xs.setChcqj(chcqj);
							// 是否随迁子女
							String sfsqznm = getCellFormatValue(
									row.getCell((int) 16)).trim();
							String sfsqzn = DictUtils.getDictValue(sfsqznm,
									"sfdm", "0");
							xs.setSfsqzn(sfsqzn);
							// 生源地行政区划码
							String sydxzqhm = getCellFormatValue(
									row.getCell((int) 17)).trim();
							xs.setSydxzqhm(sydxzqhm);
							// 出生地行政区划码
							String csdxzqhm = getCellFormatValue(
									row.getCell((int) 18)).trim();
							xs.setCsdxzqhm(csdxzqhm);
							// 籍贯地行政区划码
							String jgdxzqhm = getCellFormatValue(
									row.getCell((int) 19)).trim();
							xs.setJgdxzqhm(jgdxzqhm);
							// 户口所在地区县以下详细地址
							String hkzsdqxyxxxdz = getCellFormatValue(
									row.getCell((int) 20)).trim();
							xs.setHkszdqxyxxxdz(hkzsdqxyxxxdz);
							// 所属派出所
							String sspcs = getCellFormatValue(
									row.getCell((int) 21)).trim();
							xs.setScpcs(sspcs);
							// 户口所在地行政区划码
							String hkszdxzqhm = getCellFormatValue(
									row.getCell((int) 22)).trim();
							xs.setHkszdxzqhm(hkszdxzqhm);
							// 户口性质
							String hkxz = getCellFormatValue(
									row.getCell((int) 23)).trim();
							String hkxz1 = DictUtils.getDictValue(hkxz, "hkxz",
									"0");
							xs.setHkxz(hkxz1);
							// 学生居住地类型
							String xsjzdlx = getCellFormatValue(
									row.getCell((int) 24)).trim();
							String xsjzdlx1 = DictUtils.getDictValue(xsjzdlx,
									"xsjzdlx", "0");
							xs.setXsjzdlx(xsjzdlx1);
							// 入学年月
							String rxny = getCellFormatValue(
									row.getCell((int) 25)).trim();
							if (!rxny.equals("") && rxny != null) {
								String year = rxny.substring(0, 4);
								String month = rxny.substring(4, 6);
								String rxny1 = year + "-" + month;
								xs.setRxny(rxny1);
							}
							// 专业
							String zy = getCellFormatValue(
									row.getCell((int) 26)).trim();
							ZyJbxx zyjbxx = zyJbxxService.getValueByName(zy);
							xs.setZymc(zy);
							xs.setZyId(zyjbxx);
							// 专业方向
							String zyfx = getCellFormatValue(
									row.getCell((int) 27)).trim();
							xs.setZyfx(zyfx);
							// 学制
							String xzm = getCellFormatValue(
									row.getCell((int) 28)).trim();
							String xz = DictUtils
									.getDictValue(xzm, "xzdm", "0");
							xs.setXz(xz);
							// 民族
							String mzm = getCellFormatValue(
									row.getCell((int) 29)).trim();
							String mz = DictUtils.getDictValue(mzm, "nation",
									"0");
							xs.setMzm(mz);
							// 政治面貌
							String zzmmm = getCellFormatValue(
									row.getCell((int) 30)).trim();
							String zzmm = DictUtils.getDictValue(zzmmm, "zzmm",
									"0");
							xs.setZzmmm(zzmm);
							// 健康状况
							String jkzkm = getCellFormatValue(
									row.getCell((int) 31)).trim();
							String jkzk = DictUtils.getDictValue(jkzkm,
									"health", "0");
							xs.setJkzkm(jkzk);
							// 学生来源
							String xslym = getCellFormatValue(
									row.getCell((int) 32)).trim();
							String xsly = DictUtils.getDictValue(xslym,
									"xs_ly", "0");
							xs.setXslym(xsly);
							// 招生对象
							String zsdx = getCellFormatValue(
									row.getCell((int) 33)).trim();
							String zsdx1 = DictUtils.getDictValue(zsdx, "zsdx",
									"0");
							xs.setZsdx(zsdx1);
							// 联系电话
							String lxdh = getCellFormatValue(
									row.getCell((int) 34)).trim();
							xs.setLxdh(lxdh);
							// 招生方式
							String zsfs = getCellFormatValue(
									row.getCell((int) 35)).trim();
							String zsfs1 = DictUtils.getDictValue(zsfs, "zsfs",
									"0");
							xs.setZsfs(zsfs1);
							// 联招合作类型
							String lzhzlxm = getCellFormatValue(
									row.getCell((int) 36)).trim();
							String lzhzlx = DictUtils.getDictValue(lzhzlxm,
									"lzhzlx", "0");
							xs.setLzhzlx(lzhzlx);
							// 准考证号
							String zkzh = getCellFormatValue(
									row.getCell((int) 37)).trim();
							xs.setZkzh(zkzh);
							// 考生号
							String ksh = getCellFormatValue(
									row.getCell((int) 38)).trim();
							xs.setKsh(ksh);
							// 考试总分
							String kszf = getCellFormatValue(
									row.getCell((int) 39)).trim();
							xs.setKszf(kszf);
							// 联招合作办学形式
							String lzhzbxxsm = getCellFormatValue(
									row.getCell((int) 40)).trim();
							String lzhzbxxs = DictUtils.getDictValue(lzhzbxxsm,
									"lzhzbxxs", "0");
							xs.setLzhzbxfs(lzhzbxxs);
							// 联招合作学校代码
							String lzhzxxdm = getCellFormatValue(
									row.getCell((int) 41)).trim();
							xs.setLzhzxxdm(lzhzxxdm);
							// 校外教学点
							String xwjxd = getCellFormatValue(
									row.getCell((int) 42)).trim();
							xs.setXwjxd(xwjxd);
							// 分段培养方式
							String fdpyfsm = getCellFormatValue(
									row.getCell((int) 43)).trim();
							String fdpyfs = DictUtils.getDictValue(fdpyfsm,
									"fdpyfs", "0");
							xs.setFdpyfs(fdpyfs);
							// 英文姓名
							String ywxm = getCellFormatValue(
									row.getCell((int) 44)).trim();
							xs.setYwxm(ywxm);
							// 电子信箱/其他联系方式
							String dzxx = getCellFormatValue(
									row.getCell((int) 45)).trim();
							xs.setDzxx(dzxx);
							// 家庭现地址
							String jtxdz = getCellFormatValue(
									row.getCell((int) 46)).trim();
							xs.setJtxdz(jtxdz);
							// 家庭邮政编码
							String jtyzbm = getCellFormatValue(
									row.getCell((int) 47)).trim();
							xs.setJtyzbm(jtyzbm);
							// 家庭电话
							String jtdh = getCellFormatValue(
									row.getCell((int) 48)).trim();
							xs.setJtdh(jtdh);

							/**
							 * 成员1信息
							 */

							// 成员1姓名
							String cyyxm = getCellFormatValue(
									row.getCell((int) 49)).trim();
							xs.setCyyxm(cyyxm);
							// 成员1关系
							String cyygxm = getCellFormatValue(
									row.getCell((int) 50)).trim();
							String cyygx = DictUtils.getDictValue(cyygxm,
									"cygx", "0");
							xs.setCyygx(cyygx);
							// 成员1是否监护人
							String cyysfjhrm = getCellFormatValue(
									row.getCell((int) 51)).trim();
							String cyysfjhr = DictUtils.getDictValue(cyysfjhrm,
									"sfdm", "0");
							xs.setCyysfjhr(cyysfjhr);
							// 成员1联系电话
							String cyylxdh = getCellFormatValue(
									row.getCell((int) 52)).trim();
							xs.setCyylxdh(cyylxdh);
							// 成员1出生年月
							String cyycsny = getCellFormatValue(
									row.getCell((int) 53)).trim();
							if (!cyycsny.equals("") && cyycsny != null) {
								String year = cyycsny.substring(0, 4);
								String month = cyycsny.substring(4, 6);
								String cyycsny1 = year + "-" + month;
								xs.setCyycsny(cyycsny1);
							}
							// 成员1身份证件类型
							String cyysfzjlxm = getCellFormatValue(
									row.getCell((int) 54)).trim();
							String cyysfzjlx = DictUtils.getDictValue(
									cyysfzjlxm, "sfzjlx", "0");
							xs.setCyysfzjlx(cyysfzjlx);
							// 成员1身份证件号
							String cyysfzjh = getCellFormatValue(
									row.getCell((int) 55)).trim();
							xs.setCyysfzjh(cyysfzjh);
							// 成员1民族
							String cyymzm = getCellFormatValue(
									row.getCell((int) 56)).trim();
							String cyymz = DictUtils.getDictValue(cyymzm,
									"nation", "0");
							xs.setCyymzm(cyymz);
							// 成员1政治面貌
							String cyyzzmmm = getCellFormatValue(
									row.getCell((int) 57)).trim();
							String cyyzzmm = DictUtils.getDictValue(cyyzzmmm,
									"zzmm", "0");
							xs.setCyyzzmmm(cyyzzmm);
							// 成员1健康状况
							String cyyjkzkm = getCellFormatValue(
									row.getCell((int) 58)).trim();
							String cyyjkzk = DictUtils.getDictValue(cyyjkzkm,
									"health", "0");
							xs.setCyyjkzkm(cyyjkzk);
							// 成员1工作或学习单位
							String cyygzhxxdw = getCellFormatValue(
									row.getCell((int) 59)).trim();
							xs.setCyygzhxxdw(cyygzhxxdw);
							// 成员1职务
							String cyyszw = getCellFormatValue(
									row.getCell((int) 60)).trim();
							xs.setCyyzw(cyyszw);

							/**
							 * 成员2信息
							 */

							// 成员2姓名
							String cyexm = getCellFormatValue(
									row.getCell((int) 61)).trim();
							xs.setCyexm(cyexm);
							// 成员2关系
							String cyegxm = getCellFormatValue(
									row.getCell((int) 62)).trim();
							String cyegx = DictUtils.getDictValue(cyegxm,
									"cygx", "0");
							xs.setCyegx(cyegx);
							// 成员2是否监护人
							String cyesfjhrm = getCellFormatValue(
									row.getCell((int) 63)).trim();
							String cyesfjhr = DictUtils.getDictValue(cyesfjhrm,
									"sfdm", "0");
							xs.setCyesfjhr(cyesfjhr);
							// 成员2联系电话
							String cyelxdh = getCellFormatValue(
									row.getCell((int) 64)).trim();
							xs.setCyelxdh(cyelxdh);
							// 成员2出生年月
							String cyecsny = getCellFormatValue(
									row.getCell((int) 65)).trim();
							if (!cyecsny.equals("") && cyecsny != null) {
								String year = cyecsny.substring(0, 4);
								String month = cyecsny.substring(4, 6);
								String cyecsny1 = year + "-" + month;
								xs.setCyecsny(cyecsny1);
							}
							// 成员2身份证件类型
							String cyesfzjlxm = getCellFormatValue(
									row.getCell((int) 66)).trim();
							String cyesfzjlx = DictUtils.getDictValue(
									cyesfzjlxm, "sfzjlx", "0");
							xs.setCyesfzjlx(cyesfzjlx);
							// 成员2身份证件号
							String cyesfzjh = getCellFormatValue(
									row.getCell((int) 67)).trim();
							xs.setCyesfzjh(cyesfzjh);
							// 成员2民族
							String cyemzm = getCellFormatValue(
									row.getCell((int) 68)).trim();
							String cyemz = DictUtils.getDictValue(cyemzm,
									"nation", "0");
							xs.setCyemzm(cyemz);
							// 成员2政治面貌
							String cyezzmmm = getCellFormatValue(
									row.getCell((int) 69)).trim();
							String cyezzmm = DictUtils.getDictValue(cyezzmmm,
									"zzmm", "0");
							xs.setCyezzmmm(cyezzmm);
							// 成员2健康状况
							String cyejkzkm = getCellFormatValue(
									row.getCell((int) 70)).trim();
							String cyejkzk = DictUtils.getDictValue(cyejkzkm,
									"health", "0");
							xs.setCyejkzkm(cyejkzk);
							// 成员2工作或学习单位
							String cyegzhxxdw = getCellFormatValue(
									row.getCell((int) 71)).trim();
							xs.setCyegzhxxdw(cyegzhxxdw);
							// 成员2职务
							String cyeszw = getCellFormatValue(
									row.getCell((int) 72)).trim();
							xs.setCyezw(cyeszw);

							// 修改人
							User user = UserUtils.getUser();
							xs.setUpdateBy(user);
							// 修改时间
							xs.setUpdateDate(new Date());

							xsJbxxService.updateXsxx(xs);
							successNum++;
						} catch (ConstraintViolationException ex) {
							failureMsg.append("<br/>学生 " + xs.getXm()
									+ " 更新失败：");
							List<String> messageList = BeanValidators
									.extractPropertyAndMessageAsList(ex, ": ");
							for (String message : messageList) {
								failureMsg.append(message + "; ");
								failureNum++;
							}
						} catch (Exception ex) {
							failureMsg.append("<br/>学生 " + xs.getXm()
									+ " 更新失败：" + ex.getMessage());
						}
					}
					if (failureNum > 0) {
						failureMsg.insert(0, "，失败 " + failureNum
								+ " 条数据，更新信息如下：");
					}
					addMessage(redirectAttributes, "已成功更新 " + successNum
							+ " 条数据" + failureMsg);
				} catch (Exception e) {
					addMessage(redirectAttributes,
							"更新学生失败！失败信息：" + e.getMessage());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:" + adminPath + "/xs/xsJbxx/xjList?repage";
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "exportZsxxDemo", method = RequestMethod.POST)
	public String exportZsxxDemo(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			List<XsJbxx> list = xsJbxxService.findList(xsJbxx);
			ExcelUtil excel = new ExcelUtil();
			String oldPath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/templet/招生信息采集表V1.1.xls"); // 文件在项目中的老路径
			String newPath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/download/招生信息采集表V1.1.xls"); // 文件在项目中的新路径
			excel.copyFile(oldPath, newPath);
			excel.writeZsxx(newPath, list);
			excel.upload(request, response, newPath);
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes,
					"招生信息采集表V1.1.xls下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/xs/xsJbxx/xjList?repage";
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "exportXsxxDemo", method = RequestMethod.POST)
	public String exportXsxxDemo(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			List<XsJbxx> list = xsJbxxService.findList(xsJbxx);
			ExcelUtil excel = new ExcelUtil();
			String oldPath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/templet/新生信息采集表V1.2.xls"); // 文件在项目中的老路径
			String newPath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/download/新生信息采集表V1.2.xls"); // 文件在项目中的新路径
			excel.copyFile(oldPath, newPath);
			excel.writeXsxx(newPath, list);
			excel.upload(request, response, newPath);
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes,
					"新生信息采集表V1.2.xls下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/xs/xsJbxx/xjList?repage";
	}

	/**
	 * 招生信息采集表导出
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "exportZsxx", method = RequestMethod.POST)
	public String exportZsxx(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "招生信息采集表.xlsx";
			List<XsJbxx> list = xsJbxxService.findList(xsJbxx);
			XsJbxx xsInfo = null;
			for (int i = 0; i < list.size(); i++) {
				xsInfo = list.get(i);
				String csrq = DateUtils.getDateForYMD(xsInfo.getCsrq());// 出生日期
				xsInfo.setCsrq(csrq);
				String rxny = DateUtils.getDateForYM(xsInfo.getRxny());// 入学年月
				xsInfo.setRxny(rxny);
			}

			new ExportExcel("招生信息采集表", xsInfo.getClass(), 1, 1)
					.setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出招生信息采集表失败！失败信息：" + e.getMessage());
			System.err.println(e.getMessage());
		}
		return "redirect:" + adminPath + "/xs/xsJbxx/xjList?repage";
	}

	/**
	 * 新生信息采集表导出
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "exportXsxx", method = RequestMethod.POST)
	public String exportXsxx(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "新生信息采集表.xlsx";
			List<XsJbxx> list = xsJbxxService.findList(xsJbxx);
			XsJbxx xsInfo = null;
			for (int i = 0; i < list.size(); i++) {
				xsInfo = list.get(i);
				String csrq = DateUtils.getDateForYMD(xsInfo.getCsrq());// 出生日期
				xsInfo.setCsrq(csrq);
				String rxny = DateUtils.getDateForYM(xsInfo.getRxny());// 入学年月
				xsInfo.setRxny(rxny);
				String cyycsny = DateUtils.getDateForYM(xsInfo.getCyycsny());// 成员1出生年月
				xsInfo.setCyycsny(cyycsny);
				String cyecsny = DateUtils.getDateForYM(xsInfo.getCyecsny());// 成员2出生年月
				xsInfo.setCyecsny(cyecsny);
				BjJbxx bjxx = bjJbxxService.get(xsInfo.getBjmc());// 班级名称
				if (bjxx != null) {
					String bjName = bjxx.getBjmc();
					xsInfo.setBjName(bjName);
				}
				ZyJbxx zyxx = zyJbxxService.get(xsInfo.getZyId());// 专业名称
				if (zyxx != null) {
					String zyName = zyxx.getZymc();
					xsInfo.setZyName(zyName);
				}
			}
			new ExportExcel("信息信息采集表", xsInfo.getClass(), 1, 2)
					.setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出新生信息采集表失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/xs/xsJbxx/xjList?repage";
	}

	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "exportTxxx", method = RequestMethod.POST)
	public void exportTxxx(HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			System.out.println("导出头像信息.");
			// 压缩文件
			XsJbxxController xsjbxx = new XsJbxxController();
			xsjbxx.zip("C:\\studentPhoto.zip", new File("D:\\studentPhoto"));
			// 下载zip包
			String filePath = "C:\\studentPhoto.zip";
			File f = new File(filePath);
			if (f.exists()) {
				upload("C:\\studentPhoto.zip", request, response);
			} else {
				System.out.println("压缩文件不存在.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void zip(String zipFileName, File inputFile) throws Exception {
		System.out.println("压缩中...");
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
				zipFileName));
		BufferedOutputStream bo = new BufferedOutputStream(out);
		zip(out, inputFile, inputFile.getName(), bo);
		bo.close();
		out.close(); // 输出流关闭
		System.out.println("压缩完成");
	}

	private int k = 1; // 定义递归次数变量

	private void zip(ZipOutputStream out, File f, String base,
			BufferedOutputStream bo) throws Exception { // 方法重载
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			if (fl.length == 0) {
				out.putNextEntry(new ZipEntry(base + "/")); // 创建zip压缩进入点base
				System.out.println(base + "/");
			}
			for (int i = 0; i < fl.length; i++) {
				zip(out, fl[i], base + "/" + fl[i].getName(), bo); // 递归遍历子文件夹
			}
			System.out.println("第" + k + "次递归");
			k++;
		} else {
			out.putNextEntry(new ZipEntry(base)); // 创建zip压缩进入点base
			System.out.println(base);
			FileInputStream in = new FileInputStream(f);
			BufferedInputStream bi = new BufferedInputStream(in);
			int b;
			while ((b = bi.read()) != -1) {
				bo.write(b); // 将字节流写入当前zip目录
				bo.flush();// 刷新
			}
			bi.close();
			in.close(); // 输入流关闭
		}
	}

	// 下载web应用下的文件
	private void upload(String filePath, HttpServletRequest request,
			HttpServletResponse response) {
		InputStream fis = null;
		OutputStream os = null;
		try {
			System.out.println("=filePath:=" + filePath);

			File outfile = new File(filePath);
			String filename = outfile.getName();// 获取文件名称
			fis = new BufferedInputStream(new FileInputStream(filePath));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer); // 读取文件流
			// fis.close();
			response.reset(); // 重置结果集
			response.addHeader("Content-Disposition", "attachment;filename="
					+ new String(
							filename.replaceAll(" ", "").getBytes("utf-8"),
							"iso8859-1")); // 返回头 文件名
			response.addHeader("Content-Length", "" + outfile.length()); // 返回头
																			// 文件大小
			response.setContentType("application/octet-stream"); // 设置数据种类
			// 获取返回体输出权
			os = new BufferedOutputStream(response.getOutputStream());
			os.write(buffer); // 输出文件
			os.flush();
			// os.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		String filePath2 = "C:\\studentPhoto.zip";
		File f2 = new File(filePath2);
		if (f2.exists()) {
			f2.delete();
		}
	}

	/**
	 * 跳转区域统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "qytjForm", "" })
	public String qytjForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		addPropertys(model);
		return "modules/xs/qytjForm";
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = { "qytjList", "" })
	public String qytjList(Model model, @RequestParam("zsjhid") String zsjhid,
			@RequestParam("csid") String csid, HttpServletRequest request,
			HttpServletResponse response) {
		List<XsJbxx> list = xsJbxxService.qytjList(zsjhid, csid);
		List<String> qyidlist = new ArrayList<String>();// 区域信息
		List<Integer> rwllist = new ArrayList<Integer>();// 任务量
		List<Integer> zsllist = new ArrayList<Integer>();// 招生量
		List<Integer> bmllist = new ArrayList<Integer>();// 报名量
		String zytjTable = "";
		zytjTable += "<table class='table table-striped table-bordered table-condensed'>";
		zytjTable += "<tr><td>区域</td><td>任务量</td><td>招生量</td><td>报名量</td></tr>";
		for (int i = 0; i < list.size(); i++) {
			XsJbxx xsJbxx = list.get(i);
			qyidlist.add(xsJbxx.getQuyu());
			rwllist.add(xsJbxx.getRwl());
			zsllist.add(xsJbxx.getZsl());
			bmllist.add(xsJbxx.getBml());
			zytjTable += "<tr>";
			zytjTable += "<td>" + xsJbxx.getQuyu() + "</td>";
			zytjTable += "<td>" + xsJbxx.getRwl() + "</td>";
			zytjTable += "<td>" + xsJbxx.getZsl() + "</td>";
			zytjTable += "<td>" + xsJbxx.getBml() + "</td>";
			zytjTable += "</tr>";
		}
		zytjTable += "</table>";
		Map m = new HashMap();
		m.put("qyidlist", qyidlist);
		m.put("rwllist", rwllist);// 任务量
		m.put("zsllist", zsllist);// 招生量
		m.put("bmllist", bmllist);// 报名量
		m.put("qytjTable", zytjTable);
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 跳转专业统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "zytjForm", "" })
	public String zytjForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		addPropertys(model);
		return "modules/xs/zytjForm";
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = { "zytjList", "" })
	public String zytjList(@RequestParam("zsjhid") String zsjhid,
			HttpServletRequest request, HttpServletResponse response) {
		List<XsJbxx> list = xsJbxxService.zytjList(zsjhid);
		List<String> zymclist = new ArrayList<String>();// 专业名称
		List<Integer> rwllist = new ArrayList<Integer>();// 任务量
		List<Integer> zsllist = new ArrayList<Integer>();// 招生量
		List<Integer> bmllist = new ArrayList<Integer>();// 报名量
		String zytjTable = "";
		zytjTable += "<table class='table table-striped table-bordered table-condensed'>";
		zytjTable += "<tr><td>专业名称</td><td>任务量</td><td>招生量</td><td>报名量</td></tr>";
		for (int i = 0; i < list.size(); i++) {
			XsJbxx xsxx = list.get(i);
			zymclist.add(xsxx.getZymc());
			rwllist.add(xsxx.getRwl());
			zsllist.add(xsxx.getZsl());
			bmllist.add(xsxx.getBml());
			zytjTable += "<tr>";
			zytjTable += "<td>" + xsxx.getZymc() + "</td>";
			zytjTable += "<td>" + xsxx.getRwl() + "</td>";
			zytjTable += "<td>" + xsxx.getZsl() + "</td>";
			zytjTable += "<td>" + xsxx.getBml() + "</td>";
			zytjTable += "</tr>";
		}
		zytjTable += "</table>";
		Map m = new HashMap();
		m.put("zymclist", zymclist);
		m.put("rwllist", rwllist);// 任务量
		m.put("zsllist", zsllist);// 招生量
		m.put("bmllist", bmllist);// 报名量
		m.put("zytjTable", zytjTable);
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 跳转来源统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "lytjForm", "" })
	public String lytjForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		addPropertys(model);
		return "modules/xs/lytjForm";
	}

	/**
	 * 跳转部门统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "bmtjForm", "" })
	public String bmtjForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		addPropertys(model);
		return "modules/xs/bmtjForm";
	}

	/**
	 * 跳转个人统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "grtjForm", "" })
	public String grtjForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		addPropertys(model);
		Page<XsJbxx> page = xsJbxxService.findPage(new Page<XsJbxx>(request,
				response), xsJbxx);
		model.addAttribute("page", page);
		return "modules/xs/grtjForm";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = { "lytjList", "" })
	public String lytjList(@RequestParam("zsjhid") String zsjhid,
			HttpServletRequest request, HttpServletResponse response) {
		List<XsJbxx> list = xsJbxxService.lytjList(zsjhid);

		List<String> zymclist = new ArrayList<String>();// 专业名称
		List<Integer> zswdjlist = new ArrayList<Integer>();// 招生网登记
		List<Integer> zslsdjist = new ArrayList<Integer>();// 招生老师登记
		List<Integer> mmdjlist = new ArrayList<Integer>();// 慕名登记
		List<Integer> zsdjlist = new ArrayList<Integer>();// 招生代理机构登记

		String lytjTable = "";
		lytjTable += "<table class='table table-striped table-bordered table-condensed'>";
		lytjTable += "<tr><td>专业名称</td><td>招生网登记</td><td>招生老师登记</td><td>慕名登记</td><td>招生代理机构登记</td></tr>";
		for (int i = 0; i < list.size(); i++) {
			XsJbxx xsxx = list.get(i);
			zymclist.add(xsxx.getZymc());
			zswdjlist.add(xsxx.getZsw());
			zslsdjist.add(xsxx.getZsls());
			mmdjlist.add(xsxx.getMuming());
			zsdjlist.add(xsxx.getDljg());
			lytjTable += "<tr>";
			lytjTable += "<td>" + xsxx.getZymc() + "</td>";
			lytjTable += "<td>" + xsxx.getZsw() + "</td>";
			lytjTable += "<td>" + xsxx.getZsls() + "</td>";
			lytjTable += "<td>" + xsxx.getMuming() + "</td>";
			lytjTable += "<td>" + xsxx.getDljg() + "</td>";
			lytjTable += "</tr>";
		}
		lytjTable += "</table>";
		Map m = new HashMap();
		m.put("zymclist", zymclist);
		m.put("zswdjlist", zswdjlist);// 招生网登记
		m.put("zslsdjist", zslsdjist);// 招生老师登记
		m.put("mmdjlist", mmdjlist);// 慕名登记
		m.put("zsdjlist", zsdjlist);// 招生代理机构登记

		m.put("lytjTable", lytjTable);
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 功能:跳转带参数
	 */
	private void addPropertys(Model model) {
		Zsdj zsdj2 = new Zsdj();
		List<Zsjh> list2 = DictUtils.getZsjhList();
		// 通过时间来判断
		Date later = null;
		Zsjh zsjh = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list2.size(); i++) {
			String date = sdf.format(list2.get(i).getCreateDate());
			try {
				if (later == null) {
					zsjh = list2.get(i);
					later = sdf.parse(date);
				} else {
					if (later.before(sdf.parse(date))) {
						zsjh = list2.get(i);
						later = sdf.parse(date);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		zsdj2.setZsjh(zsjh);
		model.addAttribute("zsdj", zsdj2);
	}

	/************** 招生统计/个人 分析 *********************************/
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping("zstjGrList")
	public String zstjGrList(@RequestParam("jsid") String jsid,
			@RequestParam("jhid") String jhid, XsJbxx xsjbxx,
			HttpServletRequest request, HttpServletResponse response) {

		/*System.out.println("教师ID信息:" + jsid);
		System.out.println("招生计划ID信息:" + jhid);*/
		if (jsid == null || jsid.equals("") || jsid == "" || jhid == null
				|| jhid.equals("") || jhid == "") {
			jsid = UserUtils.getUser().getId();
			jhid = xsJbxxService.getZuiXinJhId();
		}

		List<XsJbxx> list = xsJbxxService.zstjGrList(jsid, jhid);
		List<Map> maps = new ArrayList<Map>();
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				Map m = new HashMap();
				m.put("y", list.get(i).getRwl());
				m.put("name", list.get(i).getZsl());
				maps.add(m);
			}
		} else {
			Map m = new HashMap();
			m.put("y", "0");
			m.put("name", "");
			maps.add(m);
		}
		return JsonMapper.toJsonString(maps);
	}

	/************* 当前登录用户所在部门的成员招生量 ************************************/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping("zstjBmcy")
	public String zstjBmcyList(@RequestParam("id") String id,
			@RequestParam("jhId") String jhId, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Map> lists = new ArrayList<Map>();
		List<User> users = systemService.findSysUserByOfficeId(id);
		for (int i = 0; i < users.size(); i++) {
			Map m = new HashMap();
			String uid = users.get(i).getId();
			Zsdj zsdj = new Zsdj();
			zsdj.setOfficeId(uid);
			zsdj.setJhId(jhId);
			Zsdj xsJbxx = xsJbxxService.zstjBmcyList(zsdj);
			if (xsJbxx != null) {
				m.put("num", xsJbxx.getRwl());
			} else {
				m.put("num", "0");
			}
			if (users.get(i) != null) {
				m.put("name", users.get(i).getName());
			} else {
				m.put("name", "");
			}
			lists.add(m);
		}
		return JsonMapper.toJsonString(lists);
	}

	/************* 招生统计/各部门 招生量 ************************************/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping("zstjgzy")
	public String zstjgbmList(@RequestParam("jhId") String jhId,
			HttpServletRequest request, HttpServletResponse response) {
		Zsdj zsdj = new Zsdj();
		zsdj.setId(jhId);
		List<Zsdj> list = xsJbxxService.zstjgzyList(zsdj);
		List num = new ArrayList();
		List dateN = new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			num.add(list.get(i).getRwl());
			dateN.add(list.get(i).getZymc());
		}
		Map m = new HashMap();
		m.put("num", num);
		m.put("dateN", dateN);
		return JsonMapper.toJsonString(m);
	}

	/************* 招生统计/各部门 的实际招生量和计划招生量 ************************************/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping("zstjgbmDb")
	public String zstjgbmDbList(@RequestParam("jhId") String jhId,
			XsJbxx xsjbxx, HttpServletRequest request,
			HttpServletResponse response) {
		Zsdj zsdj = new Zsdj();
		zsdj.setJhId(jhId);
		List<Zsdj> list = xsJbxxService.zstjgbmDbList(zsdj);

		// 个人
		/* List<Zsdj> grList = xsJbxxService.zstjBmgrList(zsdj); */

		List bm = new ArrayList();// 部门
		List dateSj = new ArrayList();// 实际招生量
		List dateJh = new ArrayList();// 计划招生量
		for (int i = 0; i < list.size(); i++) {
			dateSj.add(list.get(i).getRwl());
			dateJh.add(list.get(i).getZsl());
			bm.add(list.get(i).getZymc());
		}

		/*
		 * if(grList!=null && grList.size()>0){ for (int i = 0; i <
		 * grList.size(); i++) { dateSj.add(grList.get(i).getRwl());
		 * dateJh.add(grList.get(i).getZsl()); bm.add(grList.get(i).getZymc());
		 * } }
		 */
		Map m = new HashMap();
		m.put("bm", bm);
		m.put("dateSj", dateSj);
		m.put("dateJh", dateJh);
		return JsonMapper.toJsonString(m);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping("getGeRenXinXi")
	public String getGeRenXinXi(XsJbxx xsjbxx, HttpServletRequest request,
			HttpServletResponse response) {
		String userId = UserUtils.getUser().getId();

//		XsJbxx xsJbxx2 = xsJbxxService.getGeRenXinXi(userId);
		 BdJbxx bdJbxx=new BdJbxx();
		 bdJbxx.setZsjh(zsjhService.get(xsjbxx.getJhid()));
		 bdJbxx.setJfzt(CommonUtils.SYS_SHI);
		 bdJbxx.setJs(new JsJbxx(userId));
		 List<BdJbxx> list = bdJbxxService.findList(bdJbxx);
		Map m = new HashMap();
		/*if (xsJbxx2 != null) {
			// m.put("rwl", xsJbxx2.getRwl());
			m.put("zsl", xsJbxx2.getZsl());
		} else {
			// m.put("rwl", "0");
			m.put("zsl", "0");
		}*/
		m.put("zsl", list.size());
		return JsonMapper.toJsonString(m);
	}

	@ResponseBody
	@RequestMapping("getGeRen")
	public String getGeRen(@RequestParam("id") String jhid) {
		String userId = UserUtils.getUser().getId();

		JhFjGr jhFjGr = new JhFjGr();
		jhFjGr.setJsId(userId);

		List<JhFjGr> list = jhFjGrService.findList(jhFjGr);
		Map m = new HashMap();
		for (JhFjGr jhFjGr2 : list) {
			if (jhFjGr2.getZsjh().getId().equals(jhid) == true) {
				m.put("zsrs", jhFjGr2.getZsrs());
				/*
				 * System.out.println(jhFjGr2.getZsrs()+"============"+jhFjGr2.
				 * getJsId()
				 * +"   ...."+jhid+"   bbbbb   "+jhFjGr2.getZsjh().getId());
				 */

			}

		}
		if (m.size() < 1) {
			m.put("zsrs", "0");

		}
		return JsonMapper.toJsonString(m);
	}

	@ResponseBody
	@RequestMapping(value = "getBanJiByZyid")
	public String getBanJiByZyid(@RequestParam("bjid") String bjid,
			@RequestParam("zyid") String zyid,
			RedirectAttributes redirectAttributes) {
		BjJbxx xsfb = new BjJbxx();
		ZyJbxx zyJbxx = new ZyJbxx();
		zyJbxx.setId(zyid);
		xsfb.setZyId(zyJbxx);
		List<BjJbxx> bjList = this.xsfbService.findList(xsfb);
		StringBuffer bjStr = new StringBuffer();
		bjStr.append("<select class='input-xlarge required' name='bjmc.id' id='bjID' >");
		if (bjList != null && bjList.size() > 0) {
			for (BjJbxx entity : bjList) {
				bjStr.append("<option value='" + entity.getId() + "' ");
				if (bjid != null && !"".equals(bjid)) {
					if (bjid.equals(entity.getId())) {
						bjStr.append("selected='selected'");
					}
				}

				bjStr.append(">" + entity.getBjmc() + "</option>");
			}
		}
		bjStr.append("</select ><span class='help-inline'><font color='red'>*</font> </span>");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bjHtml", bjStr.toString());
		return JsonMapper.toJsonString(map);
	}

	/**
	 * Des:根据条件查询学生信息 2016-12-16
	 * 
	 * @author fn
	 * @param njId
	 *            年级id
	 * @param bjId
	 *            班级id
	 * @param zyId
	 *            专业id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "getXsJbssList")
	public String getXsJbssList(String njId, String bjId, String zyId) {
		XsJbxx xsjbxx = new XsJbxx();
		xsjbxx.setRemarks("222");
		if (njId != null && !"".equals(njId)) {
			XnJbxx nj = new XnJbxx();
			nj.setId(njId);
			xsjbxx.setNj(nj);
		}
		if (bjId != null && !"".equals(bjId)) {
			BjJbxx bjmc = new BjJbxx();
			bjmc.setId(bjId);
			xsjbxx.setBjmc(bjmc);
		}
		if (zyId != null && !"".equals(zyId)) {
			ZyJbxx zy = new ZyJbxx();
			zy.setId(zyId);
			xsjbxx.setZyId(zy);
		}
		List<XsJbxx> list = xsJbxxService.findList(xsjbxx);
		Map map = new HashMap();
		if (list != null && list.size() > 0) {
			map.put("isTrue", false);
		} else {
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}
	
	

	/************************************ 学生基本信息JSON格式数据 ************************************************************/
	@ResponseBody
	@RequestMapping(value = "getXsxxJson")
	public List<Map<String, Object>> getXsxxJson(XsJbxx xsjbxx,
			HttpServletRequest request, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Page<XsJbxx> page = xsJbxxService.findPage(new Page<XsJbxx>(request,
				response), xsjbxx);
		List<XsJbxx> listXsJbxx = page.getList();
		for (int i = 0; i < listXsJbxx.size(); i++) {
			XsJbxx xsJbxxObj = listXsJbxx.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("xm", xsJbxxObj.getXm());
			map.put("xbm", xsJbxxObj.getXbm());
			map.put("xxdz", xsJbxxObj.getJtxdz());
			map.put("lxdh", xsJbxxObj.getLxdh());
			mapList.add(map);
		}
		return mapList;
	}

	/***************** 2017-03-10 统计分析下四个页面Form ***************************************/
	// 年度招生任务完成情况
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "ndzsrwwcqkForm", "" })
	public String ndzsrwwcqkForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Map> zsndList = zsjhService.findAllZsnd();
		model.addAttribute("zsndList", zsndList);
		return "modules/xs/ndzsrwwcqkForm";
	}

	// 年度间招生任务完成情况
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "ndjzsrwwcqkForm", "" })
	public String ndjzsrwwcqkForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Map> zsndList = zsjhService.findAllZsnd();
		model.addAttribute("zsndList", zsndList);
		return "modules/xs/ndjzswcqkForm";
	}

	// 年度专业招生完成情况
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "ndzyzswcqkForm", "" })
	public String ndzyzswcqkForm(XsJbxx xsJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		addPropertys(model);
		return "modules/xs/ndzyzswcqkForm";
	}

	// 年度招生区域分布情况
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "ndzsqyfbqkForm", "" })
	public String ndzsqyfbqkForm(HttpServletRequest request,
			HttpServletResponse response, Model model, Model model2,
			Model model3) {
		int zrws = 0;// 总任务数
		int zdjs = 0;// 总登记数
		int zwcs = 0;// 总完成数
		Statistics ss = new Statistics();
		// 所有招生年度
		List<Map> list = zsjhDao.findAllZsnd();
		Area area = new Area();
		area.setParent(new Area("1"));
		// 所有省
		Statistics s;
		String zsnd;
		List<Statistics> statList = new ArrayList<Statistics>();
		if (list.size()<1) {
			zsnd="";
		}else {
			zsnd=(String)list.get(0).get("zsnd");
		
		List<Area> areas = areaService.findAllByChr(area);
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		List<Map> byAREA=null;
		for (int i = 0; i < areas.size(); i++) {
			Area a = areas.get(i);
			s = new Statistics();
			s.setId(a.getId());
			s.setName(a.getName());
			Map aMap = new HashMap();
			aMap.put("zsnd", zsnd);
			aMap.put("type", a.getType());
			aMap.put("id", a.getId());
			byAREA = areaService.findByAREA(aMap);
			s.setZsnd(zsnd);
			int rws = Integer.parseInt((String) byAREA.get(0).get("zrws").toString());
			int djs = Integer.parseInt((String)byAREA.get(0).get("zdjs").toString());
			int wcs = Integer.parseInt((String)byAREA.get(0).get("zwcs").toString());
			s.setNum1(rws);
			s.setNum2(djs);
			s.setNum3(wcs);
			if (rws<1) {
				s.setNum4("--");
			}else{
				s.setNum4((String)byAREA.get(0).get("wcPercent"));
			}
			zrws+=rws;
			zdjs+=djs;
			zwcs+=wcs;
			if (rws<1&&djs<1&&wcs<1) {
				statList.remove(s);
			}else {
				statList.add(s);
			}
		}
		ss.setNum5(zrws);
		ss.setNum6(zdjs);
		ss.setNum7(zwcs);
		double wc=zwcs;
		double rw=zrws;
		if (zrws > 0) {
			ss.setNum8(format.format(wc / rw));
		} else {
			ss.setNum8("--");
		}
		}
		model3.addAttribute("zarea", ss);
		model.addAttribute("area", statList);
		model2.addAttribute("jh", list);
		return "modules/xs/ndzsqyfbqkForm";
	}

	// 年度招生生源校分布情况
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "ndzssyxfbqkForm", "" })
	public String ndzssyxfbqkForm(String zsnd, String syx,
			HttpServletRequest request, HttpServletResponse response,
			Model model, Model model2, Model model3, Model model4) {
		// 所有招生年度
		List<Map> list = zsjhDao.findAllZsnd();
		// 创建List用于保存生源校与专业信息
		List<List<Map>> school_ZyList = new ArrayList<List<Map>>();
		if (list.size()<1) {
			zsnd = "" ;
		}else {
			if (zsnd == "" || zsnd == null) {
			zsnd = (String) list.get(0).get("zsnd");
			}
		Zsdj zsdj = new Zsdj();
		zsdj.setZsnd(zsnd);
		if (syx == null || syx.length() < 1) {
				/* 根据生源校和招生年度查询出学校、专业、任务数、登记数、完成数 */
				List<Map> SchoolZys = zsdjService.getSchoolByZYMC(zsdj);
				school_ZyList.add(SchoolZys);
		} else {
			zsdj.setFromSchool(syx);
			/* 根据生源校和招生年度查询出学校、专业、任务数、登记数、完成数 */
			List<Map> SchoolZys = zsdjService.getSchoolByZYMC(zsdj);
			school_ZyList.add(SchoolZys);
		}
		}
		List<Map> schools = zsdjService.getBySchool(zsnd);
		model3.addAttribute("zymcs", school_ZyList);
		model.addAttribute("jh", list);
		model2.addAttribute("school", schools);
		model4.addAttribute("zsnd", zsnd);
		model4.addAttribute("fromSchool", syx);
		return "modules/xs/ndzssyxfbqkForm";
	}

	// 年度间招生生源校分布情况
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = "ndjsyx")
	public String ndjsyx(HttpServletRequest request,String zsnd,String syx,
			HttpServletResponse response, Model model) 
	{
				//创建List用于保存生源校与专业信息
				List<List<Map>> school_ZyList=new ArrayList<List<Map>>();
		        //所有招生年度
				List<Map> list = zsjhDao.findAllZsnd();
				Map map = new HashMap();
				List<Map> ndjList=new ArrayList<Map>();
				if (list.size()<2) {
					zsnd="";
				}else{
					if (zsnd==null||zsnd.equals("")) {
						zsnd=list.get(0).get("zsnd")+","+(String) list.get(1).get("zsnd");
					}
				Map zsndmap = new HashMap();
				zsndmap.put("zsndString", zsnd);
				zsndmap.put("syx", syx);
				List<Map> schoolAndZY = zsdjService.getSchoolAndZY(zsndmap);
				String[] str = zsnd.split(",");
				List<List<Map>> tempMap=new ArrayList<List<Map>>();
				for (int k = 0; k < str.length; k++) {
					Map map2=new HashMap();
					boolean falg=false;
					String nd =str[k];
					Zsdj zsdj = new Zsdj();
					zsdj.setZsnd(nd);
					List<Map> SchoolZys = zsdjService.getSchoolByDATE(zsdj);
					if (SchoolZys.size()<1) {
						SchoolZys = new ArrayList<Map>();
						Map hashMap = new HashMap();
						hashMap.put("zsnd", nd);
						SchoolZys.add(hashMap);
					}
					tempMap.add(SchoolZys);
				}
				String key = null;
				String value = null;
				String valueid=null;
			
				for (int i = 0; i < schoolAndZY.size(); i++) {
					value=(String)schoolAndZY.get(i).get("zymc");
					valueid=(String)schoolAndZY.get(i).get("zyid");
					key=(String)schoolAndZY.get(i).get("school");
					for (int k = 0; k < tempMap.size(); k++) {
						Map map2=new HashMap();
						boolean falg=false;
						String nd=null;
						List<Map> SchoolZys = tempMap.get(k);
						for (int j = 0; j < SchoolZys.size(); j++) {
							String school=(String) SchoolZys.get(j).get("fromSchool");
							String zymc=(String) SchoolZys.get(j).get("zymc");
							String zyid=(String) SchoolZys.get(j).get("zyid");
							nd=(String) SchoolZys.get(j).get("zsnd");
							if (key.equals(school)&&valueid.equals(zyid)) {
								falg=true;
								map2= SchoolZys.get(j);
							}
						}
						if (!falg) {
							map2.put("fromSchool", key);
							map2.put("zymc", value);
							map2.put("zsnd", nd);
							map2.put("rws", 0);
							map2.put("djs", 0);
							map2.put("wcs", 0);
						}
						ndjList.add(map2);
					}
				}
				}
		        model.addAttribute("syxHidden", syx);
		        model.addAttribute("zsnd", zsnd);
		model.addAttribute("jh", list);
		model.addAttribute("ndjsyx", ndjList);
		return "modules/xs/ndjsyx";
	}

	/**
	 * 个人排行榜统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "paiHangGRForm", "" })
	public String paiHangGRForm(JhFjRw jhFjRw,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		addPropertys(model);
		if (jhFjRw.getJhId() == null || jhFjRw.getJhId().trim().length() == 0) {
			if (DictUtils.getZsjhList().size()<1) {
				jhFjRw.setJhId(""); 
			}else {
				jhFjRw.setJhId(DictUtils.getZsjhList().get(0).getId()); 
			}
		}
		List<Statistics> list = zsjhService.paiHangGRByZsjhAndBm(jhFjRw.getJhId(), jhFjRw.getBmId());
		model.addAttribute("list", list);
		model.addAttribute("jhFjRw", jhFjRw);
		return "modules/xs/paiHangGRForm";
	}

	/**
	 * 部门排行榜统计
	 * 
	 * @param xsJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("xs:xsJbxx:view")
	@RequestMapping(value = { "paiHangBMForm", "" })
	public String paiHangBMForm(JhFjRw jhFjRw,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		addPropertys(model);
		if (jhFjRw.getJhId() == null || jhFjRw.getJhId().trim().length() == 0) {
			if (DictUtils.getZsjhList().size()<1) {
				jhFjRw.setJhId(""); 
			}else {
				jhFjRw.setJhId(DictUtils.getZsjhList().get(0).getId()); 
			}
		}
		List<Statistics> list = zsjhService.paiHangBMByZsjh(jhFjRw.getJhId());
		model.addAttribute("list", list);
		model.addAttribute("jhFjRw", jhFjRw);
		return "modules/xs/paiHangBMForm";
	}
	// 年度间招生区域分布情况
		@RequiresPermissions("xs:xsJbxx:view")
		@RequestMapping(value = { "ndjzsqu", "" })
		public String ndjzsqu(HttpServletRequest request,String zsnd,
				HttpServletResponse response, Model model, Model model2,
				Model model3) {
			NumberFormat format = NumberFormat.getPercentInstance();
			format.setMinimumFractionDigits(2);
			List<Statistics> ssList = new ArrayList<Statistics>();
			// 所有招生年度
			List<Map> list = zsjhDao.findAllZsnd();
			List<Statistics> statList = new ArrayList<Statistics>();
			List<Statistics> statList1 = new ArrayList<Statistics>();
			if (list.size()<2) {
				zsnd="";
			}else {
			
			Area area = new Area();
			area.setParent(new Area("1"));
			Statistics s;String nd;
			// 所有省
			List<Area> areas = areaService.findAllByChr(area);
		
			List<Map> ndjList=new ArrayList<Map>();
			if (zsnd==null||zsnd.equals("")) {
				nd=list.get(0).get("zsnd")+","+list.get(1).get("zsnd");
			}else {
				nd=zsnd;
			}
			String[] str = nd.split(",");
			for (int i = 0; i < str.length; i++) {
				Statistics sata = new Statistics();
				sata.setZsnd(str[i]);
				sata.setNum5(0);
				sata.setNum6(0);
				sata.setNum7(0);
				ssList.add(sata);
			}
			for (int i = 0; i < areas.size(); i++) {
				Map aMap = new HashMap();
				statList1=new ArrayList<Statistics>();
				for (int j = 0; j < str.length; j++) {
					Area a = areas.get(i);
					s = new Statistics();
					s.setId(a.getId());
					s.setName(a.getName());
					String zndString=str[j];
					aMap.put("zsnd", zndString);
					aMap.put("type", a.getType());
					aMap.put("id", a.getId());
					List<Map> byAREA = areaService.findByAREA(aMap);
					s.setZsnd(zndString);
					s.setNum1(Integer.parseInt((String) byAREA.get(0).get("zrws").toString()));
					s.setNum2(Integer.parseInt((String)byAREA.get(0).get("zdjs").toString()));
					s.setNum3(Integer.parseInt((String)byAREA.get(0).get("zwcs").toString()));
					s.setNum4((String)byAREA.get(0).get("wcPercent"));
					statList1.add(s);
					
					for (int k = 0; k < ssList.size(); k++) {
						if (zndString.equals(ssList.get(k).getZsnd())) {
							ssList.get(k).setNum5(ssList.get(k).getNum5()+Integer.parseInt((String) byAREA.get(0).get("zrws").toString()));
							ssList.get(k).setNum6(ssList.get(k).getNum6()+Integer.parseInt((String) byAREA.get(0).get("zdjs").toString()));
							ssList.get(k).setNum7(ssList.get(k).getNum7()+Integer.parseInt((String) byAREA.get(0).get("zwcs").toString()));
						}
					}
				}
				
				boolean flag=false;
				for (int j = 0; j < statList1.size(); j++) {
					if (statList1.get(j).getNum1()>0||statList1.get(j).getNum2()>0||statList1.get(j).getNum3()>0) {
						flag=true;
					}
				}
				if (flag) {
					statList.addAll(statList1);
				}
				
			}
			for (int i = 0; i < statList.size(); i++) {
				if (statList.get(i).getNum1()==0) {
					statList.get(i).setNum4("--");
				}
			}
			for (int k = 0; k < ssList.size(); k++) {
				
				if (ssList.get(k).getNum5() > 0) {
					ssList.get(k).setNum8(format.format((double)ssList.get(k).getNum7() /(double)ssList.get(k).getNum5()));
				} else {
					ssList.get(k).setNum8("--");
				}
			}
		    zsnd=list.get(0).get("zsnd")+","+list.get(1).get("zsnd");
			}
			model3.addAttribute("zarea", ssList);
			model.addAttribute("area", statList);
			model2.addAttribute("jh", list);
			model.addAttribute("nd", zsnd);
			return "modules/xs/ndjzsqu";
		}
		
		
		
		
		
		
		
		/**
		 * @RequiresPermissions("xs:xsJbxx:view")
		 * @return@ResponseBody
		 */
		@RequiresPermissions("xs:xsJbxx:view")
		@RequestMapping(value = "exportXjInfo")
		public String exportXjInfo(XsJbxx xsJbxx, HttpServletRequest request,
				HttpServletResponse response, Model model)
		{
			// 当前用户操作
			if (xsJbxx == null) {
				xsJbxx = new XsJbxx();
			}
			User user = UserUtils.getUser();
			List<Role> roleList = user.getRoleList();
			Role userRole = this.getUserRole(roleList);
			if (userRole != null) {
				user.setRole(userRole);
				if (xsJbxx.getBjmc() != null && xsJbxx.getBjmc().getId() != null
						&& !xsJbxx.getBjmc().getId().equals("")) {
					xsJbxx.getBjmc().setJsId(user);
				} else {
					BjJbxx bj = new BjJbxx();
					bj.setJsId(user);
					xsJbxx.setBjmc(bj);
				}
			}
			xsJbxx.setBgydlxlszt("9");//状态为9则查询变更异动状态不等于1(变更异动审核中)的数据
			List<XsJbxx> list = xsJbxxService.findList(xsJbxx);
			ExcelUtil excel = new ExcelUtil();
			String oldPath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/templet/新生信息采集表V1.2.xls"); // 文件在项目中的老路径
			String newPath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/upload/新生信息.xls"); // 文件在项目中的新路径
			excel.copyFile(oldPath, newPath);
			excel.writeXsInfo(newPath, list);
			excel.upload(request, response, newPath);
	        return null;
		}
		
		/**导入
		 * @param xsJbxx
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 */
		@RequiresPermissions("xs:xsJbxx:view")
		@RequestMapping(value = "daoRuXjDialog")
		public String daoRuXjDialog(XsJbxx xsJbxx, HttpServletRequest request,
				HttpServletResponse response, Model model)
		{
			
			return "modules/xs/daoRuXjDialog";
		}
		
		//@RequiresPermissions("xs:xsJbxx:view")
		/**
		 * 判断并保存导入的学籍信息+
		 * 
		 * @param file
		 * @param request
		 * @param redirectAttributes
		 * @return
		 */
		@ResponseBody
		@RequestMapping(value = "importXjInfo")
		public String importXjInfo(MultipartFile file, HttpServletRequest request,
				RedirectAttributes redirectAttributes)
		{
			StringBuilder failureMsg = new StringBuilder();
			Map<String,Object> map = new HashMap<String, Object>();
			//存储信息
			List<XsJbxx> xsJbxxList = new ArrayList<XsJbxx>();
			// 判断文件是否为空
			try {
				if (!file.isEmpty())
				{
					// 文件保存路径
					String filePath = request
							.getSession()
							.getServletContext()
							.getRealPath(
									"/WEB-INF/upload/" + file.getOriginalFilename());
					// 转存文件
					file.transferTo(new File(filePath));
					
					// 读取Excel表格内容
					InputStream is = new FileInputStream(filePath);
					try {
						fs = new POIFSFileSystem(is);
						wb = new HSSFWorkbook(fs);
					} catch (IOException e) {
						e.printStackTrace();
					}
					sheet = wb.getSheetAt(1);
					// 得到总行数
					int rowNum = sheet.getLastRowNum();
					row = sheet.getRow(0);
					
					//身份证号
					String idCardRegex = "(^\\d{18}$)|(^\\d{15}$)";
					//纯字母
					String ziMuRegex ="^[A-Za-z]+$";
					//数字
					String shuZiRegex ="^[0-9]*$";
					//email
					String emailRegex = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
					//mobile phone
					String mobileRegex = "^1\\d{10}$";
					String phoneRegex ="^((\\(\\d{2,3}\\))|(\\d{3}\\-))?(\\(0\\d{2,3}\\)|0\\d{2,3}-)?[1-9]\\d{6,7}(\\-\\d{1,4})?$";
					
					// 正文内容应该从第四行开始
					for (int i = 3; i <= rowNum; i++) 
					{
						XsJbxx entity = null;
						row = sheet.getRow(i);
						// 姓名
						String xm = getCellFormatValue(row.getCell((int) 0)).trim();
						if(xm == null || "".equals(xm)){
							continue;
						}
						// 身份证件类型
						String sfzjlxm = getCellFormatValue(
								row.getCell((int) 3)).trim();
						String sfzjlx = DictUtils.getDictValue(sfzjlxm,
								"sfzjlx", "0");
						// 身份证件号
						String sfzjh = getCellFormatValue(row.getCell((int) 4)).trim();
						//错误信息提交
						String errorMsg ="第"+(i+1)+"行:学生:"+xm+",身份证件号:"+sfzjh;
						
						boolean istrue = true;
						//身份证号验证
						if(sfzjlx.equals("1"))
						{
							istrue = Pattern.matches(idCardRegex, sfzjh);
							if(!istrue)
							{
								errorMsg +=",身份证件号输入有误";
							}
						}
						
						XsJbxx xs = new XsJbxx();
						xs.setSfzjh(sfzjh);
						xs.setXm(xm);
						List<XsJbxx> listBysfzjh = xsJbxxService.selectXjList(xs);
						if(listBysfzjh!=null && listBysfzjh.size()>0)
						{
							entity = (XsJbxx)listBysfzjh.get(0);
							//审核状态
							String shzt = entity.getShzt();
							if(!shzt.equals("3"))
							{
								errorMsg +=",此学生已注册过";
								errorMsg += "</br>";
								failureMsg.append(errorMsg);
								continue;
							}
							// 姓名拼音
							String xmpy = getCellFormatValue(row.getCell((int) 5)).trim();
							if(!Pattern.matches(ziMuRegex, xmpy))
							{
								errorMsg +=",姓名拼音由26个英文字母组成";
							}
							entity.setXmpy(xmpy);
							// 班级名称
							String bjmc = getCellFormatValue(row.getCell((int) 6)).trim();
							// 学号
							String xh = getCellFormatValue(row.getCell((int) 7)).trim();
							if(xh!=null && !"".equals(xh))
							{
								if(!Pattern.matches(shuZiRegex, xh))
								{
									errorMsg +=",学号是正整数数字";
								}
								entity.setXh(xh);
								
							}else{
								errorMsg +=",学号不能为空";
							}
							
							// 学生类别
							String xslbm = getCellFormatValue(row.getCell((int) 8)).trim();
							if(xslbm!=null && !"".equals(xslbm))
							{
								String xslb = DictUtils.getDictValue(xslbm, "xslb","0");
								entity.setXslbm(xslb);
							}else
							{
								errorMsg +=",学生类别不能为空";
							}
							// 学习形式
							String xxxsm = getCellFormatValue(row.getCell((int) 9)).trim();
							if(xxxsm!=null && !"".equals(xxxsm))
							{
								String xxxs = DictUtils.getDictValue(xxxsm, "xxxs","0");
								entity.setXxxsm(xxxs);
							}else
							{
								errorMsg +=",学习形式不能为空";
							}
							
							// 入学方式
							String rxfsm = getCellFormatValue(row.getCell((int) 10)).trim();
							if(rxfsm!=null && !"".equals(rxfsm))
							{
								String rxfs = DictUtils.getDictValue(rxfsm, "rxfs","0");
								entity.setRxfsm(rxfs);
							}else
							{
								errorMsg +=",入学方式不能为空";
							}
							// 就读方式
							String jdfsm = getCellFormatValue(row.getCell((int) 11)).trim();
							if(jdfsm!=null && !"".equals(jdfsm))
							{
								String jdfs = DictUtils.getDictValue(jdfsm, "jdfs","0");
								entity.setJdfsm(jdfs);
							}else
							{
								errorMsg +=",就读方式不能为空";
							}
							// 国籍/地区
							String gjdqm = getCellFormatValue(row.getCell((int) 12)).trim();
							if(gjdqm!=null && !"".equals(gjdqm))
							{
								String gjdq = DictUtils.getDictValue(gjdqm,"gjdqm", "0");
								entity.setGjdqm(gjdq);
							}else
							{
								errorMsg +=",国籍/地区不能为空";
							}
							// 港澳台侨外
							String gatqwm = getCellFormatValue(row.getCell((int) 13)).trim();
							if(gatqwm!=null && !"".equals(gatqwm))
							{
								String gatqw = DictUtils.getDictValue(gatqwm,"gatqwm", "0");
								entity.setGatqwm(gatqw);
							}else
							{
								errorMsg +=",港澳台侨外不能为空";
							}
							// 婚姻状况
							String hyzkm = getCellFormatValue(row.getCell((int) 14)).trim();
							if(hyzkm!=null && !"".equals(hyzkm))
							{
								String hyzk = DictUtils.getDictValue(hyzkm, "hyzk","0");
								entity.setHyzkm(hyzk);
							}else
							{
								errorMsg +=",婚姻状况不能为空";
							}
							// 乘火车区间
							String chcqj = getCellFormatValue(row.getCell((int) 15)).trim();
							if(chcqj!=null && !"".equals(chcqj))
							{
								entity.setChcqj(chcqj);
							}else
							{
								errorMsg +=",乘火车区间不能为空";
							}
							// 是否随迁子女
							String sfsqznm = getCellFormatValue(row.getCell((int) 16)).trim();
							if(sfsqznm!=null && !"".equals(sfsqznm))
							{
								String sfsqzn = DictUtils.getDictValue(sfsqznm,"sfdm", "0");
								entity.setSfsqzn(sfsqzn);
							}else
							{
								errorMsg +=",是否随迁子女不能为空";
							}
							// 生源地行政区划码
							String sydxzqhm = getCellFormatValue(row.getCell((int) 17)).trim();
							if(sydxzqhm!=null && !"".equals(sydxzqhm))
							{
								if(!Pattern.matches(shuZiRegex, sydxzqhm))
								{
									errorMsg +=",生源地行政区划码格式有误";
								}
								entity.setSydxzqhm(sydxzqhm);
							}else
							{
								errorMsg +=",生源地行政区划码不能为空";
							}
							// 出生地行政区划码
							String csdxzqhm = getCellFormatValue(row.getCell((int) 18)).trim();
							if(csdxzqhm!=null && !"".equals(csdxzqhm))
							{
								if(!Pattern.matches(shuZiRegex, csdxzqhm))
								{
									errorMsg +=",出生地行政区划码格式有误";
								}
								entity.setCsdxzqhm(csdxzqhm);
							}else
							{
								errorMsg +=",出生地行政区划码不能为空";
							}
							// 籍贯地行政区划码
							String jgdxzqhm = getCellFormatValue(row.getCell((int) 19)).trim();
							if(jgdxzqhm!=null && !"".equals(jgdxzqhm))
							{
								if(!Pattern.matches(shuZiRegex, jgdxzqhm))
								{
									errorMsg +=",籍贯地行政区划码格式有误";
								}
								entity.setJgdxzqhm(jgdxzqhm);
							}else
							{
								errorMsg +=",籍贯地行政区划码不能为空";
							}
							
							// 户口所在地区县以下详细地址
							String hkzsdqxyxxxdz = getCellFormatValue(row.getCell((int) 20)).trim();
							if(hkzsdqxyxxxdz!=null && !"".equals(hkzsdqxyxxxdz))
							{
								entity.setHkszdqxyxxxdz(hkzsdqxyxxxdz);
							}else
							{
								errorMsg +=",户口所在地区县以下详细地址不能为空";
							}
							// 所属派出所
							String sspcs = getCellFormatValue(row.getCell((int) 21)).trim();
							if(sspcs!=null && !"".equals(sspcs))
							{
								entity.setScpcs(sspcs);
							}else
							{
								errorMsg +=",所属派出所不能为空";
							}
							// 户口所在地行政区划码
							String hkszdxzqhm = getCellFormatValue(row.getCell((int) 22)).trim();
							if(hkszdxzqhm!=null && !"".equals(hkszdxzqhm))
							{
								entity.setHkszdxzqhm(hkszdxzqhm);
							}else
							{
								errorMsg +=",户口所在地行政区划码不能为空";
							}
							// 户口性质
							String hkxz = getCellFormatValue(row.getCell((int) 23)).trim();
							if(hkxz!=null && !"".equals(hkxz))
							{
								String hkxz1 = DictUtils.getDictValue(hkxz, "hkxz","0");
								entity.setHkxz(hkxz1);
							}else
							{
								errorMsg +=",户口性质不能为空";
							}
							// 学生居住地类型
							String xsjzdlx = getCellFormatValue(row.getCell((int) 24)).trim();
							if(xsjzdlx!=null && !"".equals(xsjzdlx))
							{
								String xsjzdlx1 = DictUtils.getDictValue(xsjzdlx,"xsjzdlx", "0");
								entity.setXsjzdlx(xsjzdlx1);
							}else
							{
								errorMsg +=",学生居住地类型不能为空";
							}
							
							// 入学年月
							String rxny = getCellFormatValue(row.getCell((int) 25)).trim();
							if(rxny!=null && !"".equals(rxny))
							{
								String year = rxny.substring(0, 4);
								String month = rxny.substring(4, 6);
								String rxny1 = year + "-" + month;
								entity.setRxny(rxny1);
							}else
							{
								errorMsg +=",入学年月不能为空";
							}
							// 专业
							String zy = getCellFormatValue(row.getCell((int) 26)).trim();
							// 专业方向
							String zyfx = getCellFormatValue(row.getCell((int) 27)).trim();
							// 学制
							String xzm = getCellFormatValue(row.getCell((int) 28)).trim();
							// 民族
							String mzm = getCellFormatValue(row.getCell((int) 29)).trim();
							// 政治面貌
							String zzmmm = getCellFormatValue(row.getCell((int) 30)).trim();
							if(zzmmm!=null && !"".equals(zzmmm))
							{
								String zzmm = DictUtils.getDictValue(zzmmm, "zzmm","0");
								entity.setZzmmm(zzmm);
							}else
							{
								errorMsg +=",政治面貌不能为空";
							}
							// 健康状况
							String jkzkm = getCellFormatValue(row.getCell((int) 31)).trim();
							if(jkzkm!=null && !"".equals(jkzkm))
							{
								String jkzk = DictUtils.getDictValue(jkzkm,"health", "0");
								entity.setJkzkm(jkzk);
							}else
							{
								errorMsg +=",健康状况不能为空";
							}
							// 学生来源
							String xslym = getCellFormatValue(row.getCell((int) 32)).trim();
							if(xslym!=null && !"".equals(xslym))
							{
								String xsly = DictUtils.getDictValue(xslym,"xs_ly", "0");
								entity.setXslym(xsly);
							}else
							{
								errorMsg +=",学生来源不能为空";
							}
							// 招生对象
							String zsdx = getCellFormatValue(row.getCell((int) 33)).trim();
							if(zsdx!=null && !"".equals(zsdx))
							{
								String zsdx1 = DictUtils.getDictValue(zsdx, "zsdx","0");
								entity.setZsdx(zsdx1);
							}else
							{
								errorMsg +=",招生对象不能为空";
							}
							// 联系电话
							String lxdh = getCellFormatValue(row.getCell((int) 34)).trim();
							if(lxdh!=null && !"".equals(lxdh))
							{
								if(!((Pattern.matches(mobileRegex, lxdh)) || (Pattern.matches(phoneRegex, lxdh))))
								{
									errorMsg +=",联系电话输入有误";
								}
								entity.setLxdh(lxdh);
							}else
							{
								errorMsg +=",联系电话不能为空";
							}
							String zsfsStr = null;
							// 招生方式 
							String zsfs = getCellFormatValue(row.getCell((int) 35)).trim();
							if(zsfs!=null && !"".equals(zsfs))
							{
								String zsfs1 = DictUtils.getDictValue(zsfs, "zsfs","0");
								zsfsStr = zsfs1;
								entity.setZsfs(zsfs1);
							}else
							{
								errorMsg +=",招生方式不能为空";
							}
							String lzhzlxStr =""; // 联招合作办学形式   联招合作学校代码 必填项
							// 联招合作类型 2 
							String lzhzlxm = getCellFormatValue(row.getCell((int) 36)).trim();
							if(lzhzlxm!=null && !"".equals(lzhzlxm))
							{
								String lzhzlx = DictUtils.getDictValue(lzhzlxm,"lzhzlx", "0");
								lzhzlxStr = lzhzlx;
								entity.setLzhzlx(lzhzlx);
							}else
							{
								errorMsg +=",联招合作类型不能为空";
							}
							// 准考证号
							String zkzh = getCellFormatValue(row.getCell((int) 37)).trim();
							// 考生号
							String ksh = getCellFormatValue(row.getCell((int) 38)).trim();
							// 考试总分
							String kszf = getCellFormatValue(row.getCell((int) 39)).trim();
							if(zsfsStr!=null && !"".equals(zsfsStr))
							{
								if("1".equals(zsfsStr))
								{
									if(zkzh==null || "".equals(zkzh))
									{
										errorMsg +=",准考证号不能为空";
									}
									if(ksh==null || "".equals(ksh))
									{
										errorMsg +=",考生号不能为空";
									}
									if(kszf==null || "".equals(kszf))
									{
										errorMsg +=",考试总分不能为空";
									}
								}
								
								if(zkzh!=null && !"".equals(zkzh))
								{
									entity.setZkzh(zkzh);
								}
								if(ksh!=null && !"".equals(ksh))
								{
									entity.setKsh(ksh);
								}
								if(kszf!=null && !"".equals(kszf))
								{
									entity.setKszf(kszf);
								}
								
							}
							
							
							// 联招合作办学形式 lzhzlxStr
							String lzhzbxxsm = getCellFormatValue(row.getCell((int) 40)).trim();
							// 联招合作学校代码
							String lzhzxxdm = getCellFormatValue(row.getCell((int) 41)).trim();
							
							if(lzhzlxStr!=null && !"".equals(lzhzlxStr))
							{
								// 联招合作办学形式 联招合作学校代码 必填
								if(!lzhzlxStr.equals("1"))
								{
									if(lzhzbxxsm ==null || "".equals(lzhzbxxsm))
									{
										errorMsg +=",联招合作办学形式不能为空";
									}
									if(lzhzxxdm ==null || "".equals(lzhzxxdm))
									{
										errorMsg +=",联招合作学校代码不能为空";
									}
									
								}
								
								if(lzhzbxxsm!=null && !"".equals(lzhzbxxsm))
								{
									String lzhzbxxs = DictUtils.getDictValue(lzhzbxxsm,"lzhzbxxs", "0");
									entity.setLzhzbxfs(lzhzbxxs);
								}
								if(lzhzxxdm!=null && !"".equals(lzhzxxdm))
								{
									entity.setLzhzxxdm(lzhzxxdm);
								}
							}
							
							// 校外教学点
							String xwjxd = getCellFormatValue(row.getCell((int) 42)).trim();
							if(xwjxd!=null && !"".equals(xwjxd))
							{
								entity.setXwjxd(xwjxd);
								entity.setSfxwjxdxs("1");
							}
							// 分段培养方式
							String fdpyfsm = getCellFormatValue(row.getCell((int) 43)).trim();
							if(fdpyfsm!=null && !"".equals(fdpyfsm))
							{
								String fdpyfs = DictUtils.getDictValue(fdpyfsm,"fdpyfs", "0");
								entity.setFdpyfs(fdpyfs);
							}else
							{
								errorMsg +=",分段培养方式不能为空";
							}
							// 英文姓名
							String ywxm = getCellFormatValue(row.getCell((int) 44)).trim();
							if(ywxm!=null && !"".equals(ywxm))
							{
								entity.setYwxm(ywxm);
							}else
							{
								errorMsg +=",英文姓名不能为空";
							}
							// 电子信箱/其他联系方式
							String dzxx = getCellFormatValue(row.getCell((int) 45)).trim();
							if(dzxx!=null && !"".equals(dzxx))
							{
								if(!Pattern.matches(emailRegex, dzxx))
								{
									errorMsg +=",电子信箱/其他联系方式输入有误";
								}
								entity.setDzxx(dzxx);
							}else
							{
								errorMsg +=",电子信箱/其他联系方式不能为空";
							}
							// 家庭现地址
							String jtxdz = getCellFormatValue(row.getCell((int) 46)).trim();
							if(jtxdz!=null && !"".equals(jtxdz))
							{
								entity.setJtxdz(jtxdz);
							}else
							{
								errorMsg +=",招家庭现地址不能为空";
							}
							// 家庭邮政编码
							String jtyzbm = getCellFormatValue(row.getCell((int) 47)).trim();
							if(jtyzbm!=null && !"".equals(jtyzbm))
							{
								entity.setJtyzbm(jtyzbm);
							}else
							{
								errorMsg +=",家庭邮政编码不能为空";
							}
							// 家庭电话
							String jtdh = getCellFormatValue(row.getCell((int) 48)).trim();
							if(jtdh!=null && !"".equals(jtdh))
							{
								if(!(Pattern.matches(mobileRegex, jtdh) || Pattern.matches(phoneRegex, jtdh)))
								{
									errorMsg +=",家庭电话输入有误";
								}
								entity.setJtdh(jtdh);
							}else
							{
								errorMsg +=",家庭电话不能为空";
							}
							
							
							
							/**
							 * 成员1信息
							 */

							// 成员1姓名
							String cyyxm = getCellFormatValue(row.getCell((int) 49)).trim();
							// 成员1关系
							String cyygxm = getCellFormatValue(row.getCell((int) 50)).trim();
							// 成员1是否监护人
							String cyysfjhrm = getCellFormatValue(row.getCell((int) 51)).trim();
							// 成员1联系电话
							String cyylxdh = getCellFormatValue(row.getCell((int) 52)).trim();
							
							if((cyyxm!=null && !"".equals(cyyxm)) || (cyygxm!=null && !"".equals(cyygxm)) || (cyysfjhrm!=null && !"".equals(cyysfjhrm)) || (cyylxdh!=null && !"".equals(cyylxdh)) )
							{
								if(cyyxm ==null || "".equals(cyyxm))
								{
									errorMsg +=",成员1姓名不能为空";
								}
								if(cyygxm ==null || "".equals(cyygxm))
								{
									errorMsg +=",成员1关系不能为空";
								}
								if(cyysfjhrm ==null || "".equals(cyysfjhrm))
								{
									errorMsg +=",成员1是否监护人不能为空";
								}
								if(cyylxdh ==null || "".equals(cyylxdh))
								{
									errorMsg +=",成员1联系电话不能为空";
								}
							}
							
							if(cyyxm!=null && !"".equals(cyyxm))
							{
								entity.setCyyxm(cyyxm);
							}
							// 成员1关系
							if(cyygxm!=null && !"".equals(cyygxm))
							{
								String cyygx = DictUtils.getDictValue(cyygxm,"cygx", "0");
								entity.setCyygx(cyygx);
							}
							// 成员1是否监护人
							if(cyysfjhrm!=null && !"".equals(cyysfjhrm))
							{
								String cyysfjhr = DictUtils.getDictValue(cyysfjhrm,"sfdm", "0");
								entity.setCyysfjhr(cyysfjhr);
							}
							// 成员1联系电话
							if(cyylxdh!=null && !"".equals(cyylxdh))
							{
								if(!(Pattern.matches(mobileRegex, cyylxdh) || Pattern.matches(phoneRegex, cyylxdh)))
								{
									errorMsg +=",成员1联系电话输入有误";
								}
								entity.setCyylxdh(cyylxdh);
							}
							
							// 成员1出生年月
							String cyycsny = getCellFormatValue(row.getCell((int) 53)).trim();
							if(cyycsny!=null && !"".equals(cyycsny))
							{
								String year = cyycsny.substring(0, 4);
								String month = cyycsny.substring(4, 6);
								String cyycsny1 = year + "-" + month;
								entity.setCyycsny(cyycsny1);
							}
							// 成员1身份证件类型
							String cyysfzjlxm = getCellFormatValue(row.getCell((int) 54)).trim();
							if(cyysfzjlxm!=null && !"".equals(cyysfzjlxm))
							{
								String cyysfzjlx = DictUtils.getDictValue(cyysfzjlxm, "sfzjlx", "0");
								entity.setCyysfzjlx(cyysfzjlx);
							}
							// 成员1身份证件号
							String cyysfzjh = getCellFormatValue(row.getCell((int) 55)).trim();
							if(cyysfzjh!=null && !"".equals(cyysfzjh))
							{
								entity.setCyysfzjh(cyysfzjh);
							}
							// 成员1民族
							String cyymzm = getCellFormatValue(row.getCell((int) 56)).trim();
							if(cyymzm!=null && !"".equals(cyymzm))
							{
								String cyymz = DictUtils.getDictValue(cyymzm,"nation", "0");
								entity.setCyymzm(cyymz);
							}
							// 成员1政治面貌
							String cyyzzmmm = getCellFormatValue(row.getCell((int) 57)).trim();
							if(cyyzzmmm!=null && !"".equals(cyyzzmmm))
							{
								String cyyzzmm = DictUtils.getDictValue(cyyzzmmm,"zzmm", "0");
								entity.setCyyzzmmm(cyyzzmm);
							}
							// 成员1健康状况
							String cyyjkzkm = getCellFormatValue(row.getCell((int) 58)).trim();
							if(cyyjkzkm!=null && !"".equals(cyyjkzkm))
							{
								String cyyjkzk = DictUtils.getDictValue(cyyjkzkm,"health", "0");
								entity.setCyyjkzkm(cyyjkzk);
							}
							// 成员1工作或学习单位
							String cyygzhxxdw = getCellFormatValue(row.getCell((int) 59)).trim();
							if(cyygzhxxdw!=null && !"".equals(cyygzhxxdw))
							{
								entity.setCyygzhxxdw(cyygzhxxdw);
							}
							// 成员1职务
							String cyyszw = getCellFormatValue(row.getCell((int) 60)).trim();
							if(cyyszw!=null && !"".equals(cyyszw))
							{
								entity.setCyyzw(cyyszw);
							}

							
							/**
							 * 成员2信息
							 */

							// 成员2姓名
							String cyexm = getCellFormatValue(row.getCell((int) 61)).trim();
							// 成员2关系
							String cyegxm = getCellFormatValue(row.getCell((int) 62)).trim();
							// 成员2是否监护人
							String cyesfjhrm = getCellFormatValue(row.getCell((int) 63)).trim();
							// 成员2联系电话
							String cyelxdh = getCellFormatValue(row.getCell((int) 64)).trim();
							
							if((cyexm!=null && !"".equals(cyexm)) || (cyegxm!=null && !"".equals(cyegxm)) || (cyesfjhrm!=null && !"".equals(cyesfjhrm)) 
									|| (cyelxdh!=null && !"".equals(cyelxdh)) )
							{
								if(cyexm ==null || "".equals(cyexm))
								{
									errorMsg +=",成员2姓名不能为空";
								}
								if(cyegxm ==null || "".equals(cyegxm))
								{
									errorMsg +=",成员2关系不能为空";
								}
								if(cyesfjhrm ==null || "".equals(cyesfjhrm))
								{
									errorMsg +=",成员2是否监护人不能为空";
								}
								if(cyelxdh ==null || "".equals(cyelxdh))
								{
									errorMsg +=",成员2联系电话不能为空";
								}
								
							}
							
							
							if(cyexm!=null && !"".equals(cyexm))
							{
								entity.setCyexm(cyexm);
							}
							// 成员2关系
							if(cyegxm!=null && !"".equals(cyegxm))
							{
								String cyegx = DictUtils.getDictValue(cyegxm,"cygx", "0");
								entity.setCyegx(cyegx);
							}
							// 成员2是否监护人
							if(cyesfjhrm!=null && !"".equals(cyesfjhrm))
							{
								String cyesfjhr = DictUtils.getDictValue(cyesfjhrm,"sfdm", "0");
								entity.setCyesfjhr(cyesfjhr);
							}
							// 成员2联系电话
							if(cyelxdh!=null && !"".equals(cyelxdh))
							{
								if(!(Pattern.matches(mobileRegex, cyelxdh) || Pattern.matches(phoneRegex, cyelxdh)))
								{
									errorMsg +=",成员2联系电话输入有误";
								}
								entity.setCyelxdh(cyelxdh);
							}
							
							// 成员2出生年月
							String cyecsny = getCellFormatValue(row.getCell((int) 65)).trim();
							if(cyecsny!=null && !"".equals(cyecsny))
							{
								String year = cyecsny.substring(0, 4);
								String month = cyecsny.substring(4, 6);
								String cyecsny1 = year + "-" + month;
								entity.setCyecsny(cyecsny1);
							}
							// 成员2身份证件类型
							String cyesfzjlxm = getCellFormatValue(row.getCell((int) 66)).trim();
							if(cyesfzjlxm!=null && !"".equals(cyesfzjlxm))
							{
								String cyesfzjlx = DictUtils.getDictValue(cyesfzjlxm, "sfzjlx", "0");
								entity.setCyesfzjlx(cyesfzjlx);
							}
							// 成员2身份证件号
							String cyesfzjh = getCellFormatValue(row.getCell((int) 67)).trim();
							if(cyesfzjh!=null && !"".equals(cyesfzjh))
							{
								if(!Pattern.matches(idCardRegex, sfzjh))
								{
									errorMsg +=",成员2身份证件号输入有误";
								}
								entity.setCyesfzjh(cyesfzjh);
							}
							// 成员2民族
							String cyemzm = getCellFormatValue(row.getCell((int) 68)).trim();
							if(cyemzm!=null && !"".equals(cyemzm))
							{
								String cyemz = DictUtils.getDictValue(cyemzm,"nation", "0");
								entity.setCyemzm(cyemz);
							}
							// 成员2政治面貌
							String cyezzmmm = getCellFormatValue(row.getCell((int) 69)).trim();
							if(cyezzmmm!=null && !"".equals(cyezzmmm))
							{
								String cyezzmm = DictUtils.getDictValue(cyezzmmm,"zzmm", "0");
								entity.setCyezzmmm(cyezzmm);
							}
							// 成员2健康状况
							String cyejkzkm = getCellFormatValue(row.getCell((int) 70)).trim();
							if(cyejkzkm!=null && !"".equals(cyejkzkm))
							{
								String cyejkzk = DictUtils.getDictValue(cyejkzkm,"health", "0");
								entity.setCyejkzkm(cyejkzk);
							}
							// 成员2工作或学习单位
							String cyegzhxxdw = getCellFormatValue(row.getCell((int) 71)).trim();
							if(cyegzhxxdw!=null && !"".equals(cyegzhxxdw))
							{
								entity.setCyegzhxxdw(cyegzhxxdw);
							}
							// 成员2职务
							String cyeszw = getCellFormatValue(row.getCell((int) 72)).trim();
							if(cyeszw!=null && !"".equals(cyeszw))
							{
								entity.setCyezw(cyeszw);
							}
							errorMsg += "</br>";
						}
						else
						{
							errorMsg +=",在学籍库中不存在</br>";
						}
						
						if(entity !=null)
						{
							entity.setShzt("4");//学籍状态 -- 未提交
						}
						xsJbxxList.add(entity);
						failureMsg.append(errorMsg);
						
					}
					
				}
				
				map.put("istrue", false);
				if(failureMsg.length() <50)
				{
					String str =failureMsg.toString();
					int n = str.length()-str.replaceAll(",", "").length();
					if(n<=1)
					{
						map.put("istrue", true);
						this.saveXjExcel(xsJbxxList);
					}
				}
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			map.put("failureMsg", failureMsg);
			return JsonMapper.toJsonString(map);
			
		}
		
		/**
		 * 修改学生学籍信息
		 * @param xsJbxxList
		 */
		private void saveXjExcel(List<XsJbxx> xsJbxxList)
		{
			for(XsJbxx entity :xsJbxxList)
			{
				xsJbxxService.save(entity);
			}
		}
		
		/**
		 * 导入成功后返回list页面
		 * @param xsJbxx
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 */
		@RequiresPermissions("xs:xsJbxx:view")
		@RequestMapping(value = "exportSucessPage")
		public String exportSucessPage(XsJbxx xsJbxx, HttpServletRequest request,
				HttpServletResponse response, Model model)
		{
			return  "redirect:" + Global.getAdminPath() + "/xs/xsJbxx/list/?repage";
		}

		
}