/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjz.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
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
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.school.entity.Schoolinfo;
import com.thinkgem.jeesite.modules.school.service.SchoolinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zsjz.entity.Zsjz;
import com.thinkgem.jeesite.modules.zsjz.service.ZsjzService;

/**
 * 招生简章Controller
 * 
 * @author xfb
 * @version 2016-09-23
 */
@Controller
@RequestMapping(value = "${adminPath}/zsjz/zsjz")
public class ZsjzController extends BaseController {

	@Autowired
	private ZsjzService zsjzService;
	
	@Autowired
	private SchoolinfoService schoolinfoService;

	@ModelAttribute
	public Zsjz get(@RequestParam(required = false) String id) {
		Zsjz entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = zsjzService.get(id);
		}
		if (entity == null) {
			entity = new Zsjz();
		}
		return entity;
	}

	@RequiresPermissions("zsjz:zsjz:view")
	@RequestMapping(value = { "list", "list" })
	public String list(Zsjz zsjz, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Zsjz> page = zsjzService.findPage(
				new Page<Zsjz>(request, response), zsjz);
		model.addAttribute("page", page);
		return "modules/zsjz/zsjzList";
	}

	@RequiresPermissions("zsjz:zsjz:view")
	@RequestMapping(value = "form")
	public String form(Zsjz zsjz, Model model) {
		
		//学校信息
		List<Schoolinfo> schoolist = schoolinfoService.findList(new Schoolinfo());
		if(schoolist!=null && schoolist.size()>0)
		{
//			model.addAttribute("schoolinfo", schoolist.get(0));
			if(zsjz.getLaiyuan() ==null || "".equals(zsjz.getLaiyuan()))
			{
				zsjz.setLaiyuan(schoolist.get(0).getXxmc());
			}
		}
		String releaseby = UserUtils.getUser().getCurrentUser().getName();
		model.addAttribute("releaseby", releaseby);
		model.addAttribute("zsjz", zsjz);
		
		
		return "modules/zsjz/zsjzForm";
	}

	@RequiresPermissions("zsjz:zsjz:edit")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String save(Zsjz zsjz, Model model,
			RedirectAttributes redirectAttributes,MultipartFile file,HttpServletRequest request ) throws IOException {
		if (!beanValidator(model, zsjz)) {
			return form(zsjz, model);
		}
		// 判断文件是否为空
		if (!file.isEmpty()) 
		{
			if(file.getSize()>0)
			{
				//文件保存目录路径
				String savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/";
				//文件保存目录url
				String saveUrl =  "upload" + "/";
				File uploadDir = new File(savePath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				saveFileFromInputStream(file.getInputStream(),savePath,file.getOriginalFilename()); 
				zsjz.setTitleimg(saveUrl+file.getOriginalFilename());
			}
		}
		
		zsjzService.save(zsjz);
		addMessage(redirectAttributes, "保存招生简章成功");
		return "redirect:" + Global.getAdminPath() + "/zsjz/zsjz/list?repage";
	}

	
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
	
	
	@RequiresPermissions("zsjz:zsjz:edit")
	@RequestMapping(value = "delete")
	public String delete(Zsjz zsjz, RedirectAttributes redirectAttributes) {
		zsjzService.delete(zsjz);
		addMessage(redirectAttributes, "删除招生简章成功");
		return "redirect:" + Global.getAdminPath() + "/zsjz/zsjz/list?repage";
	}

	// 招生简章JSON接口
	@ResponseBody
	@RequestMapping(value = "getZsjzJson")
	public String getZsjzJson(Zsjz zsjz,
			HttpServletRequest request, HttpServletResponse response) {
		Page<Zsjz> page = zsjzService.findPage(
				new Page<Zsjz>(request, response), zsjz);
		List<Zsjz> zsjzList = page.getList();
		List<Map<String, Object>> mapList = Lists.newArrayList();
		for (int i = 0; i < zsjzList.size(); i++) {
			Zsjz zj = zsjzList.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("title", zj.getTitle());
			map.put("releaseBy", zj.getReleaseby());
			String reDate = DateFormat.getDateInstance(DateFormat.MEDIUM).format(zj.getReleasedate());
			map.put("releaseDate", reDate);
			map.put("content", zj.getContent());
			mapList.add(map);
		}
		return JsonMapper.toJsonString(zsjzList);
	}
	
/*	@RequiresPermissions("zsjz:zsjz:edit")
	@RequestMapping(value = "uploadFile")
	public String uploadFile(HttpServletRequest request, HttpServletResponse response)
	{
		UploadFileAction upload = new UploadFileAction();
		upload.uploadFile(response);
		return null;
	}*/
	
	/*private String fileContentType;
	private File file;
	private String fileFileName;
	private String tmpUUIDPath;
	private String deleteFilePath;
	
	public void setFile(File file)
	{
		this.file = file;
	}

	public void setFileContentType(String fileContentType)
	{
		this.fileContentType = fileContentType;
	}

	public void setFileFileName(String fileFileName)
	{
		this.fileFileName = fileFileName;
	}

	public void setTmpUUIDPath(String tmpUUIDPath)
	{
		this.tmpUUIDPath = tmpUUIDPath;
	}

	public void setDeleteFilePath(String deleteFilePath)
	{
		this.deleteFilePath = deleteFilePath;
	}*/

}