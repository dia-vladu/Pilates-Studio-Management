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
    public partial class ScheduleClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnScheduleClass_Click(object sender, EventArgs e)
        {
            DropDownList ddClassNames = (DropDownList)GridView2.FooterRow.FindControl("ddClassNames");
            DropDownList ddTrainerNames = (DropDownList)GridView2.FooterRow.FindControl("ddTrainerNames");
            TextBox tbStartsAt = (TextBox)GridView2.FooterRow.FindControl("tbStartsAt");
            Label lblError = (Label)GridView2.FooterRow.FindControl("lblError");
            TextBox tbClassCapacity = (TextBox)GridView2.FooterRow.FindControl("tbClassCapacity");

            // Validate StartAt
            DateTime startTime;
            if (!DateTime.TryParse(tbStartsAt.Text, out startTime) || startTime < DateTime.Now)
            {
                if (lblError != null)
                    lblError.Text = "Cannot schedule a class in the past!";
                return;
            }

            // Validate Class Name, Trainer Name and Class Capacity
            int maxCapacity;
            if (ddClassNames.SelectedValue == "0" ||
                ddTrainerNames.SelectedValue == "0" ||
                !int.TryParse(tbClassCapacity.Text, out maxCapacity) ||
                maxCapacity <= 0)
            {
                if (lblError != null)
                    lblError.Text = "Please select a class, trainer, and enter a capacity greater than 0.";
                return;
            }

            int classId = Convert.ToInt32(ddClassNames.SelectedValue);
            int trainerId = Convert.ToInt32(ddTrainerNames.SelectedValue);

            AddNewRecordSP(classId, trainerId, startTime, maxCapacity);

            // Clear footer fields
            ddClassNames.SelectedIndex = 0;
            ddTrainerNames.SelectedIndex = 0;
            tbStartsAt.Text = "";
            tbClassCapacity.Text = "";
            //if (lblError != null) lblError.Text = "";
        }

        private void AddNewRecordSP(int classId, int trainerId, DateTime startTime, int maxCapacity)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString;

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                SqlCommand myCommand = new SqlCommand("InsertScheduledClass", myConnection);
                myCommand.CommandType = System.Data.CommandType.StoredProcedure;

                myCommand.Parameters.AddWithValue("@ClassId", classId);
                myCommand.Parameters.AddWithValue("@TrainerId", trainerId);
                myCommand.Parameters.AddWithValue("@StartTime", startTime);
                myCommand.Parameters.AddWithValue("@MaxCapacity", maxCapacity);

                myConnection.Open();
                myCommand.ExecuteNonQuery();
            }

            // Refresh GridView
            GridView2.DataBind();
        }
    }
}