using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Drawing;
using System.IO;

public partial class RandomImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CreateCheckCodeImage(GenerateCheckCode(4));
    }

    //生成验证码
    private string GenerateCheckCode(int length)
    {
        //定义验证码长度
        int CODELENGTH = length;
        int number;
        string randomCode = string.Empty;//定义验证码
        Random r = new Random();//生成随机的验证码
        for (int i = 0; i < CODELENGTH; i++)
        {
            number = r.Next();
            number = number % 36;//生成数字0~35
            if (number < 10)
            {
                number += 48;//数字0~9对应的ASIC码
            }
            else
            {
                number += 55;//大写字母A~Z对应的ASIC码
            }
            randomCode += ((char)number).ToString();//把生成的一组验证码放入字符串randomCode中
        }
        //在Cookie中保存验证码
        Response.Cookies.Add(new HttpCookie("CheckCode", randomCode));
        return randomCode;
    }

    //把字符串验证码生成一张图片
    public void CreateCheckCodeImage(string checkCode)
    {
        if (checkCode == null || checkCode.Trim() == string.Empty)
        {
            return;
        }
        //数字15后面的m表示Decimal（十进制数）
        //请测试不写m，会不会出现不同效果
        int iWidth = (int)Math.Ceiling(checkCode.Length * 15m);
        int iHeight = 20;
        //创建图像
        Bitmap image = new Bitmap(iWidth, iHeight);
        //从图像获取一个绘图面
        Graphics g = Graphics.FromImage(image);
        try
        {
            Random r = new Random();
            //清空图片背景色
            g.Clear(Color.White);
            //画图片的背景噪音点10条
            for (int i = 0; i < 10; i++)
            {
                int x1 = r.Next(image.Width);
                int x2 = r.Next(image.Width);
                int y1 = r.Next(image.Height);
                int y2 = r.Next(image.Height);
                //用银色画出噪音线
                g.DrawLine(new Pen(Color.Silver), x1, y1, x2, y2);
            }
            //画图片的前景噪音点50个
            for (int i = 0; i < 50; i++)
            {
                int x = r.Next(image.Width);
                int y = r.Next(image.Height);
                image.SetPixel(x, y, Color.FromArgb(r.Next()));
            }
            //画图片的框线
            g.DrawRectangle(new Pen(Color.SaddleBrown), 0, 0, image.Width - 1, image.Height - 1);
            //定义绘制文字的字体
            Font f = new Font("Arial", 12, (FontStyle.Bold | FontStyle.Italic));
            //线性渐变画刷
            System.Drawing.Drawing2D.LinearGradientBrush brush = new System.Drawing.Drawing2D.LinearGradientBrush(new Rectangle(0, 0, image.Width, image.Height), Color.Blue, Color.Purple, 1.2f, true);
            g.DrawString(checkCode, f, brush, 2, 2);
            //创建内存流用于输出图片
            using (MemoryStream ms = new MemoryStream())
            {
                //图片格式制定为Jpeg
                image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                //清除缓冲区流中的所有输出
                Response.ClearContent();
                //输出流的HTTP MIME类型设置为"image/Jpeg"
                Response.ContentType = "image/jpeg";
                //输出图片的二进制流
                Response.BinaryWrite(ms.ToArray());
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            return;
        }
        finally
        {
            //释放Bitmap对象和Graphics对象
            g.Dispose();
            image.Dispose();
        }
    }
}