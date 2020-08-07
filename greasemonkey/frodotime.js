// ==UserScript==
// @name Frodo time
// @namespace frodo.hackbrightacademy.com
// @run-at document-end
// @include https://fellowship.hackbrightacademy.com/admin/*/*/change
// @include http://prep.hackbrightacademy.com/admin/*/*/change
// @include https://fellowship.hackbrightacademy.com/admin/*/add
// @include http://prep.hackbrightacademy.com/admin/*/add
// @include https://fellowship.hackbrightacademy.com/admin/*/*/add
// @include http://prep.hackbrightacademy.com/admin/*/*/add
// @include https://fellowship.hackbrightacademy.com/admin/*/*/*/change
// @include http://prep.hackbrightacademy.com/admin/*/*/*/change

(() => {
  Array.from(
    document.querySelectorAll('div.field-start_at p.datetime input')
  ).forEach((el) => {
    el.addEventListener('change', (e) => {
      const [stEl, val] = [e.target, e.target.value];

      // Get #id of field from its name so we can get matching end_at
      const fieldId = Number(Array.from(stEl.getAttribute('name'))
        .filter(ch => !isNaN(Number(ch)))
        .join(''));

      document.querySelector(`#id_end_at_${fieldId}`)
        .setAttribute('value', val);
    });
  });
})();
