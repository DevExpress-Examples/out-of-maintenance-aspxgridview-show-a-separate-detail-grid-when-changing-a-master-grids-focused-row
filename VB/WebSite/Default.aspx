<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTimer" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>How to show a detail table in a separate grid when the master grid's focused row is changed by pressing navigation keys</title>
</head>
<body>
	<script type="text/javascript">
		function onRowChanged(s, e) {
			ASPxTimer1.SetEnabled(false);
			ASPxTimer1.SetEnabled(true);
		}
		function showDetail(s, e) {
			ASPxTimer1.SetEnabled(false);
			detailGrid.PerformCallback(masterGrid.GetRowKey(masterGrid.GetFocusedRowIndex()));
		}
	</script>
	<form id="form1" runat="server">
		<div>
			<dx:ASPxGridView ID="masterGrid" runat="server" DataSourceID="Categories" KeyFieldName="CategoryID" KeyboardSupport="true" ClientInstanceName="masterGrid">
				<ClientSideEvents FocusedRowChanged="onRowChanged" Init="function(s, e){ masterGrid.Focus(); }" />
				<SettingsBehavior AllowFocusedRow="true" />
			</dx:ASPxGridView>
			<dx:ASPxGridView ID="detailGrid" runat="server" DataSourceID="Products" ClientInstanceName="detailGrid" KeyFieldName="ProductID" OnCustomCallback="detailGrid_CustomCallback">
			</dx:ASPxGridView>
			<dx:ASPxTimer ID="ASPxTimer1" runat="server" Interval="1000" ClientInstanceName="ASPxTimer1">
				<ClientSideEvents Tick="showDetail" />
			</dx:ASPxTimer>
		</div>
		<asp:SqlDataSource ID="Categories" runat="server" ConnectionString="<%$ ConnectionStrings:MyNorthwind%>" SelectCommand="SELECT CategoryID, CategoryName, Description FROM Categories"></asp:SqlDataSource>
		<asp:SqlDataSource ID="Products" runat="server" ConnectionString="<%$ ConnectionStrings:MyNorthwind%>" SelectCommand="SELECT * FROM Products WHERE CategoryID=@CategoryID">
			<SelectParameters>
				<asp:SessionParameter Name="CategoryID" SessionField="CategoryID" Type="Int32" />
			</SelectParameters>
		</asp:SqlDataSource>
	</form>
</body>
</html>