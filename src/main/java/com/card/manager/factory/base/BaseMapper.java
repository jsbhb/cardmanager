package com.card.manager.factory.base;

import java.util.Map;

import com.github.pagehelper.Page;

/**
* 说明：基础映射对象
* @author  贺斌
* @version  1.0
* 2014-12-2 下午1:34:33
*/ 
public interface BaseMapper<T> {

	/**
	 *  保存一个对象
	 * @param t
	 */
	public void add(T t);

	/**
	 * 更新一个对象
	 * @param t
	 * @return 
	 */
	public int update(T t);

	/**
	 * 删除一个对象
	 * @param id
	 */
	public void delete(Object id);

	/**
	 * 查询总记录数
	 * @param params
	 * @return
	 */
	public int queryByCount(Map<String, Object> params);

	/**
	 * 根据条件查询一个list
	 * @param params
	 * @return
	 */
	public Page<T> queryByList(Map<String, Object> params);

	/**
	 * 查询一个对象
	 * @param id
	 * @return
	 */
	public T queryById(Object id);
}
