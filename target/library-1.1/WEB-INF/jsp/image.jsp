<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Font"%>
<%@page import="java.awt.Graphics"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.util.Random"%>
<%@page import="java.awt.Color"%>
<%@ page language="java" contentType="image/JPEG; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%!
    //获取随机颜色
    Color getRandColor(int fc,int bc){
        Random random = new Random();
        if(fc>255) fc=255;
        if(bc>255) bc=255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r,g,b);
    }
%>
<%
    //设置页面不缓存
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    //在内存中创建图像
    int width = 60;
    int height = 20;
    BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
    //获取图形上下文
    Graphics g = image.getGraphics();
    //随机类
    Random random = new Random();
    //设定背景
    g.setColor(getRandColor(200, 250));
    g.fillRect(0, 0, width, height);
    //设定字体
    g.setFont(new Font("Times New Roman",Font.PLAIN,18));
    //随机产生干扰线
    g.setColor(getRandColor(160, 200));
    for (int i = 0; i < 100; i++) {
        int x = random.nextInt(width);
        int y = random.nextInt(height);
        int xl = random.nextInt(12);
        int yl = random.nextInt(12);
        g.drawLine(x, y, x + xl, y + yl);
    }
    //随机产生4位验证码
    String[] codes = {"2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z"};
    String code = "";
    for(int i=0;i<4;i++){
        String str = codes[random.nextInt(codes.length)];
        code += str;
        // 将认证码显示到图象中
        g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
        //调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
        g.drawString(str, 13 * i + 6, 16);
    }
    // 将认证码存入SESSION
    session.setAttribute("code", code);
    // 图象生效
    g.dispose();
    // 输出图象到页面
    ImageIO.write(image, "JPEG", response.getOutputStream());
    //加上下面代码,运行时才不会出现java.lang.IllegalStateException: getOutputStream() has already been called ..........等异常
    response.getOutputStream().flush();
    response.getOutputStream().close();
    response.flushBuffer();
%>
