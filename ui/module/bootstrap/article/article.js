$(document).ready(function () {

    $(".module-article table").addClass('table table-striped table-bordered table-hover')

    if ($(".sequence-diagram").sequenceDiagram) {
        $(".sequence-diagram").sequenceDiagram({theme: 'hand'});
    }
});