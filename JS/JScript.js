 //重新获取验证字符
 function changeImage() 
{
    //单击触发图片重载事件，完成图片验证码的更换
    document.getElementById("imgRandom").src = document.getElementById("imgRandom").src + '?';
}