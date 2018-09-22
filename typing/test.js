!(function(d, w) {
  function _stillMatch(xs, ys) {
    for (i = 0; i < ys.length; i++) {
      if (xs[i] !== ys[i]) return false;
    }
    return true;
  }
  function _obj(xs) {
    return xs.reduce(function(acc, x, i) {
      acc[x] = x;
      return acc;
    }, {});
  }

  d.addEventListener("DOMContentLoaded", function() {
    function render(node, model) {
      while (node.children.length > 0) {
        node.children[0].remove();
      }
      node.appendChild(view(model));
    }

    var validKeys = _obj([32, 173, 190, 191, 188, 219, 220, 221, 222]);

    // Model

    w.model = {
      sample: d.querySelectorAll("p")[1].innerText,
      input: "",
      completed: false,
      stillMatch: true,
      startTime: 0,
      wpm: 0,
      time: 0
    };

    // Initialize

    var app = d.querySelector("#app");
    if (!app) return;
    render(app, w.model);

    d.addEventListener("keydown", function(e) {
      if (w.model.completed) {
        if (e.keyCode in _obj([27, 13])) {
          w.model = update(w.model, "reset");
        }
      } else {
        switch (e.keyCode) {
          case 8:
            w.model = update(w.model, "delete");
            break;
          default:
            if ((e.keyCode > 47 && e.keyCode < 91) || e.keyCode in validKeys) {
              e.preventDefault();
              w.model = update(w.model, "add", e.key);
            }
        }
      }
      render(app, w.model);
    });

    // Update

    function updateCounters(model, input) {
      var words = input.length > 1 ? input.split(" ").length : 0;
      var time = model.startTime ? new Date() - model.startTime : 0;
      var mins = model.time > 0 ? model.time / 1000 / 60 : 0;
      var wpm = words > mins ? Math.round(words / mins) : 0;
      if (input.length < 2) {
        return {
          wpm: 0,
          startTime: new Date(),
          time: 0
        };
      } else {
        return {
          wpm: wpm,
          startTime: model.startTime,
          time: time
        };
      }
    }

    function update(model, cmd, value) {
      switch (cmd) {
        case "reset":
          return {
            sample: model.sample,
            input: "",
            completed: false,
            stillMatch: true,
            startTime: model.startTime,
            wpm: 0,
            time: 0
          };

        case "add":
          var input = model.input + value;
          var n = updateCounters(model, input);

          return {
            sample: model.sample,
            input: input,
            completed: model.sample === input,
            stillMatch: _stillMatch(model.sample, input),
            wpm: n.wpm,
            startTime: n.startTime,
            time: n.time
          };
          break;

        case "delete":
          var input = model.input.slice(0, model.input.length - 1);
          var n = updateCounters(model, input);
          return {
            sample: model.sample,
            input: input,
            completed: model.sample === input,
            stillMatch: _stillMatch(model.sample, input),
            wpm: n.wpm,
            startTime: n.startTime,
            time: n.time
          };

        default:
          return model;
      }
    }

    // View

    function view(model) {
      var fragment = document.createDocumentFragment();

      var input = document.createElement("span");
      input.textContent = model.input;

      input.setAttribute(
        "style",
        (model.completed ? "" : "border-right: 1px solid black;") +
          "padding-bottom: 3px;" +
          "line-height: 44px;" +
          "white-space: pre-wrap;" +
          "color: " +
          (model.stillMatch
            ? model.completed
              ? "#cccccc;"
              : "#444444;"
            : "#cc0000;") +
          "border-bottom: 1px solid " +
          (model.stillMatch
            ? model.completed
              ? "#cccccc;"
              : "#444444;"
            : "#cc0000;") +
          ";" +
          ";"
      );

      var p = document.createElement("p");
      p.appendChild(input);
      fragment.appendChild(input);

      var wpm = document.createElement("p");
      wpm.setAttribute(
        "style",
        "font-size: 36px;" +
          "color: " +
          (model.completed ? "#444444;" : "#cccccc;")
      );
      wpm.textContent = model.wpm + " wpm";
      fragment.appendChild(wpm);

      return fragment;
    }
  });
})(document, window);
