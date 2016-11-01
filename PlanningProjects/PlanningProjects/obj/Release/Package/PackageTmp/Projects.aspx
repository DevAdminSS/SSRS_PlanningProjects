<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="PlanningProjects.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:UpdatePanel runat="server" ID="PanData" UpdateMode="Conditional" ChildrenAsTriggers="false">
      
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnInsert" />
            <asp:AsyncPostBackTrigger ControlID="btnUpdate" />
            <asp:AsyncPostBackTrigger ControlID="btnClear" />
        </Triggers>
    <ContentTemplate>
    <div>
        <table id="Tbl1" class="PrjLeft">
            <tr>
                <td colspan="3" class="lblMiddle">
                    Enter or Update Project Information
                </td>
            </tr>
            <tr>
                <td >
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td >
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="lblRight">
                    <asp:Label ID="lblPrjID" runat="server" Text="Project ID"></asp:Label>
                </td>
                <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtPrjID"  MaxLength="30" TabIndex="1"  AutoPostBack="True"></asp:TextBox>
                </td>
                <td class="lblRight">
                    <asp:Label ID="lblSubmitted" runat="server" Text="Date Submitted"></asp:Label>
                </td>
                <td class="lblLeft">
                    <asp:TextBox runat="server" ID="txtSubmitted"  MaxLength="255" TabIndex="5" CssClass="date" AutoPostBack="True"></asp:TextBox>
                    <asp:ImageButton ID="imgCal" runat="server"  ImageUrl="~/Images/calendar.png"  ImageAlign="AbsMiddle" />
                    <ajaxToolkit:CalendarExtender ID="dtSubmit" runat="server" DefaultView="Days" TargetControlID="txtSubmitted" PopupButtonID="imgCal" />
                </td>
            </tr>
            <tr>
                <td class="lblRight">
                    <asp:Label ID="lblPrjName" runat="server" Text="Project Name"></asp:Label>
                </td>
                <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtPrjName"  MaxLength="255" TabIndex="2" AutoPostBack="True"></asp:TextBox>
                </td>
                <td class="lblRight">
                    <asp:Label ID="lblCompleted" runat="server" Text="Date Completed"></asp:Label>
                </td>
                <td class="lblLeft">
                    <asp:TextBox runat="server" ID="txtCompleted"  MaxLength="255" TabIndex="6" AutoPostBack="True"></asp:TextBox>
                       <asp:ImageButton ID="imgCalComp" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle"/>
                    <ajaxToolkit:CalendarExtender ID="dtComplete" runat="server" DefaultView="Days" TargetControlID="txtCompleted" PopupButtonID="imgCalComp" />
                </td>
            </tr>
            <tr>
                 <td class="lblRight">
                    <asp:Label ID="lblApplicant" runat="server" Text="Applicant"></asp:Label>
                </td>
                <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtApplicant"  MaxLength="255" TabIndex="3" AutoPostBack="True"></asp:TextBox>
                </td>
                <td class="lblRight">
                    <asp:Label ID="lblPC" runat="server" Text="PC Date"></asp:Label>
                </td>
                <td class="lblLeft">
                    <asp:TextBox runat="server" ID="txtPC"  MaxLength="255" TabIndex="7" AutoPostBack="True"></asp:TextBox>
                       <asp:ImageButton ID="imgCalPC" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle" />
                    <ajaxToolkit:CalendarExtender ID="dtPC" runat="server" DefaultView="Days" TargetControlID="txtPC" PopupButtonID="imgCalPC" />
                </td>
            </tr>
            <tr>
                 <td class="lblRight">
                    <asp:Label ID="lblPlanner" runat="server" Text="Planner"></asp:Label>
                </td>
                <td class="lblLeft" >
                 <asp:DropDownList ID="ddPlanners" runat="server" AutoPostBack ="true"></asp:DropDownList>
                </td>
                <td class="lblRight">
                    <asp:Label ID="lblCC" runat="server" Text="CC Date"></asp:Label>
                </td>
                <td class="lblLeft">
                    <asp:TextBox runat="server" ID="txtCC"  MaxLength="255" TabIndex="8"></asp:TextBox>
                    <asp:ImageButton ID="imgCalCC" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle"/>
                    <ajaxToolkit:CalendarExtender ID="dtCC" runat="server" DefaultView="Days" TargetControlID="txtCC" PopupButtonID="imgCalCC" />
                </td>
            </tr>
            <tr>
                <td class="lblRight">
                    &nbsp;</td>
                <td class="lblLeft" >
                    &nbsp;</td>
                <td class="lblRight">
                    <asp:Label ID="lblBOA" runat="server" Text="BOA Date"></asp:Label>
                </td>
                <td class="lblLeft">
                    <asp:TextBox runat="server" ID="txtBOA"  MaxLength="255" TabIndex="9"></asp:TextBox>
                    <asp:ImageButton ID="imgCalBOA" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle" />
                    <ajaxToolkit:CalendarExtender ID="dtBOA" runat="server" DefaultView="Days" TargetControlID="txtBOA" PopupButtonID="imgCalBOA" />
                </td>
            </tr>
            <tr>
                 <td class="lblRight">
                    <asp:Label ID="lblWithdrawn" runat="server" Text="WithDrawn"></asp:Label>
                 </td>
                 <td class="lblLeft" >
                     <asp:DropDownList ID="ddWithdrawn" runat="server" AutoPostBack ="true" TabIndex="10"></asp:DropDownList>
                </td>
            </tr>
                        <tr>
                 <td class="lblRight">
                    <asp:Label ID="lblTerminated" runat="server" Text="Terminated"></asp:Label>
                 </td>
                 <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtTerminated" Width="325px" MaxLength="100" TabIndex="11" AutoPostBack="True"></asp:TextBox>
                    <asp:ImageButton ID="imgCalTermin" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle" />
                    <ajaxToolkit:CalendarExtender ID="dtTermin" runat="server" DefaultView="Days" TargetControlID="txtTerminated" PopupButtonID="imgCalTermin" />
                </td>
            </tr>
            <tr>
                 <td class="lblRight">
                    <asp:Label ID="lblExpired" runat="server" Text="Expired"></asp:Label>
                 </td>
                 <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtExpired" Width="325px" MaxLength="100" TabIndex="12" AutoPostBack="True"></asp:TextBox>
                    <asp:ImageButton ID="imgCalExpire" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle" />
                    <ajaxToolkit:CalendarExtender ID="dtExpired" runat="server" DefaultView="Days" TargetControlID="txtExpired" PopupButtonID="imgCalExpire" />
                </td>
            </tr>
                        <tr>
                 <td class="lblRight">
                    <asp:Label ID="lblPUD" runat="server" Text="PUD"></asp:Label>
                 </td>
                 <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtPUD" Width="325px" MaxLength="100" TabIndex="13" AutoPostBack="True"></asp:TextBox>
                    <asp:ImageButton ID="imgCalPUD" runat="server"  ImageUrl="~/Images/calendar.png" ImageAlign="AbsMiddle" />
                    <ajaxToolkit:CalendarExtender ID="dtPUD" runat="server" DefaultView="Days" TargetControlID="txtPUD" PopupButtonID="imgCalPUD" />
                </td>
            </tr>
            <tr>
                <td class="lblRight">
                    <asp:Label ID="lblProjectDesc" runat="server" Text="Project Description"></asp:Label>
                </td>
                <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtPrjDesc"  MaxLength="500" Height="70px" Width="350px" TextMode="MultiLine" TabIndex="14" AutoPostBack="True"></asp:TextBox> 
                </td>
            </tr>
            <tr>
                <td class="lblRight">
                    <asp:Label ID="lblPrjNotes" runat="server" Text="Project Notes"></asp:Label>
                </td>
                <td class="lblLeft">
                    <asp:TextBox runat="server" ID="txtPrjNotes"  MaxLength="500" Height="70px" Width="350px" TextMode="MultiLine" TabIndex="15"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="lblRight">
                    <asp:Label ID="lblCompletedNotes" runat="server" Text="Completed Notes"></asp:Label>
                </td>
                <td class="lblLeft" >
                    <asp:TextBox runat="server" ID="txtCompletedNotes"  MaxLength="255" Height="70px" Width="350px" TextMode="MultiLine" TabIndex="16"></asp:TextBox>

                    <asp:Button ID="btnInsert" Text="Save" runat="server" OnClick="InsertRec" Enabled="true" />
                     <asp:Button ID="btnUpdate" Text="Update" runat="server" OnClick="UpdateRec" enabled="false" />
                    <asp:Button ID="btnClear" Text="Clear" runat="server" OnClick="Clear"  />
                   
                    <asp:Button ID="btnTransfer" runat="server" OnClientClick="return Transfer();" Visible="false" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td class="lblMid">
                    <asp:Label ID="lblSuccess" runat="server" Text="Record Inserted Successfully!" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
      </div>
    </ContentTemplate>
   </asp:UpdatePanel>
    

</asp:Content>
