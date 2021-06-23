// ==UserScript==
// @name Frodo Lecturesession
// @namespace http://tampermonkey.net/
// @version 0.1
// @description Frodo
// @author Ashley
// @match https://fellowship.hackbrightacademy.com/admin/curriculum/lecturesession/*
// @match https://fellowship.hackbrightacademy.com/admin/curriculum/lecturesession
// @grant none
// @run-at document-body
// ==/UserScript==

(() => {
  document.querySelector('body').insertAdjacentHTML('beforeend', `
    <style>
      #ashtoolswhoo {
        font-size: 11px;
        background: #505050;
        position: fixed;
        top: 30%;
        display: flex;
        flex-direction: column;
        padding: 0.25em;
        color: white;
      }
      #ashtoolswhoo * {
        font-size: inherit !important;
      }
      #ashtoolswhoo section {
        display: flex;
        width: 187px;
      }
      .hidden {
        /* margin-left: 100vw; */
      }
      #pullout {
        font-size: 6px;
      }
    </style>
    <div id="ashtoolswhoo" class="hidden">
      <span id="pullout">Open tools</span>
      <div id="atools-lec_config">
        <section id="atools-am_config">
          <div>
            <label name="atools-am_lec_start">Lec start</label>
            <input type="text" id="atools-am_lec_start">
          </div>
          <div>
            <label name="atools-am_lec_end">Lec end</label>
            <input type="text" id="atools-am_lec_end">
          </div>
        </section>
        <section id="atools-pm_config">
          <div>
            <label name="atools-pm_lec_start">Lec start</label>
            <input type="text" id="atools-pm_lec_start">
          </div>
          <div>
            <label name="atools-pm_lec_end">Lec end</label>
            <input type="text" id="atools-pm_lec_end">
          </div>
        </section>
      </div>
    </div>
  `);
})();
