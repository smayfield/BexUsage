using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.IO;

namespace BexUsage
{
    class Program
    {
        static void Main(string[] args)
        {
            var url = ConfigurationManager.AppSettings["bexUrl"];
            var webpage = GetWebpage(url);
            var usage = ParseData(webpage);
            UpdateDatabase(usage);
        }

        public static void UpdateDatabase(Usage usage)
        {
            var connString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            var conn = new SqlConnection(connString);
            conn.Open();
            // id, isDeleted, and dateReported will use default values...
            var sql = "insert into usage (megabytesUsed, baseAllowance) values "
                    + $"({usage.MegabytesUsed}, {usage.BaseAllowance});";
            var cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public static Usage ParseData(string webpage)
        {
            // base allowance...
            var searchFor = "Base Allowance (GB):";
            var index = webpage.IndexOf(searchFor);
            var searchFor2 = "<td class=\"data\">";
            var index2 = webpage.IndexOf(searchFor2, index);
            var searchFor3 = "</td>";
            var index3 = webpage.IndexOf(searchFor3, index2);
            var baseAllowance = webpage.Substring(index2 + searchFor2.Length, index3 - index2 - searchFor2.Length);

            // usage consumed...
            searchFor = "Usage Consumed (GB):";
            index = webpage.IndexOf(searchFor);
            searchFor2 = "<td class=\"data\">";
            index2 = webpage.IndexOf(searchFor2, index);
            searchFor3 = "</td>";
            index3 = webpage.IndexOf(searchFor3, index2);
            var usageConsumed = webpage.Substring(index2 + searchFor2.Length, index3 - index2 - searchFor2.Length);

            var usage = new Usage()
            {
                DateReported = DateTime.Now,
                MegabytesUsed = float.Parse(usageConsumed),
                BaseAllowance = float.Parse(baseAllowance)
            };
            return usage;
        }

        public static string GetWebpage(string url)
        {
            var request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "GET";
            var response = request.GetResponse();
            var sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
            string result = sr.ReadToEnd();
            sr.Close();
            response.Close();
            return result;
        }
    }

    public class Usage
    {
        public DateTime DateReported { get; set; }
        public float MegabytesUsed { get; set; }
        public float BaseAllowance { get; set; }
    }
}
