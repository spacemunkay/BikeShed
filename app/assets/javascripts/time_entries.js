$(document).ready(function () {

    var $date_input = $("#date_id");
    $date_input.datetimepicker({format: $date_input.data("format")});

    var $start_time_input = $("#start_time_id");
    var $end_time_input = $("#end_time_id");
    [$start_time_input, $end_time_input].forEach(function($x) {
        $x.datetimepicker({format: $x.data("format"), stepping: 15});
    })

    $("#add_time_entry_submit").click(function () {
        var date = $date_input.val();
        var start_date = new Date(date + " " + $start_time_input.val());
        var end_date = new Date(date + " " + $end_time_input.val());

        var forward = $("#add_time_entry_submit").data("forward");

        // If a bike is selected, forward to the bike
        // checklist.
        var bike_id = parseInt($("#bike_id").val());
        if (bike_id > 0) {
            forward = "/task_lists/" + bike_id + "/edit";
        }

        //FIXME: Ideally, we'd submit the dates as ISO, but I can't figure out
        // how to get Netzke to render UTC dates correctly (it calls to_json
        // somewhere and drops off the timezone).  For the time being, save dates
        // in locale like Netzke.
        var json_data = {
            time_entries: [{
                start_date: moment(start_date).format("DD-MM-YYYY h:mm A"),
                end_date: moment(end_date).format("DD-MM-YYYY h:mm A"),
                log_action_id: parseInt($('input[name=action_id]:checked').val()),
                bike_id: bike_id,
                description: $("#description_id").val(),
            }]
        };

        $.ajax({
            url: $("#add_time_entry_submit").data("url"),
            type: "POST",
            data: JSON.stringify(json_data),
            contentType: 'application/json',
            dataType: "json",
            success: function (data, status, xhr) {
                window.location = forward;
            },
            error: function (data, status) {
                displayFormErrors(data.responseJSON);
            }
        });

    });

    $(".work_entry-delete-btn").click(function () {
        var row = $(this).closest("tr");
        var entry_id = row.data("id");
        var start_date = row.data("start_date");
        var duration = row.data("duration");
        var description = row.data("description");
        $("#work_entry_start_date").text(start_date);
        $("#work_entry_duration").text(duration);
        $("#work_entry_description").text(description);
        $("#confirmation_delete").data("entry_id", entry_id);
    });

    $("#confirmation_delete").click(function () {
        var entry_id = $(this).data("entry_id");
        var url = $("#confirmation_delete").data("url-template").replace(/__ID__/, entry_id);
        $.ajax({
            url: url,
            type: "delete",
            contentType: 'application/json',
            success: function (data, status, xhr) {
                location.reload();
            },
            error: function (data, status) {
                displayFormErrors(data.responseJSON);
            }
        });
    });
});
