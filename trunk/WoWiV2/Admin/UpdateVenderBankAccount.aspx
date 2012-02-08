﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    
    protected void EntityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            int bankid = (e.Entity as WoWiModel.venderbanking).bank_id;
            Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + isWestUnitStr);
        }
    }


    protected void EntityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.venderbanking obj = (WoWiModel.venderbanking)e.Entity;
        obj.isWestUnit = isWestUnit;
        obj.vender_id = id;
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
    }

    protected void lbMessage_Load(object sender, EventArgs e)
    {
        //Utils.Message_Load((Label)sender, ViewState, VenderUtils.Key_ViewState_InsertMessage);
    }
        
    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + "&bid=" + bid + isWestUnitStr);
        }
    }

    int id;
    int bid;
    bool isWestUnit;
    String isWestUnitStr;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            id = int.Parse(Request.QueryString["id"]);
            if (String.IsNullOrEmpty(Request.QueryString["bid"]))
            {
                FormView1.Visible = false;
            }
            else
            {
                FormView1.Visible = true;
            }
          
        }
        catch
        {
        }


        try
        {

            String mode = Request.QueryString["mode"];
            String isWUStr = Request.QueryString["iswu"];
            if (!String.IsNullOrEmpty(isWUStr) && isWUStr == "1")
            {
                isWestUnit = true;
                isWestUnitStr = "&iswu=1";
            }
            if (!String.IsNullOrEmpty(mode) && mode == "create")
            {

                try
                {

                    if (isWestUnit)
                    {
                        FormView2.Visible = false;
                        FormView3.Visible = true;
                        GridView1.Visible = false;
                        GridView2.Visible = true;
                    }
                    else
                    {
                        isWestUnitStr = "";
                        FormView2.Visible = true;
                        FormView3.Visible = false;
                        GridView1.Visible = true;
                        GridView2.Visible = false;
                    }
                }
                catch
                {
                }
            }
            else
            {
                FormView2.Visible = false;
                FormView3.Visible = false;
            }
            //GridView1.Visible = true;
            if (mode == "select")
            {
                FormView1.Visible = true;
                FormView4.Visible = false;
            }
            else if (mode == "selectwu")
            {
                FormView4.Visible = true;
                FormView1.Visible = false;
            }
            else
            {
                FormView1.Visible = false;
                FormView4.Visible = false;
            }
        }
        catch
        {
        }
       
    }


    protected void EntityDataSource1_Updating(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.venderbanking obj = (WoWiModel.venderbanking)e.Entity;
        bid = obj.bank_id;
        obj.modify_date = DateTime.Now;
        obj.modify_user = User.Identity.Name;
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/SelectExistContact.aspx?id=" + id + "&type=vender&mode=update");
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (isWestUnit)
        {
            if (!FormView3.Visible)
            {
                FormView3.Visible = true;
                Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + "&mode=create" + isWestUnitStr);
            }
        }
        else
        {
            if (!FormView2.Visible)
            {
                FormView2.Visible = true;
                Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + "&mode=create" + isWestUnitStr);
            }
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + isWestUnitStr);

    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MySelect")
        {
            GridViewRow row = GridView1.Rows[int.Parse(e.CommandArgument.ToString())];
            int bankid = int.Parse(row.Cells[8].Text);
            //FormView1.Visible = true;
            Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + "&mode=select" + "&bid=" + bankid + isWestUnitStr);
        }

    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MySelect")
        {
            GridViewRow row = GridView2.Rows[int.Parse(e.CommandArgument.ToString())];
            int bankid = int.Parse(row.Cells[4].Text);
            //FormView4.Visible = true;
            Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + id + "&mode=selectwu" + "&bid=" + bankid + isWestUnitStr);
        }

    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.SetRenderMethodDelegate(RenderHeader);
    }

    private void RenderHeader(HtmlTextWriter output, Control container)
    {
        for (int i = 0; i < container.Controls.Count - 1; i++)
        {
            TableCell cell = (TableCell)container.Controls[i];
            cell.RenderControl(output);
        }
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
        .style9
        {
            width: 15%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<font size="+1">Vender Bank Account Information Modification&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;
                           <asp:Button ID="Button1" runat="server" Text="Create Bank Info" onclick="Button1_Click" /> <asp:Button ID="LinkButton3" runat="server" Text="Contact Modification" onclick="LinkButton1_Click" /> 
  <asp:FormView ID="FormView2" runat="server" DataKeyNames="id" SkinID="FormView" Visible="false"
            DataSourceID="EntityDataSource3" DefaultMode="Insert" Width="100%" >
           
            <InsertItemTemplate>
               
                
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
              <tr><td><table  align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Bank Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBankName" runat="server" Text='<%# Bind("bank_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="tbBankName" ErrorMessage="Have to provide Bank Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Branch Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBranchName" runat="server" 
                                Text='<%# Bind("bank_branch_name") %>'></asp:TextBox></td></tr>
                                <tr>
                                <th 
                                   align="left" class="style2"><font color="red">*&nbsp;</font> Swif Code:&#160;</th><td class="style3" 
                                   width="30%">
                            <asp:TextBox ID="tbSwif" runat="server" 
                                       Text='<%# Bind("bank_swifcode") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="tbSwif" ErrorMessage="Have to provide Swift Code" 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Address:&nbsp;</th><td width="30%">
                            <asp:TextBox ID="tbBankAddress" runat="server" 
                                Text='<%# Bind("bank_address") %>' Width="211px"></asp:TextBox>
                        </td></tr>
                                <tr>
                                <th 
                                   align="left" class="style7"><font color="red">*&nbsp;</font> Account No.(IBAN):&#160;&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBankAccountNo" runat="server" 
                                Text='<%# Bind("bank_account_no") %>' MaxLength="31"  Width="211px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ControlToValidate="tbBankAccountNo" ErrorMessage="Have to provide Account No." 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                        <th align="left" 
                                   class="style7"><font color="red">*&nbsp;</font> Beneficiary Name:</th><td class="style3" width="30%">
                            <asp:TextBox ID="tbBeneficiaryName" runat="server" 
                                Text='<%# Bind("bank_beneficiary_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                            ControlToValidate="tbBeneficiaryName" 
                                            ErrorMessage="Have to provide Beneficiary Name" ForeColor="Red">*</asp:RequiredFieldValidator>
                        </td></tr>
                        <tr>
                                <th 
                                   align="left" class="style7">&#160;&nbsp;&nbsp;Routing No.:&#160;&#160;</th><td  colspan="3"><asp:TextBox 
                                       ID="tbBankRoutingNo" runat="server" 
                                Text='<%# Bind("bank_routing_no") %>' MaxLength="50"  Width="211px"></asp:TextBox>
                                    </td></tr>
                            <tr><th 
                                   align="left" class="style2">&nbsp;&nbsp; Comments:&#160;</th><td class="style3" colspan="3"
                                   width="30%">
                          
                                    <asp:TextBox ID="TextBox1" runat="server" Width="600px" Text='<%# Bind("bank_comments") %>' TextMode="MultiLine" Height="100"></asp:TextBox>
                          
                        </td></tr>
                            </table></td></tr><tr><td class="style4"><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%"><tr align="center"><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="Create" />  <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                             Text="Cancel" onclick="Button2_Click" />   <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                          ShowMessageBox="True" ShowSummary="False" />
                      </td></tr></table></td></tr>
             
    </table>    
           
            </InsertItemTemplate>
        </asp:FormView>

         <asp:FormView ID="FormView3" runat="server" DataKeyNames="id" SkinID="FormView" Visible="false"
            DataSourceID="EntityDataSource3" DefaultMode="Insert" Width="100%" >
           
            <InsertItemTemplate>
             <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>--%>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
              <tr><th 
                           align="left" class="style10"><font size="+1">Western Union Bank Account Information&#160; </font></th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> First Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbWuFirstName" runat="server" Text='<%# Bind("wu_first_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="tbWuFirstName" ErrorMessage="Have to provide First Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    <th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Last Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbWuLastName" runat="server" Text='<%# Bind("wu_last_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="tbWuLastName" ErrorMessage="Have to provide Last Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    </tr>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Destination:&#160;</th><td colspan="3"><asp:TextBox 
                                       ID="tbWuDestination" runat="server" Text='<%# Bind("wu_destination") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ControlToValidate="tbWuDestination" ErrorMessage="Have to provide Destination " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    
                                    </tr>
                                
                            
                            </table></td></tr><tr><td class="style4"><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%"><tr align="center"><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="Create" />&#160;&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />&#160;
                                            &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                           Text="Next" onclick="LinkButton1_Click" />
                      <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                          ShowMessageBox="True" ShowSummary="False" />
                      </td></tr></table></td></tr>
             
    </table>    
                
            </InsertItemTemplate>
        </asp:FormView>
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  Width="100%"
            DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="5" 
        onrowcommand="GridView1_RowCommand" onrowcreated="GridView1_RowCreated" >                           
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="MySelect" Text="Select" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="bank_name" HeaderText="Bank Name" 
                SortExpression="bank_name" />
            <asp:BoundField DataField="bank_branch_name" HeaderText="Branch Name" 
                SortExpression="bank_branch_name" />
            <asp:BoundField DataField="bank_address" HeaderText="Bank Address" 
                SortExpression="bank_address" />
            <asp:BoundField DataField="bank_account_no" HeaderText="Account No.(IBAN)" 
                SortExpression="bank_account_no" />
            <asp:BoundField DataField="bank_swifcode" HeaderText="Swif Code" 
                SortExpression="bank_swifcode" />
            <asp:BoundField DataField="bank_beneficiary_name" 
                HeaderText="Beneficiary Name" SortExpression="bank_beneficiary_name" />
            <asp:BoundField DataField="bank_routing_no" HeaderText="Routing No." 
                SortExpression="bank_routing_no" />
            <asp:BoundField DataField="bank_id" HeaderText="Bank ID" ControlStyle-CssClass="Hidden"
                SortExpression="bank_id" />
        </Columns>
    </asp:GridView>

    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="100%"
           AllowPaging="True" PageSize="5" DataSourceID="SqlDataSource2" onrowcommand="GridView2_RowCommand" onrowcreated="GridView1_RowCreated" >                             
        <Columns>
        <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="MySelect" Text="Select" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="wu_first_name" HeaderText="First Name" 
                SortExpression="wu_first_name" />
            <asp:BoundField DataField="wu_last_name" HeaderText="Last Name" 
                SortExpression="wu_last_name" />
                <asp:BoundField DataField="wu_destination" HeaderText="Destination" 
                SortExpression="wu_destination" />
                <asp:BoundField DataField="bank_id" HeaderText="Bank ID" ControlStyle-CssClass="Hidden"
                SortExpression="bank_id" />
        </Columns>
    </asp:GridView>
      <asp:EntityDataSource ID="EntityDataSource2" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableFlattening="False" EnableInsert="False" EntitySetName="venderbankings" 
     onupdated="EntityDataSource1_Updated" Where="it.vender_id == @id" 
                    onupdating="EntityDataSource1_Updating" EnableUpdate="True" >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>
     
  
   <asp:FormView ID="FormView1" runat="server" DataKeyNames="bank_id" 
        SkinID="FormView" DataSourceID="EntityDataSource1" Visible="false"
           DefaultMode="Edit" Width="100%" >
           
            <EditItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
             
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
            <tr><th 
                                   align="left" class="style9">&#160;&#160; Bank Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBankName" runat="server" Text='<%# Bind("bank_name") %>'></asp:TextBox></td><th 
                                   align="left" class="style7">&#160; Branch Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBranchName" runat="server" 
                                Text='<%# Bind("bank_branch_name") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Address:&nbsp;</th><td width="30%">
                            <asp:TextBox ID="tbBankAddress" runat="server" 
                                Text='<%# Bind("bank_address") %>' Width="211px"></asp:TextBox>
                        </td><th 
                                   align="left" class="style7">&#160; Account No.(IBAN):&#160;&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBankAccountNo" runat="server" 
                                Text='<%# Bind("bank_account_no") %>' MaxLength="31"  Width="211px"></asp:TextBox></td></tr>
                                <tr><th 
                                   align="left" class="style2">&#160;&#160; Swif Code:&#160;</th><td class="style3" 
                                   width="30%">
                            <asp:TextBox ID="tbSwif" runat="server" 
                                       Text='<%# Bind("bank_swifcode") %>'></asp:TextBox></td>
                        <th align="left" 
                                   class="style7">&nbsp;&nbsp;Beneficiary Name:</th><td class="style3" width="30%">
                            <asp:TextBox ID="tbBeneficiaryName" runat="server" 
                                Text='<%# Bind("bank_beneficiary_name") %>'></asp:TextBox>
                        </td></tr>
                        <tr><th 
                                   align="left" class="style2">&#160;&#160; Routing No:&#160;</th><td colspan="3">
                            <asp:TextBox ID="TextBox2" runat="server" 
                                       Text='<%# Bind("bank_routing_no") %>'></asp:TextBox></td>
                       </tr>
                            <tr><th 
                                   align="left" class="style2">&#160;&#160; Comments:&#160;</th><td class="style3" colspan="3"
                                   width="30%">
                          
                                  <asp:TextBox ID="TextBox1" runat="server" Width="600px" Text='<%# Bind("bank_comments") %>' TextMode="MultiLine" Height="100"></asp:TextBox>
                          
                        </td></tr>
                                            
                                            
                                            </table></td>
                    <tr>
                        <td class="style4">
                            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:LinkButton ID="UpdateButton2" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="Update" />
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateCancelButton2" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />
                                        &nbsp;<asp:LinkButton ID="LinkButton12" runat="server" CausesValidation="False" 
                                           Text="Next" onclick="LinkButton1_Click" /></td>
                                </tr>
                </table>
            </td>
        </tr>
                                            </table>
                </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="UpdateButton2" />
                  </Triggers>
                </asp:UpdatePanel>
            </EditItemTemplate>
        </asp:FormView>

         <asp:FormView ID="FormView4" runat="server" DataKeyNames="bank_id" 
        SkinID="FormView" DataSourceID="EntityDataSource1" Visible="false"
           DefaultMode="Edit" Width="100%" >
           
            <EditItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
             
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                           
                        <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> First Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbWuFirstName" runat="server" Text='<%# Bind("wu_first_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="tbWuFirstName" ErrorMessage="Have to provide First Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    <th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Last Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbWuLastName" runat="server" Text='<%# Bind("wu_last_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="tbWuLastName" ErrorMessage="Have to provide Last Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    </tr>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Destination:&#160;</th><td colspan="3"><asp:TextBox 
                                       ID="tbWuDestination" runat="server" Text='<%# Bind("wu_destination") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ControlToValidate="tbWuDestination" ErrorMessage="Have to provide Destination " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    </tr> </table></td>
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
                                        &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                           Text="Next" onclick="LinkButton1_Click" /> <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                          ShowMessageBox="True" ShowSummary="False" /></td>
                                </tr>
                                          </table>
            </td>
        </tr>
                                            </table>
                </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="UpdateButton" />
                  </Triggers>
                </asp:UpdatePanel>
            </EditItemTemplate>
        </asp:FormView>
                    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        SelectCommand="SELECT * FROM [venderbanking] WHERE ([bank_id] = @bank_id)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="bank_id" QueryStringField="bid" Type="Int32" />
                        </SelectParameters>
    </asp:SqlDataSource>--%>
                    <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableFlattening="False" EnableInsert="False" EntitySetName="venderbankings"  
            onupdated="EntityDataSource1_Updated" Where="it.bank_id == @id"  onupdating="EntityDataSource1_Updating" EnableUpdate="True" >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="bid" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSource3" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableFlattening="False" EnableInsert="True" EntitySetName="venderbankings" 
        oninserted="EntityDataSource1_Inserted" 
        oninserting="EntityDataSource1_Inserting" EnableDelete="False" 
            EnableUpdate="False">
        </asp:EntityDataSource >
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT * FROM [venderbanking] WHERE (([vender_id] = @vender_id) AND ([isWestUnit] = @isWestUnit))">
            <SelectParameters>
                <asp:QueryStringParameter Name="vender_id" QueryStringField="id" Type="Int32" />
                <asp:Parameter DefaultValue="False" Name="isWestUnit" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT * FROM [venderbanking] WHERE (([vender_id] = @vender_id) AND ([isWestUnit] = @isWestUnit))">
            <SelectParameters>
                <asp:QueryStringParameter Name="vender_id" QueryStringField="id" Type="Int32" />
                <asp:Parameter DefaultValue="True" Name="isWestUnit" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>
