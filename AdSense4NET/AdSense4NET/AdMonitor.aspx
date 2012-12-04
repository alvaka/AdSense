<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdMonitor.aspx.cs" Inherits="AdSense4NET.AdMonitor"  MasterPageFile="~/Site.Master"%>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
   <script type="text/javascript">
       $(function () {
           $("#accordion").accordion();
       });
    </script>

    <div id="accordion">
    <h3>新华网</h3>
    <div>
      <ul>
         <li>今日曝光量：100 PV</li>
         <li>今日点击量：50 PV</li>
      </ul>
    </div>
    <h3>人民网</h3>
    <div>
       <ul>
         <li>今日曝光量：100 PV</li>
         <li>今日点击量：50 PV</li>
      </ul>
    </div>
    <h3>开心网</h3>
    <div>
       <ul>
         <li>今日曝光量：100 PV</li>
         <li>今日点击量：50 PV</li>
      </ul>
    </div>
    <h3>水木清华</h3>
    <div>
        <ul>
         <li>今日曝光量：100 PV</li>
         <li>今日点击量：50 PV</li>
        </ul>
    </div>
</div>
</asp:Content>