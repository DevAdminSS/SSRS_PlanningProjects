using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace PlanningProjects
{
    public partial class Projects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
 
            if (!Page.IsPostBack)
            {
               // LoadData();
                ClearRecs();
                lblSuccess.Visible = false;
                btnInsert.Enabled = true;
                btnUpdate.Enabled = false;
                ddPlanners.Items.Add("-- Select a Planner --");
                ddPlanners.Items.Add("Bob Keenan");
                ddPlanners.Items.Add("Barb Wheeler");
                ddPlanners.Items.Add("Jake Rosenberg");
                ddPlanners.Items.Add("Karen Lewer");
                ddPlanners.Items.Add("Kelly Zappia");
                ddPlanners.Items.Add("Rebecca Bessey");
                ddPlanners.Items.Add("Stuart King");
                ddPlanners.Items.Add("Toby Stauffer");

                ListItem item = new ListItem("No","0");
                ddWithdrawn.Items.Add(item);
                item = new ListItem("Yes", "1");
                ddWithdrawn.Items.Add(item);

                string prjID = Request.QueryString["ProjID"];
                if (prjID != null)
                {
                    ProjectByIDTableAdapters.GetProjectByIDTableAdapter prjAdpt = new ProjectByIDTableAdapters.GetProjectByIDTableAdapter();
                    ProjectByID.GetProjectByIDDataTable prjTbl = prjAdpt.GetData(prjID);
                    if (prjTbl.Count > 0)
                    {
                        btnUpdate.Enabled = true;
                        btnInsert.Enabled = false;
                        FillInitialData(prjTbl.Rows[0]);
                    }
                }
            }
        }

        private void FillInitialData(DataRow rw)
        {
            txtPrjName.Text = rw[0].ToString();
            txtPrjID.Text = rw[1].ToString();
            txtPrjNotes.Text = rw[2].ToString();
            txtPrjDesc.Text = rw[3].ToString();
            txtApplicant.Text = rw[4].ToString();
            ddPlanners.SelectedValue = rw[5].ToString();
            txtSubmitted.Text = rw[6].ToString();
            txtCompleted.Text = rw[7].ToString();
            txtPC.Text = rw[8].ToString();
            txtCC.Text = rw[9].ToString();
            txtBOA.Text = rw[10].ToString();
            txtCompletedNotes.Text = rw[11].ToString();
            ddWithdrawn.SelectedValue = rw[12].ToString();
            txtTerminated.Text = rw[13].ToString();
            txtExpired.Text = rw[14].ToString();
            txtPUD.Text = rw[15].ToString();
            
        }

        protected void InsertRec(object sender, EventArgs e)
        {
            
            string PrjID =  txtPrjID.Text.ToString();
            if (PrjID != "")
            {
                string PrjName = txtPrjName.Text.ToString();
                string PrjNotes = txtPrjNotes.Text.ToString();
                string PrjDesc = txtPrjDesc.Text.ToString();
                string Applicant = txtApplicant.Text.ToString();
                string Planner = ddPlanners.SelectedValue.ToString();
                if (Planner == "-- Select a Planner--" || Planner == "")
                    Planner = null;
                DateTime? Submitted = null;
                DateTime? Completed = null;
                DateTime? PC = null;
                DateTime? CC = null;
                DateTime? BOA = null;
                int? Yr = null;
                if (txtSubmitted.Text != "")
                {
                    Submitted = DateTime.Parse(txtSubmitted.Text.ToString());
                    Yr = DateTime.Parse(txtSubmitted.Text.ToString()).Year;
                }
                if (txtCompleted.Text != "")
                    Completed = DateTime.Parse(txtCompleted.Text.ToString());
                if (txtPC.Text != "")
                    PC = DateTime.Parse(txtPC.Text.ToString());
                if (txtCC.Text != "")
                    CC = DateTime.Parse(txtCC.Text.ToString());
                if (txtBOA.Text != "")
                    BOA = DateTime.Parse(txtBOA.Text.ToString());
                string CompNotes = txtCompletedNotes.Text.ToString();
                float Withdrawn = 0;
                if (ddWithdrawn.SelectedValue.ToLower() == "yes")
                    Withdrawn = 1;
                string Terminated = txtTerminated.Text.ToString();
                string Expired = txtExpired.Text.ToString();
                string PUD = txtPUD.Text.ToString();
                int? Year = Yr;

                PlProjectDataTableAdapters.GetCurrentPrjsTableAdapter adpt = new PlProjectDataTableAdapters.GetCurrentPrjsTableAdapter();

                int cnt = adpt.Insert(PrjID, PrjName, PrjNotes, PrjDesc, Applicant, Planner, Submitted, Completed, PC, CC, BOA, CompNotes, Withdrawn, Terminated, Expired, PUD, Year);
                if (cnt == 1)
                {
                    lblSuccess.Text = "Record Inserted Successfully!";
                    lblSuccess.Visible = true;
                    ClearRecs();
                }
            }
            else
            {
                lblSuccess.Text = "Please Provide a Project ID";
                lblSuccess.Visible = true;
            }
        }
        private void ClearRecs()
        {
            txtPrjID.Text = "";
            txtPrjName.Text = "";
            txtPrjNotes.Text = "";
            txtPrjDesc.Text = "";
            txtApplicant.Text = "";
            ddPlanners.SelectedIndex = 0;
            txtSubmitted.Text = "";
            txtCompleted.Text = "";
            txtPC.Text = "";
            txtCC.Text = "";
            txtBOA.Text = "";
            txtCompletedNotes.Text = "";
            ddWithdrawn.SelectedValue = "0";
            txtTerminated.Text = "";
            txtExpired.Text = "";
            txtPUD.Text = "";
        }


        protected void UpdateRec(object sender, EventArgs e)
        {
            string PrjID = txtPrjID.Text.ToString();
            if (PrjID == "")
                PrjID = null;
            string PrjName = txtPrjName.Text.ToString();
            if (PrjName == "")
                PrjName = null;
            string PrjNotes = txtPrjNotes.Text.ToString();
            if (PrjNotes == "")
                PrjNotes = null;
            string PrjDesc = txtPrjDesc.Text.ToString();
            if (PrjDesc == "")
                PrjDesc = null;
            string Applicant = txtApplicant.Text.ToString();
            if (Applicant == "")
                Applicant = null;
            string Planner = ddPlanners.SelectedValue.ToString();
            if (Planner == "-- Select a Planner--" || Planner == "")
                Planner = null;
            string CompNotes = txtCompletedNotes.Text.ToString();
            DateTime? Submitted = null;
            DateTime? Completed = null;
            DateTime? PC = null;
            DateTime? CC = null;
            DateTime? BOA = null;
            int? Yr = null;
            if (txtSubmitted.Text != "")
            {
                Submitted = DateTime.Parse(txtSubmitted.Text.ToString());
                Yr = DateTime.Parse(txtSubmitted.Text.ToString()).Year;
            }
            if (txtCompleted.Text != "")
                Completed = DateTime.Parse(txtCompleted.Text.ToString());
            if (txtPC.Text != "")
                PC = DateTime.Parse(txtPC.Text.ToString());
            if (txtCC.Text != "")
                CC = DateTime.Parse(txtCC.Text.ToString());
            if (txtBOA.Text != "")
                BOA = DateTime.Parse(txtBOA.Text.ToString());
            float Withdrawn = 0;
            if (ddWithdrawn.SelectedValue == "1")
            {
                Withdrawn = 1;
            }
            else
            {
                Withdrawn = 0;
            }
            DateTime? Terminated = null;
            if (txtTerminated.Text.ToString() != "")
                Terminated = DateTime.Parse(txtTerminated.Text.ToString());

            string Expired = txtExpired.Text.ToString();
            if (Expired == "")
                Expired = null;
            string PUD = txtPUD.Text.ToString();
            if (PUD == "")
                PUD = null;


            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PlanningPrjConnectionString"].ConnectionString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "UpdateProject";
            cmd.CommandType = CommandType.StoredProcedure;
           
            cmd.Connection = conn;
            cmd.Parameters.Add("@ProjectName", SqlDbType.NVarChar, 255).Value = PrjName;
            cmd.Parameters.Add("@ProjectID", SqlDbType.NVarChar, 30).Value = PrjID;
            cmd.Parameters.Add("@ProjectDesc", SqlDbType.NVarChar, 500).Value = PrjDesc;
            cmd.Parameters.Add("@ProjectNotes", SqlDbType.NVarChar, 500).Value = PrjNotes;
            cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar, 255).Value = Applicant;
            cmd.Parameters.Add("@Planner", SqlDbType.NVarChar, 255).Value = Planner;
            cmd.Parameters.Add("@Submitted", SqlDbType.DateTime).Value = Submitted;
            cmd.Parameters.Add("@Completed", SqlDbType.DateTime).Value = Completed;
            cmd.Parameters.Add("@PC", SqlDbType.DateTime).Value = PC;
            cmd.Parameters.Add("@CC", SqlDbType.DateTime).Value = CC;
            cmd.Parameters.Add("@BOA", SqlDbType.DateTime).Value = BOA;
            cmd.Parameters.Add("@CompletedNotes", SqlDbType.NVarChar, 255).Value = CompNotes;
            cmd.Parameters.Add("@Withdrawn", SqlDbType.Float).Value = Withdrawn;
            cmd.Parameters.Add("@Terminated", SqlDbType.NVarChar,100).Value = Terminated;
            cmd.Parameters.Add("@Exp", SqlDbType.NVarChar,100).Value = Expired;
            cmd.Parameters.Add("@PUD", SqlDbType.NVarChar,100).Value = PUD;
            cmd.Parameters.Add("@Year", SqlDbType.Int).Value = Yr;

            int rowsAffected = 0;
            try
            {
                conn.Open();
                rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    lblSuccess.Text = "Record Sucessfully Updated!";
                    lblSuccess.Visible = true;
                    ClearRecs();
                    btnUpdate.Enabled = false;
                    btnInsert.Enabled = true;
                }
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                string st = sqlex.Message;
            }

        }

        protected void Clear(object sender, EventArgs e)
        {
            ClearRecs();
            lblSuccess.Visible = false;
        }
    }   
}
