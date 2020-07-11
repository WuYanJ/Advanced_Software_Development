package com.wyj.Test;

import com.wyj.Model.User;
import org.apache.commons.beanutils.BeanUtils;
import org.junit.Test;

import java.lang.reflect.InvocationTargetException;

public class BeanUtilsTest {
    @Test
    public void testSetProperty() throws InvocationTargetException, IllegalAccessException {
        User user = new User();
        System.out.println(user.toString());

        BeanUtils.setProperty(user, "username", "zhangyuru");
        System.out.println(user.toString());
        BeanUtils.setProperty(user, "password", "19721110");
        System.out.println(user.toString());

    }

    @Test
    public void testGetProperty() throws InvocationTargetException, IllegalAccessException, NoSuchMethodException {
        User user = new User();
        System.out.println(user.toString());
        BeanUtils.setProperty(user, "username", "zhangyuru");
        System.out.println(user.toString());
        Object val = BeanUtils.getProperty(user, "username");
        // 如果getXxx方法的Xxx的属性不是"username"，就get不到
    }
}
