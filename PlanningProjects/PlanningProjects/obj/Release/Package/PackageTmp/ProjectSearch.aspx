<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectSearch.aspx.cs" Inherits="PlanningProjects.ProjectSearch" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="SearchPos">
    <asp:UpdatePanel ID="ProjectViewPan" runat="server">
        <ContentTemplate>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="#A3BBCF"  Font-Names="Verdana" Font-Size="8pt" ProcessingMode="Remote" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" 
                    Width="100%"  Height="900px">
                <ServerReport ReportPath="/PlanningProjects/Projects"  ReportServerUrl="http://claritytest/ReportServer_SQLCLARITYTEST" />
            </rsweb:ReportViewer>
        </ContentTemplate>
    </asp:UpdatePanel>
        </div>
</asp:Content>
