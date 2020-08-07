// ==UserScript==
// @name Frodo time
// @namespace http://tampermonkey.net/
// @version 0.1
// @description Frodo
// @author Ashley
// @match https://fellowship.hackbrightacademy.com/admin/*/*/add/
// @grant none
// @run-at document-end
// ==/UserScript==

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
