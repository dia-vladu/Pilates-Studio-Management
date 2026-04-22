<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trainers.aspx.cs" Inherits="ProiectBDInternet.Trainers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="myGridStyle" ShowFooter="True">
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
        <asp:TemplateField HeaderText="Name" SortExpression="Name">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbNameTrainers" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Specialty" SortExpression="Specialty">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Specialty") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbSpecialty" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Specialty") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Phone") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbPhoneTrainers" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Phone") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email" SortExpression="Email">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="tbEmailTrainers" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <FooterTemplate>
                <asp:Button ID="btnAddTrainer" runat="server" Text="Add New Trainer" />
            </FooterTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>" SelectCommand="SELECT [Id], [Name], [Specialty], [Phone], [Email] FROM [Trainers]" DeleteCommand="DELETE FROM Trainers
WHERE Id = @Id;" InsertCommand="INSERT INTO Trainers(Name, Specialty, Phone, Email) VALUES (@Name, @Specialty, @Phone, @Email)" UpdateCommand="UPDATE Trainers
SET 
    Name = @Name,
    Specialty = @Specialty,
    Phone = @Phone,
    Email = @Email
WHERE Id = @Id;">
    <DeleteParameters>
        <asp:Parameter Name="Id" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Specialty" />
        <asp:Parameter Name="Phone" />
        <asp:Parameter Name="Email" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Specialty" />
        <asp:Parameter Name="Phone" />
        <asp:Parameter Name="Email" />
        <asp:Parameter Name="Id" />
    </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
