/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.syxx.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.statistics.entity.Statistics;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.syxx.entity.SyJbxx;
import com.thinkgem.jeesite.modules.syxx.service.SyJbxxService;

/**
 * 生源信息Controller
 * 
 * @author xfb
 * @version 2016-05-05
 */
@Controller
@RequestMapping(value = "${adminPath}/syxx/syJbxx")
public class SyJbxxController extends BaseController {
	@Autowired
	private SyJbxxService syJbxxService;

	@Autowired
	private  AreaService  areaService;
	
	@ModelAttribute
	public SyJbxx get(@RequestParam(required = false) String id) {
		SyJbxx entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = syJbxxService.get(id);
		}
		if (entity == null) {
			entity = new SyJbxx();
		}
		return entity;
	}

	@RequiresPermissions("syxx:syJbxx:view")
	@RequestMapping(value = { "list", "list" })
	public String list(SyJbxx syJbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User u = UserUtils.getUser();
		syJbxx.setCreateBy(u);
		Page<SyJbxx> page = syJbxxService.findPage(new Page<SyJbxx>(request,
				response), syJbxx);
		model.addAttribute("page", page);
		return "modules/syxx/syJbxxList";
	}

	@RequiresPermissions("syxx:syJbxx:view")
	@RequestMapping(value = "form")
	public String form(SyJbxx syJbxx, Model model) {
		model.addAttribute("syJbxx", syJbxx);
		return "modules/syxx/syJbxxForm";
	}

	@RequiresPermissions("syxx:syJbxx:edit")
	@RequestMapping(value = "save")
	public String save(SyJbxx syJbxx, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, syJbxx)) {
			return form(syJbxx, model);
		}
		syJbxxService.save(syJbxx);
		addMessage(redirectAttributes, "保存生源信息成功");
		return "redirect:" + Global.getAdminPath() + "/syxx/syJbxx/list?repage";
	}

	@RequiresPermissions("syxx:syJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(SyJbxx syJbxx, String ids,
			RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for (String id : idArr) {
			SyJbxx sj = get(id);
			syJbxxService.delete(sj);
		}
		addMessage(redirectAttributes, "删除生源信息成功");
		return "redirect:" + Global.getAdminPath() + "/syxx/syJbxx/list?repage";
	}

	/**
	 * 功能:验证文件信息
	 * 
	 * @param syJbxx
	 * @param model
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "veriftfile")
	public String veriftfile(SyJbxx syJbxx2, MultipartFile file, Model model,
			RedirectAttributes redirectAttributes, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> map = isNotScuess(file, request, response);
		if (map == null) {
			return JsonMapper.toJsonString("导入文档为空!");
		}
		for (Map.Entry<String, String> entry : map.entrySet()) {
			System.out.println(entry.getKey() + "--->" + entry.getValue());
			String key = entry.getKey();
			String value = entry.getValue();
			if (key == "1" || key.equals("1")) {
				// 添加数据
				importScuess(syJbxx2, file);
				return JsonMapper.toJsonString(value);
			} else {
				// 返回信息
				return JsonMapper.toJsonString(value);
			}
		}
		return "";
	}

	/**
	 * 功能:导入数据到应用中
	 * 
	 * @param syJbxx2
	 *            生源信息对象
	 * @param file
	 *            XLS文件
	 * 
	 */
	private void importScuess(SyJbxx syJbxx2, MultipartFile file) {
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<SyJbxx> list = ei.getDataList(SyJbxx.class);
			for (SyJbxx syJbxx : list) {
				BeanValidators.validateWithException(validator, syJbxx);
				syJbxxService.save(syJbxx);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 功能:过滤导入条件
	 * 
	 * @param file
	 *            XLS文件
	 * @param request
	 * @param response
	 * @return
	 */
	private Map<String, String> isNotScuess(MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> map = new HashMap<String, String>();
		int successNum = 0;
		int failureNum = 0;
		StringBuilder failureMsg = new StringBuilder();
		StringBuilder successMsg = new StringBuilder();
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<SyJbxx> list = ei.getDataList(SyJbxx.class);
			for (SyJbxx syJbxx : list) {
				String name = syJbxx.getXm();
				// 判断字段信息
				String message = checkSyJbxx(syJbxx);
				// 判断是否有重复信息
				boolean boo = checkSyJbxxName(name, syJbxx, request, response);

				if (message.equals("1") && (!boo)) {// 1 是成功
					successMsg.append("姓名是:" + syJbxx.getXm() + "添加成功<br/>");
					successNum++;
				} else {
					if (!message.equals("1")) {
						failureMsg.append(message + "<br/>");
						failureNum++;
					}
					if (boo) {
						failureMsg.append("姓名是:" + syJbxx.getXm() + "已存在<br/>");
						failureNum++;
					}
				}
			}
			if (successNum > 0) {
				map.put("1", successMsg.toString());
			}
			if (failureNum > 0) {
				map.put("0", failureMsg.toString());
			}
		} catch (Exception e) {
			return null;
		}
		return map;
	}

	/**
	 * 查询信息
	 * 
	 * @param syJbxx
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("syxx:syJbxx:view")
	@RequestMapping(value = "importfile", method = RequestMethod.POST)
	public String importfile(SyJbxx syJbxx, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		Page<SyJbxx> page = syJbxxService.findPage(new Page<SyJbxx>(request,
				response), syJbxx);
		model.addAttribute("page", page);
		return "redirect:" + Global.getAdminPath() + "/syxx/syJbxx/?repage";
	}

	/**
	 * 
	 * 功能:过滤字段信息
	 * 
	 * @param syJbxx
	 * @return
	 */
	private String checkSyJbxx(SyJbxx syJbxx) {
		String ret = "1";
		String name = syJbxx.getXm();// 姓名
		String sex = syJbxx.getXbm();// 性别码
		String sfzjm = syJbxx.getSfzjh();// 身份证件码
		String jtzz = syJbxx.getXxdz();// 家庭住址
		String byyx = syJbxx.getByxx();// 毕业院校
		String xlcc = syJbxx.getXlm();// 学历层次
		if (name.length() > 25) {
			ret = "录入的姓名为" + name + "的信息超过25个字,请修改后上传,或者手动添加.";
			return ret;
		}
		if (sex.length() > 1) {
			ret = "姓名为:" + name + "+录入的性别字段信息超过1个字,请修改后上传,或者手动添加.";
			return ret;
		}
		if (sfzjm.length() > 18) {
			ret = "姓名为:" + name + "+录入的身份证件码字段信息超过18个字,请修改后上传,或者手动添加.";
			return ret;
		}
		if (jtzz.length() > 100) {
			ret = "姓名为:" + name + "+录入的家庭住址字段信息超过100个字,请修改后上传,或者手动添加.";
			return ret;
		}
		if (byyx.length() > 100) {
			ret = "姓名为:" + name + "+录入的毕业院校字段信息超过100个字,请修改后上传,或者手动添加.";
			return ret;
		}
		if (xlcc.length() > 10) {
			ret = "姓名为:" + name + "+录入的学历层次字段信息超过10个字,请修改后上传,或者手动添加.";
			return ret;
		}
		return ret;
	}

	/**
	 * 功能:下载模板
	 * 
	 * @param syJbxx
	 * @param model
	 * @return
	 */
	@RequiresPermissions("syxx:syJbxx:view")
	@RequestMapping(value = "template")
	public String template(SyJbxx syJbxx, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			this.upload(request, response);
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/syxx/syJbxx/?repage";
	}

	// 下载web应用下的文件
	private void upload(HttpServletRequest request, HttpServletResponse response) {
		try {
			String filePath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/templet/生源信息表.xlsx"); // 文件在项目中的路径

			System.out.println(adminPath + "=filePath:=" + filePath);

			File outfile = new File(filePath);
			String filename = outfile.getName();// 获取文件名称
			InputStream fis = new BufferedInputStream(new FileInputStream(
					filePath));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer); // 读取文件流
			fis.close();
			response.reset(); // 重置结果集
			response.addHeader("Content-Disposition", "attachment;filename="
					+ new String(
							filename.replaceAll(" ", "").getBytes("utf-8"),
							"iso8859-1")); // 返回头 文件名
			response.addHeader("Content-Length", "" + outfile.length()); // 返回头
																			// 文件大小
			response.setContentType("application/octet-stream"); // 设置数据种类
			// 获取返回体输出权
			OutputStream os = new BufferedOutputStream(
					response.getOutputStream());
			os.write(buffer); // 输出文件
			os.flush();
			os.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 功能:验证导入生源信息是否存在
	 * 
	 * @param name
	 * @param syJbxx
	 * @param request
	 * @param response
	 * @return
	 */
	public boolean checkSyJbxxName(String name, SyJbxx syJbxx,
			HttpServletRequest request, HttpServletResponse response) {
		SyJbxx syJbxx2 = new SyJbxx();
		List<SyJbxx> list = syJbxxService.findList(syJbxx2);
		for (int i = 0; i < list.size(); i++) {
			String name2 = list.get(i).getXm();
			if ((name2.trim().equals(name.trim()))
					|| (name2.trim() == name.trim())) {
				return true;
			}
		}
		return false;
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
	@RequiresPermissions("syxx:syJbxx:view")
	@RequestMapping(value = "exportFile", method = RequestMethod.POST)
	public String exportFile(SyJbxx syJbxx2, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		syJbxx2.setCreateBy(UserUtils.getUser());
		try {
			String fileName = "学生生源信息表" + DateUtils.getDate("yyyyMMddHHmmss")
					+ ".xlsx";
			User u = UserUtils.getUser();
			syJbxx2.setCreateBy(u);
			syJbxx2.setXsly("");// 设置学生来源
			Page<SyJbxx> page = syJbxxService.findPage(new Page<SyJbxx>(
					request, response), syJbxx2);
			List<SyJbxx> list = page.getList();
			new ExportExcel("学生生源信息表", SyJbxx.class).setDataList(list)
					.write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出生源信息失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/syxx/syJbxx/list?repage";
	}

	/********************* 辅助方法 -验证身份证信息 ***********************************************/
	@ResponseBody
	@RequestMapping(value = "validateSyxx")
	public String validateSyxx(@RequestParam("sfzjh") String zsfzjhvalue,
			RedirectAttributes redirectAttributes, Model model) {
		List<SyJbxx> list = syJbxxService.findList(new SyJbxx());
		for (int i = 0; i < list.size(); i++) {
			String sfzjh = list.get(i).getSfzjh();
			if (sfzjh.trim().equals(zsfzjhvalue.trim())
					|| sfzjh.trim() == zsfzjhvalue.trim()) {
				return JsonMapper.toJsonString("身份证件号码已存在");
			}
		}
		return JsonMapper.toJsonString("");
	}
	
	
	
	@RequestMapping(value = "exportResources", method = RequestMethod.POST)
	public String exportResources(Statistics statistics, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes,String zsnd) {
	String fileName = zsnd+"年度招生区域分布情况" + ".xlsx";
	List<Area> list = areaService.findByAllList();
	List<Statistics> statList=new ArrayList<Statistics>();
	NumberFormat format=NumberFormat.getPercentInstance();
	format.setMinimumFractionDigits(2);
	for(int i=0;i<list.size();i++){
		Area a=list.get(i);
		Statistics s=new Statistics();
		s.setId(a.getId());
		s.setName(a.getName());
		s.setZsnd(zsnd);
		Area area2 = new Area();
		area2.setType(areaService.findByType(a.getId()));
		area2.setId(a.getId());
		area2.setZsnd(zsnd);
		String str = areaService.findByAll(area2);
		//每个省份的登记数
		if (str==""||str==null) {
			str="0";
		}
		String str1 = areaService.findByAllWC(area2);
		//每个省份的完成数
		if (str1==""||str1==null) {
			str1="0";
		}
		JhFjGrRw jhFjGrRw=new JhFjGrRw();
		jhFjGrRw.setZsnd(zsnd);
		jhFjGrRw.setType(areaService.findByType(a.getId()));
		jhFjGrRw.setId(a.getId());
		List<Map> zsrs = areaService.findByAllZSRS(jhFjGrRw);
		if (((Number)zsrs.get(0).get("zzsrs")).intValue()>0) {
			s.setNum1(((Number)zsrs.get(0).get("zzsrs")).intValue());
			double rws = ((Number)zsrs.get(0).get("zzsrs")).intValue();
			double wcs = Integer.parseInt(str1);
			s.setNum4(format.format(wcs/rws));
		}else {
	        s.setNum1(0);
	        s.setNum4("--");
		}
		
		s.setNum2(Integer.parseInt(str));
		s.setNum3(Integer.parseInt(str1));
		statList.add(s);
	}
	try {
		new ExportExcel("信息表", Statistics.class).setDataList(statList)
		.write(response, fileName).dispose();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		addMessage(redirectAttributes, "导出生源信息失败！失败信息：" + e.getMessage());
	}
			return null;
	 
	
	}

}