﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaLocalAgent : System.Web.UI.Page
{
    IMAUtil imau = new IMAUtil();
    int intCopyTimes = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindItem();
            LoadData();
            SetControlVisible();
        }
    }

    //載入選項
    protected void BindItem()
    {
        if (Request["laid"] == null || (Request["laid"] != null && Request["copy"] != null))
        {
            DateTime dt = DateTime.Now;
            lblContactIDTemp.Text = dt.Day.ToString() + dt.Minute.ToString() + dt.Second.ToString() + dt.Millisecond.ToString();
        }
    }

    //設定顯示的控制項
    protected void SetControlVisible()
    {
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Selected)
            {
                //lblProTypeName.Text += "," + li.Text;
                if (li.Text == "RF") { trTechRF.Style.Value = "display:'';"; }
                if (li.Text == "EMC") { trTechEMC.Style.Value = "display:'';"; }
                if (li.Text == "Safety") { trTechSafety.Style.Value = "display:'';"; }
                if (li.Text == "Telecom") { trTechTelecom.Style.Value = "display:'';"; }
            }
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Local Agent Edit";
        string strID = Request["laid"];
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        cbProductType.DataBind();
        gvContact.Columns[0].Visible = false;
        gvContact.Columns[1].Visible = false;
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        gvFile2.Columns[0].Visible = false;
        gvFile2.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_LocalAgent where LocalAgentID=@LocalAgentID";
            cmd.Parameters.AddWithValue("@LocalAgentID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbName.Text = dt.Rows[0]["Name"].ToString();
                if (dt.Rows[0]["Professional"].ToString().Trim().ToLower() == "true") { cbProfessional.Checked = true; }
                if (dt.Rows[0]["Individual"].ToString().Trim().ToLower() == "true") { cbIndividual.Checked = true; }
                if (dt.Rows[0]["OtherBusiness"].ToString().Trim().ToLower() == "true") { cbOtherBusiness.Checked = true; }
                if (dt.Rows[0]["Responsive"].ToString().Trim().ToLower() == "true") { cbResponsive.Checked = true; }
                if (dt.Rows[0]["Knowledgeable"].ToString().Trim().ToLower() == "true") { cbKnowledgeable.Checked = true; }
                if (dt.Rows[0]["Slow"].ToString().Trim().ToLower() == "true") { cbSlow.Checked = true; }
                if (dt.Rows[0]["NDAYes"].ToString().Trim().ToLower() == "true") { cbNDAYes.Checked = true; }
                if (dt.Rows[0]["NDAChoose"].ToString().Trim().ToLower() == "true") { cbNDAChoose.Checked = true; }
                if (dt.Rows[0]["MOUYes"].ToString().Trim().ToLower() == "true") { cbMOUYes.Checked = true; }
                if (dt.Rows[0]["MOUChoose"].ToString().Trim().ToLower() == "true") { cbMOUChoose.Checked = true; }
                //lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                tbRFRemark.Text = dt.Rows[0]["RFRemark"].ToString();
                tbEMCRemark.Text = dt.Rows[0]["EMCRemark"].ToString();
                tbSafetyRemark.Text = dt.Rows[0]["SafetyRemark"].ToString();
                tbTelecomRemark.Text = dt.Rows[0]["TelecomRemark"].ToString();
                foreach (ListItem li in cbProductType.Items)
                {
                    if (li.Text.Trim() == "RF")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["RF"]);
                    }
                    else if (li.Text.Trim() == "Telecom")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["Telecom"]);
                    }
                    else if (li.Text.Trim() == "EMC")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["EMC"]);
                    }
                    else if (li.Text.Trim() == "Safety")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["Safety"]);
                    }
                    if (li.Selected) { lblProTypeName.Text += "," + li.Text; }
                }

                if (Request.Params["copy"] != null)
                {
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Local Agent Copy";
                    gvContact.Columns[1].Visible = true;
                    gvFile1.Columns[1].Visible = true;
                    gvFile2.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    gvContact.Columns[0].Visible = true;
                    gvFile1.Columns[0].Visible = true;
                    gvFile2.Columns[0].Visible = true;
                }
            }
            //Ima_Contact
            DataTable dtContact = imau.GetContact(Convert.ToInt32(strID), Request["categroy"].ToString());
            gvContact.DataSource = dtContact;
            gvContact.DataBind();
        }
        else
        {
            gvContact.Columns[0].Visible = true;
            btnSave.Visible = true;
            foreach (string str in HttpUtility.UrlDecode(Request["pt"]).Split(','))
            {
                if (str != "")
                {
                    foreach (ListItem li in cbProductType.Items)
                    {
                        if (li.Value == str)
                        {
                            li.Selected = true;
                            break;
                        }
                    }
                }
            }
        }
    }

    //protected void CheckSelect(string strType, DataTable dtTechnology) 
    //{
    //    CheckBoxList cbl;
    //    if (strType == "RF") { cbl = cbTechRF; }
    //    else if (strType == "EMC") { cbl = cbTechEMC; }
    //    else if (strType == "Safety") { cbl = cbTechSafety; }
    //    else { cbl = cbTechTelecom; }
    //    int i = 0;
    //    foreach (DataRow dr in dtTechnology.Rows)
    //    {
    //        foreach (ListItem li in cbl.Items)
    //        {
    //            if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; i += 1; }
    //        }
    //    }
    //    if (i == cbl.Items.Count - 1) { cbl.Items[0].Selected = true; }
    //}

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strTsql = "insert into Ima_LocalAgent (world_region_id,country_id,Name,RF,Telecom,EMC,Safety,CreateUser,LasterUpdateUser,Professional,Individual,OtherBusiness,Responsive,Knowledgeable,Slow,NDAYes,NDAChoose,MOUYes,MOUChoose,RFRemark,EMCRemark,SafetyRemark,TelecomRemark) ";
        strTsql += "values(@world_region_id,@country_id,@Name,@RF,@Telecom,@EMC,@Safety,@CreateUser,@LasterUpdateUser,@Professional,@Individual,@OtherBusiness,@Responsive,@Knowledgeable,@Slow,@NDAYes,@NDAChoose,@MOUYes,@MOUChoose,@RFRemark,@EMCRemark,@SafetyRemark,@TelecomRemark)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF") 
            {
                cmd.Parameters.AddWithValue("@RF", li.Selected);
            }
            else if (li.Text.Trim() == "Telecom")
            {
                cmd.Parameters.AddWithValue("@Telecom", li.Selected);
            }
            else if (li.Text.Trim() == "EMC")
            {
                cmd.Parameters.AddWithValue("@EMC", li.Selected);
            }
            else if (li.Text.Trim() == "Safety")
            {
                cmd.Parameters.AddWithValue("@Safety", li.Selected);
            }
        }
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Professional", cbProfessional.Checked);
        cmd.Parameters.AddWithValue("@Individual", cbIndividual.Checked);
        cmd.Parameters.AddWithValue("@OtherBusiness", cbOtherBusiness.Checked);
        cmd.Parameters.AddWithValue("@Responsive", cbResponsive.Checked);
        cmd.Parameters.AddWithValue("@Knowledgeable", cbKnowledgeable.Checked);
        cmd.Parameters.AddWithValue("@Slow", cbSlow.Checked);
        cmd.Parameters.AddWithValue("@NDAYes", cbNDAYes.Checked);
        cmd.Parameters.AddWithValue("@NDAChoose", cbNDAChoose.Checked);
        cmd.Parameters.AddWithValue("@MOUYes", cbMOUYes.Checked);
        cmd.Parameters.AddWithValue("@MOUChoose", cbMOUChoose.Checked);
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        //SQLUtil.ExecuteSql(cmd);
        int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
        //文件上傳
        GeneralFileUpload(intGeneralID);
        //上傳已存在的文件
        if (Request["copy"] != null)
        {
            CopyDocData(gvFile1, intGeneralID);
            CopyDocData(gvFile2, intGeneralID);
        }
        //Ima_Contact
        CopyContact(gvContact, intGeneralID);
        intCopyTimes += 1;
        UpdateContact(intGeneralID);
        //新增Technology
        AddUpdTechnology(intGeneralID);
        BackURL();
    }

    //文件上傳
    protected void GeneralFileUpload(int intGeneralID)
    {
        foreach (ListItem li in cbProductType.Items) 
        {
            if (li.Selected) 
            {
                lblProType.Text = li.Value;
                string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\LocalAngent\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                imau.FileUpload(intGeneralID, fuGeneral1, "A", strUploadPath);
                imau.FileUpload(intGeneralID, fuGeneral2, "A", strUploadPath);
                imau.FileUpload(intGeneralID, fuGeneral3, "A", strUploadPath);
                imau.FileUpload(intGeneralID, fuGeneral4, "A", strUploadPath);
                imau.FileUpload(intGeneralID, fuGeneral5, "A", strUploadPath);
                imau.FileUpload(intGeneralID, FileUpload1, "B", strUploadPath);
                imau.FileUpload(intGeneralID, FileUpload2, "B", strUploadPath);
                imau.FileUpload(intGeneralID, FileUpload3, "B", strUploadPath);
                imau.FileUpload(intGeneralID, FileUpload4, "B", strUploadPath);
                imau.FileUpload(intGeneralID, FileUpload5, "B", strUploadPath);
                //將上傳的文件記錄在第1個ProductType上(其他有勾選的ProductType共同，若刪除則全部刪除)PS：只適用在Local Agent
                break;
            }
        }        
    }

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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\LocalAngent\" + IMAUtil.GetProductType(lblProType.Text.Trim());
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
        string strTsql = "insert into Ima_Files (DocID,DocCategory,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @DocID,@DocCategory,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Files where FileID=@FileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@DocID", intGAID);
        cmd.Parameters.AddWithValue("@DocCategory", Request["categroy"]);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@FileID", strGAFID);
        SQLUtil.ExecuteSql(cmd);
    }


    //protected void GeneralFileUpload(int intID, FileUpload fu, string strFileCatetory)
    //{
    //    string strFileURL = "";
    //    string strFileName = "";
    //    string strFileType = "";
    //    if (fu.HasFile)
    //    {
    //        //取得檔名(包含副檔名)
    //        strFileName = fu.FileName.Trim();
    //        //strFileURL = @"D:\IMA\General\" + strFileName;
    //        //上傳檔案路徑
    //        string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PostCertification\" + IMAUtil.GetProductType(lblProType.Text.Trim());
    //        //檢查上傳檔案路徑是否存在，若不存在就自動建立
    //        IMAUtil.CheckURL(strUploadPath);
    //        strFileURL = strUploadPath + @"\" + strFileName;
    //        //取得副檔名
    //        strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
    //        strFileName = strFileName.Replace("." + strFileType, "");

    //        string strTsql = "insert into Ima_Post_Files (PostID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
    //        strTsql += "values(@PostID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
    //        SqlCommand cmd = new SqlCommand();
    //        cmd.CommandText = strTsql;
    //        cmd.Parameters.AddWithValue("@PostID", intID);
    //        cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(), ""));
    //        cmd.Parameters.AddWithValue("@FileName", strFileName);
    //        cmd.Parameters.AddWithValue("@FileType", strFileType);
    //        cmd.Parameters.AddWithValue("@FileCategory", strFileCatetory);
    //        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
    //        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
    //        SQLUtil.ExecuteSql(cmd);
    //        fu.SaveAs(strFileURL);
    //    }
    //}

    protected void UpdateContact(int intDID)
    {
        SqlCommand cmd = new SqlCommand("update Ima_Contact set DID=@DID,IsTemp=0 where DID=@OldDID and Categroy=@Categroy and IsTemp=1 ");
        cmd.Parameters.AddWithValue("@DID", intDID);
        cmd.Parameters.AddWithValue("@OldDID", lblContactIDTemp.Text.Trim());
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        if (lblContactIDTemp.Text.Trim().Length > 0)
        {
            SQLUtil.ExecuteSql(cmd);
        }
    }

    //新增Contact
    protected void AddContact(int intGAID)
    {
        string strTsql = "insert into Ima_Contact (FirstName,LastName,Title,WorkPhone,Ext,CellPhone,Adress,CountryID,DID,Categroy,LeadTime,CreateUser,LasterUpdateUser,Fax,Remark,IsTemp)";
        strTsql += "values(@FirstName,@LastName,@Title,@WorkPhone,@Ext,@CellPhone,@Adress,@CountryID,@DID,@Categroy,@LeadTime,@CreateUser,@LasterUpdateUser,@Fax,@Remark,@IsTemp)";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text.Trim());
        cmd.Parameters.AddWithValue("@LastName", tbLastName.Text.Trim());
        cmd.Parameters.AddWithValue("@Title", tbTitle.Text.Trim());
        cmd.Parameters.AddWithValue("@WorkPhone", tbWorkPhone.Text.Trim());
        cmd.Parameters.AddWithValue("@Ext", tbExt.Text.Trim());
        cmd.Parameters.AddWithValue("@CellPhone", tbCellPhone.Text.Trim());
        cmd.Parameters.AddWithValue("@Adress", tbAdress.Text.Trim());
        cmd.Parameters.AddWithValue("@CountryID", ddlCountry.SelectedValue);
        cmd.Parameters.AddWithValue("@DID", intGAID);
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Fax", tbFax.Text.Trim());
        cmd.Parameters.AddWithValue("@Remark", tbRemark.Text.Trim());
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            cmd.Parameters.AddWithValue("@IsTemp", 0);
        }
        else
        {
            cmd.Parameters.AddWithValue("@IsTemp", 1);
        }
        SQLUtil.ExecuteSql(cmd);
    }

    //複製Contact
    protected void CopyContact(GridView gv, int intDID)
    {
        foreach (GridViewRow gvr in gvContact.Rows)
        {
            CheckBox chContactCopy = (CheckBox)gvr.FindControl("chContactCopy");
            bool blIsTemp = Convert.ToBoolean(gvContact.DataKeys[gvr.RowIndex].Values["IsTemp"]);
            //intCopyTimes
            if (intCopyTimes >= 1) { blIsTemp = false; }
            if (Request["copy"] == null) { chContactCopy.Checked = true; }
            if (chContactCopy.Checked && !blIsTemp)
            {
                string strTsql = "insert into Ima_Contact (FirstName,LastName,Title,WorkPhone,Ext,CellPhone,Adress,CountryID,DID,Categroy,LeadTime,CreateUser,LasterUpdateUser,Fax,Remark,IsTemp)";
                strTsql += "values(@FirstName,@LastName,@Title,@WorkPhone,@Ext,@CellPhone,@Adress,@CountryID,@DID,@Categroy,@LeadTime,@CreateUser,@LasterUpdateUser,@Fax,@Remark,@IsTemp)";
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = strTsql;
                cmd.Parameters.AddWithValue("@FirstName", ((Label)gvr.FindControl("lblFirstName")).Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", ((Label)gvr.FindControl("lblLastName")).Text.Trim());
                cmd.Parameters.AddWithValue("@Title", ((Label)gvr.FindControl("lblTitle")).Text.Trim());
                cmd.Parameters.AddWithValue("@WorkPhone", ((Label)gvr.FindControl("lblWorkPhone")).Text.Trim());
                cmd.Parameters.AddWithValue("@Ext", ((Label)gvr.FindControl("lblExt")).Text.Trim());
                cmd.Parameters.AddWithValue("@CellPhone", ((Label)gvr.FindControl("lblCellPhone")).Text.Trim());
                cmd.Parameters.AddWithValue("@Adress", ((Label)gvr.FindControl("lblAdress")).Text.Trim());
                cmd.Parameters.AddWithValue("@CountryID", ((Label)gvr.FindControl("lblCountryID")).Text.Trim());
                cmd.Parameters.AddWithValue("@DID", intDID);
                cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
                Label lblLeadTime = (Label)gvr.FindControl("lblLeadTime");
                if (lblLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", lblLeadTime.Text.Trim()); }
                else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
                cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
                cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
                cmd.Parameters.AddWithValue("@Fax", ((Label)gvr.FindControl("lblFax")).Text.Trim());
                cmd.Parameters.AddWithValue("@Remark", ((Label)gvr.FindControl("lblFax")).Text.Trim());
                cmd.Parameters.AddWithValue("@IsTemp", 0);
                SQLUtil.ExecuteSql(cmd);
            }
        }
    }

    //新增及修改Technology
    protected void AddUpdTechnology(int intID)
    {
        //刪除Technology
        imau.DelTechnology(intID, Request["categroy"]);
        DataList dl;
        foreach (ListItem li in cbProductType.Items) 
        {
            if (li.Selected) 
            {
                lblProType.Text = li.Value;
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
                        imau.AddTechnology(intID, Request["categroy"], intTechID, tbFee.Text.Trim());
                    }
                }
            }
        }
    }

    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_LocalAgent set Name=@Name,RF=@RF,Telecom=@Telecom,EMC=@EMC,Safety=@Safety,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),Professional=@Professional,Individual=@Individual,OtherBusiness=@OtherBusiness,Responsive=@Responsive,Knowledgeable=@Knowledgeable,Slow=@Slow,NDAYes=@NDAYes,NDAChoose=@NDAChoose,MOUYes=@MOUYes,MOUChoose=@MOUChoose,RFRemark=@RFRemark,EMCRemark=@EMCRemark,SafetyRemark=@SafetyRemark,TelecomRemark=@TelecomRemark ";
        strTsql += "where LocalAgentID=@LocalAgentID ";
        //if (lblContactID.Text.Trim().Length > 0)
        //{
        //    strTsql += "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,Fee=@Fee,FeeUnit=@FeeUnit,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ContactID=@ContactID ";
        //}
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@LocalAgentID", Request["laid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF")
            {
                cmd.Parameters.AddWithValue("@RF", li.Selected);
            }
            else if (li.Text.Trim() == "Telecom")
            {
                cmd.Parameters.AddWithValue("@Telecom", li.Selected);
            }
            else if (li.Text.Trim() == "EMC")
            {
                cmd.Parameters.AddWithValue("@EMC", li.Selected);
            }
            else if (li.Text.Trim() == "Safety")
            {
                cmd.Parameters.AddWithValue("@Safety", li.Selected);
            }
        }
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Professional", cbProfessional.Checked);
        cmd.Parameters.AddWithValue("@Individual", cbIndividual.Checked);
        cmd.Parameters.AddWithValue("@OtherBusiness", cbOtherBusiness.Checked);
        cmd.Parameters.AddWithValue("@Responsive", cbResponsive.Checked);
        cmd.Parameters.AddWithValue("@Knowledgeable", cbKnowledgeable.Checked);
        cmd.Parameters.AddWithValue("@Slow", cbSlow.Checked);
        cmd.Parameters.AddWithValue("@NDAYes", cbNDAYes.Checked);
        cmd.Parameters.AddWithValue("@NDAChoose", cbNDAChoose.Checked);
        cmd.Parameters.AddWithValue("@MOUYes", cbMOUYes.Checked);
        cmd.Parameters.AddWithValue("@MOUChoose", cbMOUChoose.Checked);
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        //if (lblContactID.Text.Trim().Length > 0)
        //{
        //    cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text.Trim());
        //    cmd.Parameters.AddWithValue("@LastName", tbLastName.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Title", tbTitle.Text.Trim());
        //    cmd.Parameters.AddWithValue("@WorkPhone", tbWorkPhone.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Ext", tbExt.Text.Trim());
        //    cmd.Parameters.AddWithValue("@CellPhone", tbCellPhone.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Adress", tbAdress.Text.Trim());
        //    cmd.Parameters.AddWithValue("@CountryID", ddlCountry.SelectedValue);
        //    cmd.Parameters.AddWithValue("@DID", Request["laid"]);
        //    cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        //    if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
        //    else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }
        //    cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
        //    if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        //    else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        //    cmd.Parameters.AddWithValue("@ContactID", lblContactID.Text.Trim());
        //}
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["laid"]));
        ////新增Contact
        //if (lblContactID.Text.Trim().Length == 0)
        //{
        //    AddContact(Convert.ToInt32(Request["laid"]));
        //}
        //修改Technology
        AddUpdTechnology(Convert.ToInt32(Request["laid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "laid", "copy" }));
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

    protected void btnCSave_Click(object sender, EventArgs e)
    {
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            AddContact(Convert.ToInt32(Request["laid"]));
        }
        else
        {
            AddContact(Convert.ToInt32(lblContactIDTemp.Text.Trim()));
        }
        tbFirstName.Text = "";
        tbLastName.Text = "";
        tbTitle.Text = "";
        tbWorkPhone.Text = "";
        tbExt.Text = "";
        tbCellPhone.Text = "";
        tbAdress.Text = "";
        ddlCountry.SelectedValue = Request["cid"];
        tbLeadTime.Text = "";
        tbFax.Text = "";
        tbRemark.Text = "";
        GetContact();
    }

    protected void btnEditSave_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow gvr = gvContact.Rows[Convert.ToInt32(btn.CommandArgument)];
        string strTsql = "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),Fax=@Fax,Remark=@Remark where ContactID=@ContactID ";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.Parameters.AddWithValue("@FirstName", ((TextBox)gvr.FindControl("tbFirstName")).Text.Trim());
        cmd.Parameters.AddWithValue("@LastName", ((TextBox)gvr.FindControl("tbLastName")).Text.Trim());
        cmd.Parameters.AddWithValue("@Title", ((TextBox)gvr.FindControl("tbTitle")).Text.Trim());
        cmd.Parameters.AddWithValue("@WorkPhone", ((TextBox)gvr.FindControl("tbWorkPhone")).Text.Trim());
        cmd.Parameters.AddWithValue("@Ext", ((TextBox)gvr.FindControl("tbExt")).Text.Trim());
        cmd.Parameters.AddWithValue("@CellPhone", ((TextBox)gvr.FindControl("tbCellPhone")).Text.Trim());
        cmd.Parameters.AddWithValue("@Adress", ((TextBox)gvr.FindControl("tbAdress")).Text.Trim());
        cmd.Parameters.AddWithValue("@CountryID", ((DropDownList)gvr.FindControl("ddlCountry")).SelectedValue);
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            cmd.Parameters.AddWithValue("@DID", Request["laid"]);
        }
        else
        {
            cmd.Parameters.AddWithValue("@DID", lblContactIDTemp.Text.Trim());
        }
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        TextBox tbLeadTime = (TextBox)gvr.FindControl("tbLeadTime");
        if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Fax", ((TextBox)gvr.FindControl("tbFax")).Text.Trim());
        cmd.Parameters.AddWithValue("@Remark", ((TextBox)gvr.FindControl("tbRemark")).Text.Trim());
        cmd.Parameters.AddWithValue("@ContactID", gvContact.DataKeys[gvr.RowIndex].Values[0]);
        SQLUtil.ExecuteSql(cmd);
        GetContact();
    }

    protected void gvContact_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "GoDel")
        {
            SqlCommand cmd = new SqlCommand("delete from Ima_Contact where ContactID=@ContactID");
            cmd.Parameters.AddWithValue("@ContactID", e.CommandArgument.ToString());
            SQLUtil.ExecuteSql(cmd);
            GetContact();
        }
    }

    protected void GetContact()
    {
        int intDID;
        if (Request["laid"] != null) { intDID = Convert.ToInt32(Request["laid"]); }
        else { intDID = Convert.ToInt32(lblContactIDTemp.Text.Trim()); }

        DataTable dtContact = imau.GetContact(intDID, Request["categroy"].ToString());
        if (Request["Copy"] != null)
        {
            intDID = Convert.ToInt32(lblContactIDTemp.Text.Trim());
            DataTable dtContactTemp = imau.GetContact(intDID, Request["categroy"].ToString());
            if (dtContactTemp.Rows.Count > 0) { dtContact.Merge(dtContactTemp); }
        }
        gvContact.DataSource = dtContact;
        gvContact.DataBind();
    }

    protected void gvContact_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlCountry = (DropDownList)e.Row.FindControl("ddlCountry");
            ddlCountry.DataBind();
            Label lblCountryID = (Label)e.Row.FindControl("lblCountryID");
            ddlCountry.SelectedValue = lblCountryID.Text.Trim();
        }
    }
}