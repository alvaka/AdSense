<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="AdSense4NET.index"  MasterPageFile="~/Site.Master"%>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<h2 id="siteBanner">监测中的网站</h2>
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
        </tbody>
    </table>
</div>

<div id="dialog-form-adsite" title="新建监测站点">
    <fieldset>
        <label for="site-name">网站名称</label>
        <input type="text" name="site-name" id="siteName" class="text ui-widget-content ui-corner-all" />
        <label for="site-url">网站地址</label>
        <input type="text" name="site-url" id="siteUrl" class="text ui-widget-content ui-corner-all" />
    </fieldset>
</div>

<div id="dialog-form-adlink" title="新建广告投放链接">
    <fieldset>
        <label for="ad-site-id">广告位编号</label>
        <input type="text" name="ad-site-id" id="adSiteId" disabled="true" class="text ui-widget-content ui-corner-all" />
        <label for="ad-target-url">广告目标地址</label>
        <input type="text" name="ad-target-url" id="adTargetUrl" class="text ui-widget-content ui-corner-all" />
        <label for="ad-img-url">广告图片地址</label>
        <input type="text" name="ad-img-url" id="adImgUrl" class="text ui-widget-content ui-corner-all" />
    </fieldset>
</div>

<div id="dialog-form-adsource" title="广告位代码">
    <fieldset>
        <textarea  rows="6" cols="45" name="ad-source" id="adSource" class="text ui-widget-content ui-corner-all"></textarea>
    </fieldset>
</div>

<div id="dialog" title="Basic dialog">
    <p></p>
</div>

<script type="text/javascript">
    $(function () {
        function LoadAdSite() {
            $.post(
            "AdService.asmx/GetAdSites",
            function (data) {
                var p = $.parseJSON($(data).find("string").text());
                $.each(p, function (index, site) {
                    $("#users tbody").append("<tr>" +
                            "<td title=\"" + site["SiteId"] + "\">" + site["SiteName"] + "</td>" +
                            "<td>" + site["SiteUrl"] + "</td>" +
                            "<td><a class='showAdLink'>广告链接</a></td>" +
                        "</tr>");
                });
                //注册点击事件
                $("tbody >tr").click(rowSelect);

                //点击产生广告连接
                $(".showAdLink").click(ShowAdLink);
            },
            "xml");
        }

        //添加站点
        function AddAdSite(siteName, siteUrl) {
            $.post(
            "AdService.asmx/AddAdSite",
            { name: siteName, url: siteUrl },
            function (data) {
                var p = $.parseJSON($(data).find("string").text());

                $("<tr>" +
                       "<td title=\"" + p.SiteId + "\">" + siteName + "</td>" +
                       "<td>" + siteUrl + "</td>" +
                       "<td><a class='showAdLink'>广告链接</a></td>" +
                       "</tr>").bind("click", rowSelect).appendTo("#users tbody");
            }, "xml");
        }

        //加载数据 
        function ShowAdLink() {
            $("#adSiteId").val($(this).parent().siblings(":first").attr("title"));
            $("#dialog-form-adlink").dialog("open");
            event.stopPropagation();
        }

        LoadAdSite();

        $("#dialog-form-adsite").dialog({
            autoOpen: false,
            height: 250,
            width: 350,
            modal: true,
            buttons: {
                "确定": function () {
                    var bValid = true;
                    var siteName = $("#siteName").val(),
                        siteUrl = $("#siteUrl").val();
                    if (bValid) {
                        AddAdSite(siteName, siteUrl);
                        $(this).dialog("close");
                    }
                },
                "取消": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#dialog-form-adlink").dialog({
            autoOpen: false,
            height: 320,
            width: 350,
            modal: true,
            buttons: {
                "产生代码": function () {
                    $(this).dialog("close");
                    $("#adSource").val("<iframe><a href=''><img src='#' /></a></iframe>");
                    $("#dialog-form-adsource").dialog("open");
                },
                "取消": function () { }
            }
        });

        $("#dialog-form-adsource").dialog({
            autoOpen: false,
            height: 240,
            width: 350,
            modal: true,
            buttons: {
                "复制": function () { },
                "关闭": function () { $(this).dialog("close"); }
            }
        });

        $("#create-user")
            .button()
            .click(function () {
                $("#dialog-form-adsite").dialog("open");
            });

        $("#delete-site").button().click(function () {
            var selectedRow = $("tbody>tr.tr-selected");
            if (selectedRow.length != 0) {
                var siteId = selectedRow.children(":first").attr("title");
                $.post("AdService.asmx/RemoveAdSite", { siteId: siteId });
                selectedRow.remove();
            }
        });

        function rowSelect() {
            if (!$(this).hasClass("tr-selected")) {
                $("tbody>tr.tr-selected").removeClass("tr-selected");
                $(this).addClass("tr-selected");
            }
        }

        $("tbody >tr").click(rowSelect);



    });
    </script>
</asp:Content>