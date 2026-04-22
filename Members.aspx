<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="ProiectBDInternet.Members" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" CssClass="myGridStyle" OnRowCommand="GridView1_RowCommand" ShowFooter="True">
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
        <asp:TemplateField HeaderText="Name" SortExpression="Name">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
            </ItemTemplate>
            <FooterStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Phone") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbPhone" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Phone") %>'></asp:Label>
            </ItemTemplate>
            <FooterStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email" SortExpression="Email">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="JoinDate" SortExpression="JoinDate">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("JoinDate") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("JoinDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <FooterTemplate>
                <asp:Button ID="btnAdd" runat="server" CommandName="ADD" Text="Add New Member" />
            </FooterTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>" InsertCommand="INSERT INTO Members(Name, Phone, Email) VALUES (@Name, @Phone, @Email)" SelectCommand="SELECT [Id], [Name], [Phone], [Email], [JoinDate] FROM [Members]" DeleteCommand="DELETE FROM Produse WHERE (Id = @Id)" UpdateCommand="UPDATE Members SET Name = @Name, Phone = @Phone, Email = @Email, JoinDate = @JoinDate WHERE (Id = @Id)">
    <DeleteParameters>
        <asp:Parameter Name="Id" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Phone" />
        <asp:Parameter Name="Email" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Phone" />
        <asp:Parameter Name="Email" />
        <asp:Parameter Name="JoinDate" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
