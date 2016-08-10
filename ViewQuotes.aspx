<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewQuotes.aspx.cs" Inherits="ViewQuotes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Auto Transport Quotes</title>
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>

    <!-- bootstrap stylesheet -->
    <link href='components/bootstrap/dist/css/bootstrap.min.css' rel='stylesheet' type='text/css'>

    <style>
        body {
            padding: 10px;
        }

        table {
            border: solid 1px #ececec;
            padding: 4px;
        }

        td {
            border: solid 1px #ececec;
            padding: 4px;
        }

        th {
            border: solid 1px #ececec;
            padding: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        <div>
            <h1>Submitted Quotes</h1>
            <asp:Repeater ID="rptQuotes" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Created</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Vehicle Make & Model</th>
                            <th>Pickup City/State</th>
                            <th>Delivery City/State</th>
                            <th>Run?</th>
                            <th>Trailer</th>
                            <th>Additional Info</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("id") %></td>
                        <td><%# Eval("created") %></td>
                        <td><%# Eval("name") %></td>
                        <td><%# Eval("email") %></td>
                        <td><%# Eval("phone") %></td>
                        <td><%# Eval("vehicle") %></td>
                        <td><%# Eval("pickup") %></td>
                        <td><%# Eval("delivery") %></td>
                        <td><%# Eval("run") %></td>
                        <td><%# Eval("trailer") %></td>
                        <td><%# Eval("notes") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
