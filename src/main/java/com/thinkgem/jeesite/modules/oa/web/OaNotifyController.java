/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.entity.OaNotifyRecord;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 通知通告Controller
 * @author ThinkGem
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/oaNotify")
public class OaNotifyController extends BaseController {

	@Autowired
	private OaNotifyService oaNotifyService;
	
	@ModelAttribute
	public OaNotify get(@RequestParam(required=false) String id) {
		OaNotify entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaNotifyService.get(id);
		}
		if (entity == null){
			entity = new OaNotify();
		}
		return entity;
	}
	
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify);
		model.addAttribute("page", page);
		return "modules/oa/oaNotifyList";
	}

	@ResponseBody
	@RequestMapping(value = "getOanatifyJson")
	public String getOanatifyJson(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response)
	{
		//获取通知公告
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify);
		List<OaNotify> list = page.getList();
		
		return JsonMapper.toJsonString(list);
	}
	
	
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "form")
	public String form(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotify = oaNotifyService.getRecordList(oaNotify);
		}
		model.addAttribute("oaNotify", oaNotify);
		return "modules/oa/oaNotifyForm";
	}

	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "save")
	public String save(OaNotify oaNotify, Model model, RedirectAttributes redirectAttributes,MultipartFile file,HttpServletRequest request) throws IOException {
		if (!beanValidator(model, oaNotify)){
			return form(oaNotify, model);
		}
		// 如果是修改，则状态为已发布，则不能再进行操作
		if (StringUtils.isNotBlank(oaNotify.getId())){
			OaNotify e = oaNotifyService.get(oaNotify.getId());
			if ("1".equals(e.getStatus())){
				addMessage(redirectAttributes, "已发布，不能操作！");
				return "redirect:" + adminPath + "/oa/oaNotify/?repage";
			}
		}
		// 判断文件是否为空
		/*if (!file.isEmpty()) 
		{
			if(file.getSize()>0)
			{
				String fileExt = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
				//文件保存目录路径
				String savePath = request.getSession().getServletContext().getRealPath("/") + "upload/file" + "/";
				//文件保存目录url
				String saveUrl =  "upload/file" + "/";
				File uploadDir = new File(savePath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
				saveFileFromInputStream(file.getInputStream(),savePath,newFileName);
				oaNotify.setFiles(saveUrl+newFileName);
			}
		}*/
		
		oaNotifyService.save(oaNotify);
		addMessage(redirectAttributes, "保存通知'" + oaNotify.getTitle() + "'成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}
	
	
	/**
	 * Des:下载附件
	 * 2016-10-26
	 * @author fn
	 * @param oaNotify
	 * @param request
	 * @param response
	 * @return
	 * String
	 */
	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "xiaZaiFuJian")
	public String xiaZaiFuJian(OaNotify oaNotify,HttpServletRequest request, HttpServletResponse response)
	{
		if(oaNotify.getFiles()!=null && !"".equals(oaNotify.getFiles())){
			this.upload(request, response,oaNotify.getFiles());
		}
		return null;
	}
	
	/**
	 * Des:保存file
	 * 2016-10-26
	 * @author fn
	 * @param stream
	 * @param path
	 * @param filename
	 * @throws IOException
	 * void
	 */
	public void saveFileFromInputStream(InputStream stream,String path,String filename) throws IOException   
    {         
        FileOutputStream fs=new FileOutputStream( path + "/"+ filename);   
        byte[] buffer =new byte[1024*1024];   
        int bytesum = 0;   
        int byteread = 0;    
        while ((byteread=stream.read(buffer))!=-1)   
        {   
           bytesum+=byteread;   
           fs.write(buffer,0,byteread);   
           fs.flush();   
        }    
        fs.close();   
        stream.close();         
    }
	
	// 下载web应用下的文件
	private void upload(HttpServletRequest request, HttpServletResponse response,String filePath) {
			try {

				String savePath = request.getSession().getServletContext().getRealPath("/") + "/"+filePath;
				File outfile = new File(savePath);
				String filename = outfile.getName();// 获取文件名称
				InputStream fis = new BufferedInputStream(new FileInputStream(
						savePath));
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
				}catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	
	
	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "delete")
	public String delete(OaNotify oaNotify,String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id : idArr)
		{
			OaNotify oanot = get(id);
			oaNotifyService.delete(oanot);
		}
		addMessage(redirectAttributes, "删除通知成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}
	
	/**
	 * 我的通知列表
	 */
	@RequestMapping(value = "self")
	public String selfList(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		oaNotify.setSelf(true);
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify); 
		model.addAttribute("page", page);
		return "modules/oa/oaNotifyList";
	}

	/**
	 * 我的通知列表-数据
	 */
	@RequestMapping(value = "selfData")
	@ResponseBody
	public Page<OaNotify> listData(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		oaNotify.setSelf(true);
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify);
		return page;
	}
	
	/**
	 * 查看我的通知
	 */
	@RequestMapping(value = "view")
	public String view(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotifyService.updateReadFlag(oaNotify);
			oaNotify = oaNotifyService.getRecordList(oaNotify);
			model.addAttribute("oaNotify", oaNotify);
			return "modules/oa/oaNotifyForm";
		}
		return "redirect:" + adminPath + "/oa/oaNotify/self?repage";
	}

	@RequestMapping(value = "viewNotify")
	public String viewNotify(OaNotify oaNotify, Model model)
	{
		oaNotifyService.updateReadFlag(oaNotify);
		oaNotify = oaNotifyService.getRecordList(oaNotify);
		model.addAttribute("oaNotify", oaNotify);
		return "modules/oa/oaNotifyView";
	}
	
	/**
	 * 查看我的通知-数据
	 */
	@RequestMapping(value = "viewData")
	@ResponseBody
	public OaNotify viewData(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotifyService.updateReadFlag(oaNotify);
			return oaNotify;
		}
		return null;
	}
	
	/**
	 * 查看我的通知-发送记录
	 */
	@RequestMapping(value = "viewRecordData")
	@ResponseBody
	public OaNotify viewRecordData(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotify = oaNotifyService.getRecordList(oaNotify);
			return oaNotify;
		}
		return null;
	}
	
	/**
	 * 获取我的通知数目
	 */
	@RequestMapping(value = "self/count")
	@ResponseBody
	public String selfCount(OaNotify oaNotify, Model model) {
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		return String.valueOf(oaNotifyService.findCount(oaNotify));
	}
}