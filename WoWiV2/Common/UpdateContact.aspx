﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        ContactUtils.StoreRolesInViewState((FormView)sender, ContactUtils.Name_CheckBox_RoleList, ViewState, ContactUtils.Key_ViewState_Roles); 
    }

    protected override void LoadControlState(object savedState)
    {
        base.LoadControlState(savedState);

        InitRoles();
    }
        
    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.contact_info obj = (WoWiModel.contact_info)e.Entity;
            List<int> roles = (List<int>)ViewState[ContactUtils.Key_ViewState_Roles];
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                var data = db.m_contact_role;
                try
                {
                    var delList = from c in db.m_contact_role where c.contact_id == obj.id select c;
                    foreach (WoWiModel.m_contact_role item in delList)
                    {
                        data.DeleteObject(item);
                    }
                }
                catch (Exception ex)
                {
                }
                if (roles.Count != 0)
                {
                    foreach (int id in roles)
                    {
                        var d = new WoWiModel.m_contact_role()
                        {
                            contact_id = obj.id,
                            role_id = id
                        };
                        data.AddObject(d);
                    }
                }
                try
                {
                    db.SaveChanges();
                }
                catch
                {
                }
            }

            ViewState.Remove(ContactUtils.Key_ViewState_Roles);
            ViewState[ContactUtils.Key_ViewState_UpdateMessage] = ContactUtils.Value_ViewState_UpdateMessage;
           
        }
    }

    protected void Page_Completed(object sender, EventArgs e)
    {

        InitRoles();
        
    }


    private void InitRoles()
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            ContactUtils.InitRoles(id, FormView1, ContactUtils.Name_CheckBox_RoleList);
        }
        catch
        {
        }
    }

   

    protected void clRoleList_DataBound(object sender, EventArgs e)
    {
        InitRoles();
    }

    protected void lbMessage_Load(object sender, EventArgs e)
    {
        Utils.Message_Load((Label)sender, ViewState, ContactUtils.Key_ViewState_UpdateMessage);
    }

    protected void EntityDataSource1_Updating(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.contact_info obj = (WoWiModel.contact_info)e.Entity;
        obj.modify_date = DateTime.Now;
        obj.modify_user = User.Identity.Name;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 174px;
            height: 18px;
        }
        .style3
        {
            height: 18px;
        }
        .style4
        {
            height: 25px;
        }
        .style7
        {
            width: 15%;
        }
        .style8
        {
            height: 18px;
            width: 67px;
        }
        .style9
        {
            width: 15%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
   <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Edit" Width="900px" onitemupdating="FormView1_ItemUpdating"
            >
            <EditItemTemplate>
                <table align="left" border="0" cellpadding="2" cellspacing="0" 
                    style="width:95%">
                    <tr>
                        <th align="left">
                            <font size="+1">Contact Information&nbsp; </font>
                            <asp:HyperLink ID="HyperLink1" runat="server" 
                                NavigateUrl="~/Admin/ContactList.aspx">Contact List</asp:HyperLink>
                            &nbsp;<asp:Label ID="lbMessage" runat="server" ForeColor="Red" 
                                onload="lbMessage_Load"></asp:Label>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <th align="left" class="style9">
                                        <font color="red">*&nbsp;</font>First Name:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbFirstName" runat="server" Text='<%# Bind("fname") %>'></asp:TextBox>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 姓:</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbcLastName" runat="server" Text='<%# Bind("c_lname") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        <font color="red">*&nbsp;</font>Last Name:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbLastName" runat="server" Text='<%# Bind("lname") %>'></asp:TextBox>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 名:&nbsp;&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbcFirstName" runat="server" Text='<%# Bind("c_fname") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style2">
                                        <font color="red">*&nbsp;</font>Title:&nbsp;</th>
                                    <td class="style3" width="35%">
                                        <asp:TextBox ID="tbTitle" runat="server" Text='<%# Bind("title") %>'></asp:TextBox>
                                    </td>
                                    <th align="left" class="style8">
                                        &nbsp; 職稱:</th>
                                    <td class="style3" width="35%">
                                        <asp:TextBox ID="tbcTitle" runat="server" Text='<%# Bind("c_title") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        <font color="red">*&nbsp;</font>Company:&nbsp;&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="Company" runat="server" Text='<%# Bind("companyname") %>'></asp:TextBox>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 公司:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        <font color="red">*&nbsp;</font>Work Phone:</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbWorkphone" runat="server" Text='<%# Bind("workphone") %>'></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Ext</strong>:&nbsp;&nbsp;<asp:TextBox ID="tbExt" runat="server" 
                                            Text='<%# Bind("ext") %>' Width="44px"></asp:TextBox>
                                        &nbsp;</td>
                                    <th align="left" class="style7">
                                        <font color="red">*&nbsp;</font>Email:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp; Cell Phone:</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbCellPhone" runat="server" Text='<%# Bind("cellphone") %>'></asp:TextBox>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; Fax:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbFax" runat="server" Text='<%# Bind("fax") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        <font color="red">*&nbsp;</font>Address:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbAddress" runat="server" Text='<%# Bind("address") %>' 
                                            Width="211px"></asp:TextBox>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 地址:&nbsp;</th>
                                    <td width="35%">
                                        <asp:TextBox ID="tbcAddresss" runat="server" Text='<%# Bind("c_address") %>' 
                                            Width="211px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                            <th align="left" class="style9">
                                &nbsp; Country:&nbsp;</th>
                             <td colspan="3">
                              <asp:DropDownList ID="dlCountry" runat="server" 
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country]">
                              </asp:SqlDataSource>
                          </td>
                        </tr>
                                <tr>
                                <td colspan = "4" align="left">
                           
                          
                                     <b>&nbsp; Role: </b>
                            <br />
                                        <asp:CheckBoxList ID="clRoleList" runat="server" 
                                            DataSourceID="EntityDataSource2" DataTextField="contact_name" DataValueField="contact_id" 
                                            RepeatColumns="5" RepeatDirection="Horizontal" 
                                            ondatabound="clRoleList_DataBound">
                                        </asp:CheckBoxList>
                                        <asp:EntityDataSource ID="EntityDataSource2" runat="server" 
                                            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
                                            EnableFlattening="False" EntitySetName="contact_role" 
                                            Select="it.[contact_id], it.[contact_name]">
                                        </asp:EntityDataSource>
                                    
                        </td>
                        </tr>
                            </table>
                        </td>
                   
                        
                    </tr>
                 
                     <tr>
            <td>
                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                    <tr align="center">
                        <th width="25%">
                            Create Date</th>
                        <th width="25%">
                            Create User</th>
                        <th width="25%">
                            Last Modified Date</th>
                        <th width="25%">
                            Modify User</th>
                    </tr>
                    <tr align="center">
                        <td>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("create_date") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("create_user") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("modify_date") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("modify_user") %>'></asp:Label>
                        </td>
                    </tr>
                       
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="style4">
                            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="Update" />
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />
                                        &nbsp;</td>
                                </tr>
                </table>
            </td>
        </tr>
                </table>
                <br />
                &nbsp;
            </EditItemTemplate>
            <InsertItemTemplate>
                <br />
&nbsp;
            </InsertItemTemplate>
        </asp:FormView>
  
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" 
        DefaultContainerName="WoWiEntities" EnableFlattening="False" 
            EnableUpdate="True" EntitySetName="contact_info" 
            EntityTypeFilter="contact_info" 
        onupdated="EntityDataSource1_Updated" Where="it.id == @id" 
                    onupdating="EntityDataSource1_Updating" >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>
          </ContentTemplate>
        </asp:UpdatePanel>
    </p>
   
</asp:Content>
