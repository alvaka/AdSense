<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="AdSense4NET.index"  MasterPageFile="~/Site.Master"%>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2 id="siteBanner">在监测的网站</h2>
<ul id="siteToolBar">
   <li><a id="create-user">添加</a></li>
   <li><a id="delete-site">删除</a></li>
</ul>
<br />
<div id="users-contain" class="ui-widget">
    <table id="users" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th>网站名称</th>
                <th>网站地址</th>
                <th>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td title="10001">新华网</td>
                <td>http://www.xinhua.com</td>
                <td><a class="showAdLink">广告链接</a></td>
            </tr>
            <tr>
                <td title="10002">人民网</td>
                <td>http://www.renming.com</td>
                <td><a class="showAdLink">广告链接</a></td>
            </tr>
        </tbody>
    </table>
</div>

<div id="dialog-form" title="新建广告投放站点">
    <fieldset>
        <label for="site-name">网站名称</label>
        <input type="text" name="site-name" id="siteName" class="text ui-widget-content ui-corner-all" />
        <label for="site-url">网站地址</label>
        <input type="text" name="site-url" id="siteUrl" class="text ui-widget-content ui-corner-all" />
    </fieldset>
</div>

<div id="dialog" title="Basic dialog">
    <p></p>
</div>

<script type="text/javascript">
    $(function () {
        var siteName = $("#siteName"),
            siteUrl = $("#siteUrl");

        $("#dialog-form").dialog({
            autoOpen: false,
            height: 300,
            width: 350,
            modal: true,
            buttons: {
                "Ok": function () {
                    var bValid = true;

                    if (bValid) {
                        $("#users tbody").append("<tr>" +
                            "<td>" + siteName.val() + "</td>" +
                            "<td>" + siteUrl.val() + "</td>" +
                            "<td><a class='showAdLink'>广告链接</a></td>" +
                        "</tr>");
                        $(this).dialog("close");
                    }
                },
                Cancel: function () {
                    $(this).dialog("close");
                }
            },
            close: function () {
                allFields.val("").removeClass("ui-state-error");
            }
        });

        $("#create-user")
            .button()
            .click(function () {
                $("#dialog-form").dialog("open");
            });

        $("#delete-site").button();
        $("#delete-site").click(function () {
            var selectedRow = $("tbody>tr[title='selected-row']");
            if (selectedRow.length != 0) {
                $("#dialog>p").html(selectedRow.children(":first").attr("title"));
                $("#dialog").dialog();
            }
        });

        $("tbody>tr").click(function () {
            $("tbody>tr").each(function () {
                $(this).removeClass("tr-selected");
                $(this).attr("title", "");
            });
            $(this).addClass("tr-selected");
            $(this).attr("title", "selected-row");
        });
        $(".showAdLink").click(function () {
            $("#dialog>p").html($(this).parent().siblings(":first").attr("title"));
            $("#dialog").dialog();
        });
    });
    </script>
</asp:Content>