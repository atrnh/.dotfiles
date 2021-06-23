// ==UserScript==
// @name FRODO Enhancement - Django Filterlist
// @namespace http://tampermonkey.net/
// @version 0.1
// @description Fix size of Django Admin filterlist.
// @author Ashley
// @include https://fellowship.hackbrightacademy.com/admin/*
// @run-at document-end
// ==/UserScript==

(() => {
  "use strict";

  const filterlist = document.querySelector("#changelist-filter");

  // Create header using first element of filterlist
  const filterHeader = document.createElement("div");
  filterHeader.setAttribute("id", "fes-changelist-header");

  const newHeader = filterlist.firstElementChild.cloneNode(true);
  filterlist.firstElementChild.remove();
  filterHeader.append(newHeader);

  // Create body and append rest of filterlist.children
  const filterBody = document.createElement("div");
  filterBody.setAttribute("id", "fes-changelist-body");

  for (const el of filterlist.children) {
    const clone = el.cloneNode(true);
    filterBody.append(clone);

    filterlist.remove(el);
  }
  filterBody.style.display = "none";

  filterHeader.addEventListener("click", () => {
    filterBody.style.display = filterBody.style.display ? null : "none";
  });

  const newFilterlistContainer = document.createElement("div");
  newFilterlistContainer.setAttribute("id", "fes-changelist-filter");

  newFilterlistContainer.appendChild(filterHeader);
  newFilterlistContainer.appendChild(filterBody);

  document
    .querySelector("#toolbar")
    .insertAdjacentElement("afterend", newFilterlistContainer);
  filterlist.remove();
})();
