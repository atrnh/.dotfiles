// ==UserScript==
// @name         fb.hackbrightacademy.com
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Scripts to improve Survey Porcupine
// @author       Ashley Trinh
// @match        http://fb.hackbrightacademy.com/admin/*
// @run-at document-body
// @require https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js
// ==/UserScript==

(() => {
  "use strict";

  const addElement = (parent, tagname, attributes, position) => {
    const element = document.createElement(tagname);

    Object.entries(attributes).forEach(([key, val]) => {
      if (val === null) {
        element.removeAttribute(key);
      } else if (element[key] !== undefined) {
        element[key] = val;
      } else if (key === "classNames") {
        val.forEach((clsname) => {
          element.classList.add(clsname);
        });
      } else {
        element.setAttribute(key, val);
      }
    });

    parent.insertAdjacentElement(position, element);

    return element;
  };

  const prependElement = (parent, tagname, attributes) =>
    addElement(parent, tagname, attributes, "afterbegin");

  const appendElement = (parent, tagname, attributes) =>
    addElement(parent, tagname, attributes, "beforeend");

  (function createToolbar() {
    const content = document.querySelector("#content");
    prependElement(content, "style", {
      innerText: `
      body {
        font-family: "IBM Plex Mono" !important;
      }

      .ashley {
        font-size: 16px !important;
      }
      `,
    });

    const toolbar = prependElement(content.querySelector(".navbar"), "div", {
      classNames: ["ashley"],
    });

    const viewSurveysButton = appendElement(toolbar, "a", {
      innerText: "View Surveys",
      href: "/admin/feedback/survey/",
    });

    content.querySelector(".navbar-inner").style.display = "none";
  })();

  const parseFieldnameFromClass = (el) => {
    let fieldClass;
    for (const className of el.getAttribute("class").split(" ")) {
      if (className.includes("field-")) {
        fieldClass = className;
      }
    }

    if (!fieldClass) {
      return;
    }

    const [prefix, fieldName] = fieldClass.split("-");

    return fieldName;
  };

  const removeDateCruft = (text) =>
    text
      .split(",")
      .map((raw) => raw.trim())
      .slice(0, 2)
      .join(", ");

  const parseDateStr = (datestr) =>
    moment(removeDateCruft(datestr.trim()), "MMMM D, YYYY");

  const fieldHandlers = {
    results: (el) => el.querySelector("a").getAttribute("href"),
    name: (el) => el.querySelector("a").innerText.trim(),
    site: (el) => el.innerText.trim(),
    open_at: (el) => parseDateStr(el.innerText.trim()),
    close_at: (el) => parseDateStr(el.innerText.trim()),
    num_responses: (el) => el.innerText.match(/\d+/)[0],
  };

  const serializeTable = (tableEl) => {
    return Array.from(tableEl.querySelectorAll("tr"))
      .filter(
        (tr) =>
          tr.getAttribute("class") && tr.getAttribute("class").includes("row")
      )
      .map((tr) => Array.from(tr.children))
      .map((row) =>
        row.reduce((obj, td) => {
          const fieldname = parseFieldnameFromClass(td);

          if (fieldname) {
            obj[fieldname] =
              fieldHandlers[fieldname] && fieldHandlers[fieldname](td);
          }

          return obj;
        }, {})
      );
  };

  (function showTodayResults() {
    const here = new URL(document.location);
    if (!here.pathname.includes("feedback/survey")) {
      return;
    }

    // Hide useless crap
    document.querySelector("#changelist-form").style.display = "none";

    const tableEl = document.querySelector("table");
    const tableData = serializeTable(tableEl);

    const todaySurveys = tableData.filter((data) => {
      return data.close_at.isSameOrAfter(moment(), "day");
    });

    console.log(todaySurveys);

    appendElement(content, "h1", { innerText: "Today's Surveys" });

    const iframes = todaySurveys.map((survey) => {
      const cohortName = survey.site.split(".")[0];

      const container = appendElement(content, "div", {
        classNames: ["ashley-survey-container", "ashley"],
        innerHTML: `
          <span class="subtitle" style="display: inline-block; margin-top: 1em;">${cohortName}</span>
          <h2 style="margin-top: 0;">${survey.name}</h2>
        `,
      });

      return appendElement(container, "iframe", {
        src: survey.results,
        width: "100%",
        height: "400px",
      });
    });

    const applyIframeStyle = (iframe) => {
      const idoc = iframe.contentDocument;

      // Remove padding on body
      idoc.querySelector("body").style.padding = "0";
      // Hide everything except div#content
      Array.from(idoc.querySelector(".container").children).forEach((child) => {
        if (child.getAttribute("id") !== "content") {
          child.style.display = "none";
        }
      });

      idoc.querySelector("#content .navbar").style.display = "none";

      idoc.querySelectorAll("#content h2").forEach((heading) => {
        heading.style.fontSize = "1.3em";
        heading.style.fontFamily = "IBM Plex Mono";
      });

      const css = `

      `;
    };

    iframes.forEach((iframe) => {
      // applyIframeStyle(iframe);
      iframe.addEventListener("load", (evt) => applyIframeStyle(evt.target));
    });

    // TODO display results from today
    // appendElement(content, "pre", {
    //   innerText: resultsFromToday
    //     .map((res) => JSON.stringify(res))
    //     .map((json) => json.split(",").join(",\n  "))
    //     .join("\n\n\n"),
    // });
  })();
})();
