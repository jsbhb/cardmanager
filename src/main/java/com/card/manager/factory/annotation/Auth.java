package com.card.manager.factory.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
* 说明：自定义注解 权限
* @author  赵增丰
* @version  1.0
* 2014-8-18 上午10:41:24
*/ 
@Retention(RetentionPolicy.RUNTIME) 
@Target(ElementType.METHOD) 
@Documented 
@Inherited
public @interface  Auth {
	/**
	 * 是否验证登陆 true=验证 ,false = 不验证
	 * @return
	 */
	 public boolean verifyLogin() default true;
	 
	 
	 /**
	 * 是否验证URL true=验证 ,false = 不验证
	 * @return
	 */
	 public boolean verifyURL() default true;
	 
	 
}
