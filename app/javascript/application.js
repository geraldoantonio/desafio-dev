// Entry point for the build script in your package.json
import "bootstrap";
import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery
import DataTable from 'datatables.net-bs5';
import 'datatables.net-plugins/api/sum().mjs';

$(document).ready(function () {
  $('#transactions').DataTable({
    footerCallback: function(row, data, start, end, display) {
      var api = this.api();
      var column = api.column(4, { page: 'current' });

      var sum = column.data().reduce(function(acc, value) {
        return acc + parseFloat(value);
      }, 0);

      var amount = Intl.NumberFormat('pt-BR', {style: 'currency', currency: 'BRL'}).format(sum);

      $(row).find('th:eq(2)').text(amount);
    }
  });
});

