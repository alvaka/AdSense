using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace AdSense4NET.Account
{
    public partial class adimage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int MAX_IMG_SIZE=5*1024*1024;
      
            FileStream fs = new FileStream("D:\\cache\\f2.png", FileMode.Open);
            BinaryReader br = new BinaryReader(fs);
            byte[] imgBuff=br.ReadBytes(MAX_IMG_SIZE);
            Response.ContentType = "image/jpeg";
            Response.Clear();
            Response.BufferOutput = true;
            Response.BinaryWrite(imgBuff);
            Response.Flush();
            br.Close();
        }
    }
}