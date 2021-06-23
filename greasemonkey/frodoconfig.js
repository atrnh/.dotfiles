// ==UserScript==
// @name Frodo Lecturesession
// @namespace http://tampermonkey.net/
// @version 0.1
// @description Frodo
// @author Ashley
// @match https://fellowship.hackbrightacademy.com/admin/curriculum/lecturesession/*
// @match https://fellowship.hackbrightacademy.com/admin/curriculum/lecturesession
// @grant GM_getValue
// @grant GM_setValue
// @run-at document-body
// ==/UserScript==

(() => {
  const b = document.querySelector('body');
  b.insertAdjacentHTML('beforeend', `
    <style>
      #ashtoolswhoo {
        font-size: 11px;
        background: #505050;
        position: fixed;
        top: 30%;
        display: flex;
        padding: 0.25em;
        color: white;
        text-transform: uppercase;
        font-family: 'Public Sans';
        font-weight: 700;
        transition: margin-left 0.5s ease;
      }
      #ashtoolswhoo * {
        font-size: inherit;
        font-family: inherit;
      }
      #ashtoolswhoo section {
        display: flex;
        padding: 0.25em 0.25em 0.3em;
      }
      .hidden {
        margin-left: 98%;
      }
      .show {
        margin-left: 360px;
      }
      #pullout {
        letter-spacing: normal;
        justify-content: center;
        align-items: center;
        display: flex;
      }
    </style>
  `);
  const root = document.createElement('div');
  root.setAttribute('id', 'ashtoolswhoo')
  root.setAttribute('class', 'hidden');

  const pullout = document.createElement('span');
  pullout.setAttribute('id', 'pullout');
  pullout.innerText = '👆';
  pullout.addEventListener('click', () => {
    root.setAttribute(
      'class',
      root.getAttribute('class') === 'hidden' ? 'show' : 'hidden'
    );

    const inputs = root.querySelectorAll('input');
    if (inputs) {
      for (const el of inputs) {
        const key = el.getAttribute('id').split('-')[1];
        console.log(key);
        el.setAttribute('value', GM_getValue(key, ''));
      }
    }
  });

  root.append(pullout);

  const amConfigVals = [
    {
      key: 'am_lec_start',
      value: 'am_lec_start'
    },
    {
      key: 'am_lec_end',
      value: 'am_lec_end'
    }
  ];

  root.insertAdjacentHTML('beforeend', `
    <div id="atools-lec_config">
      <section id="atools-am_config">
        <div>
          <label name="atools-am_lec_start">AM start</label>
          <input type="text" id="atools-am_lec_start" value="${GM_getValue('am_lec_start', '')}">
        </div>
        <div>
          <label name="atools-am_lec_end">AM end</label>
          <input type="text" id="atools-am_lec_end" value="${GM_getValue('am_lec_end', '')}">
        </div>
      </section>
      <section id="atools-pm_config">
        <div>
          <label name="atools-pm_lec_start">PM start</label>
          <input type="text" id="atools-pm_lec_start" value="${GM_getValue('pm_lec_start', '')}">
        </div>
        <div>
          <label name="atools-pm_lec_end">PM end</label>
          <input type="text" id="atools-pm_lec_end" value="${GM_getValue('pm_lec_end', '')}">
        </div>
      </section>
    </div>
  `);

  root.querySelector('input').addEventListener('change', (e) => {
    const key = e.target.getAttribute('id').split('-')[1];
    GM_setValue(key, e.target.value);
  });

  b.append(root);
})();
