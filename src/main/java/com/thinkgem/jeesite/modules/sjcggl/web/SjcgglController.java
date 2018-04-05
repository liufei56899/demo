/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sjcggl.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sjcggl.entity.Sjcggl;
import com.thinkgem.jeesite.modules.sjcggl.service.SjcgglService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 实践成果管理Controller
 * @author zx
 * @version 2018-02-25
 */
@Controller
@RequestMapping(value = "${adminPath}/sjcggl/sjcggl")
public class SjcgglController extends BaseController {

	@Autowired
	private SjcgglService sjcgglService;
	
	@ModelAttribute
	public Sjcggl get(@RequestParam(required=false) String id) {
		Sjcggl entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sjcgglService.get(id);
		}
		if (entity == null){
			entity = new Sjcggl();
		}
		return entity;
	}
	
	@RequiresPermissions("sjcggl:sjcggl:view")
	@RequestMapping(value = {"list", ""})
	public String list(Sjcggl sjcggl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Sjcggl> page = sjcgglService.findPage(new Page<Sjcggl>(request, response), sjcggl); 
		User user=UserUtils.getUser();
		model.addAttribute("user", user);
		model.addAttribute("page", page);
		return "modules/sjcggl/sjcgglList";
	}

	@RequiresPermissions("sjcggl:sjcggl:view")
	@RequestMapping(value = "form")
	public String form(Sjcggl sjcggl, Model model) {
		model.addAttribute("sjcggl", sjcggl);
		return "modules/sjcggl/sjcgglForm";
	}

	@RequiresPermissions("sjcggl:sjcggl:edit")
	@RequestMapping(value = "save",method=RequestMethod.POST)
	public String save(Sjcggl sjcggl, Model model, RedirectAttributes redirectAttributes,@RequestParam("file")MultipartFile file,HttpServletRequest request)throws IOException {
		if (!beanValidator(model, sjcggl)){
			return form(sjcggl, model);
		}
		sjcggl.setUploadBy(UserUtils.getUser().getName());
		if (StringUtils.isNotBlank(file.getOriginalFilename())) {
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String fileName = df.format(new Date())+"_" + file.getOriginalFilename();
			String  path="F://upload/";
		        File dir = new File(path,fileName);          
		        if(!dir.exists()){  
		            dir.mkdirs();  
		        }  
		        file.transferTo(dir);
		    sjcggl.setFj(path+fileName); 	
		}
		
		sjcgglService.save(sjcggl);
		addMessage(redirectAttributes, "保存实践成果管理成功");
		return "redirect:"+Global.getAdminPath()+"/sjcggl/sjcggl/?repage";
	}
	
	@RequiresPermissions("sjcggl:sjcggl:edit")
	@RequestMapping(value = "delete")
	public String delete(Sjcggl sjcggl, RedirectAttributes redirectAttributes) {
		sjcgglService.delete(sjcggl);
		addMessage(redirectAttributes, "删除实践成果管理成功");
		return "redirect:"+Global.getAdminPath()+"/sjcggl/sjcggl/?repage";
	}
	@RequiresPermissions("sjcggl:sjcggl:edit")
	@RequestMapping(value = "download")
	public void download(Sjcggl sjcggl, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response) throws IOException {
		 InputStream bis = new BufferedInputStream(new FileInputStream(new File(sjcggl.getFj())));  
         String filename = sjcggl.getFj().substring(sjcggl.getFj().lastIndexOf("_")+1,sjcggl.getFj().length());  
         
         filename = URLEncoder.encode(filename,"UTF-8");  
         
         response.addHeader("Content-Disposition", "attachment;filename=" + filename);    
             
         response.setContentType("multipart/form-data");   
         
         BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());  
         int len = 0;  
         while((len = bis.read()) != -1){  
             out.write(len);  
             out.flush();  
         }  
         out.close();  
	}

}