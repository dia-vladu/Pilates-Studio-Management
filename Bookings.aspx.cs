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
    public partial class Bookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CalendarReserveASpot_SelectionChanged(object sender, EventArgs e)
        {
            ddScheduledClassesAvailable.DataBind();
        }

        protected void btnReserveASpot_Click(object sender, EventArgs e)
        {
            int memberId;
            int scheduledClassId;

            if (!int.TryParse(DropDownList1.SelectedValue, out memberId) || memberId <= 0)
            {
                // Show error (optional Label)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a member.');", true);
                return;
            }

            if (!int.TryParse(ddScheduledClassesAvailable.SelectedValue, out scheduledClassId) || scheduledClassId <= 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a class.');", true);
                return;
            }

            // Prevent double-booking for same member/class
            if (IsAlreadyBooked(memberId, scheduledClassId))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This member is already booked for the selected class.');", true);
                return;
            }

            // Insert booking
            string connStr = ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                int currentBookings;
                int maxCapacity;

                // 1️) Count current bookings
                string countSql = "SELECT COUNT(*) FROM Bookings WHERE ScheduledClassId = @ScheduledClassId";
                using (SqlCommand cmd = new SqlCommand(countSql, conn))
                {
                    cmd.Parameters.AddWithValue("@ScheduledClassId", scheduledClassId);
                    currentBookings = (int)cmd.ExecuteScalar();
                }

                // 2️) Get max capacity
                string capacitySql = "SELECT MaxCapacity FROM ScheduledClasses WHERE Id = @ScheduledClassId";
                using (SqlCommand cmd = new SqlCommand(capacitySql, conn))
                {
                    cmd.Parameters.AddWithValue("@ScheduledClassId", scheduledClassId);
                    maxCapacity = (int)cmd.ExecuteScalar();
                }

                // 3️) Stop if class already full
                if (currentBookings >= maxCapacity)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No spots left for this class.');", true);
                    return;
                }

                // 4️) Insert booking
                string insertSql = @"INSERT INTO Bookings (ScheduledClassId, MemberId)
                             VALUES (@ScheduledClassId, @MemberId)";
                using (SqlCommand cmd = new SqlCommand(insertSql, conn))
                {
                    cmd.Parameters.AddWithValue("@ScheduledClassId", scheduledClassId);
                    cmd.Parameters.AddWithValue("@MemberId", memberId);
                    cmd.ExecuteNonQuery();
                }

                currentBookings++;

                // 5️) If class became full → mark SoldOut
                if (currentBookings >= maxCapacity)
                {
                    string soldOutSql = @"UPDATE ScheduledClasses 
                                  SET SoldOut = 1 
                                  WHERE Id = @ScheduledClassId";

                    using (SqlCommand cmd = new SqlCommand(soldOutSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@ScheduledClassId", scheduledClassId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            GridView3.DataBind();

        }

        private bool IsAlreadyBooked(int memberId, int scheduledClassId)
        {
            bool booked = false;
            string connStr = ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT COUNT(*) FROM Bookings WHERE MemberId=@MemberId AND ScheduledClassId=@ScheduledClassId";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@MemberId", memberId);
                    cmd.Parameters.AddWithValue("@ScheduledClassId", scheduledClassId);

                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    booked = count > 0;
                }
            }
            return booked;
        }
    }
}