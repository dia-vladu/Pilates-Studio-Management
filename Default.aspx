<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProiectBDInternet.Dashboard1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Page Title -->
    <h1 class="page-title mb-4">Dashboard</h1>

    <div class="row">
        
        <!-- Total Members Card-->
        <div class="col-md-3 mb-3">
            <div class="dashboard-card">
                <div class="card-icon bg-blue"><i class="bi bi-people-fill"></i></div>
                <div class="card-text">
                    <p><strong>Total Membri</strong></p>
                    <h3 runat="server" id="lblTotalMembers">0</h3>
                </div>
            </div>
        </div>

        <!-- Reservations Card -->
        <div class="col-md-3 mb-3">
            <div class="dashboard-card">
                <div class="card-icon bg-green"><i class="bi bi-calendar-event"></i></div>
                <div class="card-text">
                    <p><strong>Rezervări</strong></p>
                    <p class="p-small">Săptămâna aceasta</p>
                    <h3 runat="server" id="lblTotalBookings">0</h3>
                </div>
            </div>
        </div>

        <!-- Available Classes Card -->
        <div class="col-md-3 mb-3">
            <div class="dashboard-card">
                <div class="card-icon bg-purple"><i class="bi bi-journal-bookmark"></i></div>
                <div class="card-text">
                    <p><strong>Clase</strong></p>
                    <p class="p-small">Disponibile</p>
                    <h3 runat="server" id="lblTotalClasses">0</h3>
                </div>
            </div>
        </div>

        <!-- Active Trainers Card -->
        <div class="col-md-3 mb-3">
            <div class="dashboard-card">
                <div class="card-icon bg-orange"><i class="bi bi-heart-fill"></i></div>
                <div class="card-text">
                    <p><strong>Traineri Activi</strong></p>
                    <h3 runat="server" id="lblTotalTrainers">0</h3>
                </div>
            </div>
        </div>
    </div>

    <div class="dashboard-card-vertical" style="padding: 20px; width: 60%;">
        <h4>Participarea pe zile</h4>

        <div style="width: 90%; height: 250px;">
            <canvas id="weeklyBookingsChart"></canvas>
        </div>

        <div style="margin-top: 10px;">
            <span style="color: #5aa7a7; padding: 20px;">● Numar Rezervari</span>
            <span style="float: right;">
                <strong><%= totalBookings %></strong> Rezervari Ttotale
            </span>
        </div>
    </div>

    <script>

        const ctx = document.getElementById('weeklyBookingsChart');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['L', 'M', 'M', 'J', 'V', 'S', 'D'],
                datasets: [{
                    label: 'Număr Rezervări',
                    data: [<%= chartData %>],
            borderColor: '#5aa7a7',
            backgroundColor: 'rgba(90,167,167,0.2)',
            tension: 0.4,
            fill: true,
            pointRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

    </script>

</asp:Content>
