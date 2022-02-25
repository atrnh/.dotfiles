// ==UserScript==
// @name FRODO Admin MAIN
// @namespace http://tampermonkey.net/
// @version 0.1
// @description FRODO Admin global scripts
// @author Ashley
// @include https://fellowship.hackbrightacademy.com/admin/*
// @grant GM_getValue
// @grant GM_setValue
// @run-at document-end
// @require https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js
// ==/UserScript==

const configInputAttrs = {
  cohort: { type: "text", id: "fes-config-cohort" },
  stDate: { type: "text", id: "fes-config-start-date" },

  lecStAM: { type: "text", id: "fes-config-lec-start-am" },
  lecEdAM: { type: "text", id: "fes-config-lec-end-am" },
  lecStPM: { type: "text", id: "fes-config-lec-start-pm" },
  lecEdPM: { type: "text", id: "fes-config-lec-end-pm" },

  exStAM: { type: "text", id: "fes-config-ex-start-am" },
  exEdAM: { type: "text", id: "fes-config-ex-end-am" },
  exStPM: { type: "text", id: "fes-config-ex-start-pm" },
  exEdPM: { type: "text", id: "fes-config-ex-end-pm" },

  dri: { type: "text", id: "fes-config-dri" },
};

/* CUSTOM ELEMENTS */
(function customElements() {
  class FESConfigInput extends HTMLInputElement {
    constructor() {
      self = super();
      self.value = self.getGMValue();

      self.onchange = self.handleChange;
    }

    connectedCallback() {
      this.value = this.getGMValue();
    }

    handleChange(e) {
      e.target.setGMValue();
    }

    setGMValue() {
      return GM_setValue(this.getAttribute("name"), this.value);
    }

    getGMValue() {
      return GM_getValue(this.getAttribute("name"), "");
    }
  }

  customElements.define("fes-config-input", FESConfigInput, {
    extends: "input",
  });

  class GMConfig extends HTMLElement {
    constructor() {
      self = super();

      const configSpec = JSON.parse(self.getAttribute("data-spec"));
      // { gmkey: {type: text, label: Cohort ID}}

      const wrapper = document.createElement("div");
      wrapper.classList.add("fes-config");
      wrapper.style.display = "flex";
      wrapper.style.flexWrap = "wrap";
      wrapper.style.background = "rgba(0, 0, 0, 0.8)";

      const openBtn = wrapper.appendChild(document.createElement("button"));
      openBtn.innerText = "open";
      openBtn.onclick = function openconfig(e) {
        e.target.nextElementSibling.style.display = null;
      };

      const wrapper2 = wrapper.appendChild(document.createElement("div"));
      wrapper2.style.display = "none";
      for (const GMkey in configSpec) {
        const inptWrapper = wrapper2.appendChild(document.createElement("div"));

        const { typ, labelText } = configSpec[GMkey];

        const label = inptWrapper.append(document.createElement("label"));
        label.setAttribute("for", GMkey);
        label.innerText = labelText;
        label.style.fontSize = "10px";
        label.style.fontWeight = "600";
        label.style.display = "block";

        const inpt = inptWrapper.append(
          document.createElement("input", { is: "fes-config-input" })
        );
        inpt.setAttribute("name", GMkey);
        inpt.setAttribute("type", typ);
      }

      const closeBtn = wrapper2.appendChild(document.createElement("button"));
      closeBtn.innerText = "close";
      closeBtn.onclick = function (e) {
        e.target.parent.style.display = "none";
      };
    }
  }
})();
