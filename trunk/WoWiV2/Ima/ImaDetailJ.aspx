﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailJ.aspx.cs" Inherits="Ima_ImaDetailJ" StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" align="center">
        <tr>
            <td valign="top">
                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                    <tr>
                        <td colspan="2" class="tdHeader">
                            <asp:Label ID="lblTitle" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trProductType" runat="server">
                        <td class="tdRowName" valign="top">
                            Product Type：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblProTypeName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trCopyTo" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Coyp to：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Name of approval method：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblApprovalMethod" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission Methods：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbDirect" runat="server" Text="Direct Submission" Enabled="false" />
                            <asp:CheckBox ID="cbLocalAgent" runat="server" Text="Local Agent Submission" Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission in-person：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblInPerson" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ Hard Copy：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblHardCopy" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ Website：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblWebsite" runat="server" RepeatDirection="Horizontal"
                                Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ Email：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblEmail" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ CD：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblCD" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSubmissionDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='A'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Accepts：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:CheckBox ID="cbFCCTest" runat="server" Text="FCC Test Report" Enabled="false" />
                            <asp:CheckBox ID="cbCETest" runat="server" Text="CE Test Report" Enabled="false" />
                            <asp:CheckBox ID="cbLocalTest" runat="server" Text="Local Testing" Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Samples required：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbSamplesRequired" runat="server" Text="No Samples required" Enabled="false"/>
                        </td>
                    </tr>
                    <tr id="trSamplesRequired" runat="server">
                        <td class="tdRowName" valign="top">
                            Radiated Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblRadiated" runat="server"></asp:Label>pieces
                        </td>
                    </tr>
                    <tr id="trSamplesRequired1" runat="server">
                        <td class="tdRowName" valign="top">
                            Conducted Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblConducted" runat="server"></asp:Label>pieces
                        </td>
                    </tr>
                    <tr id="trSamplesRequired2" runat="server">
                        <td class="tdRowName" valign="top">
                            Normal-Link Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblNormalLink" runat="server"></asp:Label>pieces
                        </td>
                    </tr>
                    <tr id="trSamplesRequired3" runat="server">
                        <td class="tdRowName" valign="top">
                            Testing Sample for review only：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblReviewOnly" runat="server"></asp:Label>pieces
                        </td>
                    </tr>
                    <tr id="trSamplesRequired4" runat="server">
                        <td class="tdRowName" valign="top">
                            Modular Approval acceptable：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblModular" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblModularDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile2">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO" >
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='B'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Local Representative required：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblRepresentative" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="LocalCompany" Text="Local Company" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="LocalDealer" Text="Local Dealer"></asp:ListItem>
                                            <asp:ListItem Value="RealImporter" Text="Real Importer"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRepresentativeDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile3">
                                            <Columns>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                            Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Copy to">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chSelCopy" runat="server" Checked="true" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NO" Visible="false">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='C'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Test Lab Lead-Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblLabLeadTime" runat="server"></asp:Label>week(s)
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certification Body Lead-Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblBodyLeadTime" runat="server"></asp:Label>week(s)
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Authority Lead-Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblAuthorityLeadTime" runat="server"></asp:Label>week(s)
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Expedited Process Available ：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblExpeditedProcess" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblExpeditedProcessDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile4" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile4">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='D'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Control by：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:CheckBox ID="cbControlByCertificate" runat="server" Text="Certificate # / Approval #" Enabled="false" />
                            <asp:CheckBox ID="cbControlByModel" runat="server" Text="Model #" Enabled="false" />
                            <asp:CheckBox ID="cbControlByID" runat="server" Text="ID #" Enabled="false" /><br />
                            Others：<asp:Label ID="lblControlByOther" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Multiple Model Names listed：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblMMNamesListed" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Adding model after approval ：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblAfterApproval" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblModelDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile5" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile5">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile5" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='E'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            Certificate Holder(s)
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Foreign Applicant：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblForeignApplicant" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Any Local Person/Company：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblAnyLocalPerson" runat="server" RepeatDirection="Horizontal"
                                Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Actual Importer：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblActualImporter" runat="server" RepeatDirection="Horizontal"
                                Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Local Dealer：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblLocalDealer" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCertificateHolderDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile6" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile6">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile6" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='F'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Declaration of Origin required：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblOriginRequired" runat="server" 
                                RepeatDirection="Horizontal" Enabled="False">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            ISO/Quality documents required：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblQualityRequired" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="Yes" Text="Yes(Specify)" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRequiredDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile7" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile7">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile7" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='G'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Contract required
                            <br />
                            with Local Agent：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblContractRequired" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Notarized PoA required
                            <br />
                            with Local Agent：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblNotarizedPoARequired" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certificate Number/ID
                            <br />
                            created by：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblCertificateIDCreateBy" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Authority" Text="Authority" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="User" Text="User"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Possible to get certificate number
                            <br />
                            before certificate issuance t：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblGetCertificateNumber" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Validity of Certificate：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblValidity" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Value="Life-time" Text="Life-time" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="Non-Life time" Text="Non-Life time"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblValidityDesc" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile8" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile8">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
                                                            Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsFile8" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='H'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" class="tdFooter">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>