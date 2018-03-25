using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Security.Cryptography;
using System.Text.RegularExpressions;

/// <summary>
///Tool 的摘要说明
/// </summary>
public class Tool
{
    //加密密码
    public static string EncryptPassword(string password)
    {
        byte[] pass = ConvertToByteArray(password);//安全的哈希编码
        SHA1 s = new SHA1CryptoServiceProvider();
        string cryptPassword = BitConverter.ToString(s.ComputeHash(pass));
        return cryptPassword;
    }

    public static byte[] ConvertToByteArray(string password)
    {
        char[] pass = password.ToCharArray();
        byte[] covPass = new byte[pass.Length];
        for (int i = 0; i < covPass.Length; i++)
        {
            covPass[i] = Convert.ToByte(pass[i]);
            //Console.WriteLine("test: "+covPass[i]);
        }
        return covPass;
    }

    private string SqlReplace(string str)
    {
        str = str.Trim();
        str = str.Replace("'", "''");
        str = str.Replace("\"", "");
        str = str.Replace("%", "");
        str = str.Replace("--", "");
        str = str.Replace(";", "");
        //str = str.Replace("(", "");
        //str = str.Replace(")", "");
        str = str.Replace("_", "");
        str = str.Replace("<", "&lt;");
        str = str.Replace(">", "&gt;");
        return str;
    }

    public static string ProcessTags(string text)
    {
        //替换粗体标记
        text = Regex.Replace(text, "\\[(/?B)\\]", "<$1>", RegexOptions.IgnoreCase);
        //替换下划线标记
        text = Regex.Replace(text, "\\[(/?U)\\]", "<$1>", RegexOptions.IgnoreCase);
        //替换斜体标记
        text = Regex.Replace(text, "\\[(/?I)\\]", "<$1>", RegexOptions.IgnoreCase);

        //替换笑脸标记
        text = text.Replace("[:)]", @"<img src='images/topicface/smile.gif' alt='微笑' style='border:0'/>");
        text = text.Replace("[:D]", @"<img src='images/topicface/LargeSmile.gif' alt='大笑' style='border:0'/>");
        text = text.Replace("[8]", @"<img src='images/topicface/Cool.gif' alt='酷' style='border:0'/>");
        text = text.Replace("[:o]", @"<img src='images/topicface/Surprise.gif' alt='惊奇' style='border:0'/>");
        text = text.Replace("[:(]", @"<img src='images/topicface/Sad.gif' alt='悲伤' style='border:0'/>");
        text = text.Replace("[:x]", @"<img src='images/topicface/angry.gif' alt='生气' style='border:0'/>");
        //替换引用标记
        text = Regex.Replace(text, "\\[QUOTE\\]", "<font size=\"1\"><blockquote>引用:<hr height=\"1\"noshade>", RegexOptions.IgnoreCase);
        text = Regex.Replace(text, "\\[QUOTE\\]", "<hr height=\"1\" noshade></blockquote></font>", RegexOptions.IgnoreCase);
        //替换换行与空格标记
        text = text.Replace("\n", "<br/>");
        text = text.Replace("\r", "");
        return text;
    }
}