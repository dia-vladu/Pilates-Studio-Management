using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProiectBDInternet
{
    public partial class Dashboard1 : System.Web.UI.Page
    {
        public string chartData = "";
        public int totalBookings = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblTotalMembers.InnerText = GetTotalMembers().ToString();
                lblTotalTrainers.InnerText = GetTotalTrainers().ToString();
                lblTotalClasses.InnerText = GetTotalAvailableClasses().ToString();

                // Get total bookings once
                totalBookings = GetTotalBookings();
                lblTotalBookings.InnerText = totalBookings.ToString();

                LoadWeeklyChart();
            }
        }
        private int GetTotalMembers()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Members", conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private int GetTotalTrainers()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM trainers", conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private int GetTotalAvailableClasses()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString))
            {
                string sql = @"
                    SELECT COUNT(*) 
                    FROM ScheduledClasses
                    WHERE StartTime > GETDATE() 
                        AND SoldOut = 0          
                ";

                SqlCommand cmd = new SqlCommand(sql, conn);
              
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private int GetTotalBookings()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString))
            {
                string sql = @"
                    SELECT COUNT(*)
                    FROM Bookings b
                    INNER JOIN ScheduledClasses sc ON b.ScheduledClassId = sc.Id
                    WHERE sc.StartTime >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0)
                    AND sc.StartTime < DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) + 1, 0)
                ";

                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private void LoadWeeklyChart()
        {
            int[] days = new int[7];

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetWeeklyBookings", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int day = Convert.ToInt32(reader["DayNumber"]) - 1;
                    int bookings = Convert.ToInt32(reader["TotalBookings"]);

                    days[day] = bookings;
                }
            }

            chartData = string.Join(",", days);
        }
    }
}