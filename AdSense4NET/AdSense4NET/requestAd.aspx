<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="requestAd.aspx.cs" Inherits="AdSense4NET.Account.requestAd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h3>Look at this!</h3><span><%=Request.PhysicalApplicationPath %></span>
      <img src="adimage.aspx" />
    </div>
    </form>
</body>
</html>
