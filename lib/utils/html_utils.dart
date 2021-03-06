import 'dart:convert';

import 'package:zhihu/commom/model/news_details.dart';

class HtmlUtils {
  static String formatNewsDetailsHtml(NewsDetails newsDetails, int themeMode) {
    if (newsDetails == null) {
      return "";
    }

    String imageHead = '<div class="img-wrap">'
        '<h1 class="headline-title">${newsDetails.title}</h1>'
        '<span class="img-source">${newsDetails.imageSource??""}</span>'
        '<img src="${newsDetails.image}" alt="" />'
        '</div>';

    String sectionHtml = "";
    if (newsDetails.section != null) {
      sectionHtml = "<div class='bottom-recommend'>"
          "<a class='recommend-link' href='section://${newsDetails.section.id}' data-story='9712709'>"
          "<span style='background-image:url(${newsDetails.section.thumbnail})' class='link-image'></span>"
          "<span class='recommend-link-title'>"
          "本文来自 : ${newsDetails.section.name} · 合集"
          "</span>"
          "</a>"
          "</div>";
    }

    String nightMode = "";
    if (themeMode == 1) {
      nightMode = nightJs;
    }

    String html = "<!doctype html>"
        "<html>"
        " <head>"
        "   <meta charset='utf-8'>"
        "   <meta name='viewport' content='user-scalable=no, width=device-width'>"
        "$css"
        " </head>"
        "  <body>"
        "$nightMode"
        "${newsDetails.body}"
        "$sectionHtml"
        "  </body>"
        "</html>";
    html = html.replaceAll("<div class=\"img-place-holder\">", imageHead);
    html = html.replaceAll("http://", "https://");
    return Uri.dataFromString(html,
            mimeType: 'text/html', encoding: Encoding.getByName("utf-8"))
        .toString();
  }

  ///夜间模式JS
  static const String nightJs = "<script>"
      "var body = document.body;"
      "set_night_mode('night');"
      "function set_night_mode(mode) {"
      "body.className += mode ? 'night ' : ' ';"
      "return 6;"
      "}"
      "</script>";

  static const String css = r'''
            <style type="text/css">
body {
	padding-top: 60px;
	margin: 0;
	font-family: 'Helvetica Neue',Helvetica,Arial,Sans-serif;
}

img {
	vertical-align: middle;
	color: transparent;
	font-size: 0;
}

blockquote {
	border-left: 3px solid #D0E5F2;
	font-style: normal;
	padding: 0 0 0 .5em;
	margin: .5em 0;
	display: block;
	line-height: 1.7em;
	vertical-align: baseline;
	font-size: 100%;
}

ul, ol {
	padding-left: 20px;
}

.web-logo {
	width: 126px;
	height: 42px;
	background-image: url('/img/Web_Logo.png');
	background-repeat: no-repeat;
	display: inline-block;
	vertical-align: middle;
}

.global-header {
	width: 100%;
	position: fixed;
	top: 0;
	z-index: 9990;
	height: 60px;
	background-color: #009dd7;
	color: #FaFcFe;
}

.global-header .title {
	font-size: 24px;
	font-weight: 100;
	margin: 0 0 0 63px;
}

.global-header .main-wrap {
	height: 60px;
	position: relative;
	line-height: 60px;
}

.download-banner-v2 {
	position: fixed;
	bottom: 0;
	z-index: 3;
	display: none;
	width: 100%;
	height: 60px;
	background-color: rgba(0, 0, 0, .7);
	color: #fff;
	-webkit-transition: opacity .3s ease-out;
	transition: opacity .3s ease-out;
}

.download-banner-v2.hide {
	opacity: 0;
}

.download-banner-v2 .close {
	position: absolute;
	top: 0;
	left: 0;
	width: 21px;
	height: 21px;
	padding: 19px 12px 20px;
	background-image: url(/img/download_banner/close.png);
	background-position: center;
	background-repeat: no-repeat;
	background-size: 21px;
	opacity: 1;
}

.download-banner-v2 .icon {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 46px;
	width: 41px;
	height: 41px;
	margin: auto;
	background-image: url(/img/download_banner/app-icon.png);
	background-position: center;
	background-size: 41px;
}

.download-banner-v2 .title,
                .download-banner-v2 .describe {
	margin-left: 97px;
	margin-right: 84px;
	line-height: 1;
}

.download-banner-v2 .title {
	margin-top: 12px;
	margin-bottom: 0;
	font-size: 19px;
}

.download-banner-v2 .describe {
	margin-top: 4px;
	font-size: 12px;
}

.download-banner-v2 .download-btn {
	position: absolute;
	top: 0;
	right: 10px;
	bottom: 0;
	width: 74px;
	height: 23px;
	padding-top: 10px;
	margin: auto;
	font-size: 13px;
	line-height: 1;
	text-align: center;
	text-decoration: none;
	color: #fff;
	background-color: #58af08;
	border: 0;
	border-radius: 4px;
}

.sprite-ico-Header_Logo2x {
	position: absolute;
	bottom: 0;
}

.button {
	display: inline-block;
	height: 36px;
	line-height: 36px;
	width: 120px;
	background-color: #1cade9;
	margin: 0 5px;
	color: white;
	text-decoration: none;
	text-align: center;
	border-radius: 4px;
	font-size: 14px;
}

html.no-touch .button:hover {
	background-color: #1fb3f0;
}

.button i {
	margin-right: 10px;
}

.button span {
	vertical-align: -2px;
}

.download {
	float: right;
}

.main-wrap {
	max-width: 600px;
	min-width: 300px;
	margin: 0 auto;
}

.content-wrap {
	overflow: hidden;
	background-color: #fff;
}

.content-wrap a {
	word-break: break-all;
}

.headline {
	border-bottom: 4px solid #f6f6f6;
}

.headline-title.onlyheading {
	margin: 20px 0;
}

.headline img {
	max-width: 100%;
	vertical-align: top;
}

html.no-touch .headline-background:hover {
	background-color: #fdfdfd;
}

.headline-background-link {
	line-height: 2em;
	position: relative;
	padding: 25px 40px;
	display: block;
	text-decoration: none;
}

.icon-arrow-right {
	position: absolute;
	top: 50%;
	right: 20px;
	margin-top: -10px;
}

.headline-background .heading {
	color: #999;
	font-size: 20px;
	margin-bottom: 5px;
}

.headline-background .heading-content {
	font-size: 24px;
	color: #444;
	text-decoration: none;
}

.img-wrap {
	position: relative;
	max-height: 268px;
	overflow: hidden;
}

.img-wrap img {
	margin-top: -18%;
	width: 640px;
}

.img-wrap .img-source {
	position: absolute;
	bottom: 10px;
	z-index: 1;
	font-size: 12px;
	color: rgba(255,255,255,.6);
	right: 40px;
	text-shadow: 0px 1px 2px rgba(0,0,0,.3);
}

.logo-image-place-holder {
	background-color: #00addf;
	height: 126px;
}

.logo-image-place-holder img {
	display: block;
	margin: 0 auto;
}

.img-mask {
	position: absolute;
	top: 0;
	width: 100%;
	height: 100%;
	background: -moz-linear-gradient(top, rgba(0,0,0,0) 25%, rgba(0,0,0,0.6) 100%);
 /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(25%,rgba(0,0,0,0)), color-stop(100%,rgba(0,0,0,0.6)));
 /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%);
 /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%);
 /* Opera 11.10+ */
	background: -ms-linear-gradient(top, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%);
 /* IE10+ */
	background: linear-gradient(to bottom, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%);
 /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00000000', endColorstr='#99000000',GradientType=0 );
 /* IE6-9 */
}

.headline-title {
	margin: 20px 0 10px;
	font-size: 30px;
	line-height: 1.2em;
	padding: 0 40px;
	color: #222;
}

.img-wrap .headline-title {
	margin: 20px 0;
	bottom: 10px;
	z-index: 1;
	position: absolute;
	color: white;
	text-shadow: 0px 1px 2px rgba(0,0,0,0.3);
}

.headline-summary {
	padding: 20px 40px 0;
}

.meta {
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	font-size: 16px;
	color: #b8b8b8;
}

.meta span {
	vertical-align: middle;
}

.meta .source-icon {
	width: 20px;
	height: 20px;
}

.meta .time {
	float: right;
	margin-top: 2px;
}

.meta .source-icon {
	margin-right: 4px;
}

.meta .source {
	vertical-align: middle;
}

.content {
	color: #444;
	line-height: 2em;
	margin: 10px 0 25px;
}

.content img {
	max-width: 100%;
	margin: 10px 0;
	display: block;
}

.content img[src*="zhihu.com/equation"] {
	display: inline-block;
	margin: 0 3px;
}

.content a {
	color: #105CB6;
	text-decoration: none;
}

.content a:hover {
	text-decoration: underline;
}

.view-more {
	margin-bottom: 25px;
	text-align: center;
}

.view-more a {
	width: 100%;
	display: block;
	font-size: 13px;
	height: 30px;
	line-height: 30px;
	background: #f0f0f0;
	color: #B8B8B8;
	text-decoration: none;
}

html.no-touch .view-more a:hover {
	text-decoration: underline;
}

.question {
	padding: 0 40px;
	overflow: hidden;
}

.question + .question {
	border-top: 5px solid #f6f6f6;
}

.question-title {
	font-size: 18px;
	line-height: 1.4em;
	color: #494b4d;
	font-weight: 700;
	margin: 20px 0;
}

.meta .author {
	color: #444;
}

.meta .avatar {
	width: 20px;
	height: 20px;
	border-radius: 2px;
	margin-right: 5px;
}

.meta img.avatar {
	display: inline-block;
}

.meta .bio {
	color: #999;
}

.answer + .answer {
	border-top: 2px solid #f6f6f6;
	padding-top: 30px;
}

.qr {
	background-color: #fff;
	text-align: center;
	border-top: 5px solid #F6F6F6;
	padding: 25px;
}

.qr .heading {
	font-size: 18px;
	color: #555;
}

.qr .subheading {
	font-size: 14px;
	color: #b8b8b8;
}

.qr-wrap {
	padding-top: 25px;
	padding-bottom: 15px;
}

.footer {
	padding: 20px 0;
	text-align: center;
	color: #b8b8b8;
	font-size: 13px;
}

.footer a {
	color: #b8b8b8;
	text-decoration: none;
}

.footer .view-origin {
	margin: 5px auto;
	display: inline-block;
	line-height: 50px;
	background: #f1f1f1;
	height: 50px;
	width: 90%;
	font-size: 16px;
	color: #616161;
	text-decoration: none;
}

.footer-download {
	display: none;
	margin-top: 10px;
	margin-bottom: 40px;
}

a.download-btn {
	display: inline-block;
	height: 60px;
	line-height: 60px;
	width: 280px;
	border: 1px solid #b8b8b8;
	background-color: #fdfdfd;
	font-size: 17px;
	border-radius: 10px;
	color: #444;
}

html.no-touch .footer a:hover {
	text-decoration: underline;
}

.icon-arrow-right {
	background-image: url('/img/share-icons.png');
	background-repeat: no-repeat;
	display: inline-block;
	vertical-align: middle;
	background-position: -70px 0px;
	width: 12px;
	height: 20px;
}

.highlight {
	width: auto;
	overflow: auto;
	word-wrap: normal;
}

.highlight::-webkit-scrollbar {
	width: 6px;
	height: 6px;
}

.highlight code {
	overflow: auto;
}

.highlight::-webkit-scrollbar-thumb:horizontal {
	border-radius: 6px;
	background-color: rgba(0,0,0,.5);
}

.highlight::-webkit-scrollbar-thumb:horizontal:hover {
	background-color: rgba(0,0,0,.6);
}

.highlight pre {
	margin: 0;
	white-space: pre;
}

.highlight .hll {
	background-color: #ffffcc
}

.highlight {
	background: #ffffff;
}

.highlight .c {
	color: #999988;
	font-style: italic
}

.highlight .err {
	color: #a61717;
	background-color: #e3d2d2
}

.highlight .k {
	font-weight: bold
}

.highlight .o {
	font-weight: bold
}

.highlight .cm {
	color: #999988;
	font-style: italic
}

.highlight .cp {
	color: #999999;
	font-weight: bold
}

.highlight .c1 {
	color: #999988;
	font-style: italic
}

.highlight .cs {
	color: #999999;
	font-weight: bold;
	font-style: italic
}

.highlight .gd {
	color: #000000;
	background-color: #ffdddd
}

.highlight .ge {
	font-style: italic
}

.highlight .gr {
	color: #aa0000
}

.highlight .gh {
	color: #999999
}

.highlight .gi {
	color: #000000;
	background-color: #ddffdd
}

.highlight .go {
	color: #888888
}

.highlight .gp {
	color: #555555
}

.highlight .gs {
	font-weight: bold
}

.highlight .gu {
	color: #aaaaaa
}

.highlight .gt {
	color: #aa0000
}

.highlight .kc {
	font-weight: bold
}

.highlight .kd {
	font-weight: bold
}

.highlight .kn {
	font-weight: bold
}

.highlight .kp {
	font-weight: bold
}

.highlight .kr {
	font-weight: bold
}

.highlight .kt {
	color: #445588;
	font-weight: bold
}

.highlight .m {
	color: #009999
}

.highlight .s {
	color: #d32
}

.highlight .na {
	color: #008080
}

.highlight .nb {
	color: #008080
}

.highlight .nc {
	color: #445588;
	font-weight: bold
}

.highlight .no {
	color: #008080
}

.highlight .ni {
	color: #800080
}

.highlight .ne {
	color: #990000;
	font-weight: bold
}

.highlight .nf {
	color: #990000;
	font-weight: bold
}

.highlight .nn {
	color: #555555
}

.highlight .nt {
	color: #000080
}

.highlight .nv {
	color: #008080
}

.highlight .ow {
	font-weight: bold
}

.highlight .w {
	color: #bbbbbb
}

.highlight .mf {
	color: #009999
}

.highlight .mh {
	color: #009999
}

.highlight .mi {
	color: #009999
}

.highlight .mo {
	color: #009999
}

.highlight .sb {
	color: #d32
}

.highlight .sc {
	color: #d32
}

.highlight .sd {
	color: #d32
}

.highlight .s2 {
	color: #d32
}

.highlight .se {
	color: #d32
}

.highlight .sh {
	color: #d32
}

.highlight .si {
	color: #d32
}

.highlight .sx {
	color: #d32
}

.highlight .sr {
	color: #808000
}

.highlight .s1 {
	color: #d32
}

.highlight .ss {
	color: #d32
}

.highlight .bp {
	color: #999999
}

.highlight .vc {
	color: #008080
}

.highlight .vg {
	color: #008080
}

.highlight .vi {
	color: #008080
}

.highlight .il {
	color: #009999
}

.bottom-recommend {
	display: none;
	padding-left: 12px;
	padding-right: 12px;
	font-size: 14px;
	color: #000;
	background: #f0f0f0;
}

.bottom-recommend a {
	margin-top: 12px;
	padding-top: 12px;
	display: block;
	height: 60px;
	font-size: 15px;
	color: #000;
	text-decoration: none;
	line-height: 60px;
}

.bottom-recommend .link-image {
	float: left;
	width: 60px;
	height: 60px;
	background-position: 50%;
	background-size: cover;
}

.bottom-recommend .recommend-link-title {
	margin-left: 8px;
	font-size: 13px;
}

@media (max-width: 480px) {
	.bottom-recommend {
		display: block;
	}

	.new-download-banner {
		display: block;
	}

	.headline .meta {
		padding: 0 20px !important;
	}

	body {
		padding-top: 0;
	}

	blockquote, sup {
		line-height: 1.4em;
	}

	.global-header .main-wrap {
		margin: 0 10px;
	}

	.qr {
		display: none;
	}

	.footer {
		margin: 0;
		padding: 25px 0 25px 0;
		background-color: white;
	}

	.footer-download {
		display: block;
	}
                
                  /* depredecaded */
	.download-banner {
		display: block;
	}

	html.show-download-banner .download-banner-v2 {
		display: block;
	}

	.icon-arrow-right {
		background-repeat: no-repeat;
		display: inline-block;
		vertical-align: middle;
		background-position: -70px -20px;
		width: 10px;
		height: 15px;
		margin-top: -7.5px;
	}

	.img-wrap .headline-title {
		bottom: 5px;
	}

	.content {
		line-height: 1.6em;
		margin: 10px 0 20px;
		font-size: 17px
	}

	.img-wrap .img-source {
		right: 10px !important;
		font-size: 9px;
	}

	.headline-background-link {
		padding: 20px 45px 20px 20px !important;
	}

	.headline-title {
		font-size: 21px;
		padding: 0 20px !important;
	}

	.headline-background .heading {
		font-size: 15px !important;
		margin-bottom: 8px;
		line-height: 1em;
	}

	.headline-background .heading-content {
		font-size: 17px !important;
		line-height: 1.2em;
	}

	.question {
		padding: 0 20px !important;
	}

	.global-header {
		display: none;
	}

	.button {
		width: 60px;
	}

	.button i {
		margin-right: 0;
	}

	.answer + .answer {
		padding-top: 20px;
	}

	.button span {
		display: none;
	}

	.view-more {
		margin-bottom: 25px;
	}

	.footer .view-origin {
		color: #b8b8b8;
	}
}

@media only screen and (-webkit-min-device-pixel-ratio: 2), only screen and (min--moz-device-pixel-ratio: 2), only screen and (-o-min-device-pixel-ratio: 200/100), only screen and (min-device-pixel-ratio: 2) {
	.icon-arrow-right {
		background-image: url('/img/share-icons@2x.png') !important;
		-webkit-background-size: 82px 55px;
		-moz-background-size: 82px 55px;
		background-size: 82px 55px;
	}

	.star {
		background-image: url('/img/star@2x.png');
		-webkit-background-size: 9px 9px;
		-moz-background-size: 9px 9px;
		background-size: 9px 9px;
	}

	.web-logo {
		background-image: url('/img/Web_Logo@2x.png') !important;
		-webkit-background-size: 126px 42px;
		-moz-background-size: 126px 42px;
		background-size: 126px 42px;
	}
}

.meta .meta-item {
	width: 39%;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	display: inline-block;
	color: #929292;
	margin-right: 7px
}

.headline .meta {
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	font-size: 11px;
	color: #b8b8b8;
	margin: 15px 0;
	padding: 0 40px
}

.headline .meta a, .headline .meta a:hover {
	margin-top: 2px;
	float: right;
	font-size: 11px;
	color: #0066cf;
	text-decoration: none
}
                
                /* T16905 */
.header-for-mobile {
	height: 62px;
	overflow: hidden;
	line-height: 1;
	display: none;
	background: #fff;
}

.header-for-mobile-btn {
	float: right;
	margin-top: 17px;
	border-radius: 3px;
	background-color: #57c200;
	padding: 8px 9px;
	color: #fff;
	font-size: 12px;
}

.header-for-mobile-logo-img {
	float: left;
	margin-top: 7px;
	width: 48px;
	height: 48px;
}

.header-for-mobile-download-link,
                    .header-for-mobile-download-link:active,
                    .header-for-mobile-download-link:visited,
                    .header-for-mobile-download-link:hover {
	display: block;
	padding: 0 10px 0 16px;
	text-decoration: none;
}

.header-for-mobile-title {
	display: block;
	font-size: 18px;
	color: #000;
	padding: 12px 0 8px;
	margin-left: 58px;
}

.header-for-mobile-meta {
	display: block;
	font-size: 12px;
	color: #666;
	padding: 0 0 12px;
	margin-left: 58px;
}

@media (max-width: 480px) {
	.header-for-mobile {
		display: block;
	}

	.footer {
		display: block;
	}
}

.bottom-recommend-title {
	display: block;
	position: relative;
	top: -8px;
	height: 22px;
	width: 64px;
	margin: 0 auto;
	background: #fff;
	text-align: center;
	font-size: 10px;
	color: #666;
}

.bottom-recommend {
	background: #f0f0f0;
	padding-left: 0;
	padding-right: 0;
	margin: 0px 18px 24px 18px;
}

.bottom-recommend a {
	margin-top: 0;
	padding-top: 0;
	display: block;
	border-top: none;
	background: #f0f0f0;
	font-size: 15px;
}

.bottom-recommend .bottom-recommend-download-link, .bottom-recommend .bottom-recommend-download-link:hover,
                    .bottom-recommend .bottom-recommend-download-link:active,
                    .bottom-recommend .bottom-recommend-download-link:visited {
	margin-top: 15px;
	display: block;
	border-radius: 2px;
	height: 35px;
	line-height: 35px;
	font-size: 15px;
	background-color: #00b7f5;
	text-align: center;
	color: #fff;
	text-decoration: none;
}

.bottom-wrap {
	background: #fff;
}

.night .comment-label {
	color: #b8b8b8;
	border-top: 1px solid #303030;
	border-bottom: 1px solid #303030;
}

.night .comment-item {
	color: #7f7f7f;
	border-bottom: 1px solid #303030;
}

.night .headline {
	border-bottom: 4px solid #303030;
}

.night img {
	-webkit-mask-image: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(0, 0, 0, 0.7)), to(rgba(0, 0, 0, 0.7)));
}

body.night,
.night .content-wrap {
	background: #343434;
}

.night .answer + .answer {
	border-top: 2px solid #303030;
}

.night .question + .question {
	border-top: 4px solid #303030;
}

.night .view-more a {
	background: #292929;
	color: #666;
}

.night .icon-arrow-right {
	background-image: url(http://static.daily.zhihu.com/img/share-icons.png);
	background-repeat: no-repeat;
	display: inline-block;
	vertical-align: middle;
	background-position: -70px -35px;
	width: 10px;
	height: 15px;
}

.night blockquote,
.night sup {
	border-left: 3px solid #666;
}

.night .content a {
	color: #698ebf;
}

.night .from-column {
	color: #2b82ac;
	background-image: url(http://static.daily.zhihu.com/img/Dark_News_Column_Entrance.png);
}

.night .from-column:active {
	background-image: url(http://static.daily.zhihu.com/img/Dark_News_Column_Entrance_Highlight.png);
}

.night .comment-meta .author,
.night .content,
.night .meta .author,
.highlight .go {
	color: #888;
}

.night .headline-title,
.night .headline-background .heading-content,
.night .question-title {
	color: #B8B8B8;
}

.night .origin-source-wrap {
	background: #292929;
}

.night .origin-source-wrap .focus-link {
	color: #116f9e;
}

.night .origin-source-wrap .btn-label {
	border-left: solid 1px #3f3f3f;
}

.night .origin-source,
.night .origin-source.with-link {
	background: #292929;
	color: #666;
}

.night .origin-source .text,
.night .origin-source.with-link .text {
	color: #666;
}

.night .origin-source.with-link:after {
	border-color: transparent transparent transparent #292929;
}

.night .origin-source.with-link:before {
	border-color: transparent transparent transparent #666;
}

.night .bottom-recommend a {
	background: #292929;
}

.night .bottom-recommend .recommend-link-title {
	color: #888888;
}
              </style>''';
}
