// ==UserScript==
// @name FRODO Enhancement - Admin Config
// @namespace http://tampermonkey.net/
// @version 0.1
// @description Configuration dashboard
// @author Ashley
// @include https://fellowship.hackbrightacademy.com/admin/*
// @grant GM_getValue
// @grant GM_setValue
// @run-at document-end
// @require https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js
// ==/UserScript==

(() => {
  const createInput = ({ type, id, labelText }) => {
    const container = document.createElement("div");
    container.classList.add("fes-config-input-container");

    const label = document.createElement("label");
    label.setAttribute("for", id);
    label.innerText = labelText || id;
    container.append(label);

    const el = document.createElement("input");
    el.setAttribute("type", type);
    el.setAttribute("id", id);
    container.append(el);

    return container;
  };

  const createRow = () => {
    const el = document.createElement("div");
    el.classList.add("fes-row");
    return el;
  };

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

  const configInputs = {};
  Object.entries(configInputAttrs).map(([key, attrs]) => {
    configInputs[key] = createInput(attrs);
  });

  const initInputVal = (key, el) =>
    el?.setAttribute("value", GM_getValue(key, ""));
  const updateInputVal = (key, el) => GM_setValue(key, el?.value);

  Object.entries(configInputs).forEach(([key, el]) => {
    const input = el.querySelector("input");
    if (!input) {
      return;
    }

    input.addEventListener("change", () => {
      updateInputVal(key, input);
    });
  });

  const updateValues = () => {
    Object.entries(configInputs).forEach(([key, el]) => {
      const input = el.querySelector("input");
      if (!input) {
        return;
      }

      initInputVal(key, input);
    });
  };

  const rows = [
    [configInputs.cohort],
    [configInputs.stDate, configInputs.dri],
    [configInputs.lecStAM, configInputs.lecEdAM],
    [configInputs.exStAM, configInputs.exEdAM],
    [configInputs.lecStPM, configInputs.lecEdPM],
    [configInputs.exStPM, configInputs.exEdPM],
  ];
  const configRoot = document.createElement("div");
  configRoot.setAttribute("id", "fes-config");

  const rowsContainer = document.createElement("div");
  rowsContainer.setAttribute("id", "fes-config-rows");

  rows.forEach((row) => {
    const rowEl = createRow();
    for (const inputEl of row) {
      rowEl.append(inputEl);
    }

    rowsContainer.append(rowEl);
  });

  const closeConfig = document.createElement("button");
  closeConfig.setAttribute("id", "fes-close-config");
  closeConfig.innerText = "close";

  const openConfig = document.createElement("button");
  openConfig.setAttribute("id", "fes-open-config");
  openConfig.innerText = "open";

  closeConfig.addEventListener("click", () => {
    rowsContainer.style.display = "none";
    openConfig.style.display = null;
  });

  openConfig.addEventListener("click", () => {
    updateValues();

    rowsContainer.style.display = null;
    openConfig.style.display = "none";
  });

  rowsContainer.append(closeConfig);
  configRoot.append(openConfig);
  configRoot.append(rowsContainer);
  document.querySelector("body").append(configRoot);

  rowsContainer.style.display = "none";
  updateValues();

  const getFieldID = (name) =>
    Array.from(name.split("-").slice(-1)[0])
      .filter((ch) => !isNaN(Number(ch)))
      .join("");

  const setStartEndKey = (el, prefix) => {
    const url = document.URL;

    let type;
    if (url.includes("lecture")) {
      type = "lec";
    } else if (url.includes("exercise")) {
      type = "ex";
    }
    el.setAttribute("data-start-key", `${type}St${prefix}`);
    el.setAttribute("data-end-key", `${type}Ed${prefix}`);
  };

  const createTimeShortcuts = (timeInput) => {
    const setStartEndTime = (startInput, startKey, endKey) => {
      startInput.setAttribute("value", GM_getValue(startKey));
      console.log(`GET ${startKey}: ${GM_getValue(startKey)}`);

      const htmlID = startInput.getAttribute("id");
      const parts = htmlID.split("-");

      const index = getFieldID(parts.pop() || htmlID);

      const endid = parts.concat(`end_at_${index}`).join("-");
      const endel = document.querySelector(`#${endid}`);

      endel.value = GM_getValue(endKey);
      console.log(`GET ${endKey}: ${GM_getValue(endKey)}`);
    };

    const setAMButton = document.createElement("button");
    setAMButton.innerText = "Set AM";

    setStartEndKey(setAMButton, "AM");
    const setPMButton = document.createElement("button");
    setPMButton.innerText = "Set PM";
    setStartEndKey(setPMButton, "PM");

    [setPMButton, setAMButton].forEach((el) => {
      el.addEventListener("click", (e) => {
        e.preventDefault();
        e.stopPropagation();
        setStartEndTime(
          timeInput,
          e.target.getAttribute("data-start-key"),
          e.target.getAttribute("data-end-key")
        );
      });
      el.classList.add("fes-link-button");

      timeInput?.insertAdjacentElement("afterend", el);
    });
  };

  const syncStartEndFields = (root) => {
    const starts = root.querySelectorAll('.vDateField[id*="-start_at_"]');

    starts.forEach((el) => {
      console.log(el);

      el.addEventListener("change", (e) => {
        console.log("hi");
        const htmlID = el.getAttribute("id");
        const parts = htmlID.split("-");
        console.log(parts);

        const index = getFieldID(parts.pop() || htmlID);

        const endid = parts.concat(`end_at_${index}`).join("-");
        const end = document.querySelector(`#${endid}`);
        end.value = el.target.value;
      });
    });
  };

  const createDateShortcut = (dateinput) => {
    const fesDateinput = document.createElement("input");
    const dayLookup = {
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
    };
    const getStdate = () =>
      moment(
        GM_getValue("stDate") ? new Date(GM_getValue("stDate")) : new Date()
      );

    fesDateinput.addEventListener("change", (e) => {
      const [weeknum, day] = e.target.value.split(" ");

      const date = getStdate()
        .add(Number(weeknum) - 1, "w")
        .day(Number(dayLookup[day]))
        .format("YYYY-MM-DD");

      dateinput.value = date;

      const htmlID = dateinput.getAttribute("id");
      const parts = htmlID.split("-");
      console.log(parts);

      const index = getFieldID(parts.pop() || htmlID);

      const endid = parts.concat(`end_at_${index}`).join("-");
      const end = document.querySelector(`#${endid}`);
      end.value = date;
    });
    dateinput.insertAdjacentElement("beforebegin", fesDateinput);
    dateinput.style.display = "none";
  };

  const createDTShortcuts = (root) => {
    const dateinputs = root.querySelectorAll(
      ".field-start_at p.datetime input.vDateField"
    );
    dateinputs.forEach((el) => {
      createDateShortcut(el);
    });
    const timeInputs = root.querySelectorAll(
      ".field-start_at p.datetime input.vTimeField"
    );
    timeInputs.forEach((el) => {
      createTimeShortcuts(el);
    });
    syncStartEndFields(root);
  };

  createDTShortcuts(document);
  document.querySelectorAll(".add-row a").forEach((el) => {
    el.addEventListener("click", (e) => {
      const row = el.parentElement.parentElement.previousElementSibling;

      createDTShortcuts(row);
      syncStartEndFields(row);
    });
  });

  const cohortID = GM_getValue("cohort");
  const cohortSelect = document.querySelector('select[name="cohort"]');
  if (cohortID && cohortSelect) {
    cohortSelect.value = cohortID;
    document.querySelector(`option[value="${cohortID}"]`).selected = true;
    cohortSelect.style.display = "none";
  }
})();
