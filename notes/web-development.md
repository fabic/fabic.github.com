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
