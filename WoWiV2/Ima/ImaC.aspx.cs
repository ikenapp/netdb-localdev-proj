﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    //取得資料
    protected void LoadData()
    {
        string strID = Request["ngid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_NationalGoverned where NationalGovID=@NationalGovID";
            cmd.Parameters.AddWithValue("@NationalGovID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblDescription.Text = dt.Rows[0]["Description"].ToString();
                trProductType.Visible = true;
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(dt.Rows[0]["wowi_product_type_id"].ToString());
            }
            ////Technology
            //cmd = new SqlCommand();
            //cmd.CommandText = "select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            //cmd.Parameters.AddWithValue("@DID", strID);
            //cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            //DataSet ds = SQLUtil.QueryDS(cmd);
            //DataTable dtTechnology = ds.Tables[0];
            //if (dtTechnology.Rows.Count > 0)
            //{
            //    CheckBoxList cbl;
            //    if (lblProTypeName.Text.Trim() == "RF") { cbTechRF.DataBind(); cbl = cbTechRF; trTechRF.Visible = true; }
            //    else if (lblProTypeName.Text.Trim() == "EMC") { cbTechEMC.DataBind(); cbl = cbTechEMC; trTechEMC.Visible = true; }
            //    else if (lblProTypeName.Text.Trim() == "Safety") { cbTechSafety.DataBind(); cbl = cbTechSafety; trTechSafety.Visible = true; }
            //    else { cbTechTelecom.DataBind(); cbl = cbTechTelecom; trTechTelecom.Visible = true; }

            //    foreach (DataRow dr in dtTechnology.Rows)
            //    {
            //        foreach (ListItem li in cbl.Items)
            //        {
            //            if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
            //        }
            //    }
            //}
        }
    }
}