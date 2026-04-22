<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="ProiectBDInternet.Bookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- GridView showing existing bookings -->
    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CssClass="myGridStyle" DataKeyNames="BookingId" DataSourceID="SqlDataSourceBookings" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="BookingId" HeaderText="BookingId" InsertVisible="False" ReadOnly="True" SortExpression="BookingId" Visible="False" />
            <asp:BoundField DataField="MemberName" HeaderText="MemberName" SortExpression="MemberName" />
            <asp:BoundField DataField="ClassName" HeaderText="ClassName" SortExpression="ClassName" />
            <asp:BoundField DataField="TrainerName" HeaderText="TrainerName" SortExpression="TrainerName" />
            <asp:BoundField DataField="DateTime" HeaderText="DateTime" SortExpression="DateTime" />
            <asp:CommandField DeleteText="Cancel Booking" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>

    <!-- SqlDataSource for bookings -->
    <asp:SqlDataSource ID="SqlDataSourceBookings" runat="server"
        ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>"
        SelectCommand="GetBookings"
        SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM [Bookings] WHERE [Id] = @BookingId">
        <DeleteParameters>
            <asp:Parameter Name="BookingId" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <!-- Member selection dropdown -->
    <asp:DropDownList ID="DropDownList1" runat="server"
        DataSourceID="SqlDataSourceMembers"
        DataTextField="Name"
        DataValueField="Id">
    </asp:DropDownList>

    <!-- SqlDataSource for members -->
    <asp:SqlDataSource ID="SqlDataSourceMembers" runat="server"
        ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>"
        SelectCommand="SELECT [Id], [Name] FROM [Members]">
    </asp:SqlDataSource>

    <!-- Calendar for selecting date -->
    <asp:Calendar ID="CalendarReserveASpot" runat="server" AutoPostBack="true"
        OnSelectionChanged="CalendarReserveASpot_SelectionChanged">
    </asp:Calendar>

    <!-- Dropdown for available scheduled classes -->
    <asp:DropDownList ID="ddScheduledClassesAvailable" runat="server"
        DataSourceID="SqlDataSourceScheduledClasses"
        DataTextField="DisplayName"
        DataValueField="ScheduledClassId">
    </asp:DropDownList>

    <!-- Button to reserve a spot -->
    <asp:Button ID="btnReserveASpot" runat="server" Text="Reserve A Spot" OnClick="btnReserveASpot_Click" />

    <!-- SqlDataSource for scheduled classes filtered by selected date -->
    <asp:SqlDataSource ID="SqlDataSourceScheduledClasses" runat="server"
        ConnectionString="<%$ ConnectionStrings:PILATES_STUDIOConnectionString %>"
        SelectCommand="GetScheduledClassesByDate"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="TargetDate"
                                  ControlID="CalendarReserveASpot"
                                  PropertyName="SelectedDate"
                                  Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>