package com.card.manager.factory.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义注解，用于标注异常信息
 */
@Target({ElementType.FIELD})  
@Retention(RetentionPolicy.RUNTIME)  
@Documented
public @interface ExpInfo {
	
	/** 异常编号 */
	String key() default "";
	
	/** 异常信息 */
	String value() default "";
}
