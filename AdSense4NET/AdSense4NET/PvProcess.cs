using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace AdSense4NET
{
    public class PvProcess:IHttpHandler
    {
    
       public bool  IsReusable
       {
           get { return true; }
       }

      public void  ProcessRequest(HttpContext context)
      {
          string sourceUrl = context.Request.Path;
          string targetUrl = context.Request.QueryString["url"];
          int index=sourceUrl.LastIndexOf('/');
          int length=sourceUrl.LastIndexOf('.')-index-1;
          string siteID = sourceUrl.Substring(index + 1, length);
          context.Response.Write(siteID+">"+targetUrl);
          string path = context.Request.PhysicalApplicationPath + "logs\\";
          Log2File(path, siteID, targetUrl);
      }

      private void Log2File(string path,string siteID,string targetUrl)
      {
          string now = DateTime.Now.ToString("");
          string today=DateTime.Now.ToString("yyyy-MM-dd");
          string line = now + " " + targetUrl;
          string logFileName = path+siteID + "-" + today + ".log";
          StreamWriter logFile = new StreamWriter(path+siteID+"-"+today+".log",true,System.Text.Encoding.UTF8);
          logFile.WriteLine(line);
          logFile.Close();
      }
    }
}