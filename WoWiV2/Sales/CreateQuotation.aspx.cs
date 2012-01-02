﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;

public partial class Sales_CreateQuotation : System.Web.UI.Page, Imaster
{
    public int QuotationID;
    #region Imaster 成員

    public int getQuotationID()
    {
        if (hidQuotation_Version_Id.Text != "")
        {
            QuotationID = Int32.Parse(hidQuotation_Version_Id.Text);
            return this.QuotationID;
        }
        else
        {
            //QuotationID = ucTab1.Save();
            //hidQuotation_Version_Id.Text = QuotationID.ToString();
            return 0;
        }
    }

    public int saveQuotationID()
    {
        QuotationID = ucTab1.Save();
        hidQuotation_Version_Id.Text = QuotationID.ToString();
        return QuotationID;
    }

    #endregion

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucTab1.QuotationIDChanged += new providerEventHandler(ucTab1_QuotationIDChanged);
    }

    void ucTab1_QuotationIDChanged(object sender, int QuotationID)
    {
        this.QuotationID = QuotationID;
        hidQuotation_Version_Id.Text = QuotationID.ToString();
        TabContainer1.Tabs[1].Enabled = true;
        TabContainer1.Tabs[2].Enabled = true;
        TabContainer1.Tabs[3].Enabled = true;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string q = Request.QueryString["q"];
            if (q != null && Int32.TryParse(q, out QuotationID))
            {

                hidQuotation_Version_Id.Text = QuotationID.ToString();

                Quotation_Version quotation = Quotation_Controller.Get_Quotation(QuotationID);
                if (quotation != null)
                {
                    quoTitleDiv.Visible = true;

                    lblQuotation_No.Text = quotation.Quotation_No;
                    lblVersion.Text = "V" + quotation.Vername.ToString();
                    DropDownListStatus.SelectedValue = quotation.Quotation_Status.ToString();
                    txtQuotation_Statusdate.Text = ((DateTime)quotation.Quotation_Statusdate).ToString("yyyy/MM/dd HH:mm");
                    txtQuotation_Statusby.Text = quotation.Quotation_Statusby;
                }



                string t = Request.QueryString["t"];
                short tabIndex = 0;
                if (q != null && short.TryParse(t, out tabIndex))
                {
                    TabContainer1.ActiveTabIndex = tabIndex;
                }
            }
        }


        if (getQuotationID() == 0)
        {
            DropDownListStatus.Enabled = false;
            cmdStatus.Enabled = false;
        }
        else
        {
            DropDownListStatus.Enabled = true;
            cmdStatus.Enabled = true;

            Project project = CodeTableController.GetProject(getQuotationID());
            if ((project == null) && (DropDownListStatus.SelectedValue == "5"))
            {
                cmdCreateProject.Enabled = true;
                cmdCreateProject.Text = "Create Project";
            }
            else
            {
                if (project != null)
                    cmdCreateProject.Text = "Project has been created";
                else
                    cmdCreateProject.Text = "Create Project";
                cmdCreateProject.Enabled = false;
            }
        }

    }
    protected void cmdStatus_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        if (QuotationID != 0)
        {
            Quotation_Version quotation = Quotation_Controller.Get_Quotation(QuotationID);
            if (quotation != null)
            {
                quotation.Quotation_Status = Int32.Parse(DropDownListStatus.SelectedValue);
                quotation.Quotation_Statusdate = DateTime.Now;
                quotation.Quotation_Statusby = Page.User.Identity.Name;
                employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
                quotation.Quotation_StatusbyID = emp.id;

                txtQuotation_Statusdate.Text = ((DateTime)quotation.Quotation_Statusdate).ToString("yyyy/MM/dd HH:mm:ss");
                txtQuotation_Statusby.Text = quotation.Quotation_Statusby;

                Quotation_Controller.Update_Quotation(Quotation_Controller.ent, quotation);

                if ((DropDownListStatus.SelectedValue == "2") && (quotation.FinalTotalPrice != null))
                {
                    Quotation_Controller.Status_AwaitingApproval((Decimal)quotation.FinalTotalPrice, quotation.Currency, quotation);

                }

                if ((DropDownListStatus.SelectedValue == "3") && (quotation.FinalTotalPrice != null))
                {
                    bool result = Quotation_Controller.Status_Approved((Decimal)quotation.FinalTotalPrice, quotation.Currency, quotation, emp.id);

                    if (!result)
                    {
                        DropDownListStatus.SelectedValue = "2";
                    }

                }
            }

        }

    }
    protected void cmdAdditional_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        if (QuotationID != 0)
        {
            if (QuotationID > 0)
            {
                int new_id = Quotation_Controller.Copy_Quotation(QuotationID, false);
                Response.Redirect("CreateQuotation.aspx?q=" + new_id.ToString());
            }
        }
    }
    protected void cmdCopy_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        if (QuotationID != 0)
        {
            if (QuotationID > 0)
            {
                int new_id = Quotation_Controller.Copy_Quotation(QuotationID, true);
                Response.Redirect("CreateQuotation.aspx?q=" + new_id.ToString());
            }
        }
    }

    protected void cmdCreateProject_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        Quotation_Version quot = Quotation_Controller.Get_Quotation(QuotationID);
        CodeTableController.AddProject(quot);

        cmdCreateProject.Text = "Project has been created";
        cmdCreateProject.Enabled = false;
    }
}