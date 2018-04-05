/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdg.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.course.dao.CourseDao;
import com.thinkgem.jeesite.modules.course.entity.Course;
import com.thinkgem.jeesite.modules.jxdg.dao.JxDgDao;
import com.thinkgem.jeesite.modules.jxdg.entity.JxDg;
import com.thinkgem.jeesite.modules.jxdgxsfp.dao.JxDgXsfpDao;
import com.thinkgem.jeesite.modules.jxdgxsfp.entity.JxDgXsfp;

/**
 * 教学大纲Service
 * @author zx
 * @version 2018-03-01
 */
@Service
@Transactional(readOnly = true)
public class JxDgService extends CrudService<JxDgDao, JxDg> {
    @Autowired
    private CourseDao courseDao;
    @Autowired
    private JxDgDao jxdgDao;
    @Autowired
    private JxDgXsfpDao jxDgXsDao;
	public JxDg get(String id) {
		return super.get(id);
	}
	
	public List<JxDg> findList(JxDg jxDg) {
		return super.findList(jxDg);
	}
	public List<JxDgXsfp> fingjxdgxsList(JxDgXsfp jxdgxsfp){
		return jxDgXsDao.findList(jxdgxsfp);
	}
	
	public Page<JxDg> findPage(Page<JxDg> page, JxDg jxDg) {
		return super.findPage(page, jxDg);
	}
	@Transactional(readOnly = false)
	public void savejxdg(JxDg jxDg){
		try {
			JxDg jxdg=jxdgDao.findjxdgByCourseXnxq(jxDg);
			if (jxdg==null) {
				jxdg=new JxDg();
				jxdg.setXuhao("0");
			}
			if(jxdg.getXuhao().equals("1")){
				jxDg.preUpdate();
				dao.update(jxDg);
			}else{
				jxDg.preInsert();
				dao.insert(jxDg);
			}
			if (jxDg.getJxdgXsfp() != null && jxDg.getJxdgXsfp().size() > 0) {
				JxDgXsfp jxdfxs=new JxDgXsfp();
				jxdfxs.setJxdgId(jxDg.getId());
				jxDgXsDao.deLByJxDgId(jxdfxs);
				for (JxDgXsfp jx : jxDg.getJxdgXsfp()) {
					if (jx.getJxnr()!= null && !jx.getJxnr().equals("")) {
						jx.setJxdgId(jxDg.getId());
						jx.preInsert();
						jxDgXsDao.insert(jx);
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
	@Transactional(readOnly = false)
	public void save(JxDg jxDg) {
		super.save(jxDg);
	}
	
	@Transactional(readOnly = false)
	public void delete(JxDg jxDg) {
		super.delete(jxDg);
	}
	public Course getcourseByid(String id){
		return courseDao.get(id);
		
	}
	public List<Map> findZyByCourseId(String id){
		return jxdgDao.fingZyByCourseId(id);
		
	}
	public JxDg findjxdgByCourseXnxq(JxDg jxdg){
		return jxdgDao.findjxdgByCourseXnxq(jxdg);
	} 
}