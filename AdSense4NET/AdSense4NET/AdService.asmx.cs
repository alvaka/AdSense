using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Text;

namespace AdSense4NET
{
    /// <summary>
    /// AdService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://yanqizheng.cn/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    // [System.Web.Script.Services.ScriptService]
    public class AdService : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetAdSites()
        {
            string conStr=System.Configuration.ConfigurationManager.ConnectionStrings[0].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();

            cmd.CommandText = "select * from tb_AdSite";
            SqlDataReader reader = cmd.ExecuteReader();
            if(!reader.HasRows)return "[]";
            StringBuilder Json = new StringBuilder("[");
            reader.Read();
            do
            {
                int SiteId = reader.GetInt32(0);
                string SiteName = reader.GetString(1);
                string SiteUrl = reader.GetString(2);
                Json.Append("{\"SiteId\":\""+SiteId+"\",");
                Json.Append("\"SiteName\":\"" + SiteName + "\",");
                Json.Append("\"SiteUrl\":\"" + SiteUrl + "\"}");
                if (reader.Read()) Json.Append(",");
                else break;
            }while (true);
            reader.Close();
            Json.Append("]");
            conn.Close();
            return Json.ToString();    
        }

        [WebMethod]
        public string AddAdSites(string name, string url)
        {
            if (String.IsNullOrWhiteSpace(name) || String.IsNullOrWhiteSpace(url)) return "{\"status\":1,\"message\":\"parameters cannot be null or empty!\"}";
            string conStr = System.Configuration.ConfigurationManager.ConnectionStrings[0].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd.Connection = conn;
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.CommandText = "dbo.InsertAdSite";

            SqlParameter pSiteName = new SqlParameter();
            pSiteName.ParameterName = "@AdSiteName";
            pSiteName.SqlDbType = System.Data.SqlDbType.VarChar;
            pSiteName.Value = name;

            SqlParameter pSiteUrl = new SqlParameter();
            pSiteUrl.ParameterName = "@AdSiteUrl";
            pSiteUrl.SqlDbType = System.Data.SqlDbType.VarChar;
            pSiteUrl.Value = url;

            SqlParameter pSiteID = new SqlParameter();
            pSiteID.ParameterName = "@AdSiteId";
            pSiteID.SqlDbType = System.Data.SqlDbType.Int;
            pSiteID.Direction = System.Data.ParameterDirection.ReturnValue;

            cmd.Parameters.Add(pSiteName);
            cmd.Parameters.Add(pSiteUrl);
            cmd.Parameters.Add(pSiteID);
            cmd.ExecuteNonQuery();
            conn.Close();
            string siteId = pSiteID.Value.ToString();
            return "{\"status\":0,\"data\":{\"count\":1,\"items\":[{\"SiteId\":" + siteId + "}]}}";
            
            
        }
    }
}
