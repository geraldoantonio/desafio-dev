// Entry point for the build script in your package.json
import "bootstrap";
import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery
import DataTable from 'datatables.net-bs5';

$(document).ready(function () {
  $('#transactions').DataTable();
});