using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProiectBDInternet
{
    public partial class Members : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ADD")
            {
                string name = ((TextBox)GridView1.FooterRow.FindControl("tbName")).Text.Trim();
                string phone = ((TextBox)GridView1.FooterRow.FindControl("tbPhone")).Text.Trim();
                string email = ((TextBox)GridView1.FooterRow.FindControl("tbEmail")).Text.Trim();

                TextBox tbName = (TextBox)GridView1.FooterRow.FindControl("tbName");
                TextBox tbPhone = (TextBox)GridView1.FooterRow.FindControl("tbPhone");
                TextBox tbEmail = (TextBox)GridView1.FooterRow.FindControl("tbEmail");

                bool valid = true;

                // Validare Name
                if (string.IsNullOrEmpty(name) ||
                    !Regex.IsMatch(name, @"^[a-zA-Z\s]+$") ||  
                    !name.Contains(" "))                      
                {
                    tbName.ForeColor = Color.Red;
                    valid = false;
                }

                // Validare Phone (digits only, length 10)
                if (string.IsNullOrEmpty(phone) || !Regex.IsMatch(phone, @"^\+?\d{10,15}$"))
                {
                    tbPhone.ForeColor = Color.Red;
                    valid = false;
                }

                // Validare Email
                try
                {
                    var addr = new System.Net.Mail.MailAddress(email);
                }
                catch
                {
                    tbEmail.ForeColor = Color.Red;
                    valid = false;
                }

                if (valid)
                {
                    AddNewRecordSP(name, phone, email);
                    // Optionally, clear footer fields
                    tbName.Text = tbPhone.Text = tbEmail.Text = "";
                }

            }
        }

        private void AddNewRecordSP(string name, string phone, string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PILATES_STUDIOConnectionString"].ConnectionString;

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                SqlCommand myCommand = new SqlCommand("InsertMember", myConnection); 
                myCommand.CommandType = System.Data.CommandType.StoredProcedure;

                myCommand.Parameters.AddWithValue("@Name", name);
                myCommand.Parameters.AddWithValue("@Phone", phone);
                myCommand.Parameters.AddWithValue("@Email", email);
                // No need for @JoinDate if the column has GETDATE() default

                myConnection.Open();
                myCommand.ExecuteNonQuery();
            }

            // Refresh GridView
            GridView1.DataBind();
        }
    }
}