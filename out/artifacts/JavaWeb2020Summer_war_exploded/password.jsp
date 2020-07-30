<%--
  Created by IntelliJ IDEA.
  User: wuyanjie
  Date: 2020/7/28
  Time: 12:13 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>密码强度检测</title>
</head>
<style type="text/css">
    .default {background: #eeeeee;}
    .weak {background: #FF0000;}
    .medium {background: #FF9900;}
    .strong {background: #33CC00;}
    input {height: 20px; line-height: 20px;width: 210px;}
    span {display: inline-block;width: 70px;height: 30px;line-height: 30px;background: #ddd;text-align: center;margin: 4px 2px;}
</style>
<script type="text/javascript">
    window.onload = function(){
        var oInput = document.getElementById('inputPassword');
        oInput.value = '';
        var spans = document.getElementsByTagName('span');
        oInput.onkeyup = function(){
            //强度状态设为默认
            spans[0].className = spans[1].className = spans[2].className = "default";
            var pwd = this.value;
            var result = 0;
            for(var i = 0, len = pwd.length; i < len; ++i){
                result |= charType(pwd.charCodeAt(i));
            }
            var level = 0;
            //对result进行四次循环，计算其level
            for(var i = 0; i <= 4; i++){
                if(result & 1){
                    level ++;
                }
                //右移一位
                result = result >>> 1;
            }
            if(pwd.length >= 6){
                switch (level) {
                    case 1:
                        spans[0].className = "weak";
                        break;
                    case 2:
                        spans[0].className = "medium";
                        spans[1].className = "medium";
                        break;
                    case 3:
                    case 4:
                        spans[0].className = "strong";
                        spans[1].className = "strong";
                        spans[2].className = "strong";
                        break;
                }
            }
        }
    }
    /*
      定义一个函数，对给定的数分为四类(判断密码类型)，返回十进制1，2，4，8
      数字 0001 -->1 48~57
      小写字母 0010 -->2 97~122
      大写字母 0100 -->4 65~90
      特殊 1000 --> 8 其它
    */
    function charType(num){
        if(num >= 48 && num <= 57){
            return 1;
        }
        if (num >= 97 && num <= 122) {
            return 2;
        }
        if (num >= 65 && num <= 90) {
            return 4;
        }
        return 8;
    }
</script>
<body>
<label >请输入密码：</label><input id ='inputPassword' type="text" name="pwd" /><br>
<label >密 码 强 度：</label><span>弱</span><span>中</span><span>强</span>
</body>
</html>
