﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_ImaStandard : System.Web.UI.Page
{
    IMAUtil imau = new IMAUtil();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //設定業務人員不可進入編輯Page
            imau.CheckIsSales();
            BindItem();
            LoadData();
            SetControlVisible();
        }
    }

    //載入選項
    protected void BindItem()
    {
    }

    //設定顯示的控制項
    protected void SetControlVisible()
    {
        Panel plTech;
        foreach (string strCT in lblProTypeName.Text.Trim().Split(','))
        {
            if (strCT.Length > 0)
            {
                if (strCT == "RF") { plTech = plTechRF; lblTech.Text = "RF"; }
                else if (strCT == "EMC") { plTech = plTechEMC; lblTech.Text = "EMC"; }
                else if (strCT == "Safety") { plTech = plTechSafety; lblTech.Text = "Safety"; }
                else { plTech = plTechTelecom; lblTech.Text = "Telecom"; }
                plTech.Visible = true;
            }
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Test Standards Edit";
        string strID = Request["sid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        lblFCCTitle.Text = "";
        lblRequiredTitle.Text = "";
        cbFCC.Visible = false;
        cbIEC.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Standard where StandardID=@StandardID";
            cmd.Parameters.AddWithValue("@StandardID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbOthers.Text = dt.Rows[0]["Others"].ToString();
                rblRequired.SelectedValue = dt.Rows[0]["Required"].ToString();
                tbStandardDesc.Text = dt.Rows[0]["StandardDesc"].ToString();
                tbLocalStandards.Text = dt.Rows[0]["LocalStandards"].ToString();
                cbFCC.Checked = Convert.ToBoolean(dt.Rows[0]["FCC"]);
                cbIEC.Checked = Convert.ToBoolean(dt.Rows[0]["FCC"]);
                cbCE.Checked = Convert.ToBoolean(dt.Rows[0]["CE"]);
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                rblProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                tbRFRemark.Text = dt.Rows[0]["RFRemark"].ToString();
                tbEMCRemark.Text = dt.Rows[0]["EMCRemark"].ToString();
                tbSafetyRemark.Text = dt.Rows[0]["SafetyRemark"].ToString();
                tbTelecomRemark.Text = dt.Rows[0]["TelecomRemark"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Test Standards Copy";
                    gvFile1.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                }
            }
        }
        else
        {
            btnSave.Visible = true;
            //lblProTypeName.Text = IMAUtil.GetProductType(Request.Params["pt"]);
            trProductType.Visible = true;
            foreach (string str in Request["pt"].Split(','))
            {
                if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
            }
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); }
        }

        if (lblProTypeName.Text.Trim() != "Safety")
        {
            lblFCCTitle.Text = "Harmonized with FCC or CE";
            cbFCC.Visible = true;
            lblRequiredTitle.Text = "Safety Required";
        }
        else
        {
            lblFCCTitle.Text = "Harmonized with IEC or CE";
            cbIEC.Visible = true;
            lblRequiredTitle.Text = "EMC Required";
        }

    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_Standard (world_region_id,country_id,wowi_product_type_id,FCC,CE,Others,Required,StandardDesc,CreateUser,LasterUpdateUser,LocalStandards,RFRemark,EMCRemark,SafetyRemark,TelecomRemark) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@FCC,@CE,@Others,@Required,@StandardDesc,@CreateUser,@LasterUpdateUser,@LocalStandards,@RFRemark,@EMCRemark,@SafetyRemark,@TelecomRemark)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@FCC", SqlDbType.Bit);
        cmd.Parameters.Add("@CE", SqlDbType.Bit);
        cmd.Parameters.Add("@Others", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Required", SqlDbType.NVarChar);
        cmd.Parameters.Add("@StandardDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LocalStandards", SqlDbType.NVarChar);
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        string strCopyTo = HttpUtility.UrlDecode(Request["pt"]);
        if (Request["copy"] != null)
        {
            strCopyTo = rblProductType.SelectedValue;
        }
        foreach (string str in strCopyTo.Split(','))
        {
            if (str != "")
            {
                lblProType.Text = str;
                cmd.Parameters["@world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                if (cbFCC.Visible)
                {
                    cmd.Parameters["@FCC"].Value = cbFCC.Checked;
                }
                else
                {
                    cmd.Parameters["@FCC"].Value = cbIEC.Checked;
                }

                cmd.Parameters["@CE"].Value = cbCE.Checked;
                cmd.Parameters["@Others"].Value = tbOthers.Text.Trim();
                cmd.Parameters["@Required"].Value = rblRequired.SelectedValue;
                cmd.Parameters["@StandardDesc"].Value = tbStandardDesc.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LocalStandards"].Value = tbLocalStandards.Text.Trim();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    CopyDocData(gvFile1, intGeneralID);
                }
                //新增Technology
                AddUpdTechnology(intGeneralID);
            }
        }
        BackURL();
    }

    //
    protected void CopyDocData(GridView gv, int intGeneralID)
    {
        foreach (GridViewRow gvr in gv.Rows)
        {
            CheckBox chSelCopy = (CheckBox)gvr.FindControl("chSelCopy");
            if (chSelCopy.Checked)
            {
                //複制檔案資料
                CopyDoc(intGeneralID, gv.DataKeys[gvr.RowIndex].Values[0].ToString());
                //複制檔案
                Label lblFileURL = (Label)gvr.FindControl("lblFileURL");
                string strFileURLO = IMAUtil.GetIMAUploadPath() + lblFileURL.Text.Trim();
                string strFileURLN = IMAUtil.GetIMAUploadPath() + lblFileURL.Text.Trim().Replace(@"\" + lblProTypeName.Text.Trim() + @"\", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
                if (strFileURLO != strFileURLN)
                {
                    //上傳檔案路徑
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\Standards\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                    //檢查上傳檔案路徑是否存在，若不存在就自動建立
                    IMAUtil.CheckURL(strUploadPath);
                    System.IO.File.Copy(strFileURLO, strFileURLN, true);
                }
            }
        }
    }

    //複制文件基本資料
    protected void CopyDoc(int intGAID, string strGAFID)
    {
        string strTsql = "insert into Ima_Standard_Files (StandardID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @StandardID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Standard_Files where StandardFileID=@StandardFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@StandardID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@StandardFileID", strGAFID);
        SQLUtil.ExecuteSql(cmd);
    }

    //文件上傳
    protected void GeneralFileUpload(int intGeneralID)
    {
        //Attach sample certificate附件
        GeneralFileUpload(intGeneralID, fuGeneral1, "A");
        GeneralFileUpload(intGeneralID, fuGeneral2, "A");
        GeneralFileUpload(intGeneralID, fuGeneral3, "A");
        GeneralFileUpload(intGeneralID, fuGeneral4, "A");
        GeneralFileUpload(intGeneralID, fuGeneral5, "A");
    }

    protected void GeneralFileUpload(int intID, FileUpload fu, string strFileCatetory)
    {
        string strFileURL = "";
        string strFileName = "";
        string strFileType = "";
        if (fu.HasFile)
        {
            //取得檔名(包含副檔名)
            strFileName = fu.FileName.Trim();
            //strFileURL = @"D:\IMA\General\" + strFileName;
            //上傳檔案路徑
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\Standards\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_Standard_Files (StandardID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@StandardID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@StandardID", intID);
            cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(), ""));
            cmd.Parameters.AddWithValue("@FileName", strFileName);
            cmd.Parameters.AddWithValue("@FileType", strFileType);
            cmd.Parameters.AddWithValue("@FileCategory", strFileCatetory);
            cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
            cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
            SQLUtil.ExecuteSql(cmd);
            fu.SaveAs(strFileURL);
        }
    }

    //新增及修改Technology
    protected void AddUpdTechnology(int intID)
    {
        //刪除Technology
        imau.DelTech(intID, Request["categroy"]);
        DataList dl;
        string strProType = IMAUtil.GetProductType(lblProType.Text.Trim());
        if (strProType == "RF") { dl = dlTechRF; }
        else if (strProType == "EMC") { dl = dlTechEMC; }
        else if (strProType == "Safety") { dl = dlTechSafety; }
        else { dl = dlTechTelecom; }

        foreach (DataListItem dli in dl.Items)
        {
            int intTechID = Convert.ToInt32(dl.DataKeys[dli.ItemIndex]);
            CheckBox cbFee = (CheckBox)dli.FindControl("cb" + strProType + "Fee");
            TextBox tbFee = (TextBox)dli.FindControl("tb" + strProType + "Fee");
            if (cbFee.Checked)
            {
                //新增Technology
                imau.AddTech(intID, Request["categroy"], intTechID, tbFee.Text.Trim());
            }
        }
    }

    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_Standard set FCC=@FCC,CE=@CE,Others=@Others,Required=@Required,StandardDesc=@StandardDesc,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),LocalStandards=@LocalStandards,RFRemark=@RFRemark,EMCRemark=@EMCRemark,SafetyRemark=@SafetyRemark,TelecomRemark=@TelecomRemark ";
        strTsql += "where StandardID=@StandardID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@StandardID", Request["sid"]);
        if (lblProTypeName.Text.Trim() != "Safety")
        {
            cmd.Parameters.AddWithValue("@FCC", cbFCC.Checked);
        }
        else
        {
            cmd.Parameters.AddWithValue("@FCC", cbIEC.Checked);
        }
        cmd.Parameters.AddWithValue("@CE", cbCE.Checked);
        cmd.Parameters.AddWithValue("@Others", tbOthers.Text.Trim());
        cmd.Parameters.AddWithValue("@Required", rblRequired.SelectedValue);
        cmd.Parameters.AddWithValue("@StandardDesc", tbStandardDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LocalStandards", tbLocalStandards.Text.Trim());
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["sid"]));
        //修改Technology
        AddUpdTechnology(Convert.ToInt32(Request["sid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "sid", "copy" }));
    }

    /// <summary>
    /// 下一頁的 Get 參數設定
    /// </summary>
    /// <param name="isClear">是否清除URL的參數</param>
    /// <param name="dicAdd">新增參數</param>
    /// <param name="strRemove">移除參數</param>
    /// <returns>組成QuseryString</returns>
    private string GetQueryString(bool isClear, Dictionary<string, string> dicAdd, string[] strRemove)
    {
        //預設參數
        Dictionary<string, string> dic = new Dictionary<string, string>();
        return IMAUtil.SetQueryString(isClear, dic, dicAdd, strRemove);
    }

    protected void rblProductType_SelectedIndexChanged(object sender, EventArgs e)
    {
        cbFCC.Visible = false;
        cbIEC.Visible = false;
        Panel plTech;
        plTechRF.Visible = false;
        plTechEMC.Visible = false;
        plTechSafety.Visible = false;
        plTechTelecom.Visible = false;
        if (rblProductType.SelectedItem.Text != "Safety")
        {
            lblFCCTitle.Text = "Harmonized with FCC or CE";
            cbFCC.Visible = true;
            lblRequiredTitle.Text = "Safety Required";
            if (rblProductType.SelectedItem.Text == "RF") { plTech = plTechRF; lblTech.Text = "RF"; }
            else if (rblProductType.SelectedItem.Text == "EMC") { plTech = plTechEMC; lblTech.Text = "EMC"; }
            else { plTech = plTechTelecom; lblTech.Text = "Telecom"; }
        }
        else
        {
            lblFCCTitle.Text = "Harmonized with IEC or CE";
            cbIEC.Visible = true;
            lblRequiredTitle.Text = "EMC Required";
            plTech = plTechSafety;
            lblTech.Text = "Safety";
        }
        plTech.Visible = true;
    }
}