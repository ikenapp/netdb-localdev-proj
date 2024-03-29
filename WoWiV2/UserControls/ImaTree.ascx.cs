﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class UserControls_ImaTree : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BuildCatalogTree();
        }
    }
   
    protected void BuildCatalogTree()
    {
        tvCatalog.Nodes.Clear();
        //建立節點
        //GetRegionNode(this.tvCatalog.Nodes);
        GetRegionNode();
    }

    //區域
    protected void GetRegionNode()
    {
        string strTsql = "select world_region_id,world_region_name from world_region ";
        strTsql += "where world_region_id in(select world_region_id from vw_ImaAccess where id=@EmpID) order by world_region_name";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@EmpID", IMAUtil.GetEmpIDbyLoginName());
        SqlDataReader sdr = SQLUtil.QueryDR(cmd);
        while (sdr.Read())
        {
            TreeNode tn = new TreeNode();
            tn.Text = sdr["world_region_name"].ToString();
            tn.Value = sdr["world_region_id"].ToString();
            tn.NavigateUrl = "~/Ima/ImaList.aspx?rid=" + tn.Value;
            tn.ImageUrl = "~/images/46.gif";
            //tn.SelectAction = TreeNodeSelectAction.SelectExpand;
            if ((Request.Params["rid"] != null))
            {
                CheckSelect(tn, tn.Value, "", "");
            }
            tvCatalog.SelectedNodeStyle.BackColor = System.Drawing.Color.FromArgb(160, 190, 220);
            tvCatalog.Nodes.Add(tn);
            GetContryNode(tn, Convert.ToInt32(tn.Value));
        }
        sdr.Close();
    }

    //國別
    protected void GetContryNode(TreeNode tnc, int intRegionID)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "select country_id,country_name from country where world_region_id=@RegionID order by country_name";
        cmd.Parameters.AddWithValue("@RegionID", intRegionID);
        SqlDataReader sdr = SQLUtil.QueryDR(cmd);
        while (sdr.Read())
        {
            TreeNode tn = new TreeNode();
            tn.Text = sdr["country_name"].ToString();
            tn.Value = sdr["country_id"].ToString();
            tn.NavigateUrl = "~/Ima/ImaList.aspx?rid=" + intRegionID.ToString() + "&cid=" + tn.Value;
            tn.ImageUrl = "~/images/46.gif";
            //tn.SelectAction = TreeNodeSelectAction.SelectExpand;
            if ((Request.Params["cid"] != null))
            {
                CheckSelect(tn, intRegionID.ToString(), tn.Value, "");
            }
            tvCatalog.SelectedNodeStyle.BackColor = System.Drawing.Color.FromArgb(160, 190, 220);
            tnc.ChildNodes.Add(tn);
            GetProductTypeNode(tn, intRegionID.ToString(), tn.Value);
        }
        sdr.Close();
    }

    //四大分類
    protected void GetProductTypeNode(TreeNode tnc, string strRegionID, string strContryID)
    {
        SqlCommand cmd = new SqlCommand("STP_IMAGetProductType");
        cmd.CommandType = CommandType.StoredProcedure;
        //cmd.CommandText = "select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish=1 and wowi_product_type_id<>10004";
        SqlDataReader sdr = SQLUtil.QueryDR(cmd);
        while (sdr.Read())
        {
            TreeNode tn = new TreeNode();
            tn.Text = sdr["wowi_product_type_name"].ToString();
            tn.Value = sdr["wowi_product_type_id"].ToString();
            tn.NavigateUrl = "~/Ima/ImaList.aspx?rid=" + strRegionID + "&cid=" + strContryID + "&pid=" + tn.Value;
            tn.ImageUrl = "~/images/46.gif";
            //tn.SelectAction = TreeNodeSelectAction.SelectExpand;
            if ((Request.Params["pid"] != null))
            {
                CheckSelect(tn, strRegionID, strContryID, tn.Value);
            }
            tvCatalog.SelectedNodeStyle.BackColor = System.Drawing.Color.FromArgb(160, 190, 220);
            tnc.ChildNodes.Add(tn);
        }
        sdr.Close();
    }

    protected void CheckSelect(TreeNode tn, string strRegionID, string strContryID, string strProductType)
    {
        if (strRegionID != "" && strContryID == "" && strProductType == "")
        {
            if (strRegionID == Request["rid"])
            {
                tn.Expanded = true;
                tn.Selected = true;
            }
        }
        else if (strRegionID != "" && strContryID != "" && strProductType == "")
        {
            if (strRegionID == Request["rid"] && strContryID == Request["cid"])
            {
                tn.Expanded = true;
                tn.Selected = true;
            }
        }
        else if (strRegionID != "" && strContryID != "" && strProductType != "")
        {
            if (strRegionID == Request["rid"] && strContryID == Request["cid"] && strProductType == Request["pid"])
            {
                tn.Expanded = true;
                tn.Selected = true;
            }
        }
    }
}