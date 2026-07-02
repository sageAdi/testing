(function () {
  "use strict";

  var storageKey = "feedbackCollector.entries";
  var form = document.querySelector("[data-testid='feedback-form']");
  var nameInput = document.querySelector("[data-testid='name-input']");
  var emailInput = document.querySelector("[data-testid='email-input']");
  var messageInput = document.querySelector("[data-testid='message-input']");
  var characterCount = document.querySelector("[data-testid='character-count']");
  var statusMessage = document.querySelector("[data-testid='status-message']");
  var feedbackList = document.querySelector("[data-testid='feedback-list']");
  var feedbackCount = document.querySelector("[data-testid='feedback-count']");
  var emptyState = document.querySelector("[data-testid='empty-state']");
  var clearAllButton = document.querySelector("[data-testid='clear-all-button']");
  var errors = {
    email: document.querySelector("[data-testid='email-error']"),
    rating: document.querySelector("[data-testid='rating-error']"),
    message: document.querySelector("[data-testid='message-error']")
  };

  var entries = loadEntries();

  function loadEntries() {
    try {
      var stored = window.localStorage.getItem(storageKey);
      if (!stored) {
        return [];
      }

      var parsed = JSON.parse(stored);
      return Array.isArray(parsed) ? parsed : [];
    } catch (error) {
      showStatus("Saved feedback could not be loaded.", true);
      return [];
    }
  }

  function saveEntries() {
    try {
      window.localStorage.setItem(storageKey, JSON.stringify(entries));
      return true;
    } catch (error) {
      showStatus("Feedback could not be saved in this browser.", true);
      return false;
    }
  }

  function getSelectedRating() {
    var selected = form.querySelector("input[name='rating']:checked");
    return selected ? selected.value : "";
  }

  function isValidEmail(value) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
  }

  function setError(field, message) {
    errors[field].textContent = message;
  }

  function clearErrors() {
    setError("email", "");
    setError("rating", "");
    setError("message", "");
    emailInput.classList.remove("input-error");
    messageInput.classList.remove("input-error");
  }

  function validateForm() {
    var valid = true;
    var email = emailInput.value.trim();
    var message = messageInput.value.trim();

    clearErrors();

    if (email && !isValidEmail(email)) {
      setError("email", "Enter a valid email address or leave it blank.");
      emailInput.classList.add("input-error");
      valid = false;
    }

    if (!getSelectedRating()) {
      setError("rating", "Choose a rating.");
      valid = false;
    }

    if (!message) {
      setError("message", "Enter feedback before saving.");
      messageInput.classList.add("input-error");
      valid = false;
    }

    return valid;
  }

  function showStatus(message, isError) {
    statusMessage.textContent = message;
    statusMessage.classList.toggle("error", Boolean(isError));
  }

  function updateCharacterCount() {
    characterCount.textContent = String(messageInput.value.length) + "/500";
  }

  function formatDate(value) {
    return new Intl.DateTimeFormat(undefined, {
      dateStyle: "medium",
      timeStyle: "short"
    }).format(new Date(value));
  }

  function createTextElement(tagName, className, text) {
    var element = document.createElement(tagName);
    element.className = className;
    element.textContent = text;
    return element;
  }

  function renderEntries() {
    feedbackList.textContent = "";

    var count = entries.length;
    feedbackCount.textContent = count === 1 ? "1 entry" : String(count) + " entries";
    emptyState.hidden = count > 0;
    clearAllButton.disabled = count === 0;

    entries.forEach(function (entry) {
      var item = document.createElement("li");
      item.className = "feedback-item";
      item.dataset.entryId = entry.id;

      var header = document.createElement("div");
      header.className = "feedback-item-header";

      var meta = document.createElement("div");
      meta.className = "feedback-meta";
      meta.appendChild(createTextElement("span", "feedback-name", entry.name || "Anonymous"));

      if (entry.email) {
        meta.appendChild(createTextElement("span", "feedback-email", entry.email));
      }

      meta.appendChild(createTextElement("span", "feedback-date", formatDate(entry.createdAt)));

      var rating = createTextElement("span", "feedback-rating", entry.rating + "/5");
      header.appendChild(meta);
      header.appendChild(rating);

      var message = createTextElement("p", "feedback-message", entry.message);
      var deleteButton = document.createElement("button");
      deleteButton.type = "button";
      deleteButton.className = "danger-button";
      deleteButton.textContent = "Delete";
      deleteButton.dataset.action = "delete";
      deleteButton.dataset.entryId = entry.id;
      deleteButton.setAttribute("aria-label", "Delete feedback from " + (entry.name || "Anonymous"));

      item.appendChild(header);
      item.appendChild(message);
      item.appendChild(deleteButton);
      feedbackList.appendChild(item);
    });
  }

  function resetForm() {
    form.reset();
    updateCharacterCount();
    clearErrors();
  }

  form.addEventListener("submit", function (event) {
    event.preventDefault();
    showStatus("", false);

    if (!validateForm()) {
      showStatus("Fix the highlighted fields.", true);
      return;
    }

    var entry = {
      id: String(Date.now()) + "-" + Math.random().toString(16).slice(2),
      name: nameInput.value.trim(),
      email: emailInput.value.trim(),
      rating: getSelectedRating(),
      message: messageInput.value.trim(),
      createdAt: new Date().toISOString()
    };

    entries.unshift(entry);

    if (!saveEntries()) {
      entries.shift();
      renderEntries();
      return;
    }

    resetForm();
    renderEntries();
    showStatus("Feedback saved.", false);
  });

  messageInput.addEventListener("input", updateCharacterCount);

  emailInput.addEventListener("input", function () {
    if (emailInput.value.trim() === "" || isValidEmail(emailInput.value.trim())) {
      setError("email", "");
      emailInput.classList.remove("input-error");
    }
  });

  messageInput.addEventListener("input", function () {
    if (messageInput.value.trim()) {
      setError("message", "");
      messageInput.classList.remove("input-error");
    }
  });

  form.addEventListener("change", function (event) {
    if (event.target.name === "rating") {
      setError("rating", "");
    }
  });

  feedbackList.addEventListener("click", function (event) {
    var target = event.target;
    if (!(target instanceof HTMLButtonElement) || target.dataset.action !== "delete") {
      return;
    }

    entries = entries.filter(function (entry) {
      return entry.id !== target.dataset.entryId;
    });

    if (saveEntries()) {
      renderEntries();
      showStatus("Feedback deleted.", false);
    }
  });

  clearAllButton.addEventListener("click", function () {
    if (entries.length === 0) {
      return;
    }

    entries = [];
    if (saveEntries()) {
      renderEntries();
      showStatus("All feedback cleared.", false);
    }
  });

  updateCharacterCount();
  renderEntries();
})();
