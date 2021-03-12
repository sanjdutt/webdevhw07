import $ from 'jquery';

function rsvp_done(resp, status, _xhr) {
    console.log("updated", status, resp);
    let post = resp.data.post;

    $(".post-card").each((_ii, card) => {
        let post_id = $(card).data('post-id');

        if (post_id == post.id) {
            $(card).find(".post-score").text(post.score);
        }
    });
}

function send_rsvp(post_id, rsvps) {
    let body = {rsvp: {post_id, rsvps}};

    $.ajax("/api/rsvps", {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(body),
        headers: {
	   'x-auth': window.userToken,
	},
        success: rsvp_done,
        error: console.log,
    });
}

function setup() {
    $(".post-card").each((_ii, card) => {
        let id = $(card).data('post-id');

        $(card).find('.rsvpyes').click(() => {
            send_rsvp(id, 1);
        });
        $(card).find('.rsvpno').click(() => {
            send_rsvp(id, 0);
        });
    });
}

$(setup);
