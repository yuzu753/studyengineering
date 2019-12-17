// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all

//= popper
//= require bootstrap-sprockets
//= require activestorage
//= require_tree .
//= require chartkick
//= require Chart.bundle
//= require data-confirm-modal

//非同期時のフラッシュメッセージ再読み込み時に消すための機能
$(function(){
  setTimeout("$('.remove').hide()", 0)
})

//フラッシュメッセージのフェードアウト用の記述
$(function(){
  setTimeout("$('.fadeout').fadeOut('slow')", 3000)
})

