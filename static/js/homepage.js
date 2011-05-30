---
---
$(function () {
    $('#events-list').crossSlide({
        sleep: 5,
        fade: 1
    }, [
        {% for post in site.posts %}
        { src: '/media/events/{{ post.img }}',
          alt: '<h2>{{ post.title }}</h2> <p>{{ post.date | date: "%A, %m/%d" }}</p>',
          href: '{{ post.url }}' },
        {% endfor %}
    ],function(idx, img, idxOut, imgOut) {
        if (idxOut == undefined) {
            // starting single image phase, put up caption
            $("#event-caption").empty().append($(img.alt)).fadeIn();
        } else {
            // starting cross-fade phase, take out caption
            $("#event-caption").fadeOut();
        }
    });
});
