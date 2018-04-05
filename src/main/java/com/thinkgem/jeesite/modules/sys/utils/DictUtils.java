/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.bj.dao.BjJbxxDao;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.course.dao.CourseDao;
import com.thinkgem.jeesite.modules.course.entity.Course;
import com.thinkgem.jeesite.modules.js.dao.JsJbxxDao;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.sys.dao.AreaDao;
import com.thinkgem.jeesite.modules.sys.dao.DictDao;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.xjxx.dao.XnJbxxDao;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xnxq.dao.XnxqJbxxDao;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xs.dao.XsJbxxDao;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.zsjh.dao.ZsjhDao;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zy.dao.ZyJbxxDao;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zylx.dao.ZylxJbxxDao;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 字典工具类
 * 
 * @author ThinkGem
 * @version 2013-5-29
 */
public class DictUtils {

	private static DictDao dictDao = SpringContextHolder.getBean(DictDao.class);

	private static ZylxJbxxDao zylxJbxxDao = SpringContextHolder
			.getBean(ZylxJbxxDao.class);
	private static ZyJbxxDao zyJbxxDao = SpringContextHolder
			.getBean(ZyJbxxDao.class);
	private static ZsjhDao zsjhDao = SpringContextHolder.getBean(ZsjhDao.class);
	private static AreaDao areaDao = SpringContextHolder.getBean(AreaDao.class);
	private static OfficeDao officeDao=SpringContextHolder.getBean(OfficeDao.class);
	private static XnxqJbxxDao xnxqDao = SpringContextHolder.getBean(XnxqJbxxDao.class);
	private static XnJbxxDao xnJbDao = SpringContextHolder.getBean(XnJbxxDao.class);
	private static BjJbxxDao bjJbDao = SpringContextHolder.getBean(BjJbxxDao.class);
	private static CourseDao courseDao = SpringContextHolder.getBean(CourseDao.class);
	private static XsJbxxDao xsJbDao = SpringContextHolder.getBean(XsJbxxDao.class);
	private static JsJbxxDao jsJbDao = SpringContextHolder.getBean(JsJbxxDao.class);
	public static final String CACHE_DICT_MAP = "dictMap";

	public static String getDictLabel(String value, String type,
			String defaultValue) {
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(value)) {
			for (Dict dict : getDictList(type)) {
				if (type.equals(dict.getType())
						&& value.equals(dict.getValue())) {
					return dict.getLabel();
				}
			}
		}
		return defaultValue;
	}

	public static List<ZylxJbxx> getZylxList() {
		return zylxJbxxDao.findList(new ZylxJbxx());
	}

	//学年学期
	public static List<XnxqJbxx> getXnxqJbxxList()
	{
		List<XnxqJbxx> list = new ArrayList<XnxqJbxx>();
		List<XnxqJbxx> xnxqList = xnxqDao.findAllList(new XnxqJbxx());
		if(xnxqList!=null && xnxqList.size()>0){
			for(XnxqJbxx entity :xnxqList){
				entity.setXnmc(entity.getXnmc()+"("+entity.getRemarks()+")");
				list.add(entity);
			}
		}
		return list;
	}
	//学年学期
	public static List<XnxqJbxx> getXnxq()
	{
		List<XnxqJbxx> list = new ArrayList<XnxqJbxx>();
		List<XnxqJbxx> xnxqList = xnxqDao.findXnxq();
		if(xnxqList!=null && xnxqList.size()>0){
			for(XnxqJbxx entity :xnxqList){
				entity.setXnmc(entity.getXnmc());
				list.add(entity);
			}
		}
		return list;
	}
	//根据id查询学年学期
		public static String getXnxqmc(String value)
		{
			 XnxqJbxx xnxqJbxx = xnxqDao.get(value);
			 String xnmc=xnxqJbxx.getXnmc();
			return xnmc;
		}
		public static String getStudent(String value)
		{
			String stuname="";
			if(value.length()>1){
				String[] str = value.split(",");
				for (int i = 0; i < str.length; i++) {
					XsJbxx jbxx = xsJbDao.get(str[i]);
					stuname+=jbxx.getXm()+" ";
				}
				return stuname;
			}
			XsJbxx jbxx = xsJbDao.get(value);
			return jbxx.getXm();
		}
		
		public static String getTeacher(String value)
		{
			String stuname="";
			if(value.length()>1){
				String[] str = value.split(",");
				for (int i = 0; i < str.length; i++) {
					JsJbxx jbxx = jsJbDao.get(str[i]);
					stuname+=jbxx.getXm()+" ";
				}
				return stuname;
			}
			XsJbxx jbxx = xsJbDao.get(value);
			return jbxx.getXm();
		}
	/**
	 * Des:学年
	 * 2016-12-1
	 * @author fn
	 * @return
	 * List<XnJbxx>
	 */
	public static List<XnJbxx> getXnJbxxList()
	{
		return xnJbDao.findListByXn(new XnJbxx());
	}
	
	/**
	 * Des:班级
	 * 2016-12-28
	 * @author fn
	 * @return
	 * List<BjJbxx>
	 */
	public static List<BjJbxx> getBjJbxxList()
	{
		User user=UserUtils.getUser();
		BjJbxx bjJbxx=new BjJbxx();
		bjJbxx.setJsId(user);
		return bjJbDao.findList(bjJbxx);
	}
	
	/**
	 * Des:全部班级
	 * 
	 * @author fn
	 * @return
	 * List<BjJbxx>
	 */
	public static List<BjJbxx> findBjJbxxList()
	{
		BjJbxx bjJbxx=new BjJbxx();
		return bjJbDao.findList(bjJbxx);
	}
	
	// 获取专业
	public static List<ZyJbxx> getZyList() {
		return zyJbxxDao.findList(new ZyJbxx());
	}

	// 获取招生计划列表
	public static List<Zsjh> getZsjhList() {
		List<Zsjh> list2 = new ArrayList<Zsjh>();
		List<Zsjh> list = zsjhDao.findList(new Zsjh());
		for (int i = 0; i < list.size(); i++) {
			String zt = list.get(i).getZt();
			if (zt.equals("3")) {
				list2.add(list.get(i));
			} else {
				continue;
			}
		}
		return list2;
	}
	// 获取招生部门列表
	public static List<Office> getZsbmList() {
		List<Office> list = officeDao.findAllZsbm();
		return list;
	}

	public static List<Zsjh> getZsjhListByCreateDate() {
		List<Zsjh> list = zsjhDao.findAllListByCreateDate(new Zsjh());
		return list;
	}
	
	public static List<Zsjh> findListByUsed() {
		List<Zsjh> list = zsjhDao.findListByUsed(new Zsjh());
		return list;
	}
	
	public static List<Zsjh> findListByUserId() {
		Zsjh zsjh = new Zsjh();
		User user = UserUtils.getUser();
		zsjh.setCreateBy(user);
		List<Zsjh> list = zsjhDao.findListByUserId(zsjh);
		return list;
	}
	
	public static List<Zsjh> findZsjhListByUserId()
	{
		Zsjh zsjh = new Zsjh();
		User user = UserUtils.getUser();
		zsjh.setCreateBy(user);
		List<Zsjh> list = zsjhDao.findZsjhListByUserId(zsjh);
		return list;
	}

	//审核通过并招生计划未结束
	public static List<Zsjh> findListZsjh()
	{
		Zsjh zsjh = new Zsjh();
		User user = UserUtils.getUser();
		zsjh.setCreateBy(user);
		List<Zsjh> list = zsjhDao.findListZsjh(zsjh);
		return list;
	}
	//获取地区名称
	public static String getAreaName(String id){
		Area area=new Area();
		if(id!=null&&id.length()!=0){
			area =areaDao.get(id);
		}
		return area.getName()==null?"":area.getName();
	}
	// 获取地区列表
	public static List<Area> findAllByChr(String parentId) {
		Area area = new Area();
		area.setParent(new Area(parentId));
		return areaDao.findAllByChr(area);
	}

	// 获取省份
		public static List<Area> findBySF() {
			return areaDao.findBySF();
		}
	
	public static String getZylxLabel(String zylxId) {
		ZylxJbxx zylxJbxx = zylxJbxxDao.get(zylxId);
		if (zylxJbxx != null) {
			return zylxJbxx.getLxmc();
		}
		return "";
	}

	public static String getDictLabels(String values, String type,
			String defaultValue) {
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(values)) {
			List<String> valueList = Lists.newArrayList();
			for (String value : StringUtils.split(values, ",")) {
				valueList.add(getDictLabel(value, type, defaultValue));
			}
			return StringUtils.join(valueList, ",");
		}
		return defaultValue;
	}

	public static String getDictValue(String label, String type,
			String defaultLabel) {
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(label)) {
			for (Dict dict : getDictList(type)) {
				if (type.equals(dict.getType())
						&& label.equals(dict.getLabel())) {
					return dict.getValue();
				}
			}
		}
		return defaultLabel;
	}

	public static List<Dict> getDictList(String type) {
		@SuppressWarnings("unchecked")
		Map<String, List<Dict>> dictMap = (Map<String, List<Dict>>) CacheUtils
				.get(CACHE_DICT_MAP);
		if (dictMap == null) {
			dictMap = Maps.newHashMap();
			for (Dict dict : dictDao.findAllList(new Dict())) {
				List<Dict> dictList = dictMap.get(dict.getType());
				if (dictList != null) {
					dictList.add(dict);
				} else {
					dictMap.put(dict.getType(), Lists.newArrayList(dict));
				}
			}
			CacheUtils.put(CACHE_DICT_MAP, dictMap);
		}
		List<Dict> dictList = dictMap.get(type);
		if (dictList == null) {
			dictList = Lists.newArrayList();
		}
		return dictList;
	}

	/**
	 * 返回字典列表（JSON）
	 * 
	 * @param type
	 * @return
	 */
	public static String getDictListJson(String type) {
		return JsonMapper.toJsonString(getDictList(type));
	}
	
	//学年学期
	public static List<Course> getCourseList()
	{
		List<Course> list = new ArrayList<Course>();
		List<Course> courseList = courseDao.findAllList(new Course());
		if(courseList!=null && courseList.size()>0){
			for(Course entity :courseList){
				list.add(entity);
			}
		}
		return list;
	}
}
