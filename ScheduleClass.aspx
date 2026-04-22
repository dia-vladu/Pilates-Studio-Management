<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScheduleClass.aspx.cs" Inherits="ProiectBDInternet.ScheduleClass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="myGridStyle" DataKeyNames="ScheduledClassId" DataSourceID="SqlDataSource1" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="ScheduledClassId" HeaderText="ScheduledClassId" InsertVisible="False" ReadOnly="True" SortExpression="ScheduledClassId" Visible="False" />
            <asp:TemplateField HeaderText="ClassName" SortExpression="ClassName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ClassName") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ddClassNames" runat="server" DataSourceID="SqlDataSourceClasses" DataTextField="Name" DataValueField="Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceClasses" runat="server" ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>" SelectCommand="SELECT [Name], [Id] FROM [Classes]"></asp:SqlDataSource>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ClassName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="TrainerName" SortExpression="TrainerName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TrainerName") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ddTrainerNames" runat="server" DataSourceID="SqlDataSourceTrainers" DataTextField="Name" DataValueField="Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceTrainers" runat="server" ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>" SelectCommand="SELECT [Id], [Name] FROM [Trainers]"></asp:SqlDataSource>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("TrainerName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="StartsAt" SortExpression="StartsAt">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("StartsAt") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="tbStartsAt" runat="server"></asp:TextBox>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("StartsAt") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Duration" SortExpression="Duration">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Duration") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Duration") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="MaxCapacity" SortExpression="MaxCapacity">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("MaxCapacity") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="tbClassCapacity" runat="server"></asp:TextBox>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("MaxCapacity") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="lblSoldOut" runat="server"
                        Text='<%# Convert.ToBoolean(Eval("SoldOut")) ? "SOLD OUT" : "" %>'
                        ForeColor="Red"
                        Font-Bold="true">
                    </asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button ID="btnScheduleClass" runat="server" OnClick="btnScheduleClass_Click" Text="Schedule New Class" />
                    <br />
                    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>" SelectCommand="GetScheduledClasses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    
</asp:Content>
