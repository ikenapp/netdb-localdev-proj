﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void EntityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.PR obj = (WoWiModel.PR)e.Entity;
            int id = obj.pr_id;
            int empid = int.Parse(Session["Session_User_Id"].ToString());
            WoWiModel.PR_authority_history auth = new WoWiModel.PR_authority_history();
            auth.pr_id = obj.pr_id;
            auth.requisitioner_id = empid;
            FillAuthForm(auth);
            auth.create_date = DateTime.Now;
            auth.create_user = User.Identity.Name;
            auth.status = (byte)PRStatus.Init;
            wowidb.PR_authority_history.AddObject(auth);
            wowidb.SaveChanges();
            WoWiModel.PR pr = wowidb.PRs.Where(n => n.pr_id == obj.pr_id).First();
            pr.pr_auth_id = auth.pr_auth_id;
            wowidb.SaveChanges();
            Response.Redirect("~/Accounting/CreatePR_SetItems.aspx?id=" +id );
        }
    }
    protected void FillAuthForm(WoWiModel.PR_authority_history auth )
    {
        int empid = (int)auth.requisitioner_id;
        auth.requisitioner = GetNameById(empid);
        try
        {
            WoWiModel.employee vp = (from e in wowidb.employees from jt in wowidb.employee_jobtitle where jt.jobtitle_name.Trim().Equals("Vice President") & e.jobtitle_id == jt.jobtitle_id select e).First();

            WoWiModel.employee p = (from e in wowidb.employees from jt in wowidb.employee_jobtitle where jt.jobtitle_name.Trim().Equals("President") & e.jobtitle_id == jt.jobtitle_id select e).First();

            WoWiModel.employee emp = (from e in wowidb.employees where e.id == empid select e).First();
            if (emp.supervisor_id != -1)
            {
                auth.supervisor_id = emp.supervisor_id;
                auth.supervisor = GetNameById((int)emp.supervisor_id);
            }
            else
            {
                auth.supervisor_id = empid;
                auth.supervisor = GetNameById(empid);
            }
            if (empid != vp.id || empid != p.id)
            {
                auth.vp_id = vp.id;
                auth.vp = GetNameById(vp.id);
                auth.president_id = p.id;
                auth.president = GetNameById(p.id);
            }
            WoWiModel.employee finance = (from e in wowidb.employees from jt in wowidb.employee_jobtitle where jt.jobtitle_name.Trim().Equals("Finance") & e.jobtitle_id == jt.jobtitle_id select e).First();
            auth.finance_id = finance.id;
            auth.finance = GetNameById(finance.id);
        }
        catch (Exception ex )
        {
            
            
        }
        
    }

    protected String GetNameById(int id)
    {
        String name = "";
        WoWiModel.employee emp = (from e in wowidb.employees where e.id == id select e).First();
        name = String.IsNullOrEmpty(emp.fname)?emp.c_lname +" "+emp.c_fname:emp.fname +" "+emp.lname;
        return name;

    }
    protected void lbMessage_Load(object sender, EventArgs e)
    {
        Utils.Message_Load((Label)sender, ViewState, VenderUtils.Key_ViewState_InsertMessage);
    }

    protected void EntityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.PR obj = (WoWiModel.PR)e.Entity;
        DropDownList ddlProjectNo = (FormView1.FindControl("ddlProjectNo") as DropDownList);
        obj.quotaion_id = int.Parse(ddlProjectNo.SelectedValue);
        int proj_id = (from p in db.Project where p.Project_No == ddlProjectNo.SelectedItem.Text select p).First().Project_Id;
        obj.project_id = proj_id;
        obj.currency = "USD";
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
    }

    protected void ddlProjectNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlQuotationNo.Items.Count >=2){
            ddlQuotationNo.Items.RemoveAt(1);
        }
        int id= int.Parse(ddlProjectNo.SelectedValue);
        var target =( from d in db.Quotation_Version where d.Quotation_Version_Id == id select d.Quotation_No ).First();
        ddlQuotationNo.Items.Add(target);
        ddlQuotationNo.SelectedValue = (target);
      
    }
    protected void ddlProjectNo_Load(object sender, EventArgs e)
    {
       
        ddlProjectNo.DataSource = db.Project;
        ddlProjectNo.DataTextField = "Project_No";
        ddlProjectNo.DataValueField = "Quotation_Id";
    }

    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        
        .style10
        {
            width: 20%;
            height: 24px;
        }
        .style11
        {
            height: 24px;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id"  
           SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Insert" Width="900px" >
           
            <InsertItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
               <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
             <tr><th 
                           align="left" class="style10"><font size="+1">&nbsp;Purchase Request 
                  Creation&nbsp; </font>
               </th></tr>
                            
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4">
                          </td></tr>
                          
                          
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                PR&nbsp; Information</th>
                        </tr>
                        <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Project 
                            No.:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                <asp:DropDownList ID="ddlProjectNo" runat="server" 
                                    onselectedindexchanged="ddlProjectNo_SelectedIndexChanged" 
                                    AppendDataBoundItems="True" onload="ddlProjectNo_Load" AutoPostBack="True">
                                    <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="ddlProjectNo" ErrorMessage="Please select a project." InitialValue="-1"
                                    ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td><th align="left" 
                                   class="style11">&nbsp; Qutation No.:&nbsp;</th><td class="style12" width="30%">
                                <asp:DropDownList ID="ddlQuotationNo" runat="server" 
                                    AppendDataBoundItems="True" Enabled="False">
                                    <asp:ListItem>--------------------</asp:ListItem>
                                </asp:DropDownList>
                            </td></tr>
                                <tr align="center"><td class="style4" colspan="4">
                      <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr align="center">
                              <td>
                                  <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                      CommandName="Insert" Text="Create" />
                                  &nbsp;&nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                      CommandName="Cancel" Text="Cancel" />
                                  &nbsp;</td>
                          </tr>
                      </table>
                      </td></tr>
                             </table>
                </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="InsertButton" />
                  </Triggers>
                </asp:UpdatePanel>
            </InsertItemTemplate>
        </asp:FormView>
   
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableInsert="True" EntitySetName="PRs" 
        oninserted="EntityDataSource1_Inserted" 
        oninserting="EntityDataSource1_Inserting">
        </asp:EntityDataSource >
  
                           
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
            ShowMessageBox="True" ShowSummary="False" />
  
                           
</asp:Content>
