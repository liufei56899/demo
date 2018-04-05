/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zyzl.web;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.SimpleFormatter;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zyzl.entity.XxZyzl;
import com.thinkgem.jeesite.modules.zyzl.service.XxZyzlService;

/**
 * 专业资料管理Controller
 * @author zh
 * @version 2018-02-25
 */
@Controller
@RequestMapping(value = "${adminPath}/zyzl/xxZyzl")
public class XxZyzlController extends BaseController {

	@Autowired
	private XxZyzlService xxZyzlService;
	
	@ModelAttribute
	public XxZyzl get(@RequestParam(required=false) String id) {
		XxZyzl entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xxZyzlService.get(id);
		}
		if (entity == null){
			entity = new XxZyzl();
		}
		return entity;
	}
	
	@RequiresPermissions("zyzl:xxZyzl:view")
	@RequestMapping(value = {"list", ""})
	public String list(XxZyzl xxZyzl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XxZyzl> page = xxZyzlService.findPage(new Page<XxZyzl>(request, response), xxZyzl); 
		model.addAttribute("page", page);
		model.addAttribute("username", UserUtils.getUser().getId()+","+UserUtils.getUser().getName());
		return "modules/zyzl/xxZyzlList";
	}

	@RequiresPermissions("zyzl:xxZyzl:view")
	@RequestMapping(value = "form")
	public String form(XxZyzl xxZyzl, Model model) {
		model.addAttribute("xxZyzl", xxZyzl);
		return "modules/zyzl/xxZyzlForm";
	}
	@RequestMapping(value = "download")
	public void download(HttpServletRequest request, HttpServletResponse response,String pathName)throws IOException {		
		response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;      
        try {
	        File file = new File(pathName);
	        long fileLength = file.length();
	        response.setContentType("application/x-msdownload;");
	        response.setHeader("Content-disposition", "attachment; filename="+new String(file.getName().getBytes("UTF-8"), "ISO8859-1" ));
	        response.setHeader("Content-Length", String.valueOf(fileLength));
	        bis = new BufferedInputStream(new FileInputStream(pathName));  
	        bos = new BufferedOutputStream(response.getOutputStream());
	        byte[] buff = new byte[2048];
	        int bytesRead;
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))){
	            bos.write(buff, 0, bytesRead);
	        }
	    } catch (Exception e){
	        e.printStackTrace();
	    } finally {
	        if(bis != null){
	          bis.close();
	        }
	        if(bos != null){
	          bos.close();
	        }
	    }
	
	}
	@RequiresPermissions("zyzl:xxZyzl:edit")
	@RequestMapping(value = "save",method = RequestMethod.POST)
	public String save(HttpServletRequest request,XxZyzl xxZyzl, Model model, RedirectAttributes redirectAttributes,@RequestParam("files") MultipartFile files){
		if (!beanValidator(model, xxZyzl)){
			return form(xxZyzl, model);
		}          
        if (files != null && !files.isEmpty()) {        	
        	 SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
        	 String fileName =format.format(new Date())+"_"+files.getOriginalFilename();
        	 String path = "F://upload/"; 
        	 File localFile=new File(path,fileName);
        	 if(!localFile.exists()){
        		 localFile.mkdirs();
        	 }
            xxZyzl.setFj(path+fileName);         
            // 写文件到本地
            try {
				files.transferTo(localFile);			
			} catch (IOException e) {
				addMessage(redirectAttributes, "上传文件失败！");				
			}	
        }
        xxZyzl.setUploadname(UserUtils.getUser().getId()+","+UserUtils.getUser().getName());
        xxZyzl.setUploaddate(new Date());
		xxZyzlService.save(xxZyzl);
		addMessage(redirectAttributes, "保存专业资料管理成功");
		return "redirect:"+Global.getAdminPath()+"/zyzl/xxZyzl/?repage";
	}
	
	@RequiresPermissions("zyzl:xxZyzl:edit")
	@RequestMapping(value = "delete")
	public String delete(XxZyzl xxZyzl, RedirectAttributes redirectAttributes) {
		xxZyzlService.delete(xxZyzl);
		addMessage(redirectAttributes, "删除专业资料管理成功");
		return "redirect:"+Global.getAdminPath()+"/zyzl/xxZyzl/?repage";
	}

}