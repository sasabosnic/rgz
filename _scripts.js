!(function(d, w) {
  // Helpers are based on Ramda.js (MIT)
  // h/t Scott Sauyet and Michael Hurley

  function _sort(list) {
    return [].slice.call(list, 0).sort(function(a, b) {
      return a - b;
    });
  }

  function _map(fn, functor) {
    var idx = 0;
    var length = functor.length;
    var result = Array(length);
    while (idx < length) {
      result[idx] = fn(functor[idx]);
      idx += 1;
    }
    return result;
  }

  function _flat(list) {
    var value, jlen, j;
    var result = [];
    var idx = 0;
    var length = list.length;
    while (idx < length) {
      value = list[idx];
      j = 0;
      jlength = value.length;
      while (j < jlength) {
        result[result.length] = value[j];
        j += 1;
      }
      idx += 1;
    }
    return result;
  }

  d.addEventListener("DOMContentLoaded", function() {
    function render() {
      if (w.model.slidesOn) {
        w.model.originalScrollY = w.scrollY;
        slidesOn.checked = w.model.slidesOn;
        w.model.offsets = getOffsets();
        body.style.overflow = "hidden";
        toSlide();
      } else {
        slidesOn.checked = w.model.slidesOn;
        w.model.offsets = getOffsets();
        body.style.overflow = "auto";
        w.scrollTo(0, w.model.originalScrollY);
      }
    }

    function getOffsets() {
      return _sort(
        _map(
          function(node) {
            return node.offsetTop;
          },
          _flat(
            _map(
              function(tag) {
                return [].slice.call(
                  d.querySelector(".article").querySelectorAll(tag)
                );
              },
              ["h1", "h2", "table"]
            )
          )
        )
      );
    }

    function toggle() {
      w.model.slidesOn = !w.model.slidesOn;
      render();
    }

    function off() {
      w.model.slidesOn = false;
      render();
    }

    function next() {
      if (w.model.slideId < w.model.offsets.length - 1)
        w.model.slideId = w.model.slideId + 1;
      toSlide();
    }

    function prev() {
      if (w.model.slideId > 0) w.model.slideId = w.model.slideId - 1;
      toSlide();
    }

    function toSlide() {
      w.model.offsets = getOffsets();
      w.scrollTo(0, w.model.offsets[w.model.slideId]);
    }

    // Initialize

    var slidesOn = d.querySelector("#slides-on");
    var body = d.querySelector("body");

    w.model = {
      slideId: 0,
      slidesOn: false,
      originalScrollY: 0,
      offsets: getOffsets()
    };

    render();

    d.addEventListener("keydown", function(e) {
	console.log(e)
      switch (e.keyCode) {
        case 32:
          if (!w.model.slidesOn) return;
          e.preventDefault();
          e.shiftKey ? prev() : next();
          break;
        case 13:
          toggle();
          break;
	case 81:
        case 27:
          off();
          break;
        case 37:
        case 38:
          if (!w.model.slidesOn) return;
          e.preventDefault();
          prev();
          break;
        case 75:
          prev();
          break;
        case 39:
        case 40:
          if (!w.model.slidesOn) return;
          e.preventDefault();
          next();
          break;
        case 74:
          next();
          break;
        case 71:
          w.model.slideId = 0;
          toSlide();
          break;
      }
    });

    w.addEventListener("resize", function() {
      w.model.offsets = getOffsets();
      toSlide();
    });
  });
})(document, window);
