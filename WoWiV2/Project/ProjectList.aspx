﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
  CodeFile="ProjectList.aspx.cs" Inherits="Project_ProjectList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  <div>
    Project List Infomation :
    <asp:Panel ID="PanelQuery" GroupingText="Query Condition" runat="server">
      <table>
        <tr>
          <td valign="top">
            <asp:TreeView ID="TreeViewMenu" runat="server" ImageSet="WindowsHelp" ShowLines="True">
              <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
              <Nodes>
                <asp:TreeNode Text="案件總覽(All)" Value="%">
                  <asp:TreeNode Text="新開案的案子(Open)" Value="Open"></asp:TreeNode>
                  <asp:TreeNode Text="暫停的案子(On-Hold)" Value="On-Hold"></asp:TreeNode>
                  <asp:TreeNode Text="完成的案子(Done)" Value="Done"></asp:TreeNode>
                  <asp:TreeNode Text="取消的案子(Cancelled)" Value="Cancelled"></asp:TreeNode>
                </asp:TreeNode>
              </Nodes>
              <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
                NodeSpacing="0px" VerticalPadding="1px" />
              <ParentNodeStyle Font-Bold="False" />
              <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
                VerticalPadding="0px" />
            </asp:TreeView>
          </td>
          <td>
          <p/>
            Client :
            <asp:DropDownList ID="DropDownListClient" runat="server" AppendDataBoundItems="True"
              DataSourceID="SqlDataSourceClient" DataTextField="companyname" DataValueField="id">
              <asp:ListItem Value="%">- All -</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
              SelectCommand="SELECT DISTINCT  clientapplicant.id , clientapplicant.companyname 
FROM Project 
INNER JOIN Quotation_Version ON Project.Quotation_Id = Quotation_Version.Quotation_Version_Id 
INNER JOIN clientapplicant ON clientapplicant.id = Quotation_Version.Client_Id
WHERE clientapplicant.clientapplicant_type=1 or clientapplicant.clientapplicant_type=3
ORDER BY clientapplicant.companyname"></asp:SqlDataSource>
            <p />
            and Model :
            <asp:TextBox ID="TextBoxDesc" runat="server"></asp:TextBox>
            <p />            
            and AE :
            <asp:DropDownList ID="DropDownListAE" runat="server" AppendDataBoundItems="True"
            DataSourceID="SqlDataSourceAE" DataTextField="empname" DataValueField="id">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSourceAE" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            SelectCommand="SELECT [id],  empname FROM vw_GetAEWithoutAccounting"></asp:SqlDataSource>
            <p />
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
          </td>
        </tr>
      </table>
    </asp:Panel>
    <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    <asp:GridView ID="GridViewProject" runat="server" AutoGenerateColumns="False" DataKeyNames="Project_Id"
      DataSourceID="SqlDataSourceProject" AllowSorting="True" EmptyDataText="查詢不到任何相關Project資料!"
      AllowPaging="True" OnRowUpdated="GridViewProject_RowUpdated" PageSize="20" 
      Width="100%" onrowdatabound="GridViewProject_RowDataBound">
      <Columns>
        <asp:TemplateField ShowHeader="False" Visible="False">
          <ItemTemplate>
            <asp:Button ID="ButtonDel" runat="server" CausesValidation="False" CommandName="Delete"
              Text="刪除" OnClientClick="return confirm('是否確定刪除此Project ?');" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="Project_Id" HeaderText="Project Id" InsertVisible="False"
          ReadOnly="True" SortExpression="Project_Id" Visible="False" />
        <asp:TemplateField HeaderText="Project No" SortExpression="Project_No">
          <EditItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Project_No") %>'></asp:Label>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Project_No") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Project Status" SortExpression="Project_Status">
          <EditItemTemplate>
            <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("Project_Status") %>'>
              <asp:ListItem Value="Open">新開案的案子(Open)</asp:ListItem>
              <asp:ListItem Value="On-Hold">暫停的案子(On-Hold)</asp:ListItem>
              <asp:ListItem Value="Done">完成的案子(Done)</asp:ListItem>
              <asp:ListItem Value="Cancelled">取消的案子(Cancelled)</asp:ListItem>
            </asp:DropDownList>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Project_Status") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Product" HeaderText="Product" ReadOnly="True" />
        <asp:BoundField DataField="Model" HeaderText="Model" ReadOnly="True" SortExpression="Model" />
        <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True"
          Visible="False" />
        <asp:TemplateField HeaderText="Client_Action" SortExpression="Client_Action">
          <EditItemTemplate>
            <asp:TextBox ID="txtClientAction" runat="server" Text='<%# Bind("Client_Action") %>'
              Rows="5" TextMode="MultiLine" Width="300px"></asp:TextBox>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Client_Action") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" />
        <asp:BoundField DataField="Applicant" HeaderText="Applicant" ReadOnly="True" />
        <asp:BoundField DataField="AE" HeaderText="AE" ReadOnly="True" />
        <asp:TemplateField HeaderText="Create_Date" SortExpression="Create_Date">
          <EditItemTemplate>
            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Create_Date") %>'></asp:Label>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Create_Date") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quotation No" SortExpression="Quotation_No" 
          Visible="False">
          <EditItemTemplate>
            <asp:Label ID="Label5" runat="server" Visible="false" Text='<%# Bind("Quotation_Id") %>'></asp:Label>
            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Quotation_No") %>'></asp:Label>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="Label5" runat="server" Visible="false" Text='<%# Bind("Quotation_Id") %>'></asp:Label>
            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Quotation_No") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quotation No">
          <ItemTemplate>
            <asp:HiddenField ID="HidQuotationId" runat="server" Value='<%# Bind("Quotation_Id") %>' />          
            <asp:HyperLink ID="LinkQuotation" runat="server" 
              NavigateUrl='<%# Eval("Quotation_Id", "~/Sales/CreateQuotation.aspx?q={0}") %>' 
              Target="_blank" Text='<%# Eval("Quotation_No") %>'></asp:HyperLink>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
      DeleteCommand="DELETE FROM [Project] WHERE [Project_Id] = @Project_Id" InsertCommand="INSERT INTO [Project] ([Project_No], [Project_Status], [Client_Action], [Create_Date], [Quotation_Id]) VALUES (@Project_No, @Project_Status, @Client_Action, @Create_Date, @Quotation_Id)"
      SelectCommand="SELECT Project.Project_Id, Project.Project_No, Project.Project_Status, Project.Client_Action, Project.Create_Date, Project.Quotation_Id
, (SELECT fname + ' ' + lname as fname FROM employee WHERE (id = Quotation_Version.SalesId)) AS AE, Quotation_Version.Product_Name AS Product, Quotation_Version.Model_No AS Model, Quotation_Version.Model_Difference AS Description
, (SELECT companyname FROM clientapplicant WHERE (id = Quotation_Version.Client_Id)) AS Client
, (SELECT companyname FROM clientapplicant WHERE (id = Quotation_Version.Applicant_Id)) AS Applicant
, Quotation_Version.Quotation_No 
FROM Project 
INNER JOIN Quotation_Version ON Project.Quotation_Id = Quotation_Version.Quotation_Version_Id 
Where Quotation_Version.Client_Id like @clientID 
and Quotation_Version.Model_No like  '%' + @Model + '%' 
and Project_Status LIKE '%' + @Project_Status + '%'
AND Quotation_Version.SalesId  LIKE @SalesId
Order by Project.Project_Id desc" UpdateCommand="UPDATE [Project] SET [Project_No] = @Project_No, [Project_Status] = @Project_Status, [Client_Action] = @Client_Action, [Create_Date] = @Create_Date, [Quotation_Id] = @Quotation_Id WHERE [Project_Id] = @Project_Id">
      <DeleteParameters>
        <asp:Parameter Name="Project_Id" Type="Int32" />
      </DeleteParameters>
      <InsertParameters>
        <asp:Parameter Name="Project_No" Type="String" />
        <asp:Parameter Name="Project_Status" Type="String" />
        <asp:Parameter Name="Client_Action" Type="String" />
        <asp:Parameter Name="Create_Date" Type="DateTime" />
        <asp:Parameter Name="Quotation_Id" Type="Int32" />
      </InsertParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListClient" DefaultValue="%" Name="clientID"
          PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="TextBoxDesc" DefaultValue="%" Name="Model" PropertyName="Text" />
        <asp:ControlParameter ControlID="TreeViewMenu" DefaultValue="%" Name="Project_Status"
          PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListAE" DefaultValue="%" Name="SalesId"
              PropertyName="SelectedValue" />

      </SelectParameters>
      <UpdateParameters>
        <asp:Parameter Name="Project_No" Type="String" />
        <asp:Parameter Name="Project_Status" Type="String" />
        <asp:Parameter Name="Client_Action" Type="String" />
        <asp:Parameter Name="Create_Date" Type="DateTime" />
        <asp:Parameter Name="Quotation_Id" Type="Int32" />
        <asp:Parameter Name="Project_Id" Type="Int32" />
      </UpdateParameters>
    </asp:SqlDataSource>
  </div>
</asp:Content>
