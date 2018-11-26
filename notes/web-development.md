---
#layout: default
layout: page
title: "Web development notes"
tagline: "personal notes on web development in general."
category : notes
tags : [draft, wide]
published: false
---


#### \<form> el. autocomplete attribute

* __ref./spec.:__ [whatwg.org : Autofilling form controls: the autocomplete attribute ¶4.10.18.7](https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#autofilling-form-controls:-the-autocomplete-attribute)
* <https://html.com/attributes/input-autocomplete/>
* <https://cloudfour.com/thinks/autofill-what-web-devs-should-know-but-dont/>


## Maps

* <https://www.npmjs.com/package/google-address-autocomplete>
* <https://github.com/googlemaps/v3-utility-library/tree/master/markerclusterer>

    Google Maps marker clustering lib.
    [marker-clustering](https://developers.google.com/maps/documentation/javascript/marker-clustering)

## Random bits

* <https://randomuser.me/>
* <https://github.com/toddmotto/public-apis> Collection of public apis.

## CSS bits

* Many hacky ways to have an element be vertically centered:
  <https://stackoverflow.com/a/18200048/643087>
  and <https://vanseodesign.com/css/vertical-centering/>

    ```css
    a {
      display: block;
      height: 100%;
      width: 100%;

      img {
        display: block;
        max-width: 100%;
        max-height: 100%;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
      }
    }
    ```

* CSS selectors specificity (priority):
    - <https://stackoverflow.com/a/4072396>
    - <https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity>
    - <https://css-tricks.com/specifics-on-css-specificity/>
* working around sibling elements “double-borders” [SO](https://stackoverflow.com/a/12693151/643087)
  (tip: use `outlet: ...` instead).
* On [how to detect (select) elements with a given children count](https://stackoverflow.com/a/12198561)

    ```css
    ul {
      li {
        min-height: 18px;
        font-size: 1.2em;
        margin-top: 4px;
        background-image: url('/svg/icon.svg');
        background-repeat: no-repeat;
        background-position: left top;
        background-size: 20px;
        padding-left: 20px;

        &:first-child:nth-last-child(7),
        &:first-child:nth-last-child(7) ~ li,
        &:first-child:nth-last-child(8),
        &:first-child:nth-last-child(8) ~ li {
          font-size: 1.125em;
          margin-top: 3px;
          background-size: 20px;
        }

        &:first-child:nth-last-child(9),
        &:first-child:nth-last-child(9) ~ li,
        &:first-child:nth-last-child(10),
        &:first-child:nth-last-child(10) ~ li {
          font-size: 1em;
          margin-top: 2px;
          background-size: 17px;
        }
      }
    }
    ```

* On having that sticky footer stick wtf it should :
    - [SO](https://stackoverflow.com/a/16245465) `margin-bottom` on the body (or parent container).
    - __must read__ <https://css-tricks.com/couple-takes-sticky-footer/>

## Typography

* [practicaltypography.com](https://practicaltypography.com/parentheses-brackets-and-braces.html) __must-read__

## jQuery bits

* <https://stackoverflow.com/a/5205476/643087>

    ```javascript
    $("div").click(function() {
      // do fading 3 times
      for(i=0;i<3;i++) {
        $(this).fadeTo('slow', 0.5).fadeTo('slow', 1.0);
      }
    });
    ```

* <http://www.bestjquery.com/example/jquery-animation-example/>

__eof__
