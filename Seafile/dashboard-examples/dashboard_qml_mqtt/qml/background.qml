import QtQuick 2.0

Canvas {
    property real xCenter: outerRadius
    property real yCenter: outerRadius

    function toPixels(percentage) {
        return percentage * outerRadius;
    }

    function degToRad(degrees) {
        return degrees * (Math.PI / 180);
    }

    function radToDeg(radians) {
        return radians * (180 / Math.PI);
    }

    function paintBackground(ctx) {


        ctx.beginPath();
        ctx.fillStyle = "black";
        ctx.ellipse(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.fill();
}

    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();

        var centreX = width / 2;
        var centreY = height / 2;

        ctx.beginPath();
        ctx.fillStyle = "black";
        ctx.moveTo(centreX, centreY);
        ctx.arc(centreX, centreY, width / 4, 0, Math.PI * 0.5, false);
        ctx.lineTo(centreX, centreY);
        ctx.fill();

        ctx.beginPath();
        ctx.fillStyle = "red";
        ctx.moveTo(centreX, centreY);
        ctx.arc(centreX, centreY, width / 4, Math.PI * 0.5, Math.PI * 2, false);
        ctx.lineTo(centreX, centreY);
        ctx.fill();
    }
}

