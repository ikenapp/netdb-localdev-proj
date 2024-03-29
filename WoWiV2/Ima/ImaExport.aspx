﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaExport.aspx.cs" Inherits="Ima_ImaExport" StylesheetTheme="IMA" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:UpdatePanel ID="upExport" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <%-- Search --%>
            <div style="width: 90%; margin: 5px auto">
                <center>
                <asp:Label ID="Message" runat="server" Text="" ForeColor="Blue"></asp:Label>
                </center>
                <table border="0" cellpadding="1" cellspacing="1" class="tbSearch" width="100%" align="center">
                    <tr>
                        <td class="tdRowName" valign="top">
                            Region：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:CheckBoxList ID="cbRegion" runat="server" RepeatDirection="Horizontal" DataSourceID="sdsRegion"
                                DataTextField="world_region_name" DataValueField="world_region_id" RepeatColumns="5">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsRegion" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select world_region_id,world_region_name from world_region where world_region_id in(select world_region_id from vw_ImaAccess where id=@EmpID) order by world_region_name"
                                SelectCommandType="Text">
                                <SelectParameters>
                                    <asp:ControlParameter Name="EmpID" ControlID="lblEmpID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="lblRegion" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lblEmpID" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Country：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbCountry" runat="server" Width="400px" TextMode="MultiLine" Rows="2" ReadOnly="True"></asp:TextBox>
                                        <asp:Label ID="lblCountrys" runat="server" Visible="false"></asp:Label>
                                        <asp:Button ID="btnSelect" runat="server" Text="Select" CausesValidation="false" OnClick="btnSelect_Click" />
                                        <asp:Button ID="btnClear" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnHidden" runat="server" Text="Select" CausesValidation="false" Style="display: none;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <act:ModalPopupExtender ID="mpeCountry" runat="server" TargetControlID="btnHidden"
                                            PopupControlID="panCountry" PopupDragHandleControlID="panCountry" BackgroundCssClass="mpeBackground"
                                            DropShadow="true" CancelControlID="btnCCancel">
                                        </act:ModalPopupExtender>
                                        <asp:Panel ID="panCountry" runat="server" Style="display: none; width: 600px; height: 300px;">
                                            <table border="0" width="100%" align="center" class="tbModalPopup">
                                                <tr>
                                                    <td class="tdHeader" style="text-align: left;">
                                                        <asp:DropDownList ID="ddlSelRegion" runat="server" DataSourceID="sdsRegion" DataTextField="world_region_name"
                                                            DataValueField="world_region_id" AutoPostBack="True" OnSelectedIndexChanged="ddlSelRegion_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Panel ID="plCountryList" runat="server" ScrollBars="Vertical" Height="300px">
                                                            <asp:UpdatePanel ID="upCountryList" runat="server" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="gvCountryList" runat="server" SkinID="gvList" AutoGenerateColumns="False"
                                                                        DataKeyNames="country_id,country_name" AllowPaging="false" OnRowDataBound="gvCountryList_RowDataBound">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Choose">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="cbChoose" runat="server" AutoPostBack="true" OnCheckedChanged="cb_CheckedChanged" ToolTip='<%#Eval("country_id") %>' />
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="world_region_name" HeaderText="Region">
                                                                                <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="country_name" HeaderText="Country">
                                                                                <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdHeader" align="center">
                                                        <asp:Button ID="btnCSelect" runat="server" Text="Select" CausesValidation="false" OnClick="btnCSelect_Click" />
                                                        <asp:Button ID="btnCCancel" runat="server" Text="Cancel" CausesValidation="false" />
                                                        <asp:Label ID="lblCCountrys" runat="server" Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Certification Type：</td>
                        <td class="tdRowValue" align="left">
                            <asp:UpdatePanel ID="upProductType" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlProductType" AutoPostBack="true" runat="server" DataSourceID="sdsProductType"
                                        DataTextField="wowi_product_type_name" 
                                        DataValueField="wowi_product_type_id" 
                                        onselectedindexchanged="ddlProductType_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Technology：</td>
                        <td class="tdRowValue" align="left">
                            <asp:UpdatePanel ID="upTechnology" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbTechnology" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                                        DataSourceID="sdsTechnology" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="sdsTechnology" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="select wowi_tech_id,wowi_tech_name from wowi_tech where wowi_product_type_id=@wowi_product_type_id and publish=1">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="wowi_product_type_id" ControlID="ddlProductType" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="lblTechID" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlProductType" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Export Data：</td>
                        <td class="tdRowValue" align="left" style="padding:4px;">
                            <asp:GridView ID="gvExportData" runat="server" DataKeyNames="MID" AutoGenerateColumns="False"
                                BackColor="White" BorderColor="#11CFFF" BorderStyle="None" BorderWidth="1px"
                                CellPadding="4" ForeColor="#696969" GridLines="Horizontal" OnRowDataBound="gvExportData_RowDataBound"
                                Width="100%" SkinID="gvList1">
                                <Columns>
                                    <asp:BoundField DataField="MName" HeaderText="模組名稱">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" Width="200px" />
                                        <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" ForeColor="#0066FF" BorderColor="#11CFFF" Font-Bold="true" Font-Italic="true" Font-Underline="true" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="滙出欄位名稱">
                                        <ItemTemplate>
                                            <asp:CheckBoxList ID="chExportData" runat="server" RepeatColumns="3" RepeatDirection="Horizontal">
                                            </asp:CheckBoxList>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" BorderColor="#11CFFF" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:CheckBoxList ID="chExportData" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" Visible="false">
                            </asp:CheckBoxList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="tdFooter" colspan="2">
                            <asp:Button ID="btnExport" runat="server" Text="Export" onclick="btnExport_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExport" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

